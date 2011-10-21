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

    def bankenclearing
      if @kodierzeile =~ /\+\s(\d+)>/
        $~[1]
      end
    end

    def bankenclearing_nummer
      return nil unless bankenclearing
      bankenclearing[2, 5]
    end
  end
end
