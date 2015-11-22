# encoding: utf-8

require "koyomi/init"

module Koyomi
  def self.year(year)
    Koyomi::Year.new(year)
  end

  private

  def self.method_missing(name, *args, &block)
    if "#{name}".match(/^_[0-9]+$/)
        self.year("#{name}".sub(/_/, "").to_i)
    else
      super
    end
  end
end
