require 'mp'
require 'os'

local function copyTime()
    local time_pos = mp.get_property_number("time-pos")
    local time_in_seconds = time_pos
    local time_seg = time_pos % 60
    time_pos = time_pos - time_seg
    local time_hours = math.floor(time_pos / 3600)
    time_pos = time_pos - (time_hours * 3600)
    local time_minutes = time_pos/60
    time_seg,time_ms=string.format("%.03f", time_seg):match"([^.]*).(.*)"

    -- time = string.format("%02d:%02d:%02d.%s", time_hours, time_minutes, time_seg, time_ms)
    -- ms is not necessary for me
    time = string.format("%02d:%02d:%02d", time_hours, time_minutes, time_seg)
    mp.osd_message(string.format("Copied to Clipboard: %s", time))
    os.execute("echo -n " ..time.. "|xclip -sel clip")
end

mp.add_key_binding("Ctrl+c", "copyTime", copyTime)
