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

``` ruby
require "koyomi"

## Koyomi::Calendar
cal = Koyomi::Calendar.new(2015, 12, :mon)
# The calendar starts monday.
# 30  1  2  3  4  5  6
#  7  8  9 10 11 12 13
# 14 15 16 17 18 19 20
# 21 22 23 24 25 26 27
# 28 29 30 31  1  2  3

cal.first.class
# => Date

cal.first.week_end?
# => false

cal.first.week_end?(:tue)
# => true

cal.first.to_s
# => "2015-11-30"

cal.range.first.to_s
# => "2015-11-30"

cal.range.last.to_s
# => "2016-01-03"

## Koyomi::Month
month = cal.the_month
# The month
#     1  2  3  4  5  6
#  7  8  9 10 11 12 13
# 14 15 16 17 18 19 20
# 21 22 23 24 25 26 27
# 28 29 30 31

month.first.class
# => Date

month.first.to_s
# => "2015-12-01"

## searching dates
cal.nth_wday(1, :mon)
# => #<Date: 2015-11-30 ((2457357j,0s,0n),+0s,2299161j)>
month.nth_wday(1, :mon)
# => #<Date: 2015-12-07 ((2457364j,0s,0n),+0s,2299161j)>

```

Some examples in [Wiki](wiki/examples).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
