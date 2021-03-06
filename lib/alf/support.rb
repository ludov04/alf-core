module Alf
  #
  # Provides tooling methods that are used here and there in Alf.
  #
  module Support

    extend self
  end # module Support
  Tools = Support
end # module Alf
require_relative 'support/registry'
require_relative 'support/coerce'
require_relative 'support/to_ruby_literal'
require_relative 'support/to_lispy'
require_relative 'support/scope'
require_relative 'support/tuple_scope'
require_relative 'support/miscellaneous'
require_relative 'support/ordered_set'
require_relative 'support/config'
require_relative 'support/dot_utils'
require_relative 'support/tree'
require_relative 'support/csv_utils'
