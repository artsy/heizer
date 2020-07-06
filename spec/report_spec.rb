require 'spec_helper'

describe Heizer::Report do
  let(:directory_path_str) { 'directory/path' }
  let(:filename_str) { 'filename.csv' }
  let(:connection) do
    {
      password: 'password'
    }
  end
  let!(:subject_class) do
    class Human
      def self.table_name
        'humans'
      end
    end
  end

  let!(:report_class) do
    class HumansReport < Heizer::Report
      @reporting_class = Human
      def columns
        %w(id name)
      end
    end
  end

  context '.reporting_class' do
    it 'defaults to nil' do
      expect(described_class.reporting_class).to be_nil
    end

    it 'may be set by inheriting class' do
      expect(HumansReport.reporting_class).to eq Human
    end
  end

  context '.initialize' do
    let!(:instance) { HumansReport.new(directory_path_str, filename_str, connection) }

    it 'returns custom value for directory_path' do
      expect(instance.instance_variable_get('@directory_path')).to eq directory_path_str
    end

    it 'returns custom value for filename' do
      expect(instance.instance_variable_get('@filename')).to eq filename_str
    end
  end

  context '#call' do
    let!(:instance) { HumansReport.new(directory_path_str, filename_str, connection) }
    let(:record) { Human.new }
    let(:expected_data) do
      [
        %w(id name),
        ['1', 'Robert Smithson'],
        ['2', 'Fred Sandback']
      ]
    end
    let(:storage) do
      Fog::Storage.new(provider: 'AWS',
                       aws_access_key_id: Heizer.configuration.aws_access_key_id,
                       aws_secret_access_key: Heizer.configuration.aws_secret_access_key)
    end
    let(:bucket) { storage.directories.get(directory_path_str) }

    before do
      DatabaseHelper.setup
      Fog.mock!
      Fog::Mock.reset
    end

    after do
      DatabaseHelper.teardown
    end

    it 'uploads a file' do
      instance.call
      uploaded_file = bucket.files.get filename_str
      expected = RemoteFileHelper.generate_csv expected_data
      expect(uploaded_file.body).to eq expected
    end
  end
end
