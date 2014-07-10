package.path = package.path .. ";../src/?.lua"
require 'ua'

detect = ua.create('../src/Mobile_Detect.json')

userAgentIpad = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
print(detect:isTablet(userAgentIpad))