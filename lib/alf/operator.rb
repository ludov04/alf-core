module Alf
  #
  # Namespace for all operators, relational and non-relational ones.
  #
  module Operator

    class << self
      include Tools::Registry

      # Installs the class methods needed on all operators
      def included(mod)
        super
        mod.extend(ClassMethods)
        register(mod, Operator)
      end
    end # class << self

    # The context in which this operator has been constructed
    attr_accessor :context

    # @param [Array] operands Operator operands
    attr_reader :operands

    # Create an operator instance
    def initialize(context, *args)
      @context = context
      signature.parse_args(args, self)
    end

    # @return [Signature] the operator signature.
    def signature
      self.class.signature
    end

    def ==(other)
      (other.class == self.class) &&
      (other.operands == self.operands) &&
      (other.signature.collect_on(self) == self.signature.collect_on(self))
    end

  ### rewriting utils (careful to clean state-full information here!)

    def dup
      super.tap do |copy|
        yield(copy) if block_given?
        copy.clean_computed_attributes!
      end
    end

    def with_operands(*operands)
      dup{|copy| copy.operands = operands}
    end

  protected

    def operands=(operands)
      @operands = operands.map{|op|
        if op.is_a?(Symbol) or op.is_a?(String)
          Operator::VarRef.new(context, op.to_sym)
        else
          op
        end
      }
    end

    def clean_computed_attributes!
      @heading = nil
      @keys = nil
    end

  end # module Operator
end # module Alf
require_relative 'operator/class_methods'
require_relative 'operator/signature'

require_relative 'operator/var_ref'
require_relative 'operator/nullary'
require_relative 'operator/unary'
require_relative 'operator/binary'
require_relative 'operator/experimental'
