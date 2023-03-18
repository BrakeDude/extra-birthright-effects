local mod = ExtraBirthright
local IsaacM = {}

function IsaacM:SpinToWin(_,rng,player,slot)
    if mod.MCMOption.Settings["Tainted Isaac"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Isaac"])
        if player:GetPlayerType() == PlayerType.PLAYER_ISAAC_B and player:HasCollectible(collectible) then
            if rng:RandomInt(10) == 1 then
                player:UseCard(Card.CARD_SOUL_ISAAC, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, IsaacM.SpinToWin, CollectibleType.COLLECTIBLE_SPINDOWN_DICE)