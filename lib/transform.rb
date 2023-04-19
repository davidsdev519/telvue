require_relative 'validate'

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
  include Validation

  attr_reader :duration, :time_format

  def initialize
  end

  def process_time(duration, time_format = 'HH:MM:SS')
    @duration = duration
    @time_format = time_format

    valid? ? duration_to_time : errors.full_messages
  end

  private
  def duration_to_time
    format = @time_format
    { 'HH' => '%H', 'MM' => '%M', 'SS' => '%S' }.each { |key, value| format.gsub! key, value }
    
    Time.at(@duration).utc.strftime(format)
  end
end