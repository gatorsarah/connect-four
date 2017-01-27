
ENV['RAILS_ENV'] ||= 'test'

require 'bundler/setup'

require 'simplecov'
require 'rspec'

SimpleCov.start 'rails' do
  add_group 'Models', 'app/models'
end

require File.expand_path('../../config/environment', __FILE__)
