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

	require "koyomi"
	cal = Koyomi::Calendar.new(2012, 12, :mon)
	cal.first.to_s # => "2012-11-26"
	
	month = cal.the_month
	month.first.to_s # => "2012-12-01"
	
	week = Koyomi::Week.new(month.first, :tue)
	week.first.to_s # => "2012-11-27"
	
	cal.first.week_end? # => false
	cal.first.week_end?(:tue) # => true

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
