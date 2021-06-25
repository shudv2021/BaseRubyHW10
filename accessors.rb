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
          #Если нужна не вся история переменной, а только для обьекта соорветсвенно нужно сделать массив instance переменой
          # перенести в модуль InstanceMethods
        end
        define_method("#{atribute}_history") {@arr_hisrory}
      end
    end


  end

  module InstanceMethods
    def strong_attr_accessor(atr_name, atr_class)
      if atr_name.class == atr_class
        self.class.attr_accessor_with_history(atr_name)
        else
        raise "Class object isn't right"
      end
    end
  end
  end

#this is chek for Modul Accessor
=begin
  class Test
    include Accessors
    attr_accessor_with_history(:x, :y, :z)
  end
t=Test.new
t.x=10
t.x=12
t.x=30
t2 = Test.new
t2.x = 14
t2.x = 15
puts t.x_history


sta = Test.new
sta.strong_attr_accessor('train1',String)
sta.train1= 20
puts sta.train1
sta.train1= 13
sta.train1= 15
puts sta.train1_history
=end