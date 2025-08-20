floe.set_required_floe_version("0.12.1");

local library = floe.new_library({
    name = "Xylophone",
    tagline = "A basic xylophone",
    library_url = "https://github.com/Floe-Project/Xylophone",
    author = "Floe Ports",
    author_url = "https://freepats.zenvoid.org/ChromaticPercussion/xylophone.html",
    background_image_path = "688290359_8128ed73da_k.jpg",
    icon_image_path = "icon.png",
    description = "A multisampled xylophone from the free, public domain FreePats project.",
})

local instrument = floe.new_instrument(library, {
    name = "Xylophone",
    description = "Multisampled xylophone.",
    tags = { "acoustic", "tonal percussion", "solo", "metal", "orchestral", "cinematic", "world" },
})

floe.add_named_key_range(instrument, {
    name = "Natural Range",
    key_range = { 48, 97 },
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
            path = "samples/" .. region.note_name .. "_" .. velocity .. ".flac",
            root_key = region.root_key,
            trigger_criteria = {
                key_range = region.key_range,
                velocity_range = velocity_range,
                feather_overlapping_velocity_regions = true,
            },
        })
    end
end

return library
