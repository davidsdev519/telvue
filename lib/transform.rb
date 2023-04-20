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