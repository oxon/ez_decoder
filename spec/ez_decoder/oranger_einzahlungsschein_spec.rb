require 'bigdecimal'
require 'ez_decoder'

describe EzDecoder::OrangerEinzahlungsschein do

  subject { EzDecoder::OrangerEinzahlungsschein.new(kodierzeile) }

  context "5-stelliger Teilnehmer-Nr." do
    context "ESR (mit vorgedruckter Betragsangabe)" do
      let(:kodierzeile) { '<050001000012035> 241170032660178+ 10304>' }

      its(:art) { should == :einzahlungsschein_orange }
      its(:belegartcode) { should == '01' }
      its(:betrag) { should == BigDecimal.new('120.35') }
      its(:referenz_nummer) { should == '241170032660178' }
      its(:teilnehmer_nummer) { should == '10304' }
    end

    context "ESR+ (ohne vorgedruckte Betragsangabe)" do
      let(:kodierzeile) { '110112111111000+ 10304>' }

      its(:art) { should == :einzahlungsschein_orange }
      its(:belegartcode) { should be_nil }
      its(:betrag) { should be_nil }
      its(:referenz_nummer) { should == '110112111111000' }
      its(:teilnehmer_nummer) { should == '10304' }
    end
  end

  context "9-stelliger Teilnehmer-Nr." do
    context "16-stellige Referenznummer" do
      context "ESR (mit vorgedruckter Betragsangabe)" do
        let(:kodierzeile) { '0100003949754>3139471430009018+ 010001628' }

        it { should be_esr }
        it { should_not be_esr_plus }

        its(:art) { should == :einzahlungsschein_orange }
        its(:belegartcode) { should == '01' }
        its(:betrag) { should == BigDecimal.new('3949.75') }
        its(:referenz_nummer) { should == '3139471430009018' }
        its(:teilnehmer_nummer) { should == '010001628' }
      end

      context "ESR+ (ohne vorgedruckte Betragsangabe)" do
        let(:kodierzeile) { '042>8257144175289632+ 010001628' }

        it { should_not be_esr }
        it { should be_esr_plus }

        its(:art) { should == :einzahlungsschein_orange }
        its(:belegartcode) { should == '04' }
        its(:betrag) { should == nil }
        its(:referenz_nummer) { should == '8257144175289632' }
        its(:teilnehmer_nummer) { should == '010001628' }
      end
    end

    context "27-stellige Referenznummer" do
      context "ESR (mit vorgedruckter Betragsangabe)" do
        let(:kodierzeile) { '0100000132451>000003371215982190000781348+ 010001628' }

        it { should be_esr }
        it { should_not be_esr_plus }

        its(:art) { should == :einzahlungsschein_orange }
        its(:belegartcode) { should == '01' }
        its(:betrag) { should == BigDecimal.new('132.45') }
        its(:referenz_nummer) { should == '000003371215982190000781348' }
        its(:teilnehmer_nummer) { should == '010001628' }
      end

      context "ESR+ (ohne vorgedruckte Betragsangabe)" do
        let(:kodierzeile) { '042>000003371215982190000781348+ 010001628' }

        it { should_not be_esr }
        it { should be_esr_plus }

        its(:art) { should == :einzahlungsschein_orange }
        its(:belegartcode) { should == '04' }
        its(:betrag) { should == nil }
        its(:referenz_nummer) { should == '000003371215982190000781348' }
        its(:teilnehmer_nummer) { should == '010001628' }
      end
    end
  end


end
