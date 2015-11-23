require "koyomi/month"

class Koyomi::MonthCycle
  attr_reader :koyomi_month
  attr_reader :dates

  def initialize(koyomi_month)
    super()
    @koyomi_month = koyomi_month
    @dates = []
  end

  def add(*args)

    while arg = args.shift
      case arg
      when Date
        raise Koyomi::WrongRangeError unless koyomi_month.range.include?(arg)
        @dates << arg
      else
        #_args = [arg]
        #_args << args.shift
        @dates += koyomi_month.cycles(*arg)
      end
    end
    uniq_and_sort
    self
  end

  private

  def uniq_and_sort
    @dates = @dates.uniq.sort
  end
end
