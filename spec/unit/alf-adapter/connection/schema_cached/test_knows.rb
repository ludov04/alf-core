require 'spec_helper'
module Alf
  class Adapter
    class Connection
      describe SchemaCached, "knows?" do
        let(:connection_method){ :knows? }

        it_should_behave_like 'a cached connection method'
      end
    end
  end
end
