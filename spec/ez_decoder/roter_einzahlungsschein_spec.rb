require 'ez_decoder'

describe EzDecoder::RoterEinzahlungsschein do

  subject { EzDecoder::RoterEinzahlungsschein.new(kodierzeile) }


  context "Bei Bankzahlungen" do
    let(:kodierzeile) { '000000000000000000234512342+ 070888845>' }

    its(:art) { should == :einzahlungsschein_rot }
    its(:konto_nummer) { should == '000000000000000000234512342' }
    its(:bankenclearing) { should == '070888845' }
    its(:bankenclearing_nummer) { should == '08888' }
  end

  context "Bei Postzahlungen" do
    let(:kodierzeile) { '250090342>' }

    its(:art) { should == :einzahlungsschein_rot }
    its(:konto_nummer) { should == '250090342' }
    its(:bankenclearing) { should be_nil }
    its(:bankenclearing_nummer) { should be_nil }
  end

end
