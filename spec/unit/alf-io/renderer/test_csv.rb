require 'spec_helper'
module Alf
  class Renderer
    describe CSV do

      context 'the class' do
        subject{ CSV }

        it_should_behave_like "a Renderer class"
      end

      context 'an instance on multiple tuples' do
        let(:input){
          [{:id => 1, :name => "Smith"}, {:id => 2, :name => "Jones"}]
        }

        subject{ renderer.execute(StringIO.new).string }

        describe "without options" do
          let(:renderer){ CSV.new(input) }
          let(:expected){
            "id,name\n1,Smith\n2,Jones\n"
          }

          it{ should eq(expected) }
        end

        describe "with options" do
          let(:renderer){ CSV.new(input, options) }
          let(:options){ {col_sep: ";"} }
          let(:expected){
            "id;name\n1;Smith\n2;Jones\n"
          }

          it{ should eq(expected) }
        end
      end

      context 'an instance on a single tuples' do
        subject{ renderer.execute(StringIO.new).string }

        let(:input){
          {:id => 1, :name => "Smith"}
        }

        describe "without options" do
          let(:renderer){ CSV.new(input) }
          let(:expected){
            "id,name\n1,Smith\n"
          }

          it{ should eq(expected) }
        end

        describe "with options" do
          let(:renderer){ CSV.new(input, options) }
          let(:options){ {col_sep: ";"} }
          let(:expected){
            "id;name\n1;Smith\n"
          }

          it{ should eq(expected) }
        end
      end

    end
  end
end