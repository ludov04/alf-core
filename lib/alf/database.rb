module Alf
  #
  # An database encapsulates the interface with the outside world, providing
  # base iterators for named datasets.
  #
  # An database is typically obtained through the factory defined by this
  # class:
  #
  #   # Returns the default database (examples, for now)
  #   Alf::Database.default
  #
  #   # Returns an database on Alf's examples
  #   Alf::Database.examples
  #
  #   # Returns an database on a specific folder, automatically
  #   # resolving datasources via recognized file extensions (see Reader)
  #   Alf::Database.folder('path/to/a/folder')
  #
  # You can implement your own database by subclassing this class and
  # implementing the {#dataset} method. As additional support is implemented
  # in the base class, Database should never be mimiced.
  #
  # This class provides an extension point allowing to participate to auto
  # detection and resolving of the --db=... option when alf is used in shell.
  # See Database.register, Database.autodetect and Database.recognizes?
  # for details.
  #
  class Database

    class << self

      # Returns registered databases
      #
      # @return [Array<Database>] registered databases.
      def databases
        @databases ||= []
      end

      # Register an database class under a specific name.
      #
      # Registered class must implement a recognizes? method that takes an array
      # of arguments; it must returns true if an database instance can be
      # built using those arguments, false otherwise.
      #
      # Example:
      #
      #     Database.register(:sqlite, MySQLiteEnvClass)
      #     Database.sqlite(...)        # MySQLiteEnvClass.new(...)
      #     Database.autodetect(...)    # => MySQLiteEnvClass.new(...)
      #
      # @see also autodetect and recognizes?
      # @param [Symbol] name name of the database kind
      # @param [Class] clazz class that implemented the database
      def register(name, clazz)
        databases << [name, clazz]
        (class << self; self; end).
          send(:define_method, name) do |*args|
            clazz.new(*args)
          end
      end

      # Auto-detect the database to use for specific arguments.
      #
      # This method returns an instance of the first registered Database
      # class that returns true to an invocation of recognizes?(args). It raises
      # an ArgumentError if no such class can be found.
      #
      # @param [Array] args arguments for the Database constructor
      # @return [Database] an database instance
      # @raise [ArgumentError] when no registered class recognizes the arguments
      def autodetect(*args)
        if (args.size == 1) and args.first.is_a?(Database)
          return args.first
        else
          name, clazz = databases.find{|nc| nc.last.recognizes?(args)}
          return clazz.new(*args) if clazz
        end
        dbs = databases.map{|r| r.last.name}.join(', ')
        raise ArgumentError, "Unable to auto-detect Database with #{args.inspect} [#{dbs}]"
      end
      alias :coerce :autodetect

      # Returns true _args_ can be used for building an database instance,
      # false otherwise.
      #
      # When returning true, an immediate invocation of new(*args) should
      # succeed. While runtime exception are admitted (no such database, for
      # example), argument errors should not occur (missing argument, wrong
      # typing, etc.).
      #
      # Please be specific in the implementation of this extension point, as
      # registered databases for a chain and each of them should have a
      # chance of being selected.
      #
      # @param [Array] args arguments for the Database constructor
      # @return [Boolean] true if an database may be built using `args`,
      #         false otherwise.
      def recognizes?(args)
        false
      end

      # Returns Alf's default database
      #
      # @return [Database] the default database instance.
      def default
        folder '.'
      end

      # Returns an database on Alf's examples
      #
      # @return [Database] an database on Alf's examples.
      def examples
        folder File.expand_path('../../../examples/operators', __FILE__)
      end

    end # class << self

    # Returns a dataset whose name is provided.
    #
    # This method resolves named datasets to tuple enumerables. When the
    # dataset exists, this method must return an Iterator, typically a
    # Reader instance. Otherwise, it must throw a NoSuchDatasetError.
    #
    # @param [Symbol] name the name of a dataset
    # @return [Iterator] an iterator, typically a Reader instance
    # @raise [NoSuchDatasetError] when the dataset does not exists
    def dataset(name)
    end
    undef :dataset

  end # class Database
end # module Alf
require_relative 'database/folder'