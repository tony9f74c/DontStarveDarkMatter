PrefabFiles = {
    "darkmatter",
    "darkmote",
    "darkpylon",
}

local modAssets = {
    "darkmatter",
    "darkmote",
    "darkpylon",
    "pouchsmall_grey",
    "pouchmedium_grey",
    "pouchbig_grey",
}

Assets = {}
for k=1,#modAssets,1 do
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/"..modAssets[k]..".xml"))
end

local _G = GLOBAL
local STRINGS = _G.STRINGS
local RECIPETABS = _G.RECIPETABS
local Recipe = _G.Recipe
local Ingredient = _G.Ingredient
local TECH = _G.TECH
local getConfig = GetModConfigData
local containers = _G.require "containers"
local Vector3 = _G.Vector3
local SetSharedLootTable = _G.SetSharedLootTable

-- STRINGS --

STRINGS.NAMES.DARKMATTER = "Dark Matter"
STRINGS.RECIPE_DESC.DARKMATTER = "Home-made dark matter."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKMATTER = "I should drop this on the ground, see what happens."
STRINGS.NAMES.DARKMOTE = "Dark Mote"
STRINGS.RECIPE_DESC.DARKMOTE = "Used to create Dark Matter."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKMOTE = "It's used to create Dark Matter."
STRINGS.NAMES.DARKPYLON = "Dark Pylon"
STRINGS.RECIPE_DESC.DARKPYLON = "Turns most things into Dark Motes."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKPYLON = "It feeds on everything!"

-- RECIPES --

local recipeTabs = {RECIPETABS.TOOLS,
    RECIPETABS.SURVIVAL,
    RECIPETABS.FARM,
    RECIPETABS.SCIENCE,
    RECIPETABS.TOWN,
    RECIPETABS.REFINE,
    RECIPETABS.MAGIC,
}
local recipeTab = recipeTabs[getConfig("cfgRecipeTab")]

local recipeTechs = {
    TECH.NONE,
    TECH.SCIENCE_ONE, -- Science Machine
    TECH.SCIENCE_TWO, -- Alchemy Engine
    TECH.MAGIC_TWO, -- Prestihatitator
    TECH.MAGIC_THREE, -- Shadow Manipulator
    TECH.ANCIENT_TWO, -- Broken APS
    TECH.ANCIENT_FOUR, -- Repaired APS
    TECH.OBSIDIAN_TWO, -- Obsidian Workbench
}
local recipeTech = recipeTechs[getConfig("cfgRecipeTech")]

local dmMotes = Ingredient("darkmote", getConfig("cfgDMMotes"))
local dpMotes = Ingredient("darkmote", getConfig("cfgDPMotes"))
dmMotes.atlas = "images/inventoryimages/darkmote.xml"
dpMotes.atlas = "images/inventoryimages/darkmote.xml"

-- Dark Mote --
local darkMote = AddRecipe("darkmote", {Ingredient("goldnugget", 1)}, recipeTab, TECH.NONE, nil, nil, nil, 3)
darkMote.atlas = "images/inventoryimages/darkmote.xml"

-- Dark Matter --
local darkMatter = AddRecipe("darkmatter", {dmMotes}, recipeTab, recipeTech)
darkMatter.atlas = "images/inventoryimages/darkmatter.xml"

-- Dark Pylon --
local darkPylon = AddRecipe("darkpylon", {dpMotes,}, recipeTab, recipeTech, "darkpylon_placer", nil, nil, nil, nil, "images/inventoryimages/darkpylon.xml")
 
-- ITEM VALUE --

local itemConfig = {
    {name = "ash",                  value = getConfig("Ash")},
    {name = "boneshard",            value = getConfig("Bone Shard")},
    {name = "charcoal",             value = getConfig("Charcoal")},
    {name = "cutgrass",             value = getConfig("Cut Grass")},
    {name = "cutreeds",             value = getConfig("Cut Reeds")},
    {name = "feather_crow",         value = getConfig("Jet Feather")},
    {name = "flint",                value = getConfig("Flint")},
    {name = "log",                  value = getConfig("Log")},
    {name = "poop",                 value = getConfig("Manure")},
    {name = "rocks",                value = getConfig("Rocks")},
    {name = "stinger",              value = getConfig("Stinger")},
    {name = "thulecite_pieces",     value = getConfig("Thulecite Fragments")},
    {name = "twigs",                value = getConfig("Twigs")},
    {name = "slurtle_shellpieces",  value = getConfig("Broken Shell")},
    {name = "feather_robin",        value = getConfig("Crimson Feather")},
    {name = "feather_canary",       value = getConfig("Saffron Feather")},
    {name = "beefalowool",          value = getConfig("Beefalo Wool")},
    {name = "rottenegg",            value = getConfig("Rotten Egg")},
    {name = "beardhair",            value = getConfig("Beard Hair")},
    {name = "silk",                 value = getConfig("Silk")},
    {name = "slurtleslime",         value = getConfig("Slurtle Slime")},
    {name = "spidergland",          value = getConfig("Spider Gland")},
    {name = "nitre",                value = getConfig("Nitre")},
    {name = "feather_robin_winter", value = getConfig("Azure Feather")},
    {name = "goldnugget",           value = getConfig("Gold Nugget")},
    {name = "moonrocknugget",       value = getConfig("Moon Rock")},
    {name = "houndstooth",          value = getConfig("Hound's Tooth")},
    {name = "pigskin",              value = getConfig("Pig Skin")},
    {name = "manrabbit_tail",       value = getConfig("Bunny Puff")},
    {name = "mosquitosack",         value = getConfig("Mosquito Sack")},
    {name = "nightmarefuel",        value = getConfig("Nightmare Fuel")},
    {name = "honeycomb",            value = getConfig("Honeycomb")},
    {name = "lightninggoathorn",    value = getConfig("Volt Goat Horn")},
    {name = "tentaclespots",        value = getConfig("Tentacle Spots")},
    {name = "marble",               value = getConfig("Marble")},
    {name = "thulecite",            value = getConfig("Thulecite")},
    {name = "gears",                value = getConfig("Gears")},
    {name = "livinglog",            value = getConfig("Living Log")},
    {name = "bluegem",              value = getConfig("Blue Gem")},
    {name = "redgem",               value = getConfig("Red Gem")},
    {name = "purplegem",            value = getConfig("Purple Gem")},
    {name = "goose_feather",        value = getConfig("Down Feather")},
    {name = "greengem",             value = getConfig("Green Gem")},
    {name = "walrus_tusk",          value = getConfig("Walrus Tusk")},
    {name = "yellowgem",            value = getConfig("Yellow Gem")},
    {name = "bearger_fur",          value = getConfig("Thick Fur")},
    {name = "deerclops_eyeball",    value = getConfig("Deerclops Eyeball")},
    {name = "dragon_scales",        value = getConfig("Scales")},
    {name = "minotaurhorn",         value = getConfig("Guardian's Horn")},
    {name = "shroom_skin",          value = getConfig("Shroom Skin")},
}

local lootTable = {}
for k = 1, #itemConfig do
    if itemConfig[k].name then -- check if it exists
        local chance = 0.3 / itemConfig[k].value -- calculate drop chance
        table.insert(lootTable, {itemConfig[k].name, chance})
        AddPrefabPostInit(itemConfig[k].name, function(inst)
            inst:AddTag("hasDarkValue")
            inst:AddTag("hasDarkChance")
            inst.darkValue = itemConfig[k].value
        end)
    end
end
SetSharedLootTable('darkmatter', lootTable)

-- MOB/BOSS SPAWNING --

local mobs = {
    "bat",
    "bishop",
    "firehound",
    "frog",
    "ghost",
    "hound",
    "icehound",
    "killerbee",
    "knight",
    "krampus",
    "manrabbit",
    "merm",
    "monkey",
    "moonpig",
    "mosquito",
    "rocky",
    "rook",
    "tallbird",
    "slurtle",
    "spider",
    "spider_healer",
    "spider_hider",
    "spider_spitter",
    "spider_warrior",

    "crawlinghorror",
    "terrorbeak",
}
 
local bosses = {
    "bearger",
    "deerclops",
    "leif",
    "spat",
    "spiderqueen",
    "warg",
}

AddPrefabPostInit("darkmatter", function(inst)
    inst.mobs = mobs
    inst.bosses = bosses
end)

-- CONTAINER --

local params = {}

local containerDetails = {
    {id = 1, name = "pouchsmall", xy = 2, offset = 40, buttonx = 0, buttony = -100},
    {id = 2, name = "pouchmedium", xy = 3, offset = 80, buttonx = 0, buttony = -145},
    {id = 3, name = "pouchbig", xy = 4, offset = 120, buttonx = 0, buttony = -185},
}

local old_widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
    container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        old_widgetsetup(container, prefab, data, ...)
    end
end

local function createContainer()
    local cont = containerDetails[getConfig("cfgContainerSize")]
    local container = {
        widget = {
            slotpos = {},
            animbank = nil,
            animbuild = nil,
            bgimage = cont.name.."_grey.tex",
            bgatlas = "images/inventoryimages/"..cont.name.."_grey.xml",
            pos = Vector3(getConfig("cfgXPos"),getConfig("cfgYPos"),0),
            side_align_tip = 160,
        },
        type = "chest",
    }

    for y = (cont.xy or cont.y), 1, -1 do
        for x = 1, (cont.xy or cont.x) do
            table.insert(container.widget.slotpos, Vector3(80 * (x-1) - (cont.offset or cont.xoffset), 80 * (y-1) - (cont.offset or cont.yoffset), 0))
        end
    end

    return container
end
params["darkpylon"] = createContainer()

-- ITEM TEST --

function params.darkpylon.itemtestfn(container, item, slot)
    return item:HasTag("hasDarkValue") or item.prefab == "darkmote"
end

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
