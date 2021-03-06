require 'spec_helper'
module Alf
  describe TupleComputation, "coerce" do

    subject{ TupleComputation.coerce(arg).evaluate(scope) }

    let(:scope) {
      Support::TupleScope.new(status: 10, who: "alf")
    }

    describe "from a TupleComputation" do
      let(:arg){ TupleComputation.new hello: TupleExpression.coerce(:who) }
      it{ should eql(hello: "alf") }
    end

    describe "from a Hash without coercion" do
      let(:arg){
        {:hello  => TupleExpression.coerce(:who),
         :hello2 => ->(t){ t.who } }
      }
      let(:expected){
        {hello: "alf", :hello2 => "alf"}
      }
      it{ should eql(expected) }
    end

    describe "from a Hash with coercion" do
      let(:arg){
        {"hello" => :who}
      }
      let(:expected){
        {hello: "alf"}
      }
      it{ should eql(expected) }
    end

    describe "from a Tuple" do
      let(:arg){ Tuple(hello: TupleExpression.coerce(:who)) }
      let(:expected){ {hello: "alf"} }

      it{ should eql(expected) }
    end

  end
end
