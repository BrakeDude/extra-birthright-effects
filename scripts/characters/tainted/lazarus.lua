local mod = ExtraBirthright
--#region Tainted Lazarus
function mod:DaSwitcharu2pointO(player)
	if mod.MCMOption.Settings["Tainted Lazarus"] > 1 and (player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B) 
	and mod.taintedLazBirthright[mod.EsauCheck(player)] then
		local battery = (player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY) and 2 or 1)
		local charge = player:GetActiveCharge(ActiveSlot.SLOT_POCKET) + player:GetBatteryCharge(ActiveSlot.SLOT_POCKET)
		if charge < 6 * battery then
			mod.fliped[mod.EsauCheck(player)] = mod.fliped[mod.EsauCheck(player)] + 1
			if math.fmod(mod.fliped[mod.EsauCheck(player)],100) == 0 then
				player:SetActiveCharge(charge + 1, ActiveSlot.SLOT_POCKET)
				Game():GetHUD():FlashChargeBar(player,ActiveSlot.SLOT_POCKET)
				if charge == 5 or charge == 11 then
					SFXManager():Play(SoundEffect.SOUND_ITEMRECHARGE)
				else
					SFXManager():Play(SoundEffect.SOUND_BEEP)
				end
			end
		end
	end
end

function mod:FlipTheSwitchLazarus2pointO(Collectible,_,player,_,slot)
	if slot == ActiveSlot.SLOT_POCKET then
		mod.fliped[mod.EsauCheck(player)] = 0
	end
	return nil
end


mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.DaSwitcharu2pointO);
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.FlipTheSwitchLazarus2pointO, 711)
--#endregion