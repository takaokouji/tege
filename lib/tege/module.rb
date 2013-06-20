require "active_support/core_ext/module/delegation"

module Tege
  class Module
    delegate :name, :to => :@internal
    
    def initialize(class_module)
      @internal = class_module
    end

    def public_instance_method_list
      return @public_instance_method_list ||= @internal.method_list.select { |m|
        !m.singleton && m.visibility == :public
      }
    end

    def public_class_method_list
      return @public_class_method_list ||= @internal.method_list.select { |m|
        m.singleton && m.visibility == :public
      }
    end
  end
end
