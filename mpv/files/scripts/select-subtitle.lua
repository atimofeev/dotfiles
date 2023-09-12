-- Select 'Full' subs by default
function on_start(_, _)
    local tracks = mp.get_property_native("track-list")

    for _, track in pairs(tracks) do
        if track["type"] == "sub" and string.match(string.lower(track["title"]), string.lower("Full")) then
            mp.set_property("sid", track["id"])
            return
        end
    end
end

mp.register_event("file-loaded", on_start)
