--[[

     Licensed under GNU General Public License v2
      * (c) 2013, Luke Bonham

--]]

local newtimer     = require("lain.helpers").newtimer

local wibox        = require("wibox")

local io           = { open = io.open }
local tonumber     = tonumber

local setmetatable = setmetatable

-- corefan
-- lain.widgets.fan
local fan = {}

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 2
    local fan1_output = args.fan1_file
    local fan2_output = args.fan2_file
    local settings = args.settings or function() end

    fan.widget = wibox.widget.textbox('')

    function update()

        data = {}
        data.fan1_speed = "N/A"
        data.fan2_speed = "N/A"
        if fan1_output then
            local f = io.open(fan1_output)
            if f then
                data.fan1_speed = tonumber(f:read("*all"))
                f:close()
            end
        end
        if fan2_output then
            local f = io.open(fan2_output)
            if f then
                data.fan2_speed = tonumber(f:read("*all"))
                f:close()
            end
        end

        widget = fan.widget
        settings()
    end

    newtimer("corefan", timeout, update)

    return fan.widget
end

return setmetatable(fan, { __call = function(_, ...) return worker(...) end })
