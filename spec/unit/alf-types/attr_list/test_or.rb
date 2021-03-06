require 'spec_helper'
module Alf
  describe AttrList, "|" do

    let(:list){ AttrList.new [:id, :name] }

    context 'disjoint lists' do
      subject{ list | [:status] }

      it{ should eq(AttrList[:id, :name, :status]) }
    end

    context 'non disjoint lists' do
      subject{ list | [:id, :status] }

      it{ should eq(AttrList[:id, :name, :status]) }
    end

  end
end
