module Alf
  module Operator
    # 
    # Encapsulates method that allows making operator introspection, that is,
    # knowing operator cardinality and similar stuff.
    # 
    module ClassMethods
      
      #
      # Returns true if this operator is an unary operator, false otherwise
      #
      def unary?
        ancestors.include?(Operator::Unary)
      end

      #
      # Returns true if this operator is a binary operator, false otherwise
      #
      def binary?
        ancestors.include?(Operator::Binary)
      end

      #
      # Installs or set the operator signature
      #
      def signature
        if block_given?
          @signature = Tools::Signature.new &Proc.new
          @signature.install(self)
          options do |opt|
            signature.fill_option_parser(opt, self)
          end
        else
          @signature || Tools::Signature::EMPTY
        end
      end
      
    end # module ClassMethods

    #
    # Yields non-relational then relational operators, in turn.
    #
    def self.each
      Operator::NonRelational.each{|x| yield(x)}
      Operator::Relational.each{|x| yield(x)}
    end
    
    # Ensures that the Introspection module is set on real operators
    def self.included(mod)
      mod.extend(ClassMethods) if mod.is_a?(Class)
    end
      
  end # module Operator
end # module Alf
