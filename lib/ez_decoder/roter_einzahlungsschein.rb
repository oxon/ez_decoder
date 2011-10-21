module EzDecoder
  class RoterEinzahlungsschein

    def initialize(kodierzeile)
      @kodierzeile = kodierzeile
    end

    def art
      :einzahlungsschein_rot
    end

    def postzahlung?
      @kodierzeile.length == 10
    end

    def bankzahlung?
      !postzahlung?
    end

    def konto_nummer
      if bankzahlung?
        konto_nummer_sektion[0..-2]
      else
        konto_nummer_sektion
      end
    end

    def konto_nummer_sektion
      if @kodierzeile =~ /(\d+)(?:\+|>)/
        $~[1]
      end
    end

    def bankenclearing_sektion
      if @kodierzeile =~ /\+\s(\d+)>/
        $~[1]
      end
    end

    def bankenclearing_nummer
      return nil unless bankenclearing_sektion
      bankenclearing_sektion[2, 5]
    end
  end
end
