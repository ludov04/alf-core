module Alf
  class Compiler

    def join(plan)
      nil
    end

    def call(expr)
      Plan.new(self).compile(expr)
    end

    def compile(plan, expr, compiled)
      send(to_method_name(expr), plan, expr, *compiled)
    end

    def on_leaf_operand(plan, expr)
      expr.to_cog(plan)
    end

    def on_missing(plan, expr, *compiled)
      raise NotSupportedError, "Unable to compile `#{expr}` (#{self})"
    end

    def on_unsupported(plan, expr, *args)
      raise NotSupportedError, "Unsupported expression `#{expr}`"
    end

  private

    def to_method_name(expr)
      case expr
      when Algebra::Operator
        name = expr.class.rubycase_name
        meth = :"on_#{name}"
        meth = :"on_missing" unless respond_to?(meth)
        meth
      when Algebra::Operand
        :on_leaf_operand
      else
        :on_unsupported
      end
    end

  end # class Compiler
end # module Alf
require_relative 'compiler/plan'
require_relative 'compiler/cog'
require_relative 'compiler/default'
