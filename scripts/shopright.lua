local BirthrightInShop = {}
local substituteBirthright = Isaac.GetItemIdByName("Birthright (Alt)")

function BirthrightInShop:BirthrightShop()
    local player = Isaac.GetPlayer(0)
    local roomtype = Game():GetRoom():GetType() == RoomType.ROOM_SHOP
    local hasCollectible = player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) or player:HasCollectible(substituteBirthright)
    local iscollectible = #Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 619) > 0 or #Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, substituteBirthright) > 0
    if not hasCollectible and not iscollectible and roomtype then
        local collectible = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1)
        collectible[1]:ToPickup():Morph(5,100,619,true)
    end
end
ExtraBirthright:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, BirthrightInShop.BirthrightShop)