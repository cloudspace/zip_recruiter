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
script.

    require 'zip_recruiter'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Notes

There is a bug in Thor (see
[issue 261](https://github.com/wycats/thor/issues/261)) where the help command
for a subcommand will display the wrong name for the subcommand due to the way
it generates the help output. E.g., `$ ziprecruiter jobalerts` shows
`ziprecruiter c_l_i` in the output.
