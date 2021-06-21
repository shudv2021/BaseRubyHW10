module Accessors
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(ClassMethods)
  end
  #не будут ли мешать друг другу одноименные модули из разных модулей , тафталогия конечно но
  # иначе не могу сформулировать
  module ClassMethods
    def attr_accessor_with_history(*atributes)
      atributes.each do |atribute|
        atribute_name = "@#{atribute}".to_sym
        define_method(atribute) { instance_varible_get(atribute_name) }
        define_method("#{atribute}=".to_sym) do |value|
          @arr_hisrory ||= []
          instace_varible_set(atribute_name, value)
        end
        define_method("#{atribute}_history") { instance_varible_get(@arr_history) }
      end
    end


  end

  module InstanceMethods
    def strong_attr_accessor(atribut_name, atribure_class)
      # Не понял что этот метод должен делать в контексте нашей проргаммы. Все проверки вроде бы в
      # модуле Valide нужно увязать его с этим модулем или делать проверку отдельно
    end

end