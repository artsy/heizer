require 'spec_helper'

describe Heizer::Configuration do
  after { ConfigurationHelper.reset }

  context 'aws_access_key_id' do
    let(:custom_aws_access_key_id) { 'aws_access_key_id' }

    context 'when no user_model_name is provided' do
      before do
        Heizer.configure do |config|
        end
      end

      it 'returns the default value for aws_access_key_id' do
        expect(Heizer.configuration.aws_access_key_id).to eq 'replace-me'
      end
    end

    context 'when a custom aws_access_key_id is provided' do
      before do
        Heizer.configure do |config|
          config.aws_access_key_id = custom_aws_access_key_id
        end
      end

      it 'returns the custom aws_access_key_id value' do
        expect(Heizer.configuration.aws_access_key_id).to eq custom_aws_access_key_id
      end
    end
  end

  context 'aws_secret_access_key' do
    let(:custom_aws_secret_access_key) { 'aws_secret_access_key' }

    context 'when no aws_secret_access_key is specified' do
      before do
        Heizer.configure do |config|
        end
      end

      it 'returns the default value for aws_secret_access_key' do
        expect(Heizer.configuration.aws_secret_access_key).to eq 'replace-me'
      end
    end

    context 'when a custom aws_secret_access_key is provided' do
      before do
        Heizer.configure do |config|
          config.aws_secret_access_key = custom_aws_secret_access_key
        end
      end

      it 'returns the custom aws_secret_access_key value' do
        expect(Heizer.configuration.aws_secret_access_key).to eq custom_aws_secret_access_key
      end
    end
  end
end
