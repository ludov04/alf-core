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
require_relative 'support/to_tuple'
require_relative 'support/to_relation'
require_relative 'support/scope'
require_relative 'support/tuple_scope'
require_relative 'support/fake_operand'
require_relative 'support/miscellaneous'