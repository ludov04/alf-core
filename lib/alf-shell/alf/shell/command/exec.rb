module Alf
  module Shell
    class Exec < Shell::Command()
      
      def execute(args)
        Reader.alf(args.first || $stdin, requester.database)
      end
      
    end # class Exec
  end # module Shell
end # module Alf
