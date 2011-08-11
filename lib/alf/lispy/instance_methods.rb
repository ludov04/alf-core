module Alf
  module Lispy
    
    alias :ruby_extend :extend
    
    # The environment
    attr_accessor :environment
    
    #
    # Compiles a query expression given by a String or a block and returns
    # the result (typically a tuple iterator)
    #
    # Example
    #
    #   # with a string
    #   op = compile "(restrict :suppliers, lambda{ city == 'London' })"
    #
    #   # or with a block
    #   op = compile {
    #     (restrict :suppliers, lambda{ city == 'London' })
    #   }
    #
    # @param [String] expr a Lispy expression to compile
    # @return [Iterator] the iterator resulting from compilation
    #
    def compile(expr = nil, path = nil, &block)
      if expr.nil? 
        instance_eval(&block)
      else 
        b = _clean_binding
        (path ? Kernel.eval(expr, b, path) : Kernel.eval(expr, b))
      end
    end
  
    #
    # Evaluates a query expression given by a String or a block and returns
    # the result as an in-memory relation (Alf::Relation)
    #
    # Example:
    #
    #   # with a string
    #   rel = evaluate "(restrict :suppliers, lambda{ city == 'London' })"
    #
    #   # or with a block
    #   rel = evaluate {
    #     (restrict :suppliers, lambda{ city == 'London' })
    #   }
    #
    def evaluate(expr = nil, path = nil, &block)
      compile(expr, path, &block).to_rel
    end
    
    #
    # Delegated to the current environment
    #
    # This method returns the dataset associated to a given name. The result
    # may depend on the current environment, but is generally an Iterator, 
    # often a Reader instance.
    #
    # @param [Symbol] name name of the dataset to retrieve
    # @return [Iterator] the dataset as an iterator
    # @see Environment#dataset
    #
    def dataset(name)
      raise "Environment not set" unless @environment
      @environment.dataset(name)
    end

    #
    # Functionally equivalent to Alf::Relation[...]
    #
    def relation(*tuples)
      Relation.coerce(tuples)
    end
   
    # 
    # Install the DSL through iteration over defined operators
    #
    Operator.each do |op_class|
      meth_name = Tools.ruby_case(Tools.class_name(op_class)).to_sym
      if op_class.unary?
        define_method(meth_name) do |child, *args|
          child = Iterator.coerce(child, environment)
          op_class.new(*args).pipe(child, environment)
        end
      elsif op_class.binary?
        define_method(meth_name) do |left, right, *args|
          operands = [left, right].collect{|x| Iterator.coerce(x, environment)}
          op_class.new(*args).pipe(operands, environment)
        end
      elsif op_class.nullary?
        define_method(meth_name) do |*args|
          op_class.new(*args).pipe(nil, environment)
        end
      else
        raise "Unexpected operator #{op_class}"
      end
    end # Operators::each

    # 
    # Install the DSL through iteration over defined aggregators
    #
    Aggregator.each do |agg_class|
      agg_name = Tools.ruby_case(Tools.class_name(agg_class)).to_sym
      if method_defined?(agg_name)
        raise "Unexpected method clash on Lispy: #{agg_name}"
      else
        define_method(agg_name) do |*args, &block|
          agg_class.new(*args, &block)
        end
      end
    end

    def allbut(child, attributes)
      (project child, attributes, :allbut => true)
    end
  
    # 
    # Runs a command as in shell.
    #
    # Example:
    #
    #     lispy = Alf.lispy(Alf::Environment.examples)
    #     op = lispy.run(['restrict', 'suppliers', '--', "city == 'Paris'"])
    #
    def run(argv, requester = nil)
      argv = Quickl.parse_commandline_args(argv) if argv.is_a?(String)
      argv = Quickl.split_commandline_args(argv, '|')
      argv.inject(nil) do |cmd,arr|
        arr.shift if arr.first == "alf"
        main = Alf::Command::Main.new(environment)
        main.stdin_reader = cmd unless cmd.nil?
        main.run(arr, requester)
      end
    end

    private 
    
    def _clean_binding
      binding
    end
  
  end # module Lispy
end # module Alf
