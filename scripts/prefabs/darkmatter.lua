require "prefabutil"

local assets = {
    Asset("ATLAS", "images/inventoryimages/darkmatter.xml"),
    Asset("IMAGE", "images/inventoryimages/darkmatter.tex"),
}

local getConfig = GetModConfigData
local maxDamage = getConfig("cfgDMMaxDmg", "workshop-2710596052") or getConfig("cfgDMMaxDmg", "DontStarveDarkMatter")

local function onDropped(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local player = FindClosestPlayerInRange(x, y, z, 1)
    local chance = math.random(1000)
    -- 0.1% chance to spawn a boss 
    if chance == 666 then
        local randomBoss = inst.bosses[math.random(#inst.bosses)]
        local boss = SpawnPrefab(randomBoss)
        boss.Transform:SetPosition(x + 5, y + 5, z)
        boss.components.combat:SetTarget(player)
    -- 5% chance to spawn a mob
    elseif chance <= 50 then
        local randomMob = inst.mobs[math.random(#inst.mobs)]
        local mob = SpawnPrefab(randomMob)
        mob.Transform:SetPosition(x + 5, y + 5, z)
        mob.components.combat:SetTarget(player)
    else
        local cycles = 1
        local jackpot = math.random(10000)
        local damage = math.random(maxDamage)
        -- 0.001% chance to drop items 99 more times and restore full health
        if jackpot == 1337 then
            cycles = 100
            damage = -1000
        end
        player.components.health:DoDelta(-damage) -- does damage when used
        local oldHammerLootPercent = TUNING.HAMMER_LOOT_PERCENT
        TUNING.HAMMER_LOOT_PERCENT = 0
        inst:Remove()
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/iceboulder_smash")
        for x = 1, cycles do
            inst.components.lootdropper:DropLoot()
        end
        TUNING.HAMMER_LOOT_PERCENT = oldHammerLootPercent
    end
end

local function fn(Sim)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/darkmatter.xml"
    inst.components.inventoryitem.cangoincontainer = true
    
    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable('darkmatter')
    inst:ListenForEvent("ondropped", onDropped)

    inst.mobs = {}
    inst.bosses = {}

    return inst

end

return Prefab("common/inventory/darkmatter", fn, assets)
