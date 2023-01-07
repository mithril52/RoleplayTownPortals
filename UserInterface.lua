
if not RTP then RTP = { } end
if not RTP.UI then RTP.UI = { } end
if not RTP.UTIL then RTP.UTIL = { } end

RTP.UI.IndicatorTooltip = "Role-Play Town Portals"

local libDialog = LibDialog

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

    for townId,town in pairs(RTP.Towns) do
        local publicLocations = {}
        local index = 1
        for _,location in pairs(RTP.Locations) do
            if location.public and location.townId == townId then
                local locationName = RTP.BuildLocationName(location)

                publicLocations[index] = {
                    label = locationName,
                    callback = function() 
                        RTP.UI.JumpToPortalLocationById(location.id)
                    end
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
    d(string.format("Portal: {location = %i, destinations = {##}, x = %i, y = %i, z = %i, cx = %f, cy = %f},", locationId, x, y, z, normalizedX, normalizedZ))
end

-- Dialogs
function RTP.UI.ShowPortalConfirmation(destinationId, portal)
    local destination = RTP.Locations[destinationId]
    local town = RTP.Towns[destination.townId]

    RTP.UI.ShowConfirmationDialog("Role-Play Town Portals", 
            "|cffffffThis is a portal to |c00ffff"..RTP.BuildLocationName(destination, portal).." in |c00ffff"..town.name.."|cffffff. Would you like to take the portal there now? ", 
            function() RTP.UI.JumpToPortalLocation(destination.owner, destination.houseId)  end)
end

function RTP.UI.ShowSelectLocationDialog(destinations)
    RTP.UI.DestinationSelection = destinations[1]
    
    local radioButtons = {}
    local index = 1
    
    for destinationId in pairs(destinations) do
        local destination = RTP.Locations[destinationId]
        
        radioButtons[index] = {}
        radioButtons[index].text = "|c00ffff"..destination.name
        radioButtons[index].clickedCallback = function() 
            ZO_Dialogs_ReleaseAllDialogs()
            RTP.UI.JumpToPortalLocationById(destinationId)
        end
        
        index = index + 1;
    end
    
    libDialog:AddRadioButtons(RTP.ADDON_NAME, RTP.CONST.DIALOG_SELECT_DESTINATION, radioButtons)
    libDialog:ShowDialog(RTP.ADDON_NAME, RTP.CONST.DIALOG_SELECT_DESTINATION, nil)
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

function RTP.UI.RegisterDialogs()
    libDialog:RegisterDialog(RTP.ADDON_NAME, RTP.CONST.DIALOG_SELECT_DESTINATION, "Select Portal Destination",
            "This portal leads to multiple destinations. Please click the destination you want below and you will travel there",
            nil, nil, nil, true, {}, {}
    )
end 