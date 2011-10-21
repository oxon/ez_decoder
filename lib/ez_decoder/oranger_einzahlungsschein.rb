module EzDecoder
  class OrangerEinzahlungsschein

    def initialize(kodierzeile)
      @kodierzeile = kodierzeile
      @strategy_class = detect_strategy
      @strategy = @strategy_class.new(kodierzeile)
    end

    def detect_strategy
      if legacy_esr?
        Teilnehmernummer5Stellig
      else
        Teilnehmernummer7Stellig
      end
    end

    def legacy_esr?
      @kodierzeile.start_with?('<') || @kodierzeile.length == 23
    end

    [:referenz_nummer, :teilnehmer_nummer, :betrag, :esr?, :esr_plus?, :belegartcode].each do |method|
      define_method method do
        @strategy.send method
      end
    end

    class Teilnehmernummer5Stellig
      def initialize(kodierzeile)
        @kodierzeile = kodierzeile
      end

      def referenz_nummer
        if @kodierzeile =~ /(?:>\s|^)(\d+)\+\s/
          $~[1]
        end
      end

      def teilnehmer_nummer
        if @kodierzeile =~ /\+\s(\d+)>$/
          $~[1]
        end
      end

      def betrag
        return nil if esr_plus?
        franken = @kodierzeile[7, 7]
        rappen = @kodierzeile[14, 2]
        BigDecimal.new("#{franken}.#{rappen}")
      end

      def esr?
        @kodierzeile.include?('<')
      end

      def esr_plus?
        !esr?
      end

      def belegartcode
        return nil if esr_plus?
        @kodierzeile[5, 2]
      end

    end

    class Teilnehmernummer7Stellig

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
end
