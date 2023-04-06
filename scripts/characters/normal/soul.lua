local mod = ExtraBirthright
local Soul = {}

function Soul:ForgottenSoulHit(entity,damage)
	local player = entity:ToPlayer()
    local data = mod.GetPersistentPlayerData(player)
	local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Forgotten"])
	if player:HasCollectible(collectible) and mod.MCMOption.Settings["The Forgotten"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THESOUL then
        data.ForgottenSoulHearts = math.floor(damage / 2) + player:GetSoulHearts() % 2
	end
	return nil
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Soul.ForgottenSoulHit, EntityType.ENTITY_PLAYER)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DAMAGE, 0, PlayerType.PLAYER_THEFORGOTTEN, function(player, amount, flags, source, cd)
    local data = mod.GetPersistentPlayerData(player)
    data.ForgottenSoulHearts = math.floor(amount / 2) + player:GetSoulHearts() % 2
end)

local function Wisps(player)
    local data = mod.GetPersistentPlayerData(player)
    if data.ForgottenSoulHearts then
        if data.ForgottenSoulHearts > 0 then
            for i = 1, data.ForgottenSoulHearts do
                for j = 1, math.max(1,mod.RNG:RandomInt(4)) do
                    local wisp = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, 0 , player.Position, Vector.Zero, player):ToFamiliar()
                    mod:GetData(wisp).SoulWispAfter = wisp.EntityCollisionClass
                    wisp.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                end
            end
        end
        data.ForgottenSoulHearts = nil
    end
end

function Soul:ForgottenSoulWisps(player)
	if mod.MCMOption.Settings["The Forgotten"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_THESOUL then
	    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["The Forgotten"])
        if player:HasCollectible(collectible) then
           Wisps(player)
        end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Soul.ForgottenSoulWisps)

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_THESOUL, Wisps)

function Soul:UpdateSoulWisps(familiar)
    if familiar.FrameCount > 30 then
        local data = mod:GetData(familiar)
        if data.SoulWispAfter ~= nil then
            familiar.EntityCollisionClass = data.SoulWispAfter
            data.SoulWispAfter = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Soul.UpdateSoulWisps, FamiliarVariant.WISP)

mod.AddBirthrightChangeCondition(function(player)
	return  player:GetPlayerType() == PlayerType.PLAYER_THESOUL and mod.MCMOption.Settings["The Forgotten"] == 2
end)