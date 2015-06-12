package.path = package.path .. ";../src/?.lua"
require 'ua'

detect = ua.create('../src/Mobile_Detect.json')

userAgentIpad = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
userAgentGoogleBot = "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
userAgentGoogleMoblieBot = "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

print(detect:isMobile(userAgentIpad))
print(detect:isMobile(userAgentGoogleBot))
print(detect:isMobile(userAgentGoogleMoblieBot))