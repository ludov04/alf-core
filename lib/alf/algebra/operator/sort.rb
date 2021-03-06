module Alf
  module Algebra
    class Sort
      include Operator
      include NonRelational
      include Unary

      signature do |s|
        s.argument :ordering, Ordering, []
      end

      def heading
        @heading ||= operand.heading
      end

      def keys
        @keys ||= operand.keys
      end

    private

      def _type_check(options)
        valid_ordering!(ordering, operand.attr_list)
      end

    end # class Sort
  end # module Algebra
end # module Alf
