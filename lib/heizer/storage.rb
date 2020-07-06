module Heizer
  class Storage
    class << self
      def find_or_create_directory(directory_path)
        Fog::Storage.new(
          provider: 'AWS',
          aws_access_key_id: Heizer.configuration.aws_access_key_id,
          aws_secret_access_key: Heizer.configuration.aws_secret_access_key
        ).directories.create(key: directory_path)
      end

      def upload(directory, filename, body)
        directory.files.create key: filename, body: body
      end
    end
  end
end
