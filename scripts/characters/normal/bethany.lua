local mod = ExtraBirthright

mod.LevelBlessing = {
    Name = {
        "Blessing of the Prevailing", --Maze
        "Blessing of Enlightenment", --Darkness
        "Blessing of Order", --Labyrinth
        "Blessing of the Baptized", --Unknown
        "Blessing of Foresight", --Blind
        "Blessing of Clarity", --Lost
        "Blessing of the Virtuous", --Curse
        "Blessing of the Imperceptible", --Unknown
    },
    GetId = function(name)
        return Isaac.GetCurseIdByName(name)
    end,
    GetFlag = function(blessing)
        return 1 << (blessing - 1)
    end,
    CheckFlag = function (mask, flag)
        return mask & flag == flag
    end
}

function mod:ReverseCurse(curse)
    if (curse == LevelCurse.CURSE_NONE) then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        local rng = Isaac.GetPlayer(0):GetCollectibleRNG(collectible)
        local randBless = mod.LevelBlessing.GetId(mod.LevelBlessing.Name[rng:RandomInt(rng:Next()) % #mod.LevelBlessing.Name + 1])
        return mod.LevelBlessing.GetFlag(randBless)
    else
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_MAZE) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Prevailing"))
        end
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_DARKNESS) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Enlightenment"))
        end
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_LABYRINTH) and not mod.LevelBlessing.CheckFlag(mod.LevelBlessing.GetId("Blessing of Order")) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Order"))
        end
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_UNKNOWN) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Baptized"))
        end
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_BLIND) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Foresight"))
        end
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_LOST) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Clarity"))
        end
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_CURSED) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Virtuous"))
        end
        if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_GIANT) then
            return mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Imperceptible"))
        end
    end
    return curse
end

function mod:BlessingsUpdate(player)
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local curse = mod.level:GetCurses()
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
            if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_MAZE) then
                mod.level:RemoveCurses(LevelCurse.CURSE_OF_MAZE)
            end
            if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_DARKNESS) then
                mod.level:RemoveCurses(LevelCurse.CURSE_OF_DARKNESS)
            end
            if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_UNKNOWN) then
                mod.level:RemoveCurses(LevelCurse.CURSE_OF_THE_UNKNOWN)
            end
            if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_BLIND) then
                mod.level:RemoveCurses(LevelCurse.CURSE_OF_BLIND)
            end
            if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_LOST) then
                mod.level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
            end
            if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_THE_CURSED) then
                mod.level:RemoveCurses(LevelCurse.CURSE_OF_THE_CURSED)
            end
            if mod.LevelBlessing.CheckFlag(curse, LevelCurse.CURSE_OF_GIANT) then
                mod.level:RemoveCurses(LevelCurse.CURSE_OF_GIANT)
            end
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Enlightenment"))) then
                local Aura=mod:GetData(player).BlessingPrevailAura
                if not Aura or Aura:IsDead() then
                    mod:GetData(player).BlessingPrevailAura = Isaac.Spawn(1000,123,2,player.Position,mod.ZERO_VECTOR,player):ToEffect()
                    Aura=mod:GetData(player).BlessingPrevailAura
                    Aura:GetSprite():ReplaceSpritesheet(0,'gfx/effects/effect_hallowedground.png')
                    Aura:GetSprite():LoadGraphics()
                    Aura.SpriteScale=Vector(1.5,1.5)
                    local AuraColor=Color(1,1,1,1)
                    AuraColor:SetColorize(1,1,0.5,1)
                    Aura:GetSprite().Offset=Vector(13,20)
                    Aura.Color=AuraColor
                    Aura.DepthOffset=-999
                end
                local enemies = Isaac.FindInRadius(player.Position, 130, EntityPartition.ENEMY)
                for _,entity in ipairs(enemies) do
                    if mod.game:GetFrameCount() % 10 == 0 and entity:IsVulnerableEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_BURN | EntityFlag.FLAG_FRIENDLY) then
                        entity:AddBurn(EntityRef(player), 10, player.Damage)
                    end
                end
            elseif mod:GetData(player).BlessingPrevailAura then
                (mod:GetData(player).BlessingPrevailAura):GetSprite().Color = Color(1,1,1,0)
            end
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Clarity"))) then
                mod.level:ApplyMapEffect()
                mod.level:ApplyBlueMapEffect()
                mod.level:ApplyCompassEffect(true)
            end
        end
    else
        for i = 1,#mod.LevelBlessing.Name do
            mod.game:GetLevel():RemoveCurses(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Name[i])))
        end
    end
end

function mod:BlessingOfPrevailingEffect()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        for i = 1,mod.game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
            local curse = mod.level:GetCurses()
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Prevailing"))) and 
            player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
                local rng = player:GetCollectibleRNG(collectible)
                if rng:RandomInt(100) < 5 then
                    player:UseCard(Card.CARD_SOUL_CAIN, UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM)
                end
            end
        end
    end
end

function mod:BlessingOfForesightEffect(player)
    if mod.MCMOption.Settings["Bethany"] > 1 then
        player = player:ToPlayer()
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        local curse = mod.level:GetCurses()
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Foresight"))) and 
        player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY and mod.room:IsFirstVisit() then
            player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.BlessingsUpdate)
mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, mod.ReverseCurse)
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.BlessingOfPrevailingEffect)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.BlessingOfForesightEffect, EntityType.ENTITY_PLAYER)