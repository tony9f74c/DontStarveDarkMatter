name = "Dark Matter"
description = "Adds Dark Motes, Dark Matter and Dark Pylon to the game."
author = "https://steamcommunity.com/profiles/76561198002269576"
version = "1.28"
forumthread = ""
api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"dark", "matter"}

local function setCount(k)
    return {description = ""..k.."", data = k}
end

local function setTab(k)
    local name = {"Tools", "Survival", "Farm", "Science", "Structures", "Refine", "Magic"}
    return {description = ""..name[k].."", data = k}
end

local function setTech(k)
    local name = {"None", "Science Machine", "Alchemy Engine", "Prestihatitator", "Shadow Manip.", "Broken APS", "Repaired APS"}
    return {description = ""..name[k].."", data = k}
end

local function setSize(k)
    local slots = {4, 9, 16}
    return {description = ""..slots[k].." slots", data = k}
end

local tab = {} for k=1,7,1 do tab[k] = setTab(k) end
local tech = {} for k=1,7,1 do tech[k] = setTech(k) end
local darkMotes = {} for k=1,20,1 do darkMotes[k] = setCount(k*5) end
local damage = {} for k=1,10,1 do damage[k] = setCount(k*10) end
local position = {} for k=1,41,1 do position[k] = setCount(k*25-525) end
local size = {} for k=1,3,1 do size[k] = setSize(k) end
local value = {} for k=1,100,1 do value[k] = setCount(k) end

local items = {
    {name = "Ash",                   value = 1},
    {name = "Azure Feather",         value = 2},
    {name = "Beard Hair",            value = 2},
    {name = "Beefalo Wool",          value = 2},
    {name = "Blue Gem",              value = 10},
    {name = "Bone Shard",            value = 1},
    {name = "Broken Shell",          value = 1},
    {name = "Bunny Puff",            value = 3},
    {name = "Charcoal",              value = 1},
    {name = "Crimson Feather",       value = 2},
    {name = "Cut Grass",             value = 1},
    {name = "Cut Reeds",             value = 1},
    {name = "Deerclops Eyeball",     value = 50},
    {name = "Down Feather",          value = 20},
    {name = "Flint",                 value = 1},
    {name = "Gears",                 value = 5},
    {name = "Gold Nugget",           value = 3},
    {name = "Green Gem",             value = 20},
    {name = "Guardian's Horn",       value = 50},
    {name = "Honeycomb",             value = 5},
    {name = "Hound's Tooth",         value = 2},
    {name = "Jet Feather",           value = 1},
    {name = "Living Log",            value = 10},
    {name = "Log",                   value = 1},
    {name = "Manure",                value = 1},
    {name = "Marble",                value = 5},
    {name = "Moon Rock",             value = 3},
    {name = "Mosquito Sack",         value = 3},
    {name = "Nightmare Fuel",        value = 5},
    {name = "Nitre",                 value = 2},
    {name = "Pig Skin",              value = 3},
    {name = "Purple Gem",            value = 10},
    {name = "Red Gem",               value = 10},
    {name = "Rocks",                 value = 1},
    {name = "Rotten Egg",            value = 2},
    {name = "Saffron Feather",       value = 2},
    {name = "Scales",                value = 50},
    {name = "Shroom Skin",           value = 50},
    {name = "Silk",                  value = 2},
    {name = "Slurtle Slime",         value = 2},
    {name = "Spider Gland",          value = 2},
    {name = "Stinger",               value = 1},
    {name = "Tentacle Spots",        value = 5},
    {name = "Thick Fur",             value = 50},
    {name = "Thulecite Fragments",   value = 1},
    {name = "Thulecite",             value = 5},
    {name = "Twigs",                 value = 1},
    {name = "Volt Goat Horn",        value = 5},
    {name = "Walrus Tusk",           value = 20},
    {name = "Yellow Gem",            value = 20},
}

local function newOption(name, label, options, default, hover)
    return {name = name, label = label, options = options, default = default, hover = hover}
end

local options = {
    newOption("cfgRecipeTab",       "Recipe Tab",               tab,        1,      "The crafting tab on which the recipes are found."),
    newOption("cfgRecipeTech",      "Recipe Tech",              tech,       5,      "The research building required to see/craft the recipes."),
    newOption("cfgDMMotes",         "DM Dark Motes",            darkMotes,  100,    "The amount of Dark Motes required to craft the Dark Matter."),
    newOption("cfgDMMaxDmg",        "DM Max Damage Taken",      damage,     40,     "The max amount of damage taken when breaking Dark Matter."),
    newOption("cfgDPMotes",         "DP Dark Motes",            darkMotes,  50,     "The amount of Dark Motes required to craft the Dark Pylon."),
    newOption("cfgContainerSize",   "DP Container Size",        size,       2,      "The size of the Dark Portal's container."),
    newOption("cfgXPos",            "UI Horizontal Position",   position,   0,      "The horizontal position of the pouch window."),
    newOption("cfgYPos",            "UI Vertical Position",     position,   100,    "The vertical position of the pouch window."),
}

-- Divider
options[#options+1] = newOption("divItemValues", "Item Values", {{description = "", data = false},}, false, "")

-- Item values
for k=1, #items, 1 do
    options[#options+1] = newOption(items[k].name, items[k].name, value, items[k].value, "How many Dark Motes it is worth.")
end

configuration_options = options