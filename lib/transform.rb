require_relative 'telvue'

class TransformValidator
  include Validate

  validates :duration, presence: true
  validates :duration, only_number: true
  validates :duration, type: Integer
  validates :duration,
            msg: 'must be greater than or equal to 0',
            with: proc { |p| p.duration >= 0 }
end

class Transform
  include Validator

  attr_reader :duration

  def initialize
  end

  # duration = seconds, time_format will be customized
  def process_time(duration, time_format = 'HH:MM:SS')
    @duration = duration

    valid? ? duration_to_time(time_format) : errors.full_messages
  end

  private
  def duration_to_time(time_format)
    # make the correct time format for Time class
    { 'HH' => '%H', 'MM' => '%M', 'SS' => '%S' }.each { |key, value| time_format.gsub! key, value }
    
    Time.at(@duration).utc.strftime(time_format)
  end
end