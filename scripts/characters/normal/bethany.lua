local mod = ExtraBirthright

mod.LevelBlessing = {
    BLESSING_MAZE = Isaac.GetCurseIdByName("Blessing of Maze"),
    BLESSING_FOUND = Isaac.GetCurseIdByName("Blessing of Found"),
    BLESSING_LIGHT = Isaac.GetCurseIdByName("Blessing of Maze"),
    BLESSING_FORESEEN = Isaac.GetCurseIdByName("Blessing of Foreseen"),
}

function mod.ToFlag(curseId)
    return 2 ^ (curseId - 1)
end

function mod.CheckFlag(mask, flag)
    return mask % (flag + flag) >= flag
end

function mod:ReverseCurse(curse)
    for i = 1,mod.game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i-1)
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
            if (curse == LevelCurse.CURSE_NONE) then
                local randBless = player:GetCollectibleRNG(collectible):RandomInt(#mod.LevelBlessing) + 1
                return mod.ToFlag(mod.LevelBlessing[randBless])
            else
                if mod.CheckFlag(curse, LevelCurse.CURSE_OF_THE_LOST) then
                    mod.level:ApplyCompassEffect(true)
                    return mod.ToFlag(mod.LevelBlessing.BLESSING_FOUND)
                end
                if mod.CheckFlag(curse, LevelCurse.CURSE_OF_MAZE) then
                    mod.level:ApplyMapEffect()
                    return mod.ToFlag(mod.LevelBlessing.BLESSING_MAZE)
                end
                if mod.CheckFlag(curse, LevelCurse.CURSE_OF_DARKNESS) then
                    mod.level:ApplyBlueMapEffect()
                    return mod.ToFlag(mod.LevelBlessing.BLESSING_LIGHT)
                end
                if mod.CheckFlag(curse, LevelCurse.CURSE_OF_BLIND) then
                    mod.level:SetCanSeeEverything(true)
                    return mod.ToFlag(mod.LevelBlessing.BLESSING_FORESEEN)
                end
            end
        end
    end
    return curse
end