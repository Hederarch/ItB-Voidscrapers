local mod = modApi:getCurrentMod()

local palette = {
    id = mod.id,
    name = "Astral Teal", 
    image = "img/units/player/turtle_mech.png", --change MyMech by the name of the mech you want to display
    colorMap = {
        lights =         { 255, 212, 58 }, --PlateHighlight
        main_highlight = { 98, 132,  134 }, --PlateLight
        main_light =     {  71,  93,  108 }, --PlateMid
        main_mid =       {  34,  46,  66 }, --PlateDark
        main_dark =      { 19,  24,  45 }, --PlateOutline
        metal_light =    { 120,  118,  128 }, --BodyHighlight
        metal_mid =      {  56,  53,  66 }, --BodyColor
        metal_dark =     {  38, 34, 49 }, --PlateShadow
    },
}

modApi:addPalette(palette)

 