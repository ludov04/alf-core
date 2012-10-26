module Alf
  module Engine
    class TypeCheck
      include Cog

      # @return [Enumerable] The operand
      attr_reader :operand

      # @return [Types::TypeChecker] Type checker to use
      attr_reader :checker

      # Creates an Coerce instance
      def initialize(operand, checker)
        @operand = operand
        @checker = checker
      end

      # (see Cog#each)
      def _each
        @operand.each do |tuple|
          raise TypeCheckError, "Invalid tuple `#{tuple.inspect}`" unless checker===tuple
          yield(tuple)
        end
      end

    end # class TypeCheck
  end # module Engine
end # module Alf
