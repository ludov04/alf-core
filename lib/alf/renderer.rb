module Alf
  #
  # Renders a relation iterator in a specific format.
  #
  # A renderer takes a tuple iterator as input and renders it on an output stream.
  # Similarly to the {Reader} class, this one provides a registration mechanism for
  # specific output formats. The common scenario is as follows:
  #
  #   # Register a new renderer for :foo format (automatically provides the
  #   # '--foo   Render output as a foo stream' option of 'alf show') and with
  #   # the FooRenderer class for handling rendering.
  #   Renderer.register(:foo, "as a foo stream", FooRenderer)
  #
  #   # Later on, you can request a renderer instance for a specific format
  #   # as follows (wiring input is optional)
  #   r = Renderer.renderer(:foo, [an iterator])
  #
  #   # Also, a factory method is automatically installed on the Renderer class
  #   # itself.
  #   r = Renderer.foo([an iterator])
  #
  class Renderer
    include Enumerable

    class << self
      include Support::Registry

      #
      # Register a renderering class with a given name and description.
      #
      # Registered class must at least provide a constructor with an empty
      # signature. The name must be a symbol which can safely be used as a ruby
      # method name. A factory class method of that name and degelation signature
      # is automatically installed on the Renderer class.
      #
      # @param [Symbol] name a name for the output format
      # @param [String] description an output format description (for 'alf show')
      # @param [Class] clazz Renderer subclass used to render in this format
      #
      def register(name, description, clazz)
        super([name, description, clazz], Renderer)
      end

      #
      # Returns a Renderer instance for the given output format name.
      #
      # @param [Symbol] name name of an output format previously registered
      # @param [...] args other arguments to pass to the renderer constructor
      # @return [Renderer] a Renderer instance, already wired if args are
      #         provided
      #
      def renderer(name, *args)
        if r = registered.find{|triple| triple.first == name}
          r.last.new(*args)
        else
          raise "No renderer registered for #{name}"
        end
      end

      #
      # Returns a Renderer instance for the given mime type.
      #
      # @param [String] mime_type a given (simplified) MIME type
      # @param [...] args other arguments to pass to the renderer constructor
      # @return [Renderer] a Renderer instance, already wired if args are provided
      #
      def by_mime_type(mime_type, *args)
        if r = registered.find{|_,_,c| c.mime_type == mime_type}
          r.last.new(*args)
        else
          raise UnsupportedMimeTypeError, "No renderer for `#{mime_type}`"
        end
      end

    end # class << self

    # Default renderer options
    DEFAULT_OPTIONS = {}

    # Renderer tuple iterator
    attr_accessor :input

    # @return [Hash] Renderer's options
    attr_accessor :options

    # Creates a reader instance.
    #
    # @param [#each] iterator an iterator of tuples to render
    # @param [Hash] options Reader's options (see doc of subclasses)
    def initialize(input, options = {})
      @input   = input
      @options = self.class.const_get(:DEFAULT_OPTIONS).merge(options || {})
    end

    # Executes the rendering, outputting the resulting tuples on the provided
    # output buffer.
    #
    # The default implementation delegates the call to {#render}.
    def execute(output = $stdout)
      each do |str|
        output << str
      end
      output
    end

  private

    def each_tuple(&bl)
      return bl.call(input) if TupleLike===input
      input.each(&bl)
    end

  end # class Renderer
end # module Alf
require_relative 'renderer/rash'
require_relative 'renderer/text'
require_relative 'renderer/yaml'
require_relative 'renderer/json'
require_relative 'renderer/csv'
require_relative 'renderer/html'
