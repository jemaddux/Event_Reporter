require_relative "../bin/event_reporter"
require_relative "../lib/help"
require_relative "../lib/queue"
require "csv"
require "rainbow"


RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end