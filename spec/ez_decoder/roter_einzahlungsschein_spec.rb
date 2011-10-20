require 'ez_decoder'

describe EzDecoder::RoterEinzahlungsschein do

  subject { EzDecoder::RoterEinzahlungsschein.new(kodierzeile) }

  context "Bei Bankzahlungen" do
    let(:kodierzeile) { '000000000000000000234512342+ 070888845>' }

    its(:konto_nummer) { should == '000000000000000000234512342' }
    its(:bank_clearing) { should == '070888845' }
  end

  context "Bei Postzahlungen" do
    let(:kodierzeile) { '250090342>' }

    its(:konto_nummer) { should == '250090342' }
    its(:bank_clearing) { should be_nil }
  end

end
