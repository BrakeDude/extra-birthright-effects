local mod = ExtraBirthright

mod.LevelBlessing = {
    Name = {
        "Blessing of Maze",
        "Blessing of Found",
        "Blessing of Sun",
        "Blessing of Sight",
        "Blessing of Labyrinth",
    },
    GetId = function(name)
        return Isaac.GetCurseIdByName(name)
    end,
    GetFlag = function(blessing)
        return 1 << (blessing - 1)
    end,
    CheckFlag = function (mask, flag)
        return mask & flag == flag
    end
}

function mod:ReverseCurse(curse)
    if mod.MCMOption.Settings["Bethany"] > 1 then
        for i = 1,mod.game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
            if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
                if (curse == LevelCurse.CURSE_NONE) then
					local randBless = mod.LevelBlessing.GetId(mod.LevelBlessing.Name[player:GetCollectibleRNG(collectible):RandomInt(#mod.LevelBlessing.Name) + 1])
                    return mod.LevelBlessing.GetFlag(randBless)
                else
                    if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_LOST) then
                        return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Found"))
                    end
                    if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_MAZE) then
                        return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Maze"))
                    end
                    if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_DARKNESS) then
                        --player:UseCard(Card.CARD_SUN, UseFlag.USE_NOANNOUNCER)
                        return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Sun"))
                    end
                    if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_BLIND) then
                        --Game():GetLevel():SetCanSeeEverything(true)
                        return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Sight"))
                    end
                end
            end
        end
    end
    return curse
end

function mod:BlessingsUpdate(player)
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local curse = mod.level:GetCurses()
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
            if (curse == LevelCurse.CURSE_NONE) then
                local randBless = mod.LevelBlessing.GetId(mod.LevelBlessing.Name[player:GetCollectibleRNG(collectible):RandomInt(#mod.LevelBlessing.Name) + 1])
                mod.level:AddCurse(mod.LevelBlessing.GetFlag(randBless),false)
            else
                if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_LOST) then
                    mod.level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
                    mod.level:AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Found")),false)
                end
                if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_MAZE) then
                    mod.level:RemoveCurses(LevelCurse.CURSE_OF_MAZE)
                    mod.level:AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Maze")),false)
                end
                if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_DARKNESS) then
                    mod.level:RemoveCurses(LevelCurse.CURSE_OF_DARKNESS)
                    mod.level:AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Sun")),false)
                end
                if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_BLIND) then
                    mod.level:RemoveCurses(LevelCurse.CURSE_OF_BLIND)
                    mod.level:AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Sight")),false)
                end
                if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_LABYRINTH) and not mod.LevelBlessing.CheckFlag(mod.LevelBlessing.GetId("Blessing of Labyrinth")) then
                    mod.level:AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Labyrinth")),false)
                end
            end
        end
    end
end

function mod:BlessingEffects()
    local curse = mod.level:GetCurses()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Found"))) then
            mod.level:SetCanSeeEverything(true)
        end
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Maze"))) then
            mod.level:ApplyMapEffect()
        end
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Sight"))) then
            mod.level:ApplyBlueMapEffect()
            mod.level:ApplyCompassEffect(true)
        end
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Labyrinth"))) then
            local items = Isaac.FindByType(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE)
            local optionIndex = 1
            for _,item in ipairs(items) do
                if not mod:GetData(item).Cloned then
                    mod:GetData(item).Cloned = true
                    local ItemPool = mod.game:GetItemPool():GetPoolForRoom(mod.room:GetType(),mod.rng:GetSeed())
                    local id = mod.game:GetItemPool():GetCollectible(ItemPool)
                    local newitem = Isaac.Spawn(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE,id,Isaac.GetFreeNearPosition(item.Position + Vector(10,0),3),Vector(0, 0),nil):ToPickup()
                    item.Position = Isaac.GetFreeNearPosition(item.Position - Vector(10,0),3)
                    mod:GetData(newitem).Cloned = true
                    if item:ToPickup():IsShopItem() then
                        if mod.room:GetType() == RoomType.ROOM_DEVIL then
                            newitem.Price = Isaac.GetItemConfig():GetCollectible(id).DevilPrice
                        elseif mod.room:GetType() == RoomType.ROOM_ANGEL then
                            newitem:Remove()
                        else
                            newitem.Price = Isaac.GetItemConfig():GetCollectible(id).ShopPrice
                        end
                    end
                end
            end
        end
    else
        for i = 1,#mod.LevelBlessing.Name do
            mod.level:RemoveCurses(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Name[i])))
        end
    end
end

function mod:BlessingOfSunNewLevel()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local curse = mod.level:GetCurses()
        for i = 1,mod.game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag((mod.LevelBlessing.GetId("Blessing of Sun")))) then
               player:UseCard(Card.CARD_SUN, UseFlag.USE_NOANNOUNCER)
            end

        end
    end
end

--mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, mod.ReverseCurse)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.BlessingsUpdate)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.BlessingsEffect)
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.BlessingOfSunNewLevel)