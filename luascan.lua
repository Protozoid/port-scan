#!/usr/bin/env lua

--------------------------------------------------------------
-- @Description: Simple demonstrational port scanner using LuaSocket
-- @Author: Forget Me Not (The Unintelligible)
-- @Contact: xxprotozoid@live.com

-- @Version: v0.1

-- @License: GNU General Public License v3 (GPLv3) - http://www.gnu.org/copyleft/gpl.html
--------------------------------------------------------------

require "socket"

----------------------------------------------
--- Scanner class
----------------------------------------------

local scanner = {}

function scanner.scan(address, port_range)
	local function split(inputStr, sep)
        if sep == nil then
			sep = "%s"
		end

		t={} ; i=1

		for str in string.gmatch(inputStr, "([^"..sep.."]+)") do
			t[i] = str
			i = i + 1
        end

		return t
	end

	local port_arr = split(port_range, '-') -- Create array from the assumed string provided in this format: "{port span 1}-{port span 2}"

	for p = tonumber(port_arr[1]), tonumber(port_arr[2]) do
		local sock = socket.tcp()
		local s = sock:connect(address, p)

		sock:close()

		if s then
			print("Port " .. p .. " is open.")
		end
	end
end

----------------------------------------------
--- Main program
----------------------------------------------

local function main()
	if #arg ~= 2 then
		print "Insufficient command line arguments received. Syntax: luascan.lua [ip/hostname] [range]"
		os.exit(1)
	end

	scanner.scan(arg[1], arg[2])
end

main()
