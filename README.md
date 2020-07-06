# heizer

[heizer](https://github.com/dylanfareed/heizer) provides a simple DSL for exporting data from ActiveRecord model collections to S3 as CSVs in Gris apps. That's a surprising number of dependencies. Heizer also uses [fog-aws](https://github.com/fog/fog-aws).

Needless to say, heizer is alpha software.

[![Circle CI](https://circleci.com/gh/dylanfareed/heizer.svg?style=svg)](https://circleci.com/gh/dylanfareed/heizer)

---

### Installation

heizer is [available as a gem via GitHub](https://github.com/dylanfareed/heizer). To install it, if your project uses [Bundler](http://bundler.io/), add heizer to your Gemfile:

```
gem 'heizer', github: 'dylanfareed/heizer'
```

And run:

```
$ bundle install
```

---

### Usage

```ruby
# config/initializers/heizer.rb
Heizer.configure do |config|
  config.aws_access_key_id = Gris.secrets.aws_access_key_id
  config.aws_secret_access_key = Gris.secrets.aws_secret_access_key
end
```

```ruby
# app/reports/submissions_report.rb
class SubmissionsReport < Heizer::Report
  @reporting_class = Submission

  def columns
    %w(id token user_id email_address phone_number attribution title year
    category location_city location_state location_country height width depth
    dimensions_metric signature provenance name artist_id completed_at
    mailer_delivered_at created_at updated_at)
  end
end
```

```ruby
# lib/taks/report.rake
namespace :report do
  desc 'Export Submissions report to S3'
  task submissions: :environment do
    SubmissionsReport.new('bucket/path', 'hello.csv').call()
  end
end
```
