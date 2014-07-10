package.path = package.path .. ";../src/?.lua"
require 'ua'

detect = ua.create('/Users/fred/Documents/ua-lua/ua-lua/src/Mobile_Detect.json')

local userAgentIpad = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
print(ua.isPhone(userAgentIpad))