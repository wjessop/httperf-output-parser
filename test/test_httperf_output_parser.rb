require 'test/unit'
require 'test_helper'
require 'httperf-output-parser'
require 'yaml'

class HttperfOutputParserTest < Test::Unit::TestCase
	def test_initialize_with_invalid_params
		assert_raise(ArgumentError)  { HttperfOutputParser.new("Not expecting this!") }
	end
	
	def test_initialize
		parser = HttperfOutputParser.new
		assert_equal parser.class, HttperfOutputParser
	end
	
	def test_httperf_output_parsing
		YAML.load_file('test/httperf_sample_output.yml').each do |result|
			parser = HttperfOutputParser.new
			parsed_values = parser.parse(result["raw_output"])

			assert_equal result["total_connections"], parsed_values[:total_connections]
			assert_equal result["test_duration"], parsed_values[:test_duration]
			assert_equal result["connections_per_sec"], parsed_values[:connections_per_sec]
			assert_equal result["min_ms_per_connection"], parsed_values[:min_ms_per_connection]
			assert_equal result["avg_ms_per_connection"], parsed_values[:avg_ms_per_connection]
			assert_equal result["max_ms_per_connection"], parsed_values[:max_ms_per_connection]
			assert_equal result["median_ms_per_connection"], parsed_values[:median_ms_per_connection]
			assert_equal result["stddev_ms_per_connection"], parsed_values[:stddev_ms_per_connection]
			assert_equal result["request_rate_per_sec"], parsed_values[:request_rate_per_sec]
			assert_equal result["ms_per_request"], parsed_values[:ms_per_request]
			assert_equal result["min_ms_per_request"], parsed_values[:min_ms_per_request]
			assert_equal result["avg_ms_per_request"], parsed_values[:avg_ms_per_request]
			assert_equal result["max_ms_per_request"], parsed_values[:max_ms_per_request]
			assert_equal result["stddev_ms_per_request"], parsed_values[:stddev_ms_per_request]
			assert_equal result["response_reply_time"], parsed_values[:response_reply_time]
		end
	end
end