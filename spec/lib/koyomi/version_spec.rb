require "spec_helper"

describe Koyomi::VERSION do
  example("has version") { expect(Koyomi::VERSION).not_to be_empty }
end
