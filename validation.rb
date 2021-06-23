module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def validate(*arg)
      case arg[1]
      when :presence
        valid_presence(arg)
      when :format
        valid_format(arg)
      when :type
        valid_type(arg)
      end

      def valid_presence(arg)
        if arg[0] != '' && !arg[0].nil?
        true
        else raise 'Error - empty argument'
      end

      def valid_format(arg)
        if arg[0] =~ arg[2]
          true
        else raise 'Error - unright format'
        end

        def valid_type(arg)
          if arg[0].class == eval(arg[2])
            true
            else raise 'Error - unright type'
          end


        end
      end

    end
  end

  module InstanceMethods

  end

end
