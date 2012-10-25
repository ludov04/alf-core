module Alf
  module Engine
    #
    # Concat tuples from multiple operands.
    #
    class Concat
      include Cog

      # @return [Array] operands to concatenate
      attr_reader :operands

      # Creates a Concat instance
      def initialize(operands)
        @operands = operands
      end

      # (see Cog#each)
      def _each(&block)
        operands.each do |op|
          op.each(&block)
        end
      end

    end # class Concat
  end # module Engine
end # module Alf
