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

function mod.HasBlessing()
    local curse = Game():GetLevel():GetCurses()
    for i = 1, #mod.LevelBlessing.Blessings do
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])) then
            return true
        end
    end
    return false
end

function mod.WasRoomVisited(roomtype)
    for ____, info in ipairs(mod.VisitedRooms) do
        if info.Type == roomtype then
            return true
        end
    end
    return false
end

function mod.WasRoomVisitedHG(index)
    for ____, info in ipairs(mod.VisitedRooms) do
        if info.Index == index then
            return true
        end
    end
    return false
end

function mod:BethHasBirthright()
    for i = 1, Game():GetNumPlayers() do
        local player = Isaac.GetPlayer(i-1)
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
            return true
        end
    end
    return false
end

function mod:ReverseCurse(curses)
    local level = Game():GetLevel()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        if mod:BethHasBirthright() then
            if (curses == LevelCurse.CURSE_NONE) and not level:IsAscent() then
                local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
                local rng = Isaac.GetPlayer(0):GetCollectibleRNG(collectible)
                local randBless = mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[rng:RandomInt(rng:Next()) % #mod.LevelBlessing.Blessings + 1])
                return mod.LevelBlessing.GetFlag(randBless)
            end
        end
    end
    return curses
end
mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, mod.ReverseCurse)

function mod:BlessingsUpdate(player)
    local game = Game()
    local room = game:GetRoom()
    local level = game:GetLevel()
    local curse = game:GetLevel():GetCurses()
    local data = mod:GetData(player)
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) then
			data.Bethany = PlayerType.PLAYER_BETHANY
            if not level:IsAscent() then
                if (curse == LevelCurse.CURSE_NONE) then
                    local rng = player:GetCollectibleRNG(collectible)
                    local randBless = mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[rng:RandomInt(rng:Next()) % #mod.LevelBlessing.Blessings + 1])
                    level:AddCurse(mod.LevelBlessing.GetFlag(randBless),false)
                else
                    for i = 1, #mod.LevelBlessing.Curses do
                        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.Curses[i]) then
                            level:RemoveCurses(mod.LevelBlessing.Curses[i])
                            level:AddCurse(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])),false)
                        end
                    end
                end
            end
           
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Enlightenment"))) and not room:HasCurseMist() then
                local Aura=mod:GetData(player).BlessingPrevailAura
                if not Aura then
                    Aura = Sprite()
                    Aura:Load("gfx/1000.112_hallowed ground.anm2",true)
                    Aura:LoadGraphics()
                    Aura.PlaybackSpeed = 0.6
                    Aura.Scale=Vector(2.5,2.5)
                    local AuraColor=Color(1,1,1,1)
                    AuraColor:SetColorize(1,1,0.5,1)
                    --Aura.Offset=Vector(20,50)
                    Aura.Color=AuraColor
                    --Aura.DepthOffset=-999
                    mod:GetData(player).BlessingPrevailAura = Aura
                    Aura:Play("Appear")
                elseif Aura:IsFinished("Appear") and not Aura:IsPlaying("Idle") then
                    Aura:Play("Idle")
                end
                local enemies = Isaac.FindInRadius(player.Position, 220, EntityPartition.ENEMY)
                for _,entity in ipairs(enemies) do
                    if game:GetFrameCount() % 10 == 0 and entity:IsVulnerableEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_BURN | EntityFlag.FLAG_FRIENDLY) then
                        entity:AddBurn(EntityRef(player), 10, player.Damage)
                    end
                end
            elseif mod:GetData(player).BlessingPrevailAura then
                local Aura = mod:GetData(player).BlessingPrevailAura
                if Aura:IsPlaying("Idle") then
                    Aura:Play("Disappear")
                elseif Aura:IsFinished("Disappear") then
                    mod:GetData(player).BlessingPrevailAura = nil
                end
            end
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Clarity"))) then
                level:ApplyMapEffect()
                level:ApplyBlueMapEffect()
                level:ApplyCompassEffect(true)
            end
            if data.Bethany and room:IsClear() and mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Baptized"))) 
            and player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY then
                player:ChangePlayerType(PlayerType.PLAYER_BETHANY)
            end
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Foresight"))) and 
            player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY and not room:HasCurseMist() then
                local items = Isaac.FindByType(EntityType.ENTITY_PICKUP,PickupVariant.PICKUP_COLLECTIBLE)
                for _,item in ipairs(items) do
                    if item.SubType ~= CollectibleType.COLLECTIBLE_NULL then
                        item = item:ToPickup()
                        local sprite = item:GetSprite()
                        local newitem = Isaac.GetItemConfig():GetCollectible(item.SubType)
                        if sprite:GetFilename() ~= newitem.GfxFileName then 
                            sprite:ReplaceSpritesheet(1, newitem.GfxFileName)
                            sprite:LoadGraphics()
                        end
                    end
                end
                if mod.Timer > 0 then
                    mod.Timer = mod.Timer - 1
                end
                if (not room:IsClear() or room:GetType() == RoomType.ROOM_CURSE or room:GetType() == RoomType.ROOM_DEVIL
                or room:GetType() == RoomType.ROOM_TREASURE or room:GetType() == RoomType.ROOM_SHOP) and mod.Timer == 0 then
                    mod.Timer = -1
                    player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, UseFlag.USE_NOANIM)
                end
            end
          
        end
    else
        for i = 1, #mod.LevelBlessing.Blessings do
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])) then
                level:RemoveCurses(mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId(mod.LevelBlessing.Blessings[i])))
                level:AddCurse(mod.LevelBlessing.Curses[i] ,false)
            end
        end
        if data.Bethany then
            data.Bethany = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.BlessingsUpdate)

function mod:AuraRender()
    for _,player in ipairs(Isaac.FindByType(EntityType.ENTITY_PLAYER,-1,PlayerType.PLAYER_BETHANY)) do
        player = player:ToPlayer()
        local data = mod:GetData(player)
        local Aura = data.BlessingPrevailAura
        if Aura then
            Aura:Render(Game():GetRoom():WorldToScreenPosition(player.Position), Vector.Zero, Vector.Zero)
            if not Game():IsPaused() then
                if data.AuraPulse == nil then
                    data.AuraPulse = Vector(0.01,0.01)
                end
                data.AuraPulse = Aura.Scale.X < 2.48 and Vector(0.0005,0.0005) or (Aura.Scale.X > 2.52 and Vector(-0.0005,-0.0005) or data.AuraPulse)
                Aura.Scale = Aura.Scale + data.AuraPulse
                Aura:Update()
            end
        elseif data.AuraPulse ~= nil then
            data.AuraPulse = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.AuraRender)

function mod:BlessingOfPrevailingandOrderEffect()
    mod.Timer = -1
    local game = Game()
    local room = game:GetRoom()
    local level = game:GetLevel()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        for i = 1,game:GetNumPlayers() do
            local player = Isaac.GetPlayer(i-1)
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
            local curse = level:GetCurses()
            local rng = player:GetCollectibleRNG(collectible)
            if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and player:HasCollectible(collectible) and not room:HasCurseMist() then
                if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Prevailing")))  then
                    if rng:RandomInt(100) < 20 then
                        player:UseCard(Card.CARD_SOUL_CAIN, UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM)
                        SFXManager():Stop(SoundEffect.SOUND_GOLDENKEY)
                    end
                end
                if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Order"))) and 
                room:GetType() ~= RoomType.ROOM_BOSS and room:GetType() ~= RoomType.ROOM_BOSSRUSH and room:GetType() ~= RoomType.ROOM_CHALLENGE
                and (level:GetStage() < LevelStage.STAGE4_3 or level:GetStage() == LevelStage.STAGE7) and not game:IsGreedMode() 
                and rng:RandomInt(100) < 30 then
                    if not mod.WasRoomVisited(RoomType.ROOM_TREASURE) and not mod.WasRoomVisited(RoomType.ROOM_PLANETARIUM) then
                        player:UseCard(Card.CARD_STARS, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
                    elseif not mod.WasRoomVisited(RoomType.ROOM_SHOP) then
                        player:UseCard(Card.CARD_HERMIT, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
                    elseif not mod.WasRoomVisited(RoomType.ROOM_SECRET) and not mod.WasRoomVisited(RoomType.ROOM_SUPERSECRET) then
                        player:UseCard(Card.CARD_MOON, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
                    elseif not mod.WasRoomVisited(RoomType.ROOM_DEVIL) and not mod.WasRoomVisited(RoomType.ROOM_ANGEL) then
                        player:UseCard(Card.CARD_JOKER, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
                    elseif not mod.WasRoomVisited(RoomType.ROOM_BOSS) or level:GetStage() == LevelStage.STAGE7 then
                        player:UseCard(Card.CARD_EMPEROR, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.BlessingOfPrevailingandOrderEffect)

function mod:BlessingOfVirtuousEffect(tear)
    local room = Game():GetRoom()
    local level = Game():GetLevel()
    if mod.MCMOption.Settings["Bethany"] > 1 then
        local player = mod:GetPlayerFromTear(tear)
        if player then 
            local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
            local curse = level:GetCurses()
            if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Virtuous"))) and 
            player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY and not room:HasCurseMist() then
                local rng = player:GetCollectibleRNG(collectible)
                if rng:RandomInt(100) < 5 then
                    tear:AddTearFlags(TearFlags.TEAR_ENEMY_TO_WISP)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.BlessingOfVirtuousEffect)

function mod.CantChange(ptype)
    local cantCange = {4, 12, 14, 16, 17, 20, 21, 24, 25, 29, 33, 35, 36, 38, 39, 40}
    for i = 1, #cantCange do
        if ptype == cantCange[i] then
            return true
        end
    end
    return false
end

function mod:NewLevelBethany()
    mod.Timer = -1
    mod.VisitedRooms = {}
    for i = 1, Game():GetNumPlayers() do
        local player = Isaac.GetPlayer(i-1)
        local data = mod:GetData(player)
        if data.Bethany and player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY then
            player:ChangePlayerType(PlayerType.PLAYER_BETHANY)
            if data.BethanyLost then
                player:GetEffects():RemoveNullEffect(NullItemID.ID_LOST_CURSE)
                data.BethanyLost = nil
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewLevelBethany)

function mod:BlessingOfImperceptibleAndBaptizedEffect()
    local game = Game()
    local room = game:GetRoom()
    mod.Timer = -1
    local roomDescriptor = game:GetLevel():GetCurrentRoomDesc()
    local visitedCount = roomDescriptor.VisitedCount
    local listIndex = roomDescriptor.ListIndex
    local type = roomDescriptor.Data.Type
    local willAdd = true
    for ____, info in ipairs(mod.VisitedRooms) do
        if info.Index == listIndex then
            willAdd = false
            break
        end
    end
    if willAdd then
        table.insert(mod.VisitedRooms, {Index = listIndex, VisitCount = visitedCount, Type = type})
    end
    if mod.MCMOption.Settings["Bethany"] > 1 and not room:HasCurseMist() then
        local curse = game:GetLevel():GetCurses()
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Imperceptible"))) then
            for i = 1, game:GetNumPlayers() do
                local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
                local player = Isaac.GetPlayer(i-1)
                if player:HasCollectible(collectible) and player:GetPlayerType() == PlayerType.PLAYER_BETHANY then
                    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_CAMO_UNDIES,false)
                    if room:GetType() ~= RoomType.ROOM_MINIBOSS and  room:GetType() ~= RoomType.ROOM_SHOP and room:GetType() ~= RoomType.ROOM_BOSS then
                        for i = 0, (room:GetGridSize()) do
                            local gent = room:GetGridEntity(i)
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

        if (not room:IsClear() or type == RoomType.ROOM_TREASURE or type == RoomType.ROOM_DEVIL or type == RoomType.ROOM_CURSE or type == RoomType.ROOM_SHOP)
        and mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Foresight"))) 
        and willAdd and not room:HasCurseMist() then
            mod.Timer = 300
        end
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of the Baptized")))
        and not room:IsClear() and not room:HasCurseMist() then
            for i = 1, game:GetNumPlayers() do
                local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
                local player = Isaac.GetPlayer(i-1)
                local data = mod:GetData(player)
                local rng = player:GetCollectibleRNG(collectible)
                if rng:RandomInt(100) < 35 and room:GetType() ~= RoomType.ROOM_BOSS and room:GetType() ~= RoomType.ROOM_BOSSRUSH
                and room:GetType() ~= RoomType.ROOM_BLACK_MARKET and room:GetType() ~= RoomType.ROOM_GREED_EXIT
                and room:GetType() ~= RoomType.ROOM_SECRET_EXIT and room:GetType() ~= RoomType.ROOM_BARREN
                and room:GetType() ~= RoomType.ROOM_ISAACS and room:GetType() ~= RoomType.ROOM_ERROR
                and room:GetType() ~= RoomType.ROOM_ANGEL and room:GetType() ~= RoomType.ROOM_DEVIL and data.Bethany then
                    local randPlayer = rng:RandomInt(41)
                    while mod.CantChange(randPlayer) do
                        randPlayer = rng:RandomInt(41)
                    end
                    if (randPlayer == 10 or randPlayer == 31) and not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) and not room:HasCurseMist() then
                        player:GetEffects():AddNullEffect(NullItemID.ID_LOST_CURSE)
                        data.BethanyLost = true
                        player:ChangePlayerType(PlayerType.PLAYER_BETHANY)
                    elseif randPlayer ~= 10 and randPlayer ~= 31 or room:HasCurseMist() then
                        if room:HasCurseMist() then
                            player:ChangePlayerType(PlayerType.PLAYER_BETHANY)
                        else
                            player:ChangePlayerType(randPlayer)
                        end
                        if data.BethanyLost and not room:IsMirrorWorld() then
                            player:GetEffects():RemoveNullEffect(NullItemID.ID_LOST_CURSE)
                            data.BethanyLost = nil
                        end
                    end
                elseif player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY and data.Bethany then
                    player:ChangePlayerType(PlayerType.PLAYER_BETHANY)
                end
            end
        else
            for i = 1, game:GetNumPlayers() do
                local player = Isaac.GetPlayer(i-1)
                local data = mod:GetData(player)
                if data.Bethany and player:GetPlayerType() ~= PlayerType.PLAYER_BETHANY then
                    player:ChangePlayerType(PlayerType.PLAYER_BETHANY)
                    if data.BethanyLost and not room:IsMirrorWorld() then
                        player:GetEffects():RemoveNullEffect(NullItemID.ID_LOST_CURSE)
                        data.BethanyLost = nil
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.BlessingOfImperceptibleAndBaptizedEffect)

function mod:TimerRender()
    local game = Game()
    local room = game:GetRoom()
    if mod.MCMOption.Settings["Bethany"] > 1 and (Game():GetHUD():IsVisible() or not Game():GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)) then
        local curse = game:GetLevel():GetCurses()
        local collectible = mod.GetOptionsBirthright(mod.MCMOption.Settings["Bethany"])
        if mod.LevelBlessing.CheckFlag(curse, mod.LevelBlessing.GetFlag(mod.LevelBlessing.GetId("Blessing of Foresight"))) and not room:HasCurseMist() then
            if mod.Timer > 0 then
                local f = Font()
                f:Load("font/teammeatfont16.fnt")
                for i = 1,game:GetNumPlayers() do
                    local player = Isaac.GetPlayer(i-1)
                    local data = mod:GetData(player)
                    if player:HasCollectible(collectible) and data.Bethany then
                        f:DrawStringScaled("Teleporting out in: "..math.ceil(mod.Timer/60),50,50,0.6,0.6,KColor(1,1,1,1,0,0,0),0,true)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.TimerRender)

function mod:ClickerCheck(collectible,_,player)
    local data = mod:GetData(player)
    if collectible == CollectibleType.COLLECTIBLE_CLICKER or collectible == CollectibleType.COLLECTIBLE_ESAU_JR then
        data.Bethany = nil
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerCheck)


