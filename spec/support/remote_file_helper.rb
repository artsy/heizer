module RemoteFileHelper
  class << self
    def generate_csv(contents)
      contents.inject([]) do |csv, row|
        force_quotes = row != contents.first
        csv << ::CSV.generate_line(row, force_quotes: force_quotes)
      end.join('')
    end
  end
end
