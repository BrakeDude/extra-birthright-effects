local mod = ExtraBirthright

---comment
---@param player EntityPlayer
---@param cache any
function mod:TForgorCache(player,cache)
	if mod.MCMOption.Settings["Tainted Forgotten"] > 1 then
        if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B then
            print("yes")
            local soul = player:GetOtherTwin()
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Forgotten"])
            if player:HasCollectible(collectible) then
                local familiars = {}
                for k,v in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR,-1,-1)) do
                    if GetPtrHash(v:ToFamiliar().SpawnerEntity) == GetPtrHash(player) then
                        local fExists = false
                        if #familiars > 0 then
                            for _,v2 in ipairs(familiars) do
                                if v2.Variant == v.Variant and v2.SubType == v.SubType then
                                    fExists = true
                                    break
                                end
                            end
                        end
                        if not fExists then
                            table.insert(familiars,{Variant = v.Variant, SubType = v.SubType})
                        end
                    end
                end
                print(#familiars)
                for _,v in ipairs(familiars) do
                    soul:CheckFamiliar(v.Variant, #Isaac.FindByType(EntityType.ENTITY_FAMILIAR,v.Variant,v.SubType), player:GetCollectibleRNG(collectible), nil, v.SubType)
                end
                soul.Size = player.Size
                soul.SizeMulti = player.SizeMulti
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.TForgorCache)