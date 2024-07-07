local mod = ExtraBirthright
local Lost = {}

function Lost:HolyProtection()
    local room = Game():GetRoom()
    local rng = RNG()
    rng:SetSeed(room:GetAwardSeed() + room:GetDecorationSeed(), 35)
    for _,player in ipairs(mod:GetPlayers()) do
        local ptype = player:GetPlayerType()
        if ptype == PlayerType.PLAYER_THELOST_B and (mod.MCMOption.Settings["Tainted Lost"] > 1) 
        and ((rng:RandomFloat() >= 0.5 and not Game():GetRoom():IsClear()) or room:GetType() == RoomType.ROOM_BOSSRUSH
        or room:GetType() == RoomType.ROOM_BOSS) then
            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Lost.HolyProtection)
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Lost.HolyProtection)

mod.AddOnPickupFunction(function(player)
	local ptype = player:GetPlayerType()
	if ptype == PlayerType.PLAYER_THELOST_B and (mod.MCMOption.Settings["Tainted Lost"] > 1) then
		player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
	end
end)

mod.AddBirthrightChangeCondition(function(player)
	return player:GetPlayerType() == PlayerType.PLAYER_THELOST_B and mod.MCMOption.Settings["Tainted Lost"] == 2
end)