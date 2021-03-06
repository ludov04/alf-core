module Alf
  module Engine
    #
    # Remove duplicate tuples through an in-memory `to_a.uniq` heuristics.
    #
    class Compact::Uniq
      include Cog

      # @return [Enumerable] The operand
      attr_reader :operand

      # Creates a Compact::Uniq instance
      def initialize(operand, expr = nil, compiler = nil)
        super(expr, compiler)
        @operand = operand
      end

      # (see Cog#each)
      def _each(&block)
        operand.to_a.uniq.each(&block)
      end

    end # class Compact::Uniq
  end # module Engine
end # module Alf
