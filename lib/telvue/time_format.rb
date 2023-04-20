module TimeFormat
  DEFAULT_TIME_FORMAT = 'HH:MM:SS'
  AVAILABLE_TIME_FORMATS = { 'HH' => '%H', 'MM' => '%M', 'SS' => '%S' }

  # make the correct time format for Time class
  def time_format_conversion(format)
    AVAILABLE_TIME_FORMATS.reduce(format) { |memo, (key, value)| memo.gsub key, value }
  end
end