local mod = ExtraBirthright

function GetCharOptions(index)
    local tab = {}
    for k,v in pairs(mod.MCMOption.Options) do
        tab[k] = v
    end
    if mod.MCMOption.OptionsMaxNum[index] == 3 then
        table.remove(tab, 5)
        table.remove(tab, 3)
    end
    return tab
end

local function InitOptions()

    if not ImGui.ElementExists("extraBirthrightMenu") then
        ImGui.CreateMenu("extraBirthrightMenu", "EBE")
    end

    if ImGui.ElementExists("extraBirthrightMenuSettings") then
        ImGui.RemoveElement("extraBirthrightMenuSettings")
    end

    ImGui.AddElement("extraBirthrightMenu", "extraBirthrightMenuSettings", ImGuiElement.MenuItem, "Settings")

    if not ImGui.ElementExists("extraBirthrightMenuWindow") then
        ImGui.CreateWindow("extraBirthrightMenuWindow", "Extra Birthright Effects")
    end

    ImGui.LinkWindowToElement("extraBirthrightMenuWindow", "extraBirthrightMenuSettings")

    if ImGui.ElementExists("extraBirthrightMenuSettingsTabbar") then
        ImGui.RemoveElement("extraBirthrightMenuSettingsTabbar")
    end

    ImGui.AddTabBar("extraBirthrightMenuWindow", "extraBirthrightMenuSettingsTabbar")


    ImGui.AddTab("extraBirthrightMenuSettingsTabbar", "extraBirthrightMenuSettingsTabbarVanillaChar", "Vanilla Characters")
    ImGui.AddTabBar("extraBirthrightMenuSettingsTabbarVanillaChar", "extraBirthrightMenuSettingsTabbarVanillaCharSettings")
    ImGui.AddTab("extraBirthrightMenuSettingsTabbarVanillaCharSettings", "extraBirthrightMenuSettingsTabbarVanillaNormalChar", "Normal Characters")
    ImGui.AddTab("extraBirthrightMenuSettingsTabbarVanillaCharSettings", "extraBirthrightMenuSettingsTabbarVanillaTaintedChar", "Tainted Characters")
    ImGui.AddTab("extraBirthrightMenuSettingsTabbarVanillaCharSettings", "extraBirthrightMenuSettingsTabbarVanillaTaintedCain", "Tainted Cain Birthright option")

    if #mod.MCMOption.Name >= 42 then
        ImGui.AddTab("extraBirthrightMenuSettingsTabbar", "extraBirthrightMenuSettingsTabbarModdedChar", "Modded Characters")
        ImGui.AddTabBar("extraBirthrightMenuSettingsTabbarModdedChar", "extraBirthrightMenuSettingsTabbarModdedCharSettings")

        ImGui.AddTab("extraBirthrightMenuSettingsTabbarModdedCharSettings", "extraBirthrightMenuSettingsTabbarModdedNormalChar", "Normal Characters")
        ImGui.AddTab("extraBirthrightMenuSettingsTabbarModdedCharSettings", "extraBirthrightMenuSettingsTabbarModdedTaintedChar", "Tainted Characters")
    end


    for i = 1, #mod.MCMOption.Name do
        
        if mod.MCMOption.Name[i] then
            if i ~= 18 and (i < 39 or i > 41) then
                
                local char = "Vanilla"
                local charType = "Normal"

                if i >= 42 then
                    char = "Modded"
                end

                if string.match(mod.MCMOption.Name[i], "Tainted") then
                    charType = "Tainted"
                end

                local dest = "extraBirthrightMenuSettingsTabbar"..char..charType.."Char"

                ImGui.AddCombobox(dest, dest..mod.MCMOption.Name[i], mod.MCMOption.Name[i], function(index, val)
                    mod.MCMOption.Settings[mod.MCMOption.Name[i]] = index + 1
                    mod:BirthrightDesc()
                end, GetCharOptions(i), 0, false)
            
                if type(mod.MCMOption.Labels[i]) == "string" then
                    ImGui.SetHelpmarker(dest..mod.MCMOption.Name[i], "Effects: "..mod.MCMOption.Labels[i])
                end
            end
        end
    end
    ImGui.AddDragInteger("extraBirthrightMenuSettingsTabbarVanillaTaintedCain", "extraBirthrightMenuSettingsTabbarVanillaTaintedCainOption", "Chance to pickup birthright",
    function(val)
        mod.MCMTCainBirthright["BirthrightYoink"] = val
    end, 0, 1, 1, 100)
    ImGui.AddCallback("extraBirthrightMenu", ImGuiCallback.Render, function()
        if mod.IsRunLoaded then
            for i = 1, #mod.MCMOption.Name do
            
                if mod.MCMOption.Name[i] then
                    if i ~= 18 and (i < 39 or i > 41) then
                        
                        local char = "Vanilla"
                        local charType = "Normal"
        
                        if i >= 42 then
                            char = "Modded"
                        end
        
                        if string.match(mod.MCMOption.Name[i], "Tainted") then
                            charType = "Tainted"
                        end
        
                        local dest = "extraBirthrightMenuSettingsTabbar"..char..charType.."Char"
        
                        ImGui.UpdateData(dest..mod.MCMOption.Name[i], ImGuiData.Value, mod.MCMOption.Settings[mod.MCMOption.Name[i]] - 1)
                    end
                end
            end
            ImGui.UpdateData("extraBirthrightMenuSettingsTabbarVanillaTaintedCainOption", ImGuiData.Value, mod.MCMTCainBirthright["BirthrightYoink"])
        end
    end)

end

if REPENTOGON then
    InitOptions()
    function mod:ReloadImGui()
        InitOptions()
    end
end