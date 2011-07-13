module Alf
  #
  # Defines an in-memory relation 
  #
  class Relation
    include Iterator
    
    protected
    
    # @return [Set] the set of tuples
    attr_reader :tuples
    
    public
    
    #
    # Creates a Relation instance.
    #
    # @param [Set] tuples a set of tuples
    #
    def initialize(tuples)
      raise ArgumentError unless tuples.is_a?(Set)
      @tuples = tuples
    end
    
    #
    # Coerces `val` to a relation
    #
    def self.coerce(val)
      case val
      when Relation
        val
      when Set
        Relation.new(val)
      when Array
        Relation.new val.to_set
      when Iterator
        Relation.new val.to_set
      else
        raise ArgumentError, "Unable to coerce #{val} to a Relation"
      end
    end
    
    # (see Relation.coerce)
    def self.[](*tuples)
      coerce(tuples)
    end
    
    #
    # (see Iterator#each)
    #
    def each(&block)
      tuples.each(&block)
    end
    
    #
    # Returns relation's cardinality (number of tuples)
    # 
    def cardinality
      tuples.size
    end
    alias :size :cardinality
    alias :count :cardinality
    
    # 
    # Install the DSL through iteration over defined operators
    #
    Operator::each do |op_class|
      meth_name = Tools.ruby_case(Tools.class_name(op_class)).to_sym
      if op_class.unary?
        define_method(meth_name) do |*args|
          op = op_class.new(*args).pipe(self)
          Relation.coerce(op)
        end
      elsif op_class.binary?
        define_method(meth_name) do |right, *args|
          op = op_class.new(*args).pipe([self, Iterator.coerce(right)])
          Relation.coerce(op)
        end
      else
        raise "Unexpected operator #{op_class}"
      end
    end # Operators::each
      
    alias :+ :union
    alias :- :minus
        
    #
    # (see Object#hash)
    #
    def hash
      @tuples.hash
    end
    
    #
    # (see Object#==)
    #
    def ==(other)
      return nil unless other.is_a?(Relation)
      other.tuples == self.tuples
    end
    alias :eql? :==
    
    #
    # Returns a textual representation of this relation
    #
    def to_s
      Alf::Renderer.text(self).execute("")
    end
    
    #
    # Returns a  literal representation of this relation
    #
    def inspect
      "Alf::Relation[" << @tuples.collect{|t| t.inspect}.join(',') << "]"
    end

  end # class Relation
end # module Alf