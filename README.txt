This mod features API for adding custom Birthright effects for modded characters. It's kinda similar to how Custom Health API handles it.
All callbacks are almost the same as base game but are defined in ExtraBirthright.Callbacks.Enums since they are for Tainted Eden.


ExtraBirthright.GetOptionsBirthright(option,extra) - gives you modded or vanilla birthright id (to track modded and combined modes). 
"option" - value between 1 and 3 (5 with "extra" set to true). Usually 1 is for vanilla, 2 is for modded effect only, 3 for combined.
"extra" - makes that character has 2 modded effects (2 and 3) and 2 combined effects (4 and 5).


ExtraBirthright.AddCustomEffectsMCM(playerType,name,extra,label,splash1,firstEID,splash2,secondEID) - function to add Mod Config Menu value for modded character (although you can do it in your mod if you want).
"playerType" - id of modded character.
"name" - name of modded character. Add 'Tainted' at the beginning for tainted character.
"extra" - set to true if you want 2 modded effects.
"label" - explanation of what modded effects are doing in MCM.
"splash1", "splash2" - splash text that appears when picking up birthright. Currently supports English, Russian and Spanish. Structure of value is table: splash = {en = "your text in that language", ru = "your text in that language", es = "your text in that language"}.
"firstEID", "secondEID" - EID for modded effect. Currently supports English, Russian and Spanish. Stucture is the same as "splash1" and "splash2"


ExtraBirthright.GetMCMValue(ptype) - gets current Mod Config Menu setting value of character. "ptype" is PlayerType.


ExtraBirthright.RemoveCustomEffectsOptions(name) - removes MCM settings, EID and splash text of character with that name

ExtraBirthright.AddOnPickupFunction(func) - custom effect of modded birthright effect on pickup


ExtraBirthright.AddBirthrightChangeCondition(func) - adds condition for changing to modded birthright. Define for which character inside function. Returns true or false


ExtraBirthright.AddCustomCallback(modID, id, priority, character, fn, ...) - functon to add custom birthright callback to Tainted Eden's Birthright. You'll have to define effect for character manually.


ExtraBirthright.UnregisterCustomCallbacks(modID) - remove all custom Tainted Eden callbacks with "modID".

if ExtraBirthright.Callbacks and ExtraBirthright.Callbacks.TEdenCallbacks and ExtraBirthright.UnregisterCustomCallbacks then
    ExtraBirthright.UnregisterCustomCallbacks("ExtraBirthright")
end


ExtraBirthright.GetCustomCallbacks(id) - get all Tainted Eden callbacks with "id". Returns table of functions.


ExtraBirthright.IsString(str) - function to check if value exists and is string. Returns true or false
ExtraBirthright.IsNumber(num) - function to check if value exists and is number. Returns true or false
ExtraBirthright.IsTable(tab) - function to check if value exists and is table. Returns true or false