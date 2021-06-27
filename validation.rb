module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_accessor :validations

    def validate(var, type, pattern = nil)
      @validations ||= []
      @validations << { variable_name: var, validation_type: type, pattern: pattern }
    end
  end

  module InstanceMethods
    def validate!
      # binding.pry
      validations = self.class.instance_variable_get(:@validations)
      validations.each do |validation|
        send(validation[:validation_type], instance_variable_get("@#{validation[:variable_name]}"),
             validation[:pattern])
      end
      # Читаем хэши и вызываем методы валидации
    end

    def valid?
      validate!
    rescue StoreError
      false
    end

    private

    # Методы валидации
    def presence(var, _)
      var.empty? ? (raise 'Cтрока пустая') : true
    end

    def format(var, type)
      (var =~ type).zero? ? true : (raise 'Неверный формат')
      # (var =~ type) == 0 ? true : raise 'Неверный формат'
      # тернарный оператор в таком виде не работает
    end

    def object_type(type)
      instance_of?(type) ? true : (raise 'Неверный тип')
    end
  end
end

# проверка на работоспособность
# class Test
#   include Validation
#
#   TRAIN_NUMBER_FORMAT = /[0-9]{3}-[а-я]{2}$/i.freeze
#   validate(:train_num, :presence)
#   validate(:train_num, :format, TRAIN_NUMBER_FORMAT)
#   def initialize(train_num)
#     @train_num = train_num
#     validate!
#   end
# end
#
# t=Test.new('123-гп')
