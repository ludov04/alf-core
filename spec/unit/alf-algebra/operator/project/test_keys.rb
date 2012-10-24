require 'spec_helper'
module Alf
  module Algebra
    describe Project, 'keys' do

      let(:operand){
        an_operand.with_heading(id: Integer, name: String, status: String).
                   with_keys([:id], [:name])
      }

      subject{ op.keys }

      context 'when conserving at least one key' do
        let(:op){
          a_lispy.project(operand, [:id, :status])
        }
        let(:expected){
          Keys[ [:id] ]
        }

        it { should eq(expected) }
      end

      context 'when projecting all keys away' do
        let(:op){
          a_lispy.project(operand, [:status])
        }
        let(:expected){
          Keys[ [:status] ]
        }

        it { should eq(expected) }
      end

      context 'when a key is projected due to a constant restriction' do
        let(:operand){
          an_operand.with_heading(sid: Integer, pid: Integer)
                    .with_keys([:sid, :pid])
        }
        let(:op){
          a_lispy.project(a_lispy.restrict(operand, sid: 1), [:pid])
        }
        let(:expected){
          Keys[ [:pid] ]
        }

        it { should eq(expected) }
      end

    end
  end
end
