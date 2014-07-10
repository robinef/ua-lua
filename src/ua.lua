json = require('json')
lib = require('rex_pcre')

ua = {}
ua.__index = ua


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
    Test if user agent is Iphone
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
