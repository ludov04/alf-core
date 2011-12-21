require 'spec_helper'
module Alf::Shell::Operator
  describe Rank do

    let(:input){ [] }
    subject{ Rank.run(argv) }

    before do
      subject.should be_a(Alf::Operator::Relational::Rank)
      subject.operands.should eq([input])
    end

    context "without name" do
      let(:argv){ [input, "--", "time"] }
      specify{
        subject.order.should eq(Alf::Ordering[[:time, :asc]])
        subject.as.should eq(:rank)
      }
    end

    context "with explicit name" do
      let(:argv){ [input, "--","time", "desc", "--", "newname"] }
      specify{
        subject.order.should eq(Alf::Ordering[[:time, :desc]])
        subject.as.should eq(:newname)
      }
    end

  end
end
