# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ENV['MAX_COLUMNS'] ||= '7'
ENV['MAX_ROWS'] ||= '6'
