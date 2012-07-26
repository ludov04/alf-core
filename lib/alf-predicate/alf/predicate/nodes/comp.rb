module Alf
  class Predicate
    module Comp
      include Expr

      def to_raw_expr
        op, h = sexpr_body
        if h.size == 1
          _ [op, _(h.keys.first), _(h.values.first)]
        else
          _ h.inject([:and]){|expr, pair|
            expr << ([op] << _(pair.first) << _(pair.last))
          }
        end
      end

    end
  end
end