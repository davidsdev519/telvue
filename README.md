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

## Set up Project
This app is developed on a Mac OS.

* Ruby - 3.2.1

Install the latest ruby using rbenv or asdf whatever you are familar with.

Create the project
```sh
% bundle gem telvue 
```

## Development

### Add Validate Module
* Added validate module in /lib/telvue folder, validate.rb
```ruby
=begin
  These are samples for validation

  validates :duration, presence: true
  validates :duration, only_number: true
  validates :duration, type: Integer
  validates :time_format, type: String
  validates :duration,
            msg: 'must be greater than or equal to 0',
            with: proc { |p| p.duration >= 0 }

  Tip: line 40 : You can add custom validation

  Notice: Currently, it only returns one error even it has several validation errors
  To return all errors, remove line 34
=end

module Validate
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end
  
  ...
  
end
```

