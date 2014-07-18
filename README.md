ua-lua
======

LUA User-Agent detector


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


## CREDITS

Using json regexp config from http://mobiledetect.net/
