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

Create the project with the following command:
```sh
% bundle gem telvue 
```

## Development

### Validate Module
* Added Validate module in /lib/telvue folder, validate.rb
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
* Added ValidateError class in /lib/telvue folder, validate_errors.rb
```ruby
class ValidateErrors
  attr_reader :msgs

  def initialize
    @msgs = {}
  end

  def add(name, msg)
    (@msgs[name] ||= []) << msg
  end

  def full_messages
    @msgs.map do |e|
      "#{e.first.capitalize} #{e.last.join(' & ')}"
    end.join
  end
end
```

### TimeFormat Module
Added TimeFormat Module in /lib/telvue folder, time_format.rb
```ruby
module TimeFormat
  DEFAULT_TIME_FORMAT = 'HH:MM:SS'
  AVAILABLE_TIME_FORMATS = { 'HH' => '%H', 'MM' => '%M', 'SS' => '%S' }

  # make the correct time format for Time class
  def time_format_conversion(format)
    AVAILABLE_TIME_FORMATS.reduce(format) { |memo, (key, value)| memo.gsub key, value }
  end
end
```
### Transform
Added Transform Class in /lib folder, transform.rb
```ruby
require_relative 'telvue'

class Transform
  include Validate
  include TimeFormat

  attr_reader :duration

  validates :duration, presence: true
  validates :duration, only_number: true
  validates :duration, type: Integer
  validates :duration,
            msg: 'must be greater than or equal to 0',
            with: proc { |p| p.duration >= 0 }

  def initialize
    super(self)
  end

  # duration = seconds, time_format = HH:MM:SS - custom value
  def process_time(duration, time_format = DEFAULT_TIME_FORMAT)
    @duration = duration

    valid? ? duration_to_time(time_format) : error_messages
  end

  private

  def duration_to_time(time_format)
    time_format = time_format_conversion(time_format)
    
    Time.at(@duration).utc.strftime(time_format)
  end
end
```
## MiniTest
Edit `Gemfile` and add:
```ruby
gem "minitest", "~> 5.0"
```

### Transform Class Test
Added test_transform.rb in test folder.
```ruby
require "test_helper"
require "transform"

describe Transform do
  before do
    @transform = Transform.new
  end

  describe "#process_time" do
    it "nil or empty duration returns a presence error" do
      error = "Duration must be presence"

      expect(@transform.process_time(nil)).must_equal error
      expect(@transform.process_time('')).must_equal error
    end

    it "special chars or letters return a number only error" do
      error = "Duration must be a number, not special chars or letters"

      expect(@transform.process_time('$10')).must_equal error
      expect(@transform.process_time('5a')).must_equal error
    end

    it "decimal or float value return integer type error" do
      error = "Duration must be a Integer"

      expect(@transform.process_time(12.3456)).must_equal error
    end

    it "negative value return error" do
      error = "Duration must be greater than or equal to 0"

      expect(@transform.process_time(-5)).must_equal error
    end

    it "valid value return time with the default time format" do
      expect(@transform.process_time(80)).must_equal "00:01:20"
    end

    it "valid value and custom time format return the time with the custom format" do
      expect(@transform.process_time(3720, 'HH:MM')).must_equal "01:02"
    end
  end
end
```
### Run Test
Run the following command to see the minitest
```sh
rake test
```
You see the following output:
```sh
Run options: --seed 25753

# Running:

......

Finished in 0.002206s, 2719.8549 runs/s, 3626.4732 assertions/s.

6 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```
