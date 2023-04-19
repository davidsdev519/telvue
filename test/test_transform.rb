require "test_helper"
require "transform"

describe Transform do
  before do
    @transform = Transform.new
  end

  describe "#process_time" do
    describe "pass nil value as duration" do
      it "returns a presence error" do
        _(@transform.process_time(nil)).must_equal "Duration must be presence"
      end
    end
  end
end
