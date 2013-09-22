require 'compiler_helper'
module Alf
  module Engine
    describe Compilable, "minus" do

      subject{
        Compilable.new(leaf).minus(expr)
      }

      let(:right){
        compact(an_operand)
      }

      let(:expr){
        minus(an_operand, right)
      }

      it_should_behave_like "a compilable"

      it 'has a Join::Hash cog' do
        resulting_cog.should be_a(Semi::Hash)
      end

      it 'has the correct left sub-cog' do
        resulting_cog.left.should be(leaf)
      end

      it 'has the correct right sub-cog' do
        resulting_cog.right.should be_a(Compact)
      end

      it 'has the correct predicate' do
        resulting_cog.predicate.should be_false
      end

    end
  end
end