module Accessors
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def attr_accessor_with_history(*atributes)
      atributes.each do |atribute|
        atribute_name = "@#{atribute}".to_sym
        define_method(atribute) { instance_variable_get(atribute_name) }
        define_method("#{atribute}=".to_sym) do |value|
          instance_variable_set(atribute_name, value)
          @arr_hisrory ||= []
          @arr_hisrory<<value
        end
        define_method("#{atribute}_history") {@arr_hisrory}
      end
    end


  end

  module InstanceMethods
    def strong_attr_accessor(atr_name, atr_class)
      #Не совсем понял что ч чем долдно сравниваться что приходит в atr_name и в atr_class? Хотябы один пример
      # atr_name  = 1  atr_class = Integer ????????????????
      if ***** == *****
        self.class.attr_cassesor_with_history
        else
        raise "Class object isn't right"
      end
    end
  end
  end

  class Test
    include Accessors
    attr_accessor_with_history(:x, :y, :z)
  end

t=Test.new
t.x=10
t.x=12
t.x=30
