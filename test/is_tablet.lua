package.path = package.path .. ";../src/?.lua"
require 'ua'

detect = ua.create('../src/Mobile_Detect.json')
userAgentNexus = "Mozilla/5.0 (Linux; Android 4.3; Nexus 10 Build/JWR66Y) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.82 Safari/537.36"
userAgentIpad = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"

print(detect:isTablet(userAgentIpad))
print(detect:isTablet(userAgentNexus))
print(detect:isTablet("Firefox"))