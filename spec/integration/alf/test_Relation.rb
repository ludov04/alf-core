require 'spec_helper'
module Alf
  describe "Relation" do

    let(:expected){ Alf::Relation.new([ {:name => "Jones"} ].to_set) }

    it 'works as expected on a tuple' do
      Alf::Relation(:name => "Jones").should eq(expected)
    end

    it 'works as expected on a Reader' do
      File.open(File.expand_path("../example.rash", __FILE__), "r") do |io|
        reader = Alf::Reader.rash(io)
        rel    = Alf::Relation(reader)
        rel.should eq(expected)
      end
    end

    it 'works as expected on an Operator' do
      op = Alf.lispy.compile{
        extend(Relation::DEE, :name => lambda{ "Jones" })
      }
      def op.each(*args, &bl)
        raise if defined?(@already_called)
        @already_called = true
        super
      end
      Alf::Relation(op).should eq(expected)
    end

  end
end