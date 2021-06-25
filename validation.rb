module Validation

  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_accessor :validations
    def validate(var, type, pattern = nil)
      @validations ||= []
      @validations << { variable_name: var, validation_type: type, pattern: pattern}
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.instance_variable_get(:@validations)
      puts validations.inspect

      validations.each do |validation|
      send(validation[:validation_type], validation[:variable_name], validation[:pattern])
      end

      # Читаем хэши и вызываем методы валидации
      validate_presence
    end

    def valid?
    validate!
    rescue StoreError
      false
    end

    private
    # Методы валидации
    def presence(var, _)
      true unless var.empty?
      raise 'Наименование отсутствует.'
    end

    def format(var, type)
      true if var =~ type
      raise 'Неверный формат наименования.'
    end

    def type(type)
      true if self.class == type
      raise 'Неверный тип обьекта'
  end
  end
  end