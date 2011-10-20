module EzDecoder
  class OrangerEinzahlungsschein

    def initialize(kodierzeile)
      @kodierzeile = kodierzeile
    end

    def referenz_nummer
      if @kodierzeile =~ />(\d+)\+\s/
        $~[1]
      end
    end

    def teilnehmer_nummer
      if @kodierzeile =~ /\+\s(\d+)>?$/
        $~[1]
      end
    end

    def betrag
      return nil if esr_plus?
      franken = @kodierzeile[2,8]
      rappen = @kodierzeile[10, 2]
      BigDecimal.new("#{franken}.#{rappen}")
    end

    def esr?
      @kodierzeile[13] == '>'
    end

    def esr_plus?
      @kodierzeile[3] == '>'
    end

    def belegartcode
      @kodierzeile[0,2]
    end

  end
end
