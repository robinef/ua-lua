ua = {}
ua.__index = ua

--[[
	Require lib json and regxp-pcre
	@link http://luaforge.net/projects/json/
	@link http://luaforge.net/projects/lrexlib/
]]--
local ok,json = pcall(require, "json")
if not ok then
    error("json module required")
end
local ok,lib = pcall(require, "rex_pcre")
if not ok then
    error("rex_pcre module required")
end


--[[
    Class ctor
    @param string JSON user agent config file
    @return class
]]--
function ua.create(mobileDetectFile, osVersionFile)
    local ualoc = {}        -- our new object
    setmetatable(ualoc,ua)  -- make UA handle lookup
    
    if mobileDetectFile ~= nil then
        ualoc.content = ua.readAll(mobileDetectFile)
        if ualoc.content then
            ualoc.result = json.decode(ualoc.content)
        end
    end
    
    if osVersionFile ~= nil then
        ualoc.content2 = ua.readAll(osVersionFile)
        if ualoc.content2 then
            ualoc.osversions = json.decode(ualoc.content2)
        end
    end
    return ualoc
end

--[[
    Read file and bufferize content
    @param string Filename
    @return string File content
]]--
function ua.readAll(file)
    local f = io.open(file, "rb")
    local content = ""
    if f then
         content = f:read("*all")
        f:close()
    end
    return content
end

--[[
    Test if user agent is phone
    @param string userAgent
    @return bool
]]--
function ua:isPhone(userAgent)
    if self.result then
        for key,value in pairs(self.result['uaMatch']['phones']) do
            res = lib.match(userAgent, value)
	    if res ~= nil then
                return true
            end
        end
    end
    return false
end


--[[
    Test if user agent is iPad
    @param string userAgent
    @return bool
]]--
function ua:isIpad(userAgent)
    if self.result then
      	res = lib.match(userAgent, self.result['uaMatch']['tablets']['iPad'])
	if res ~= nil then
           return true
        end
    end
    return false
end

--[[
    Test if user agent is iPhone
    @param string userAgent
    @return bool
]]--
function ua:isIphone(userAgent)
    if self.result then
      	res = lib.match(userAgent, self.result['uaMatch']['phones']['iPhone'])
	if res ~= nil then
           return true
        end
    end
    return false
end

--[[
    Test if user agent is Mobile
    @param string userAgent
    @return bool
]]--
function ua:isMobile(userAgent)
    
    if self.result then
        for key,value in pairs(self.result['uaMatch']) do
        	for key2,value2 in pairs(value) do
            	res = lib.match(userAgent, value2)
		if res ~= nil then
                	return true
            	end
            end
        end
    end
    return false
end

--[[
    Test if user agent is Tablet
    @param string userAgent
    @return bool
]]--
function ua:isTablet(userAgent)
    
    if self.result then
        for key,value in pairs(self.result['uaMatch']['tablets']) do
            res = lib.match(userAgent, value)
            if res ~= nil then
                return true
            end
        end
    end
    return false
end

--[[
    Get OS from user-agent
    @param string userAgent
    @return string if found or nil
]]
function ua:getOS(userAgent)
    if self.osversions then
        for key, value in pairs(self.osversions['osLookups']) do
            res = lib.match(userAgent, value)
            if res ~= nil then
                os = lib.match(res, self.osversions['osPattern'])
                return os
            end
        end
    end
    return nil
end

--[[
    Get version of OS from user-agent (from a physical mobile device)
    @param string userAgent
    @return string if found or nil
]]
function ua:getOSVersion(userAgent)
    if self.osversions then
        for key, value in pairs(self.osversions['osLookups']) do
            res = lib.match(userAgent, value)
            if res ~= nil then
                version = lib.match(res, self.osversions['versionPattern'])
                return version
            end
        end
    end
    return nil
end

return ua
