local mod = ExtraBirthright

mod.LevelBlessing = {
    Blessings = {
        "Blessing of the Prevailing", --Maze
        "Blessing of Enlightenment", --Darkness
        "Blessing of Order", --Labyrinth
        "Blessing of the Baptized", --Unknown
        "Blessing of Foresight", --Blind
        "Blessing of Clarity", --Lost
        "Blessing of the Virtuous", --Curse
        "Blessing of the Imperceptible", --Giant
    },
    Curses = {
        LevelCurse.CURSE_OF_MAZE,
        LevelCurse.CURSE_OF_DARKNESS,
        LevelCurse.CURSE_OF_LABYRINTH,
        LevelCurse.CURSE_OF_THE_UNKNOWN,
        LevelCurse.CURSE_OF_BLIND,
        LevelCurse.CURSE_OF_THE_LOST,
        LevelCurse.CURSE_OF_THE_CURSED,
        LevelCurse.CURSE_OF_GIANT,
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

function mod:BethHasBirthright()
    for i = 1, mod.game:GetNumPlayers() do
        local player = Isaac.GetPlayer(i-1)
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
            return true
        end
    end
    return false
end

function mod:ReverseCurse(curses)
    if mod.MCMOption.Settings["Bethany"] > 1 then
        if mod:BethHasBirthright() then
            if (curses == LevelCurse.CURSE_NONE) then
                local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
                local rng = Isaac.GetPlayer(0):GetCollectibleRNG(collectible)
                local randBless = mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[rng:RandomInt(rng:Next()) % #mod.LevelBlessing.Blessings + 1])
                return mod.LevelBlessing.GetFlag(randBless)
            end
        end
    end
    return curses
end

function mod:BlessingsUpdate(player)
    local curse = mod.game:GetLevel():GetCurses()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
            for i = 1, #mod.LevelBlessing.Curses do
                if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.Curses[i]) then
                    mod.level:RemoveCurses(mod.LevelBlessing.Curses[i])
                    mod.level:AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])) ,false)
                end
            end
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Enlightenment"))) then
                local Aura=mod:GetData(player).BlessingPrevailAura
                if not Aura or Aura:IsDead() then
                    mod:GetData(player).BlessingPrevailAura = Isaac.Spawn(1000,123,2,player.Position,Vector.Zero,player):ToEffect()
                    Aura=mod:GetData(player).BlessingPrevailAura
                    Aura:GetSprite():ReplaceSpritesheet(0,'gfx/effects/effect_hallowedground.png')
                    Aura:GetSprite():LoadGraphics()
                    Aura.SpriteScale=Vector(2.5,2.5)
                    local AuraColor=Color(1,1,1,1)
                    AuraColor:SetColorize(1,1,0.5,1)
                    Aura:GetSprite().Offset=Vector(20,50)
                    Aura.Color=AuraColor
                    Aura.DepthOffset=-999
                end
                local enemies = Isaac.FindInRadius(player.Position, 220, EntityPartition.ENEMY)
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
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Foresight"))) and 
            player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
                local items = Isaac.FindByType(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE)
                for _,item in ipairs(items) do
                    item = item:ToPickup()
                    local sprite = item:GetSprite()
                    local newitem = Isaac.GetItemConfig():GetCollectible(item.SubType)
                    sprite:ReplaceSpritesheet(1, newitem.GfxFileName)
                    sprite:LoadGraphics()
                end
            end
        end
    else
        for i = 1, #mod.LevelBlessing.Blessings do
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])) then
                mod.level:RemoveCurses(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])))
                mod.level:AddCurse(mod.LevelBlessing.Curses[i] ,false)
            end
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
                if rng:RandomInt(100) < 20 then
                    player:UseCard(Card.CARD_SOUL_CAIN, UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM)
                end
            end
        end
    end
end

function mod:BlessingOfVirtuousEffect(tear)
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local player = mod:GetPlayerFromTear(tear)
        if player then 
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
            local curse = mod.level:GetCurses()
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Virtuous"))) and 
            player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
                local rng = player:GetCollectibleRNG(collectible)
                if rng:RandomInt(100) < 5 then
                    tear:AddTearFlags(TearFlags.TEAR_ENEMY_TO_WISP)
                end
            end
        end
    end
end

function mod:BlessingOfImperceptibleEffect()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local curse = mod.game:GetLevel():GetCurses()
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Imperceptible"))) then
            for i = 1, mod.game:GetNumPlayers() do
                local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
                local player = Isaac.GetPlayer(i-1)
                if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
                    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES,false)
                    if mod.room:GetType() ~= RoomType.ROOM_MINIBOSS and  mod.room:GetType() ~= RoomType.ROOM_SHOP and mod.room:GetType() ~= RoomType.ROOM_BOSS then
                        for i = 0, (mod.room:GetGridSize()) do
                            local gent = mod.room:GetGridEntity(i)
                            if gent then
                                if gent:GetType() == GridEntityType.GRID_DOOR then
                                    gent:ToDoor():Open()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.BlessingsUpdate)
mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, mod.ReverseCurse)
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.BlessingOfPrevailingEffect)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.BlessingOfVirtuousEffect)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.BlessingOfImperceptibleEffect)