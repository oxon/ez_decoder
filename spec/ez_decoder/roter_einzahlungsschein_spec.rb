require 'ez_decoder'

describe EzDecoder::RoterEinzahlungsschein do

  subject { EzDecoder::RoterEinzahlungsschein.new(kodierzeile) }


  context "Bei Bankzahlungen" do
    let(:kodierzeile) { '000000000000000000234512342+ 070888845>' }

    it { should be_bankzahlung }
    it { should_not be_postzahlung }

    its(:art) { should == :einzahlungsschein_rot }
    its(:konto_nummer) { should == '00000000000000000023451234' }
    its(:bankenclearing_nummer) { should == '08888' }
  end

  context "Bei Postzahlungen" do
    let(:kodierzeile) { '250090342>' }

    it { should be_postzahlung }
    it { should_not be_bankzahlung }

    its(:art) { should == :einzahlungsschein_rot }
    its(:konto_nummer) { should == '250090342' }
    its(:bankenclearing_nummer) { should be_nil }
  end

end
