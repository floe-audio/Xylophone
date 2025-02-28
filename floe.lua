local library = floe.new_library({
    name = "Xylophone",
    tagline = "A simple xylophone",
    author = "Freepats",
    library_url = "https://freepats.zenvoid.org/ChromaticPercussion/xylophone.html",
})

local instrument = floe.new_instrument(library, {
    name = "Xylophone",
})

for _, velocity in ipairs({ "pp", "ff" }) do
    local velocity_range = { 0, 90 }
    if velocity == "ff" then
        velocity_range = { 30, 100 }
    end

    -- Floe end key is exclusive
    local regions = {
        { note_name = "C3", root_key = 48, key_range = { 0, 52 } },
        { note_name = "G3", root_key = 55, key_range = { 52, 58 } },
        { note_name = "C4", root_key = 60, key_range = { 58, 64 } },
        { note_name = "G4", root_key = 67, key_range = { 64, 70 } },
        { note_name = "C5", root_key = 72, key_range = { 70, 76 } },
        { note_name = "G5", root_key = 79, key_range = { 76, 82 } },
        { note_name = "C6", root_key = 84, key_range = { 82, 88 } },
        { note_name = "G6", root_key = 91, key_range = { 88, 94 } },
        { note_name = "C7", root_key = 96, key_range = { 94, 128 } },
    }

    for _, region in ipairs(regions) do
        floe.add_region(instrument, {
            file = {
                path = "samples/" .. region.note_name .. "_" .. velocity .. ".flac",
                root_key = region.root_key,
            },
            trigger_criteria = {
                key_range = region.key_range,
                velocity_range = velocity_range,
            },
            options = {
                feather_overlapping_velocity_regions = true,
            },
        })
    end
end

return library
