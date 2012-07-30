module Alf
  class Database
    class Schema < Module

      # Inform the schema to import native relation variables under public module
      # methods.
      def import_native_relvars
        # Implementation is a bit complex here because those relation variables
        # are not known at declaration time. Therefore, the strategy is to dynamically 
        # extend Lispy scopes that include this schema... Those scopes are extended by
        # explicit calls to Module.extend_object (see Scope implementation). So we
        # first register a singleton method to capture such call.
        define_singleton_method(:extend_object) do |obj|
          super(obj)
          # Now, we know that `obj` is a Lispy scope. That scope has a `context` that
          # should be a Connection object. We get the native schema and install it on
          # the original scope :-)
          obj.context.native_schema.send(:extend_object, obj)
        end
        self
      end

      def relvar(name, &defn)
        defn ||= lambda{ Operator::VarRef.new(context, name) }
        define_method(name, &defn)
      end

    end # class Schema
  end # class Database
end # module Alf