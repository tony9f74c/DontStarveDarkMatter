local assets = {
    Asset("ANIM", "anim/darkpylon.zip"),
}

local prefabs = {
    "darkmote",
}

local function onOpen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
end 

local function onClose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
end

local function onHammered(inst, worker)
    if inst.components.container then
        inst.components.container:DropEverything()
    end
    if inst.components.workable then
        inst:RemoveComponent("workable")
    end
    inst.SoundEmitter:PlaySound("dontstarve/sanity/shadowhand_snuff")
    inst.AnimState:PlayAnimation("destroyed")
    inst:DoTaskInTime(0.5, function()
        inst:Remove()
    end)
end

local function fn(Sim)

    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("darkpylon")
    inst.AnimState:SetBuild("darkpylon")
    inst.AnimState:PlayAnimation("idle", true)
    inst.entity:AddSoundEmitter()

    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.entity:AddDynamicShadow()
    inst.DynamicShadow:SetSize(10,5)

    MakeObstaclePhysics(inst, 0.5, 0.5) -- can't pass through
    
    inst:AddTag("darkPylon")

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("darkpylon.tex")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then return inst end

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("darkpylon")
    inst.components.container.onopenfn = onOpen
    inst.components.container.onclosefn = onClose

    inst:AddComponent("inspectable")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(6)
    inst.components.workable:SetOnFinishCallback(onHammered)

    local function exchangeItems(inst)
        local hasTradable = inst.components.container:FindItem(function(tradable)
            return tradable:HasTag("hasDarkValue")
        end)
        if hasTradable then
            if hasTradable.components.stackable then
                hasTradable.components.stackable:Get():Remove()
                for k = 1, hasTradable.darkValue, 1 do
                    inst.components.container:GiveItem(SpawnPrefab("darkmote"))
                end
            else
                hasTradable:Remove()
                for k = 1, hasTradable.darkValue, 1 do
                    inst.components.container:GiveItem(SpawnPrefab("darkmote"))
                end
            end
        end
    end
    inst:DoPeriodicTask(1, exchangeItems)

    return inst
end

return Prefab("common/objects/darkpylon", fn, assets, prefabs),
       MakePlacer("common/darkpylon_placer", "darkpylon", "darkpylon", "idle")
