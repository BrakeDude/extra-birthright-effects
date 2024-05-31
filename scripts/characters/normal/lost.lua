local mod = ExtraBirthright
local Lost = {}
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

function Lost:LostLastChance(player)
    local level = Game():GetLevel()
    local room = Game():GetRoom()
    if mod.MCMOption.Settings["The Lost"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Lost"])
        if player:GetPlayerType() == PlayerType.PLAYER_THELOST then
            local data = mod.GetPersistentPlayerData(player)
            if not data.LostChance then
                data.LostChance = 0
            end
            if data.LostChance > 0 and room:GetFrameCount() == 0 then
                player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
            end
            data.LostChance = data.LostChance > player:GetCollectibleNum(collectible) and player:GetCollectibleNum(collectible) or data.LostChance
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Lost.LostLastChance)

if REPENTOGON then
    local revive = Isaac.GetNullItemIdByName("ExtraBirthrightRevive")

    function Lost:LostReviveItem(player)
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Lost"])
        local effects = player:GetEffects()
        local data = mod.GetPersistentPlayerData(player)
        if not data.LostChance then
            data.LostChance = 0
        end
        if mod.MCMOption.Settings["The Lost"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THELOST then
            if player:HasCollectible(collectible) and not effects:HasNullEffect(revive)
            and data.LostChance < player:GetCollectibleNum(collectible) then
                effects:AddNullEffect(revive, true, 1) 
            elseif (not player:HasCollectible(collectible) or data.LostChance >= player:GetCollectibleNum(collectible)) and effects:HasNullEffect(revive) then
                effects:RemoveNullEffect(revive)
            end
        elseif effects:HasNullEffect(revive) then
            effects:RemoveNullEffect(revive)
        end
    end
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Lost.LostReviveItem)

    mod:AddCallback(ModCallbacks.MC_TRIGGER_PLAYER_DEATH_POST_CHECK_REVIVES, function(_, player)
        if mod.MCMOption.Settings["The Lost"] > 1 then
            if player:GetEffects():HasNullEffect(revive) then
                local data = mod.GetPersistentPlayerData(player)
                data.LostRevive = true
                return true
            end
        end
    end)

    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_REVIVE, function(_, player)
        if mod.MCMOption.Settings["The Lost"] > 1 then
            local data = mod.GetPersistentPlayerData(player)
            if data.LostRevive then
                data.LostRevive = nil
                data.LostChance = data.LostChance + 1
                for item = 1, mod.GetMaxCollectibleID() do
                    if Isaac.GetItemConfig():GetCollectible(item) then
                        local itemConf = Isaac.GetItemConfig():GetCollectible(item)
                        if player:HasCollectible(item) and itemConf.Type ~= ItemType.ITEM_ACTIVE
                        and (itemConf.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST)
                        and item ~= CollectibleType.COLLECTIBLE_BIRTHRIGHT
                        and item ~= mod.COLLECTIBLE_BIRTHRIGHT
                        and item ~= CollectibleType.COLLECTIBLE_HOLY_MANTLE
                        then
                            --for i = 1, player:GetCollectibleNum(item) do
                            player:AddCollectible(item,0,false)
                            --end
                        end
                    end
                end
                local level = Game():GetLevel()
                local room = Game():GetRoom()
                local direction = math.fmod(room:GetDoor(level.EnterDoor).Direction,2)
                level.LeaveDoor = room:GetDoor(level.EnterDoor).Slot
                Game():StartRoomTransition(level:GetPreviousRoomIndex(), direction, RoomTransitionAnim.WALK)
            end
        end
    end)

elseif ReviveAPI then
    mod:AddPriorityCallback(mod.ModCallbacks.MC_PRE_PLAYER_REVIVE, 0, function(mod, player)
        if mod.MCMOption.Settings["The Lost"] > 1 then
            local collectible = mod.GetOptionsBirthright(ExtraBirthright.MCMOption.Settings["The Lost"])
            local data = ExtraBirthright.GetPersistentPlayerData(player)
            if not data.LostChance then
                data.LostChance = 0
            end
            if player:HasCollectible(collectible) and data.LostChance < player:GetCollectibleNum(collectible) then
                return true
            end
        end
    end)

    mod:AddCallback(mod.ModCallbacks.MC_POST_PLAYER_REVIVE, function(mod, player, collectible)
        local level = Game():GetLevel()
        local room = Game():GetRoom()
        if ExtraBirthright.MCMOption.Settings["The Lost"] > 1 then
            local collectible = ExtraBirthright.GetOptionsBirthright(ExtraBirthright.MCMOption.Settings["The Lost"])
            if player:GetPlayerType() == PlayerType.PLAYER_THELOST and player:HasCollectible(collectible) then
                local data = ExtraBirthright.GetPersistentPlayerData(player)
                data.LostChance = data.LostChance + 1
                local direction = math.fmod(room:GetDoor(level.EnterDoor).Direction,2)
                level.LeaveDoor = room:GetDoor(level.EnterDoor).Slot
                Game():StartRoomTransition(level:GetPreviousRoomIndex(), direction, RoomTransitionAnim.WALK)
                player:Revive()
                for item = 1, ExtraBirthright.GetMaxCollectibleID() do
                    if Isaac.GetItemConfig():GetCollectible(item) then
                        local itemConf = Isaac.GetItemConfig():GetCollectible(item)
                        if player:HasCollectible(item) and itemConf.Type ~= ItemType.ITEM_ACTIVE
                        and (itemConf.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST)
                        and item ~= CollectibleType.COLLECTIBLE_BIRTHRIGHT
                        and item ~= substituteBirthright
                        and item ~= CollectibleType.COLLECTIBLE_HOLY_MANTLE
                        then
                            --for i = 1, player:GetCollectibleNum(item) do
                            player:AddCollectible(item,0,false)
                            --end
                        end
                    end
                end
            end
        end
    end)
end

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_THELOST and mod.MCMOption.Settings["The Lost"] == 2
end)