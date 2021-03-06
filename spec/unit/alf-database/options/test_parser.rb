require 'spec_helper'
module Alf
  class Database
    describe Options, "parser" do

      subject{ opts.parser }

      let(:opts){ Options.new }

      context 'by default' do

        it { should be(Lang::Parser::Lispy) }
      end

      context 'when explicitely set' do
        before{ opts.parser = Lang::Parser::Safer }

        it{ should be(Lang::Parser::Safer) }
      end

    end
  end
end
