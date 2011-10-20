require "ez_decoder/version"

module EzDecoder

  autoload :OrangerEinzahlungsschein, 'ez_decoder/oranger_einzahlungsschein'
  autoload :RoterEinzahlungsschein, 'ez_decoder/roter_einzahlungsschein'

  def self.anzahl_teile_der_esr_kodierzeile
    3
  end

  def self.decode(line)
    parts = line.gsub(/\s/, '').split(/[^0-9]/)
    if parts.count == anzahl_teile_der_esr_kodierzeile
      OrangerEinzahlungsschein.new(line)
    else
      RoterEinzahlungsschein.new(line)
    end
  end

end
