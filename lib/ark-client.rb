require 'ezid-client'
require "ezid/test_helper"

Ezid::Client.configure do |config|
  config.user = TEST_USER
  config.password = "apitest"
  config.default_shoulder = TEST_ARK_SHOULDER
end
                                
