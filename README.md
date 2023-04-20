# TelVue Pre-Interview Coding Challenge

## Requirements
Using ruby (no gems except test-unit or minitest) build a class that satisfies the following business requirements:

1) accepts two arguments:
- duration (in seconds)
- format desired (with seconds or without seconds) ie: HH:MM or HH:MM:SS,  if no format is provided, default to HH:MM:SS
2) first verifies that duration is supplied
- second verifies that the duration supplied is a number, not special chars or letters
- third verifies that the duration supplied is an integer, not a decimal/float
- fourth verifies that the duration supplied is not a negative number
- class should stop processing further errors when an error is discovered
3) return a response to callers that contains:
- an accurate error message based on the 4 possible error conditions above if verification fails
- processing should stop as soon as an error is discovered, so only the first error should be reported, do NOT return all errors
- if no errors found, return the transformed duration from seconds to HH:MM:SS or HH:MM per the format argument
4) include tests (using minitest or test:unit)
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/telvue.
