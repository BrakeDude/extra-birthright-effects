local mod = ExtraBirthright

function mod:LostLastChance(player)
    local level = Game():GetLevel()
    local room = Game():GetRoom()
    if mod.MCMOption.Settings["The Lost"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Lost"])
        if player:GetPlayerType() == PlayerType.PLAYER_THELOST then
            local data = mod:GetData(player)
            if not data.LostChance then
                data.LostChance = 0
            end
            if player:HasCollectible(collectible) and not player:WillPlayerRevive() and player:IsDead() and player:GetSprite():GetFrame() > 35 and data.LostChance < player:GetCollectibleNum(collectible) then
                data.LostChance = data.LostChance + 1
                Game():StartRoomTransition(level:GetPreviousRoomIndex(), Direction.NO_DIRECTION, RoomTransitionAnim.WALK)
                player:Revive()
                for item = 1, mod.GetMaxCollectibleID() do
                    if Isaac.GetItemConfig():GetCollectible(item) then
                        local itemConf = Isaac.GetItemConfig():GetCollectible(item)
                        if player:HasCollectible(item) and itemConf.Type ~= ItemType.ITEM_ACTIVE
                        and (itemConf.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST)
                        and item ~= CollectibleType.COLLECTIBLE_BIRTHRIGHT
                        and item ~= mod.substituteBirthright
                        and item ~= CollectibleType.COLLECTIBLE_HOLY_MANTLE
                        then
                            --for i = 1, player:GetCollectibleNum(item) do
                            player:AddCollectible(item,0,false)
                            --end
                        end
                    end
                end
            end
            if data.LostChance > 0 and room:GetFrameCount() == 0 then
                player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
            end
            data.LostChance = data.LostChance > player:GetCollectibleNum(collectible) and player:GetCollectibleNum(collectible) or data.LostChance
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.LostLastChance)