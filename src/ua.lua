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
function ua.create(file)
    local ualoc = {}        -- our new object
    setmetatable(ualoc,ua)  -- make UA handle lookup
    
    ualoc.content = ua.readAll(file)
    if ualoc.content then
        ualoc.result = json.decode(ualoc.content)
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
            if res then
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
        if res then
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
        if res then
           return true
        end
    end
    return false
end

--[[
    Test if user agent is Tablet
    @param string userAgent
    @return bool
]]--
function ua:isMobile(userAgent)
    
    if self.result then
        for key,value in pairs(self.result['uaMatch']) do
        	for key2,value2 in pairs(value) do
            	res = lib.match(userAgent, value2)
            	if res then
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
            if res then
                return true
            end
        end
    end
    return false
end

--[[
    Get device type
    @param string userAgent
    @return bool
]]--

return ua
