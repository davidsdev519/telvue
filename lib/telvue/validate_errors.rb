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