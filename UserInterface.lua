
if not RTP then RTP = { } end
if not RTP.UI then RTP.UI = { } end
if not RTP.UTIL then RTP.UTIL = { } end

RTP.UI.IndicatorTooltip = "Role-Play Town Portals"

-- XML User Interface handling code
function RTP.UI.OnIndicatorButtonMouseEnter()
    ZO_Tooltips_ShowTextTooltip(RTPIndicatorButton, BOTTOMRIGHT, RTP.UI.IndicatorTooltip)
end

function RTP.UI.OnIndicatorButtonMouseExit()
    ZO_Tooltips_HideTextTooltip()
end

-- Context Menu
function RTP.UI.ShowIndicatorContextMenu()
    ClearMenu()

    if IsControlKeyDown() then
        AddCustomMenuItem("Generate Portal text", function() RTP.UI.GeneratePortalText() end)
    end

    for townId,town in ipairs(RTP.Towns) do
        local publicLocations = {}
        local index = 1
        for _,location in ipairs(RTP.Locations) do
            if location.public and location.townId == townId then
                local locationName = RTP.BuildLocationName(location)

                publicLocations[index] = {
                    label = locationName,
                    callback = function() RTP.UI.JumpToPortalLocationById(location.id) end
                }
                
                index = index + 1
            end
        end

        AddCustomSubMenuItem(town.name.." Public Locations", publicLocations)
    end

    local minimizedIndex = AddCustomMenuItem("Minimize UI", 
            function() 
                RTP.SavedVars.IndicatorMinimized = not RTP.SavedVars.IndicatorMinimized
                RTP.IndicatorMinimizedChanged()
            end,
            MENU_ADD_OPTION_CHECKBOX
    )
    
    if RTP.SavedVars.IndicatorMinimized then
        ZO_CheckButton_SetChecked(ZO_Menu.items[minimizedIndex].checkbox)
    else
        ZO_CheckButton_SetUnchecked(ZO_Menu.items[minimizedIndex].checkbox)
    end
    
    ShowMenu()
end

function RTP.UI.GeneratePortalText()
    local houseId = GetCurrentZoneHouseId()
    if houseId == 0 then
        d("[RTP]: Portals can only be created in player homes")
        return;
    end
    
    local owner = GetCurrentHouseOwner()
    local zoneId, x, y, z = GetUnitWorldPosition("player")
    local normalizedX, normalizedZ = GetMapPlayerPosition("player")
    local _, map = LibMapPins:GetZoneAndSubzone()
    local locationId = -1
    
    for _,location in pairs(RTP.Locations) do
        if location.houseId == houseId and location.owner == owner then
            locationId = location.id
        end
    end
    
    d(string.format("Map: [%i] = {id = %i, map = \"%s\"},", houseId, houseId, map))
    d(string.format("Location: {id = %i, houseId = %i, owner = \"%s\", townId = 1, name = \"Name goes here\"},", locationId, houseId, owner))
    d(string.format("Portal: {location = %i, destination = ##, x = %i, y = %i, z = %i, cx = %f, cy = %f},", locationId, x, y, z, normalizedX, normalizedZ))
end

-- Dialogs
function RTP.UI.ShowPortalConfirmation(destinationId)
    local destination = RTP.Locations[destinationId]
    local town = RTP.Towns[destination.townId]
    
    RTP.UI.ShowConfirmationDialog("Role-Play Town Portals", 
            "|cffffffThis is a portal to |c00ffff"..RTP.BuildLocationName(destination).." in |c00ffff"..town.name.."|cffffff. Would you like to take the portal there now? ", 
            function() RTP.UI.JumpToPortalLocation(destination.owner, destination.houseId)  end)
end

function RTP.UI.JumpToPortalLocationById(locationId)
    local location = RTP.Locations[locationId]

    RTP.UI.JumpToPortalLocation(location.owner, location.houseId)
end

function RTP.UI.JumpToPortalLocation(owner, houseId)
    if owner == GetDisplayName() then
        RequestJumpToHouse(houseId)
    else
        JumpToSpecificHouse(owner, houseId)
    end
end

function RTP.UI.InitializeConfirmationDialog()
    if not ESO_Dialogs[ RTP.CONST.DIALOG_CONFIRM ] then
        ESO_Dialogs[ RTP.CONST.DIALOG_CONFIRM ] = {
            canQueue = true,
            title = { text = "" },
            mainText = { text = "" },
            buttons = {
                [1] = {
                    text = SI_DIALOG_CONFIRM,
                    callback = function() end,
                },
                [2] = {
                    text = SI_DIALOG_CANCEL,
                    callback = function() end,
                }
            }
        }
    end

    return ESO_Dialogs[ RTP.CONST.DIALOG_CONFIRM ]
end

function RTP.UI.ShowConfirmationDialog( title, body, confirmCallback, cancelCallback)
    local dialog = RTP.UI.InitializeConfirmationDialog()
    dialog.title.text = title
    dialog.mainText.text = body
    dialog.buttons[1].callback = 
        function()
            if confirmCallback ~= nil then
                confirmCallback()
            end
        end
    dialog.buttons[2].callback = 
        function()
            if cancelCallback ~= nil then
                cancelCallback()
            end
        end

    ZO_Dialogs_ShowDialog( RTP.CONST.DIALOG_CONFIRM )
end
