module Alf
  class Predicate
    module Not
      include Expr

      def priority
        90
      end

      def !
        last
      end

    end
  end
end
