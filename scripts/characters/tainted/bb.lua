local mod = ExtraBirthright
mod.DipVariant = {
    DIP_NORMAL = 0,
    DIP_RED = 1,
    DIP_CORNY = 2,
    DIP_GOLDEN = 3,
    DIP_RAINBOW = 4,
    DIP_BLACK = 5,
    DIP_HOLY = 6,
    DIP_STONE = 12,
    DIP_FLAMING = 13,
    DIP_POISON = 14,
    DIP_BROWNIE = 20
}

mod.HolyList = {
    CollectibleType.COLLECTIBLE_GODHEAD,
    CollectibleType.COLLECTIBLE_HOLY_GRAIL,
    CollectibleType.COLLECTIBLE_HOLY_MANTLE,
    CollectibleType.COLLECTIBLE_MITRE,
    CollectibleType.COLLECTIBLE_SACRED_HEART,
    CollectibleType.COLLECTIBLE_TRISAGION,
    CollectibleType.COLLECTIBLE_HALLOWED_GROUND,
    CollectibleType.COLLECTIBLE_REVELATION,
    CollectibleType.COLLECTIBLE_SALVATION,
    CollectibleType.COLLECTIBLE_SACRED_ORB,
    CollectibleType.COLLECTIBLE_DOGMA,
    CollectibleType.COLLECTIBLE_DIVINE_INTERVENTION,
}

mod.VirusList = {
    CollectibleType.COLLECTIBLE_TOXIC_SHOCK,
    CollectibleType.COLLECTIBLE_SERPENTS_KISS,
    CollectibleType.COLLECTIBLE_CONTAGION,
    CollectibleType.COLLECTIBLE_BOBS_CURSE,
    CollectibleType.COLLECTIBLE_MYSTERIOUS_LIQUID,
    CollectibleType.COLLECTIBLE_COMMON_COLD,
    CollectibleType.COLLECTIBLE_DEAD_TOOTH,
    CollectibleType.COLLECTIBLE_VIRUS,
    CollectibleType.COLLECTIBLE_SINUS_INFECTION
}

mod.FireList = {
    CollectibleType.COLLECTIBLE_PYROMANIAC,
    CollectibleType.COLLECTIBLE_FIRE_MIND,
    CollectibleType.COLLECTIBLE_HOT_BOMBS,
    CollectibleType.COLLECTIBLE_BIRDS_EYE,
    CollectibleType.COLLECTIBLE_GHOST_PEPPER,
    CollectibleType.COLLECTIBLE_CANDLE,
    CollectibleType.COLLECTIBLE_RED_CANDLE,
    CollectibleType.COLLECTIBLE_BLACK_CANDLE,
}

mod.AshList = {
    CollectibleType.COLLECTIBLE_BALL_OF_TAR,
    CollectibleType.COLLECTIBLE_LITTLE_GISH
}

mod.StoneList = {
    CollectibleType.COLLECTIBLE_SMALL_ROCK,
    CollectibleType.COLLECTIBLE_TOOTH_AND_NAIL,
    CollectibleType.COLLECTIBLE_GNAWED_LEAF,
    CollectibleType.COLLECTIBLE_KIDNEY_STONE,
    CollectibleType.COLLECTIBLE_TERRA
}

mod.RedList = {
    CollectibleType.COLLECTIBLE_BLOOD_BAG,
    CollectibleType.COLLECTIBLE_CUBE_OF_MEAT,
    CollectibleType.COLLECTIBLE_SMB_SUPER_FAN,
    CollectibleType.COLLECTIBLE_BLOODY_LUST,
    CollectibleType.COLLECTIBLE_STEM_CELLS,
    CollectibleType.COLLECTIBLE_MEAT,
    CollectibleType.COLLECTIBLE_ANEMIC,
    CollectibleType.COLLECTIBLE_PLACENTA,
    CollectibleType.COLLECTIBLE_MAGIC_SCAB,
    CollectibleType.COLLECTIBLE_VARICOSE_VEINS,
    CollectibleType.COLLECTIBLE_LEPROSY,
    CollectibleType.COLLECTIBLE_HAEMOLACRIA,
    CollectibleType.COLLECTIBLE_BLOOD_BOMBS,
    CollectibleType.COLLECTIBLE_RED_STEW,
    CollectibleType.COLLECTIBLE_VASCULITIS,
    CollectibleType.COLLECTIBLE_C_SECTION,
}

mod.CornList = {
    CollectibleType.COLLECTIBLE_BUTT_BOMBS,
    CollectibleType.COLLECTIBLE_E_COLI,
    CollectibleType.COLLECTIBLE_FRUIT_CAKE,
    CollectibleType.COLLECTIBLE_BINGE_EATER,
    CollectibleType.COLLECTIBLE_BREAKFAST,
    CollectibleType.COLLECTIBLE_MIDNIGHT_SNACK,
    CollectibleType.COLLECTIBLE_SAUSAGE,
    CollectibleType.COLLECTIBLE_MONTEZUMAS_REVENGE,
    CollectibleType.COLLECTIBLE_SUPPER,
    CollectibleType.COLLECTIBLE_IBS,
    CollectibleType.COLLECTIBLE_LUNCH,
    CollectibleType.COLLECTIBLE_DINNER,
    CollectibleType.COLLECTIBLE_DESSERT,

}

mod.GoldList = {
    CollectibleType.COLLECTIBLE_MIDAS_TOUCH,
    CollectibleType.COLLECTIBLE_DEEP_POCKETS,
    CollectibleType.COLLECTIBLE_HEAD_OF_THE_KEEPER,
    CollectibleType.COLLECTIBLE_GREEDS_GULLET,
    CollectibleType.COLLECTIBLE_EYE_OF_GREED,
    CollectibleType.COLLECTIBLE_KEEPERS_SACK,
}

function mod:HasItemInList(player,list)
    for i = 1,#list do
        if player:HasCollectible(list[i]) then
            return true
        end
    end
    return false
end

function mod:BBShooting(tear)
    local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Tainted Blue Baby"])
	if mod.MCMOption.Settings["Tainted Blue Baby"] > 1 then
        local player = mod:GetPlayerFromTear(tear)
        local rng = player:GetCollectibleRNG(collectible)
        local dirtyMind = player:HasCollectible(CollectibleType.COLLECTIBLE_DIRTY_MIND) and 3 or 1
        if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_XXX_B and rng:RandomFloat() < 0.15 * dirtyMind then
            local dipVariant = mod.DipVariant
            local type = dipVariant.DIP_NORMAL
            if mod:HasItemInList(player,mod.RedList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_RED
            elseif mod:HasItemInList(player,mod.AshList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_BLACK
            elseif mod:HasItemInList(player,mod.FireList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_FLAMING
            elseif mod:HasItemInList(player,mod.StoneList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_STONE
            elseif mod:HasItemInList(player,mod.VirusList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_POISON
            elseif mod:HasItemInList(player,mod.GoldList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_GOLDEN
            elseif mod:HasItemInList(player,mod.HolyList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_HOLY
            elseif mod:HasItemInList(player,mod.CornList) and rng:RandomFloat() < dirtyMind * 0.1 then
                type = dipVariant.DIP_CORNY
            end
            player:AddFriendlyDip(type,player.Position)
            mod.game:Fart(player.Position, 30, player,1,0,Color(1.8,0.7,1.5))
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.BBShooting)
mod:AddCallback(ModCallbacks.MC_POST_LASER_INIT, mod.BBShooting)
mod:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, mod.BBShooting)