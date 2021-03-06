require 'spec_helper'
module Alf
  module Types
    describe Tuple, "rename" do

      let(:tuple){ Tuple(:id => 1, :name => "Alf") }

      subject{ tuple.rename(:name => :first_name) }

      it { should eq(Tuple(:id => 1, :first_name => "Alf")) }

    end
  end
end
