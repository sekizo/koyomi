# Koyomi

Extends Date class to handling with calendar.

## Installation

Add this line to your application's Gemfile:

    gem 'koyomi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install koyomi

## Usage

Handling calendar by this gem.

(japanese) カレンダーを取り扱うための gem です。

	require "koyomi"
	cal = Koyomi::Calendar.new(2012, 12, :mon)
	cal.first.to_s # => "2012-11-26"
	
	cal.first.week_end? # => false
	cal.first.week_end?(:tue) # => true
	
	month = cal.the_month
	month.first.to_s # => "2012-12-01"
	
	week = Koyomi::Week.new(month.first, :tue)
	week.first.to_s # => "2012-11-27"
	
	# weeks and week days.
	
	# nth week day.
	#
	# Version 0.0.5 or later, NOT compatible version 0.0.4.x.
	# To get version 0.0.4 compatible result, use Koyomi::Month#nth_wday.
	#
	# (japanese)
	# バージョン 0.0.5 以上では、バージョン 0.0.4.x と互換性がありません。
	# 以前のバージョンと同様の結果を得るためには、 Koyomi::Month#nth_wday メソッドを利用して下さい。
	# 
	cal.nth_wday(1, :sat).to_s
	# => "2012-12-01"
	cal.nth_wday(1, :tue).to_s
	# => "2012-11-27"
	cal.the_month.nth_wday(1, :tue).to_s
	# => "2012-12-04"
	
	# cycle: every monday.
	# (japanese) 周期：毎週月曜
	cal.cycles(:every, :mon).collect { |d| d.to_s }
	# => ["2012-11-26", "2012-12-03", "2012-12-10", "2012-12-17", "2012-12-24", "2012-12-31"]
	#
	# Version 0.0.5 or later, NOT compatible version 0.0.4.x.
	# To get version 0.0.4 compatible result, use Koyomi::Month#cycles.
	#
	# (japanese)
	# バージョン 0.0.5 以上では、バージョン 0.0.4.x と互換性がありません。
	# 以前のバージョンと同様の結果を得るためには、 Koyomi::Month#cycles メソッドを利用して下さい。
	# 
	cal.the_month.cycles(:every, :mon).collect { |d| d.to_s }
	# => ["2012-12-03", "2012-12-10", "2012-12-17", "2012-12-24", "2012-12-31"]
	
	# cycle: 1st, 3rd week's tuesday or friday.
	# (japanese) 周期：第１、第３の火曜と金曜
	# 
	cal.cycles([1, 3], [:tue, :fri]).collect { |d| d.to_s }
	# => ["2012-11-27", "2012-11-30", "2012-12-11", "2012-12-14"]
	cal.the_month.cycles([1, 3], [:tue, :fri]).collect { |d| d.to_s }
	# => ["2012-12-04", "2012-12-07", "2012-12-18", "2012-12-21"]
	

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
