local mod = ExtraBirthright
local Soul = {}

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_PLAYER_TAKE_DMG, 0, PlayerType.PLAYER_THESOUL, 1, function(player, amount, flags, source, cd)
    local data = mod.GetPersistentPlayerData(player)
    data.ForgottenSoulHearts = math.floor(amount / 2) + player:GetSoulHearts() % 2
end)

local function Wisps(player)
    local data = mod.GetPersistentPlayerData(player)
    if data.ForgottenSoulHearts then
        if data.ForgottenSoulHearts > 0 then
            local rng = player:GetDropRNG()
            for i = 1, data.ForgottenSoulHearts do
                for j = 1, math.max(1,rng:RandomInt(4)) do
                    local wisp = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WISP, 0 , player.Position, Vector.Zero, player):ToFamiliar()
                    mod:GetData(wisp).SoulWispAfter = wisp.EntityCollisionClass
                    wisp.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                end
            end
            rng:Next()
        end
        data.ForgottenSoulHearts = nil
    end
end

mod.AddCustomCallback("ExtraBirthright", mod.Callbacks.Enums.MC_POST_PLAYER_UPDATE, 0, PlayerType.PLAYER_THESOUL, 1, Wisps)

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