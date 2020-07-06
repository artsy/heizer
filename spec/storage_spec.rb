require 'spec_helper'

describe Heizer::Storage do
  let(:expected_storage) do
    Fog::Storage.new(provider: 'AWS',
                     aws_access_key_id: Heizer.configuration.aws_access_key_id,
                     aws_secret_access_key: Heizer.configuration.aws_secret_access_key)
  end
  let(:directory_path_str) { 'nine/nevada/depressions' }

  before do
    Fog.mock!
    Fog::Mock.reset
  end

  context '.find_or_create_directory' do
    context 'when the directory does not exist' do
      it 'creates the directory' do
        described_class.find_or_create_directory directory_path_str
        expect(expected_storage.directories.map(&:key)).to include directory_path_str
      end

      it 'returns the newly created directory' do
        directory = described_class.find_or_create_directory directory_path_str
        expect(directory).to be_a_kind_of Fog::Storage::AWS::Directory
        expect(directory.key).to eq directory_path_str
      end
    end
  end

  context '.upload' do
    let(:directory) { expected_storage.directories.get(directory_path_str) }
    let(:filename) { 'matchdrop.txt' }
    let(:body) { '45°, 90°, 180°' }

    before do
      described_class.find_or_create_directory directory_path_str
    end

    it 'uploads the file' do
      uploaded = described_class.upload directory, filename, body
      expect(uploaded).to be_a_kind_of Fog::Storage::AWS::File
      expect(uploaded.key).to eq filename
      expect(uploaded.body).to eq body
    end
  end
end
