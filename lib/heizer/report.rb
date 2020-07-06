module Heizer
  class Report
    class << self; attr_accessor :reporting_class; end
    @reporting_class = nil

    def initialize(path, filename, connection_config = ActiveRecord::Base.connection_config)
      @connection_config = connection_config
      @directory_path = path
      @filename = filename
    end

    def call
      tmp_file = Tempfile.new @filename, '/tmp'
      begin
        write_and_upload tmp_file
      ensure
        tmp_file.close
        tmp_file.unlink
      end
    end

    private

    def write_and_upload(tmp_file)
      `#{arg_or_skip(@connection_config[:password], 'PGPASSWORD', '=')} \
        psql #{arg_or_skip(@connection_config[:database], '-d', ' ')}  \
        #{arg_or_skip(@connection_config[:host], '-h', ' ')} \
        #{arg_or_skip(@connection_config[:port], '-p', ' ')} \
        #{arg_or_skip(@connection_config[:username], '-U', ' ')} \
        -c '#{copy_command(tmp_file.path)}'`
      upload tmp_file.read
    end

    def arg_or_skip(value, command, connector)
      return unless value
      "#{command}#{connector}#{value}"
    end

    def copy_command(tmp_file_path)
      table_name = self.class.reporting_class.table_name
      "\\copy #{table_name}#{prepare_column_list} to #{tmp_file_path} WITH (FORMAT CSV, HEADER TRUE, FORCE_QUOTE *);"
    end

    def prepare_column_list
      return unless columns
      wrapped_columns = columns.map { |x| "\"#{x}\"" } * ', '
      "(#{wrapped_columns})"
    end

    def upload(content)
      directory = Heizer::Storage.find_or_create_directory @directory_path
      Heizer::Storage.upload directory, @filename, content
    end
  end
end
