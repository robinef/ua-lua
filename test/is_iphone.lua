package.path = package.path .. ";../src/?.lua"
require 'ua'

detect = ua.create('../src/Mobile_Detect.json')
userAgentIphone = "Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X; en-us) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53"

print(detect:isIphone(userAgentIphone))