local mod = ExtraBirthright

function mod:EdenRandomItemEffect()
    local game = Game()
    if mod.MCMOption.Settings["Eden"] > 1 then
        for i = 1, game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eden"])
            local rng = player:GetCollectibleRNG(collectible)
            if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_EDEN then
                local randItems = {}
                for item = 1, mod.GetMaxCollectibleID() do
                    if Isaac.GetItemConfig():GetCollectible(item) then
                        local itemConfig = Isaac.GetItemConfig():GetCollectible(item)
                        if not player:HasCollectible(item) and itemConfig.Type ~= ItemType.ITEM_ACTIVE
                        and itemConfig.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST
                        then
                            table.insert(randItems,item)
                        end
                    end
                end
                randItems = mod.Shuffle(randItems,rng)
                if #randItems > 0 and rng:RandomInt(100) < 25 then
                    local randomItem = rng:RandomInt(#randItems)+1
                    game:GetHUD():ShowItemText(player,Isaac.GetItemConfig():GetCollectible(randItems[randomItem]))
                    player:UseActiveItem(randItems[randomItem])
                end
            end 
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.EdenRandomItemEffect)