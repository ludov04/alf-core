require 'spec_helper'
module Alf
  module Algebra
    describe Project, 'heading' do

      let(:operand){
        an_operand.with_heading(:id => Integer, :name => String)
      }

      subject{ op.heading }

      context '-no-allbut' do
        let(:op){ 
          a_lispy.project(operand, [:id])
        }
        let(:expected){
          Heading[:id => Integer]
        }

        it { should eq(expected) }
      end

      context '--allbut' do
        let(:op){ 
          a_lispy.project(operand, [:name], :allbut => true)
        }
        let(:expected){
          Heading[:id => Integer]
        }

        it { should eq(expected) }
      end

    end
  end
end
