require 'spec_helper'
module Alf
  describe AttrList, 'intersect?' do

    subject{ left.intersect?(right) }

    context 'when equal' do
      let(:left){ AttrList[:id, :name] }
      let(:right){ AttrList[:name, :id] }

      it{ should be_true }
    end

    context 'when not equal but intersect' do
      let(:left){ AttrList[:id] }
      let(:right){ AttrList[:name, :id] }

      it{ should be_true }
    end

    context 'when disjoint' do
      let(:left){ AttrList[:status] }
      let(:right){ AttrList[:name, :id] }

      it{ should be_false }
    end

    context 'when both empty' do
      let(:left){ AttrList[] }
      let(:right){ AttrList[] }

      it{ should be_true }
    end

  end
end