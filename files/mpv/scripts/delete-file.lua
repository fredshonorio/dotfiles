local utils = require("mp.utils")

mp.add_key_binding("d", "delete-file", function()
    local path = mp.get_property("path")
    if path then
        mp.command("playlist-next force")
        os.remove(path)
        mp.osd_message("Deleted: " .. path)
    end
end)
