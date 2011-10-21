# -*- coding: utf-8 -*-
require "ez_decoder/version"

module EzDecoder
  class InvalidInputError < StandardError; end

  autoload :OrangerEinzahlungsschein, 'ez_decoder/oranger_einzahlungsschein'
  autoload :RoterEinzahlungsschein, 'ez_decoder/roter_einzahlungsschein'

  def self.decode(line)
    if line.length == 10 || line.length == 39
      RoterEinzahlungsschein.new(line)
    elsif line =~ /\d+\+\s\d+>/
      OrangerEinzahlungsschein.new(line)
    else
      raise InvalidInputError, "'#{line}' ist keine gültige Kodierzeile"
    end
  end

end
