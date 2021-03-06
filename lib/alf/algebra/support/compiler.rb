module Alf
  module Algebra
    class Compiler
      include Visitor

    # public interface

      def call(expr, *args, &bl)
        apply(expr, *args, &bl)
      end

    # copy all default implementation

      def apply(expr, *args, &bl)
        send to_method_name(expr, "on_"), expr, *args, &bl
      end

      def on_missing(expr, *args, &bl)
        raise NotSupportedError, "Unable to compile `#{expr}`"
      end

      def not_supported(expr, *args, &bl)
        raise NotSupportedError, "Unexpected operand `#{expr}`"
      end

    end # class Compiler
  end # module Algebra
end # module Alf
