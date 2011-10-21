module EzDecoder
  class RoterEinzahlungsschein

    def initialize(kodierzeile)
      @kodierzeile = kodierzeile
    end

    def art
      :einzahlungsschein_rot
    end

    def konto_nummer
      if @kodierzeile =~ /(\d+)(?:\+|>)/
        $~[1]
      end
    end

    def bank_clearing
      if @kodierzeile =~ /\+\s(\d+)>/
        $~[1]
      end
    end
  end
end
