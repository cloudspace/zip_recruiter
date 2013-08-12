# ZipRecruiter

Provides a CLI and ruby interface to the ZipRecruiter Job Alerts API.

## Installation

Add this line to your application's Gemfile:

    gem 'zip_recruiter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zip_recruiter

## Usage

Run the following to display CLI usage:

    $ ziprecruiter

Additionally, you may use the ZipRecruiter::API class directly in a ruby
script, e.g.:

```ruby
require 'zip_recruiter'
ZipRecruiter::API.api_key = 'your-api-key'
ZipRecruiter::JobAlerts::API.subscribe '/path/to/file.csv'
ZipRecruiter::JobAlerts::API.unsubscribe '/path/to/file.csv'
ZipRecruiter::JobAlerts::API.status 'task-id'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
