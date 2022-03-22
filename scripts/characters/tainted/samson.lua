local mod = ExtraBirthright
--#region Samson

function mod:TSamson(player)
	if mod.MCMOption.Settings["Tainted Samson"] > 1 then
		if player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B then
			local data = mod:GetData(player)
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Samson"],false)
			if player:HasCollectible(collectible) then
				if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) and data.RageMeter >= 100000 and not player:HasWeaponType(WeaponType.WEAPON_BONE) then
					player.SamsonBerserkCharge = math.floor(data.RageMeter)
					data.RageMeter = 0
					player:TakeDamage(0,DamageFlag.DAMAGE_FAKE,EntityRef(player),10)
				end
				if player.SamsonBerserkCharge > 0 then
					data.RageMeter = data.RageMeter + player.SamsonBerserkCharge * 1.5
					player.SamsonBerserkCharge = 0
				end
				if data.RageMeter > 100000 then
					data.RageMeter = 100000
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE,mod.TSamson)
--#endregion