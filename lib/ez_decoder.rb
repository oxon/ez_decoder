require "ez_decoder/version"

module EzDecoder

  autoload :OrangerEinzahlungsschein, 'ez_decoder/oranger_einzahlungsschein'
  autoload :RoterEinzahlungsschein, 'ez_decoder/roter_einzahlungsschein'

  def self.decode(line)
    if line.length == 10 || line.length == 39
      RoterEinzahlungsschein.new(line)
    else
      OrangerEinzahlungsschein.new(line)
    end
  end

end
