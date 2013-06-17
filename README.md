# HttperfOutputParser

HttperfOutputParser is a gem for parsing the output of httperf.

> [Httperf](http://code.google.com/p/httperf/) is a tool for measuring web server performance. It provides a flexible facility for generating various HTTP workloads and for measuring server performance.

httperf is run from the command line outputs information like this:

    # httperf --client=0/1 --server=10.10.0.201 --port=889 --uri=/hello.txt --send-buffer=4096 --recv-buffer=16384 --ssl --num-conns=20000 --hog --ssl-no-reuse
    Maximum connect burst length: 1

    Total: connections 20000 requests 20000 replies 20000 test-duration 350.422 s

    Connection rate: 57.1 conn/s (17.5 ms/conn, <=1 concurrent connections)
    Connection time [ms]: min 10.9 avg 17.5 max 3027.5 median 11.5 stddev 105.9
    Connection time [ms]: connect 16.3
    Connection length [replies/conn]: 1.000

    Request rate: 57.1 req/s (17.5 ms/req)
    Request size [B]: 73.0

    Reply rate [replies/s]: min 6.4 avg 57.0 max 80.6 stddev 19.9 (70 samples)
    Reply time [ms]: response 1.2 transfer 0.0
    Reply size [B]: header 215.0 content 6.0 footer 0.0 (total 221.0)
    Reply status: 1xx=0 2xx=20000 3xx=0 4xx=0 5xx=0

    CPU time [s]: user 141.21 system 208.21 (user 40.3% system 59.4% total 99.7%)
    Net I/O: 16.4 KB/s (0.1*10^6 bps)

    Errors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0
    Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0

httperf is great, but if you're running more than a few tests and need to log the output (in a database or spreadsheet etc.) then copy/pasting the values from this output becomes tedious. I wrote HttperfOutputParser to make it easier to get these values in machine readable/processable form.

Currently I'm parsing out these values because these are what I need:

    Total connections
    Total time (s)
    conn/s
    ms/conn
      min
      avg
      max
      median
      stddev
    Request rate (req/s)
    ms per request
      min
      avg
      max
      stddev
    Reply time (ms)

If you need more then feel free to send a pull request.

## Installation

Add this line to your application's Gemfile:

    gem 'httperf-output-parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install httperf-output-parser

## Usage

``` ruby
require 'httperf-output-parser'
parser = HttperfOutputParser.new
	
# Pass the parser a string
results = parser.parse(STDIN.read)
	
# Result will just be a hash
puts results.inspect
	
# with the hash we can do something with the data, like create a CSV:
puts %w{
    total_connections
    test_duration
    connections_per_sec
    min_ms_per_connection
    avg_ms_per_connection
    max_ms_per_connection
    median_ms_per_connection
    stddev_ms_per_connection
    request_rate_per_sec
    ms_per_request
    min_ms_per_request
    avg_ms_per_request
    max_ms_per_request
    stddev_ms_per_request
    reply_time_response
}.map {|dt| results[dt.to_sym]}.join "\t"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

* Will Jessop (will@willj.net)

