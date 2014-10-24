ua-lua
======

ua-lua is a small lib written in LUA providing device type detection.

ua-lua is detecting mobile or tablet devices based on user-agent inside nginx daemon.

Maybe not as accurate as WURFL but its small and fast processing.

No need to run complex backend scripts, you can save time and ressources (socket,cpu) by redirecting client to the appropriate end point (location, upstream, host).

## REQUIREMENTS

You need nginx running with LUA module :

http://wiki.nginx.org/HttpLuaModule#Installation

## INSTALL

Mac OSX install instructions:

```
cmd> brew install luarocks
cmd> luarocks install json2lua
cmd> brew install pcre
cmd> luarocks install lrexlib-pcre
cmd> git clone https://github.com/robinef/ua-lua.git
```

Linux install instructions:

```
cmd> apt-get install luarocks
cmd> luarocks install json2lua
cmd> apt-get install libpcrecpp0
cmd> luarocks install lrexlib-pcre
cmd> git clone https://github.com/robinef/ua-lua.git
```

## TESTS AND EXAMPLES

```
cmd> cd test
cmd> lua is_tablet.lua
true
```

## USAGE

ua-lua can help you redirecting your mobile user on a specific location or upstream in NGINX.
See http://wiki.nginx.org/HttpLuaModule for more info about NGINX Lua module

First init the ua-lua class for performance by loading all regexp:
```
init_by_lua '
require "ua"
detect = ua.create("/path/to/Mobile_Detect.json")
';
```

Then in any /location you can:
```
content_by_lua '
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

## Tuning

You can always create an in memory dictionary by storing already parsed user-agent :

http://wiki.nginx.org/HttpLuaModule#ngx.shared.DICT

## BENCH

On a small linux server Ubuntu 14.04 with 2 CPU, 4Go RAM :

800 req/sec

## CREDITS

Using json regexp config from http://mobiledetect.net/
