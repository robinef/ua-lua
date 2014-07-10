function readAll(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end

--[[

]]--
json = require('json')
lib = require('rex_pcre')
content = readAll('Mobile_Detect.json')
result = json.decode(content)


function isPhone(userAgent)
	for key,value in pairs(result['uaMatch']['phones']) do
		res = lib.match(userAgent, value)
    	if res then
    		return true
    	end
	end
	return false
end

function isTablet(userAgent)
	for key,value in pairs(result['uaMatch']['tablets']) do
		res = lib.match(userAgent, value)
    	if res then
    		return true
    	end
	end
	return false
end

local userAgentIphone = "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"
local userAgentIpad = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3"

print(isPhone(userAgentIphone))
print(isPhone(userAgentIpad))