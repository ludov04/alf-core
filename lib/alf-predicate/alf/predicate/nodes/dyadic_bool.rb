module Alf
  class Predicate
    module DyadicBool
      include Expr

      def priority
        60
      end

      def !
        Factory.send(OP_NEGATIONS[first], last)
      end

      def left
        self[1]
      end

      def right
        self[2]
      end

      def free_variables
        @free_variables ||= left.free_variables | right.free_variables
      end

    end
  end
end
