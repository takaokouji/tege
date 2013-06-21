require "active_support/core_ext/module/delegation"

module Tege
  class Module
    delegate :name, :parent, :to => :@internal

    attr_reader :path

    def initialize(class_module, path)
      @internal = class_module
      @path = path
    end

    def public_method_list
      return public_instance_method_list + public_class_method_list
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

    def full_name
      @full_name ||= make_full_name(self, name)
      return @full_name
    end

    def type
      if public_method_list.empty?
        return "namespace"
      else
        case path
        when %r'\bmodels/'
          return "model"
        when %r'\bhelpers/'
          return "helper"
        when %r'\bcontrollers/'
          return "controller"
        when %r'\bmailers/'
          return "mailer"
        when %r'\blib/'
          return "library"
        when %r'\binitializers/'
          return "monkey patch"
        else
          return "other"
        end
      end
    end

    private

    def make_full_name(m, name)
      if m.parent.name && m.parent.is_a?(RDoc::NormalModule)
        return make_full_name(m.parent, "#{m.parent.name}::#{name}")
      else
        name
      end
    end
  end
end
