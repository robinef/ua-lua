ua-lua
======

ua-lua is a small script detecting mobile device using HTTP user-agent header


## INSTALL 

Mac OSX install instructions

```
cmd> brew install luarocks
cmd> luarocks install json2lua
cmd> brew install pcre
cmd> luarocks install lrexlib-pcre
cmd> git clone https://github.com/robinef/ua-lua.git
```

## TESTS

```
cmd> cd test
cmd> luajit is_tablet.lua
true
```

## USAGE

ua-lua can help you redirecting your mobile user on a specific location or upstream in NGINX.
See http://wiki.nginx.org/HttpLuaModule for more info about NGINX Lua module

First init the ua-lua class for performance:
```
init_by_lua '
require "ua"
detect = ua.create("/path/to/Mobile_Detect.json")
';
```

Then in any location you can:
```
content_by_lua '
		 
		 ngx.header["Content-type"] = "text/plain"  
     ngx.send_headers()
		 local h = ngx.req.get_headers()
		 local userAgent = h["User-Agent"]
		 local type = ""
		 if detect:isMobile(userAgent) then
			type = detect:isTablet(userAgent) and "tablet" or "phone"
		 else
		      type = "other"
		  end
		  ngx.say(type)
		';
```

## BENCH

On a small linux server Ubuntu 14.04 with 2 CPU, 4Go RAM :

800 req/sec

## CREDITS

Using json regexp config from http://mobiledetect.net/
