module Alf
  module Algebra
    class NotMatching
      include Operator, Relational, Binary

      signature do |s|
      end

      def heading
        @heading ||= left.heading
      end

      def keys
        @keys ||= left.keys
      end

    end # class NotMatching
  end # module Algebra
end # module Alf