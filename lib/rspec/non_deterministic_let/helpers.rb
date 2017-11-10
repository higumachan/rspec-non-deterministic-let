module RSpec
  module NonDeterministicLet
    module Helpers
      module ClassMethods
        def nd_let_context(nd_let_name, *args, &example_group_block)
          send(nd_let_name).each do |let_options|
            context(let_options[:description], *args) do
              let(nd_let_name, &let_options[:block])
              self.module_exec(&example_group_block)
            end
          end
        end

        def nd_let(nd_let_name, description=nil, &let_block)
          begin
            let_blocks = send(nd_let_name)
            description ||= "nd_let:#{nd_let_name} \##{let_blocks.size + 1}"
            self.define_singleton_method(nd_let_name) do ||
              let_blocks + [{block: let_block, description: description}]
            end
          rescue NoMethodError
            description ||= "nd_let:#{nd_let_name} \##{1}"
            self.define_singleton_method(nd_let_name) do ||
              [{block: let_block, description: description}]
            end
          end
        end
      end
    end
  end
end
