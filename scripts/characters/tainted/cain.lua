--#region Tainted Cain
local mod = ExtraBirthright

function mod:CainDestitnyItem(pickup, collider)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Cain"])
	if mod.MCMOption.Settings["Tainted Cain"] > 1 then
        if collider.Type == EntityType.ENTITY_PLAYER then
            local player = collider:ToPlayer()
            local rng = player:GetCollectibleRNG(collectible)
            if player:GetPlayerType() == PlayerType.PLAYER_CAIN_B and pickup.SubType > 0 and player:IsItemQueueEmpty() then
                local data = mod:GetData(player)
                local chance = rng:RandomInt(100) + 1
                if not data.TaintedCainPickedItem and (player:HasCollectible(collectible) or pickup.SubType == collectible and chance <= mod.MCMTCainBirthright["BirthrightYoink"]) then
                    data.TaintedCainPickedItem = true
                    local itemConf = Isaac.GetItemConfig():GetCollectible(pickup.SubType)
                    local changeTo = CollectibleType.COLLECTIBLE_NULL
                    if itemConf.Type == ItemType.ITEM_ACTIVE and player:GetActiveItem() > 0 then
                        changeTo = player:GetActiveItem()
                    end
                    local optionIndex = 0
                    if pickup.OptionsPickupIndex > 0 then
                        optionIndex = pickup.OptionsPickupIndex
                    end
                    if pickup:IsShopItem() then
                        if pickup.Price >= 0 then
                            if player:IsItemQueueEmpty() and pickup.Price <= player:GetNumCoins() then
                                player:AnimateCollectible(pickup.SubType)
                                player:QueueItem(itemConf,0,true)
                                player:AddCoins(-pickup.Price)
                                if changeTo > 0 then
                                    pickup:Morph(5,100,changeTo)
                                else
                                    pickup:Remove()
                                end
                            else
                                return nil
                            end
                        else
                            player:AnimateCollectible(pickup.SubType)
                            player:QueueItem(itemConf,0,true)
                            if pickup.Price ~= PickupPrice.PRICE_SOUL then
                                local hpred,hpsoul = 0,0
                                if pickup.Price > PickupPrice.PRICE_THREE_SOULHEARTS then
                                    hpred = pickup.Price * 2
                                elseif pickup.Price == PickupPrice.PRICE_THREE_SOULHEARTS then
                                    hpsoul = pickup.Price * 2
                                elseif pickup.Price == PickupPrice.PRICE_ONE_HEART_AND_TWO_SOULHEARTS then
                                    hpred = -2
                                    hpsoul = -4
                                end
                                player:AddMaxHearts(hpred)
                                player:AddSoulHearts(hpsoul)
                            end
                            if changeTo > 0 then
                                pickup:Morph(5,100,changeTo)
                            else
                                pickup:Remove()
                            end
                        end
                    else
                        if player:IsItemQueueEmpty() then
                            player:AnimateCollectible(pickup.SubType)
                            player:QueueItem(itemConf,0,false)
                            if changeTo > 0 then
                                pickup:Morph(5,100,changeTo)
                            else
                                Isaac.Spawn(1000,EffectVariant.POOF01,0,pickup.Position,Vector.Zero,nil)
                                pickup:Remove()
                            end
                        end
                    end
                    if optionIndex > 0 then
                        for _,pickups in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE)) do
                            pickups = pickups:ToPickup()
                            if pickups.OptionsPickupIndex == optionIndex then
                                Isaac.Spawn(1000,EffectVariant.POOF01,0,pickups.Position,Vector.Zero,nil)
                                pickups:Remove()
                            end
                        end
                    end
                    Game():GetHUD():ShowItemText(player, itemConf)
                    local sfx = SFXManager()
                    if mod.room:GetType() == RoomType.ROOM_TREASURE then
                        sfx:Play(128)
                    elseif mod.room:GetType() == RoomType.ROOM_BOSS then
                        sfx:Play(129)
                    elseif mod.room:GetType() == RoomType.ROOM_SHOP then
                        sfx:Play(130)
                    elseif mod.room:GetType() == RoomType.ROOM_DEVIL then
                        sfx:Play(316)
                    else
                        sfx:Play(23)
                    end
                    return false
                end
            end
        end
	end
    return nil
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.CainDestitnyItem, PickupVariant.PICKUP_COLLECTIBLE)

function mod:TaintedCainItemPickupReset()
    for i = 1, mod.game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i-1)
        local data = mod:GetData(player)
        if data.TaintedCainPickedItem then
            data.TaintedCainPickedItem = false
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.TaintedCainItemPickupReset)
--#endregion