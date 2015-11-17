dir = File.join(File.dirname(__FILE__), "error")

Dir.glob(File.join(dir, "**/*.rb")).each do |f|
  require f
end
