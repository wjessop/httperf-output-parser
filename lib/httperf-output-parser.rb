require "httperf-output-parser/version"

class HttperfOutputParser
	def parse(raw_httperf_output)
		# http://rubular.com/r/EZ4xSydMlk
		matches = raw_httperf_output.match(/connections (\d+).+duration ([\d.]+).+Connection rate: ([\d.]+).+Connection time \[ms\]: min ([\d.]+) avg ([\d.]+) max ([\d.]+) median ([\d.]+) stddev ([\d.]+).+Request rate: ([\d.]+) req\/s \(([\d.]+).+Reply rate.+min ([\d.]+) avg ([\d.]+) max ([\d.]+) stddev ([\d.]+).+Reply time.+response ([\d.]+)/m)
		parsed_values = {}
		15.times do |i|
			parsed_values[data_types[i].to_sym] = matches[i+1].to_f
		end
		return parsed_values
	end
	
	private
	
	def data_types
		%w{
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
		}
	end
end
