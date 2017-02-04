
ENV['RAILS_ENV'] ||= 'test'

require 'bundler/setup'

require 'simplecov'
require 'rspec'
require 'active_support'


SimpleCov.start 'rails' do
  add_group 'Models', 'app/models'
end

require File.expand_path('../../config/environment', __FILE__)

Dir[Rails.root.join('lib/**/*.rb')].each do |f|
  require f
end

require 'rspec/rails'
