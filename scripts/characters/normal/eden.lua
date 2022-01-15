local mod = ExtraBirthright

function mod:EdenRandomItemEffect(player)
    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Eden"])
    local rng = player:GetCollectibleRNG(collectible)
	if mod.MCMOption.Settings["Eden"] > 1 and player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_EDEN then
        local randItems = {}
        for item = 1, mod.GetMaxCollectibleID() do
            if Isaac.GetItemConfig():GetCollectible(item).Type ~= ItemType.ITEM_ACTIVE
            and item ~= CollectibleType.COLLECTIBLE_KNIFE_PIECE_1
            and item ~= CollectibleType.COLLECTIBLE_KNIFE_PIECE_2
            and item ~= CollectibleType.COLLECTIBLE_DADS_NOTE
            and item ~= CollectibleType.COLLECTIBLE_DOGMA
            and item ~= CollectibleType.COLLECTIBLE_KEY_PIECE_1
            and item ~= CollectibleType.COLLECTIBLE_KEY_PIECE_2
            then
                table.insert(playersItems,item)
            end
        end
        randItems = mod.Shuffle(randItems,rng)
        if #randItems > 0 then
            local randomItem = rng:RandomInt(#randItems)+1
            player:UseActiveItem(randItems[randomItem])
        end
    end
end
