module Alf
  module Update
    class Updater < Algebra::Compiler

      ### overridings

      def not_supported(expr, *args)
        raise NotSupportedError, "Unable to update through `#{expr}`"
      end

      ### leaf Operand, recursion end :-)

      def on_leaf_operand(expr, updating, predicate)
        expr.to_relvar.update(updating, predicate)
      end

      ### non relational

      alias :on_autonum    :not_supported
      alias :on_clip       :not_supported
      alias :on_coerce     :not_supported
      alias :on_compact    :not_supported
      alias :on_defaults   :not_supported
      alias :on_generator  :not_supported
      alias :on_sort       :not_supported

      ### relational

      alias :on_extend        :not_supported
      alias :on_group         :not_supported
      alias :on_intersect     :not_supported
      alias :on_join          :not_supported
      alias :on_matching      :not_supported
      alias :on_minus         :not_supported
      alias :not_matching     :not_supported
      alias :on_project       :not_supported
      alias :on_quota         :not_supported
      alias :on_rank          :not_supported
      alias :on_rename        :not_supported

      def on_restrict(expr, updating, predicate)
        apply(expr.operand, updating, expr.predicate & predicate)
      end

      alias :on_summarize     :not_supported
      alias :on_ungroup       :not_supported
      alias :on_union         :not_supported
      alias :on_unwrap        :not_supported
      alias :on_wrap          :not_supported

    end # class Deleter
  end # module Update
end # module Alf
