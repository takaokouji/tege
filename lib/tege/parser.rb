require "rdoc"
require "rdoc/generator"
require "rdoc/options"
require "rdoc/parser/ruby"
require "rdoc/stats"

require "tege/module"
require "tege/class"

module Tege
  class Parser
    class << self
      def parse(path)
        top_level = RDoc::TopLevel.new(path)
        if RUBY_VERSION.to_f < 2.0
          RDoc::TopLevel.reset
          stats = RDoc::Stats.new(1)
        else
          store = RDoc::Store.new
          top_level.store = store
          stats = RDoc::Stats.new(store, 1)
        end
        parser = RDoc::Parser::Ruby.new(top_level, path, File.read(path),
                                        RDoc::Options.new, stats)
        top_level = parser.scan
        return extract_class_or_module(top_level)
      end

      private
    
      def extract_class_or_module(context, class_or_module_list = [])
        if context.classes.empty?
          if context.modules.empty?
            if context.is_a?(RDoc::NormalModule)
              class_or_module_list.unshift(Tege::Module.new(context))
            end
          else
            class_or_module_list.unshift(*context.modules.map { |m|
                                           Tege::Module.new(m)
                                         })
            context.modules.each do |m|
              extract_class_or_module(m, class_or_module_list)
            end
          end
        else
          class_or_module_list.unshift(*context.classes.map { |c|
                                         Tege::Class.new(c)
                                       })
        end
        class_or_module_list
      end
    end
  end
end
