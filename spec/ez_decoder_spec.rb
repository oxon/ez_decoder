# -*- coding: utf-8 -*-
require 'ez_decoder'

describe EzDecoder do

  context "Einzahlungsscheine erkennen" do

    it "Erkennt orange Einzahlungsscheine für Bankzahlungen" do
      einzahlungsschein = EzDecoder.decode('000000000000000000234512342+ 070888845>')
      einzahlungsschein.should be_kind_of(EzDecoder::RoterEinzahlungsschein)
    end

    it "Erkennt rote Einzahlungsscheine für Postzahlungen" do
      einzahlungsschein = EzDecoder.decode('250090342>')
      einzahlungsschein.should be_kind_of(EzDecoder::RoterEinzahlungsschein)
    end

    it "Erkennt orange Einzahlungsscheine für ESR Zahlungen" do
      einzahlungsschein = EzDecoder.decode('0100003949754>3139471430009018+ 010001628')
      einzahlungsschein.should be_kind_of(EzDecoder::OrangerEinzahlungsschein)
    end

    it "Erkennt orange Einzahlungsscheine für ESR+ Zahlungen" do
      einzahlungsschein = EzDecoder.decode('042>000003371215982190000781348+ 010001628')
      einzahlungsschein.should be_kind_of(EzDecoder::OrangerEinzahlungsschein)
    end
  end

end
