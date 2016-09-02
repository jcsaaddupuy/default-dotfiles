local gears     = require "gears"
local lfs       = require "lfs"

---
--
---
function string.ends(haystack, needle)
   return needle == '' or string.sub(haystack, -string.len(needle)) == needle
end


---
-- recursive listdir
---
wp_listdir = function(path, files, filter)
    for file in lfs.dir(path) do

        if file ~= "." and file ~= ".." then
            local f = path..'/'..file
            local attr = lfs.attributes (f)
            if attr.mode == "directory" then
                wp_listdir(f, files, filter)
            else
                if filter(file) then
                    table.insert(files, f)
                end
            end
        end
    end
    return files
end


---
-- setup the timer
---
local wp_random = {

    start = function(args)

        local wp_timeout = args.timeout or 10
        local wp_dir = args.directory  or os.getenv("HOME").."/Images"

        -- extension to include
        local wp_exts = args.exts or {'.png', '.jpg'}


        local wp_files = {}
        --- first round
        -- populate wallpapers
        wp_listdir(wp_dir, wp_files, function(path)
            for i, ext in ipairs(wp_exts) do
                if string.ends(path, ext) then return true end
            end
            return false
        end)
        local wp_index = math.random( 1, #wp_files)
        for s = 1, screen.count() do
            gears.wallpaper.fit(wp_files[wp_index] , s)
        end
        -- / first round

        local wp_timer = timer { timeout = wp_timeout }
        wp_timer:connect_signal("timeout", function()
            -- stop the timer (we don't need multiple instances running at the same time)
            wp_timer:stop()

            for s = 1, screen.count() do
                -- set wallpaper to current index
                gears.wallpaper.fit(wp_files[wp_index] , s)
            end
            -- get next random index
            wp_index = math.random( 1, #wp_files)
            --restart the timer
            wp_timer.timeout = wp_timeout
            wp_timer:start()
        end)

        wp_timer:start()
    end

}
return wp_random
