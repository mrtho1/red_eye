$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'red_eye/geo-coder'
require 'red_eye/bias'
require 'red_eye/lat-lng'
require 'red_eye/placemark'
require 'red_eye/result'
require 'red_eye/constants'

module RedEye
  VERSION = '0.0.1'
  GOOGLE_APP_ID = "ABQIAAAA3HdfrnxFAPWyY-aiJUxmqRTJQa0g3IQ9GZqIMmInSLzwtGDKaBQ0KYLwBEKSM7F9gCevcsIf6WPuIQ"
end