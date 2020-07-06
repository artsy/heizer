module DatabaseHelper
  DB = Sequel.connect(
    adapter: 'postgres',
    force_standard_strings: false,
    client_min_messages: ''
  )

  class << self
    def setup
      create
      fill
    end

    def teardown
      DB.drop_table :humans
    end

    private

    def create
      DB.create_table :humans do
        primary_key :id
        String :name
      end
    end

    def fill
      humans = DB[:humans]
      humans.insert name: 'Robert Smithson'
      humans.insert name: 'Fred Sandback'
    end
  end
end
