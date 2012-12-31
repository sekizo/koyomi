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
	cal.nth_wday(1, :sat).to_s # => "2012-12-01"
	
	# cycle: 1st, 3rd week's tuesday or friday.
	# (japanese) 周期：第１、第３の火曜と金曜
	cal.cycles([1, 3], [:tue, :fri]).collect { |d| d.to_s }
	# => ["2012-12-04", "2012-12-07", "2012-12-18", "2012-12-21"]
	
	# cycle: every montday.
	# (japanese) 周期：毎週月曜
	cal.cycles(:every, [:mon]).collect { |d| d.to_s }
	# => ["2012-12-03", "2012-12-10", "2012-12-17", "2012-12-24", "2012-12-31"]
	

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
