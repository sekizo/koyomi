# encoding: utf-8

lib = File.expand_path('../../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Define base module
module Koyomi
end

Dir.glob(File.join(lib, "**/*.rb")).each do |f|
  require f
end
