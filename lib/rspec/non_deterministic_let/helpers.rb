module RSpec
  module NonDeterministicLet
    module Helpers
      module ClassMethods
        def nd_let_context(nd_let_name, *args, &example_group_block)
          send(__nd_let_state_name(nd_let_name)).each do |let_options|
            context(let_options[:description], *args) do
              if let_options[:is_exclamation]
                let!(nd_let_name, &let_options[:block])
              else
                let(nd_let_name, &let_options[:block])
              end
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

        def nd_let(nd_let_name, description=nil, &let_block)
          __update_let_state(nd_let_name, description, let_block, false)
        end

        def nd_let!(nd_let_name, description=nil, &let_block)
          __update_let_state(nd_let_name, description, let_block, true)
        end

        def __update_let_state(nd_let_name, description, let_block, is_exclamation)
          nd_let = 'nd_let'
          nd_let += '!' if is_exclamation

          nd_let_state_name = __nd_let_state_name(nd_let_name)

          begin
            let_blocks = send(nd_let_state_name)
            description ||= "#{nd_let}:#{nd_let_name} \##{let_blocks.size + 1}"
            self.define_singleton_method(nd_let_state_name) do ||
              let_blocks + [{block: let_block, description: description, is_exclamation: is_exclamation}]
            end
          rescue NoMethodError
            description ||= "#{nd_let}:#{nd_let_name} \##{1}"
            self.define_singleton_method(nd_let_state_name) do ||
              [{block: let_block, description: description, is_exclamation: is_exclamation}]
            end
          end
        end

        def __nd_let_state_name(nd_let_name)
          "__nd_let_state_#{nd_let_name.to_s}".to_sym
        end
      end
    end
  end
end
