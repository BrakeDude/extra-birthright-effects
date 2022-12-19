local mod = ExtraBirthright
--#region Samson
local ChargeBar = Sprite()
ChargeBar:Load("gfx/chargebar_berserk.anm2",true)
ChargeBar:LoadGraphics()
function mod:TSamson(player)
	local data = mod.GetPersistentPlayerData(player)
	if player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B then
		if mod.MCMOption.Settings["Tainted Samson"] > 1 then	
			local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Samson"],false)
			if player:HasCollectible(collectible) then

				if player.SamsonBerserkCharge > 0 then
					data.RageMeter = data.RageMeter + player.SamsonBerserkCharge * 1.5
					player.SamsonBerserkCharge = 0
				end
				if data.RageMeter > 100000 then
					data.RageMeter = 100000
				end
				if not player:HasWeaponType(WeaponType.WEAPON_BONE) then
					if Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex) and data.RageMeter >= 100000 then
						player.SamsonBerserkCharge = math.floor(data.RageMeter)
						data.RageMeter = 0
						player:TakeDamage(0,DamageFlag.DAMAGE_FAKE,EntityRef(player),1)
						player:GetSprite():Stop()
						SFXManager():Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
					end
				end
			end
		elseif data.RageMeter and data.RageMeter > 0 then
			player.SamsonBerserkCharge = data.RageMeter
			data.RageMeter = 0
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE,mod.TSamson,0)

function mod:TSamsonChargeBar(player)
	if Game():GetRoom():GetRenderMode() == RenderMode.RENDER_WATER_REFLECT then return end
	if mod.MCMOption.Settings["Tainted Samson"] > 1 and player:GetPlayerType() == PlayerType.PLAYER_SAMSON_B then
		local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Samson"],false)
		if not player:HasWeaponType(WeaponType.WEAPON_BONE) and player:HasCollectible(collectible) then
			local data = mod.GetPersistentPlayerData(player)
			if not Game():IsPaused() then
				if data.RageMeter >= 100000 then
					if not ChargeBar:IsPlaying("Charged") then
						ChargeBar:Play("Charged")
						ChargeBar.PlaybackSpeed = 1
					else
						ChargeBar:Update()
					end
				else
					if not ChargeBar:IsPlaying("Charging") then
						ChargeBar:Play("Charging")
					else
						ChargeBar:SetFrame(math.floor(data.RageMeter/1000))
					end
				end
			end
			ChargeBar.Offset = Vector(-12,-35)
			ChargeBar:Render(Game():GetRoom():WorldToScreenPosition(player.Position), Vector.Zero, Vector.Zero)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER,mod.TSamsonChargeBar, 0)
--#endregion