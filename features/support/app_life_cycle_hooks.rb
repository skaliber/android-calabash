require 'calabash-android/management/adb'
require 'calabash-android/operations'

=begin
Before do |scenario|
  start_test_server_in_background
end
=end


Before do |scenario|
  if (scenario.source_tag_names.include?('@reset'))
    clear_app_data
  end
  start_test_server_in_background
  $screen = Screen.new
  $screen.rotate_to_proper_position()
end


  After do |scenario|
    if scenario.failed?
      print "Test failed: #{scenario.name}\n"
      if scenario.exception.message =="HTTPClient::KeepAliveDisconnected" || scenario.exception.message =="EOFError"
        puts "*********HTTP error!! attempting to restart test server!*************"
        reinstall_test_server
        start_test_server_in_background
      end
      if scenario.failed?
        screenshot_embed
      end
    end

  shutdown_test_server
  end

