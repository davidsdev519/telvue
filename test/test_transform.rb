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
