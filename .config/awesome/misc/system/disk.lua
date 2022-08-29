local awful = require("awful")
local update_interval = 10 -- every 3 minutes

-- Use /dev/sdxY according to your setup
local disk_script =
    [[
    sh -c "
    df -kh $(df . | grep -Eo '/dev/\w+') | tail -1 | awk '{printf \"%d@%d\", $4, $3}'
    "
]]

-- Periodically get disk space info
awful.widget.watch(
    disk_script,
    update_interval,
    function(_, stdout)
        local available = tonumber(stdout:match("^(.*)@"))
        local used = tonumber(stdout:match("@(.*)$"))
        awesome.emit_signal("system::disk", used, available + used)
    end
)
