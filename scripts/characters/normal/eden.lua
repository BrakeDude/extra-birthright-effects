local mod = ExtraBirthright

function mod:EdenRandomItemEffect()
    if mod.MCMOption.Settings["Eden"] > 1 then
        for i = 1, mod.game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eden"])
            local rng = player:GetCollectibleRNG(collectible)
            if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_EDEN then
                local randItems = {}
                for item = 1, mod.GetMaxCollectibleID() do
                    if Isaac.GetItemConfig():GetCollectible(item) then
                        if not player:HasCollectible(item) and Isaac.GetItemConfig():GetCollectible(item).Type ~= ItemType.ITEM_ACTIVE
                        and item ~= CollectibleType.COLLECTIBLE_KNIFE_PIECE_1
                        and item ~= CollectibleType.COLLECTIBLE_KNIFE_PIECE_2
                        and item ~= CollectibleType.COLLECTIBLE_DADS_NOTE
                        and item ~= CollectibleType.COLLECTIBLE_DOGMA
                        and item ~= CollectibleType.COLLECTIBLE_KEY_PIECE_1
                        and item ~= CollectibleType.COLLECTIBLE_KEY_PIECE_2
                        and item ~= CollectibleType.COLLECTIBLE_MARS
                        and item ~= CollectibleType.COLLECTIBLE_BROKEN_SHOVEL_1
                        and item ~= CollectibleType.COLLECTIBLE_BROKEN_SHOVEL_2
                        then
                            table.insert(randItems,item)
                        end
                    end
                end
                randItems = mod.Shuffle(randItems,rng)
                if #randItems > 0 and rng:RandomInt(100) < 25 then
                    local randomItem = rng:RandomInt(#randItems)+1
                    mod.game:GetHUD():ShowItemText(player,Isaac.GetItemConfig():GetCollectible(randItems[randomItem]))
                    player:UseActiveItem(randItems[randomItem])
                end
            end 
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.EdenRandomItemEffect)