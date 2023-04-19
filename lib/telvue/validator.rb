module Validator
  def valid?
    klass = Object.const_get("#{self.class.name}Validator")
    @validator = klass.new(self)
    @validator.valid?
  end

  def errors
    return {} unless defined?(@validator)
    @validator.errors
  end
end