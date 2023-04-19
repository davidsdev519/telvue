module Validation
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

class ValidationErrors
  attr_reader :all

  def initialize
    @all = {}
  end

  def add(name, msg)
    (@all[name] ||= []) << msg
  end

  def full_messages
    @all.map do |e|
      "#{e.first.capitalize} #{e.last.join(' & ')}"
    end.join
  end
end

module Validate
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end

  module InstanceMethods
    attr_reader :object, :errors

    def initialize(object)
      @object = object
      @errors = ValidationErrors.new
    end

    def valid?
      self.class.validators.each do |args|
        return false unless @errors.all.empty?
        validate(args)
      end
      @errors.all.empty?
    end

    private

    def validate(args)
      args_ctg = args[1]
      case
      when args_ctg.key?(:with)
        with_validator(*args)
      when args_ctg.key?(:only_number)
        only_number_validator(*args)
      when args_ctg.key?(:type)
        type_validator(*args)
      when args_ctg.key?(:presence)
        presence_validator(*args)
      end
    end

    def with_validator(name, options)
      fail unless options[:with].call(@object)
    rescue
      @errors.add(name, options[:msg])
    end

    def only_number_validator(name, options)
      return unless options[:only_number] 
      obj = @object.send(name)
      obj = obj.to_s unless obj.is_a? String
      return if /\A[+-]?\d+(\.[\d]+)?\z/.match(obj)
      @errors.add(name, "must be a number, not special chars or letters")
    end

    def type_validator(name, options)
      return if @object.send(name).is_a?(options[:type])
      @errors.add(name, "must be a #{options[:type].name}")
    end

    def presence_validator(name, options)
      return unless options[:presence]
      return unless @object.send(name).nil? || @object.send(name).to_s.empty?
      @errors.add(name, "must be presence")
    end
  end

  module ClassMethods
    def validates(*args)
      create_validation(args)
    end

    def validators
      @validators
    end

    private

    def create_validation(args)
      @validators = [] unless defined?(@validators)
      @validators << args
    end
  end
end