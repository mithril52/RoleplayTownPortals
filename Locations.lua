RTP.HouseMaps = {
    [16] = {id = 16, map = "glenumbra_base"},
    [29] = {id = 29, map = "windhelm_base"},
    [30] = {id = 30, map = "therift_base"},
    [40] = {id = 40, map = "grandtopal_base"},
    [47] = {id = 47, map = "coldharbour_base"},
    [48] = {id = 48, map = "falkreathhousing_base"},
    [71] = {id = 71, map = "moonsugarmeadow_base"},
    [81] = {id = 81, map = "antiquariansalpineext_base"}
}
RTP.Towns ={
    {id = 1, name = "Hofborg", startingLocation = 1}
}
RTP.Locations = {
    {id = 1, houseId = 71, owner = "@Shadoe12", townId = 1, name = "The Borg"},
    {id = 2, houseId = 71, owner = "@mithril52", townId = 1, name = "The Spirit Woods"},
    {id = 3, houseId = 48, owner = "@Shadoe12", townId = 1, name = "The Motherhouse"},
    {id = 4, houseId = 47, owner = "@Larawyn", townId = 1, name = "Saebjorn Long Hall"},
    {id = 5, houseId = 40, owner = "@TheBerserker88", townId = 1, name = "The Docks"},
    {id = 6, houseId = 71, owner = "@Oim", townId = 1, name = "The Village"},
    {id = 7, houseId = 71, owner = "@Cosmere", townId = 1, name = "The Faire Grounds"},
    {id = 8, houseId = 29, owner = "@Larawyn", townId = 1, name = "Thorrstad Apartments"},
    {id = 9, houseId = 16, owner = "@rainbowbunny8", townId = 1, name = "Hall Mistress Apartments"},
    {id = 10, houseId = 71, owner = "@TheGreatHrimbo", townId = 1, name = "Clever Cave"},
    {id = 11, houseId = 81, owner = "@sinath41", townId = 1, name = "Hammer Long Hall"},
    {id = 12, houseId = 30, owner = "@Kwittles", townId = 1, name = "Tinker Shop"},
}
RTP.Portals = {
    [1] = { --Hofborg: The Borg
        {location = 1, destination = 2, x = 59173, y = 29521, z = 54668, cx = 0.325924, cy = 0.313501},
        {location = 1, destination = 3, x = 66138, y = 29242, z = 59534, cx = 0.480059, cy = 0.421380},
        {location = 1, destination = 4, x = 61236, y = 29454, z = 63784, cx = 0.371854, cy = 0.515201},
        {location = 1, destination = 5, x = 68081, y = 29215, z = 70844, cx = 0.523374, cy = 0.671625},
    },
    [2] = { --Hofborg: The Spirit Woods
        {location = 2, destination = 7, x = 59170, y = 29521, z = 54670, cx = 0.326087, cy = 0.313501},
        {location = 2, destination = 1, x = 70367, y = 28976, z = 70341, cx = 0.574044, cy = 0.660673},
        {location = 2, destination = 10, x = 65871, y = 29338, z = 58991, cx = 0.473848, cy = 0.410592},
        {location = 2, destination = 11, x = 64907, y = 29226, z = 73029, cx = 0.453089, cy = 0.720170},
    },
    [3] = { --Hofborg: The Motherhouse
        {location = 3, destination = 1, x = 50417, y = 39220, z = 94570, cx = 0.277314, cy = 0.799364, radius = 20},
        {location = 3, destination = 6, x = 52148, y = 17738, z = 87341, cx = 0.300159, cy = 0.703814},
    },
    [4] = { --Hofborg: Saebjorn Long Hall
        {location = 4, destination = 1, x = 82991, y = 36927, z = 83368, cx = 0.566294, cy = 0.541505},
        {location = 4, destination = 8, x = 81960, y = 37256, z = 88112, cx = 0.566004, cy = 0.542143},
        {location = 4, destination = 9, x = 81731, y = 37254, z = 86133, cx = 0.566059, cy = 0.542607},
    },
    [5] = { --Hofborg: The Docks
        {location = 5, destination = 6, x = 64422, y = 20197, z = 66950, cx = 0.468136, cy = 0.122154},
    },
    [6] = { --Hofborg: The Village
        {location = 6, destination = 5, x = 59163, y = 29521, z = 54676, cx = 0.325760, cy = 0.313665},
        {location = 6, destination = 7, x = 72719, y = 28975, z = 62201, cx = 0.626185, cy = 0.481040},
        {location = 6, destination = 12, x = 70875, y = 28975, z = 65710, cx = 0.585159, cy = 0.558025},
    },
    [7] = { --Hofborg: The Faire Grounds
        {location = 7, destination = 6, x = 59163, y = 29521, z = 54676, cx = 0.326250, cy = 0.313338},
        {location = 7, destination = 2, x = 65723, y = 29288, z = 59190, cx = 0.471069, cy = 0.414678},
    },
    [8] = { --Hofborg: Thorrstad Apartments
        {location = 8, destination = 4, x = 26343, y = 20019, z = 25502, cx = 0.717911, cy = 0.364741},
    },
    [9] = { --Hofborg: Hall Mistress Apartments
        {location = 9, destination = 4, x = 19650, y = 20026, z = 29035, cx = 0.312595, cy = 0.789945},
    },
    [10] = { --Hofborg: Clever Cave
        {location = 10, destination = 2, x = 59186, y = 29521, z = 54656, cx = 0.326087, cy = 0.313338},
    },
    [11] = { --Hofborg: Hammer Long Hall
        {location = 11, destination = 2, x = 165387, y = 27707, z = 152042, cx = 0.669159, cy = 0.167601},
    },
    [12] = { --Hofborg: Tinker Shop
        {location = 12, destination = 6, x = 26372, y = 26644, z = 19720, cx = 0.724823, cy = 0.549507},
    },
}

RTP.CurrentLocation = nil

RTP.InPortal = false
RTP.ChangedZone = false
RTP.LastPosition = nil
RTP.SetChangedZone = false
RTP.Porting = true
RTP.MapPinTypeId = nil

function RTP.InitializeLocations()
    RTP.GenerateCylinders()
    RTP.CreateMapPins()
    RTP.CreateCompassPins()
    RTP.OnZoneChanged()
    
    EVENT_MANAGER:RegisterForEvent(RTP.ADDON_NAME, EVENT_PLAYER_ACTIVATED, RTP.OnZoneChanged)
    EVENT_MANAGER:RegisterForEvent(RTP.ADDON_NAME, EVENT_PLAYER_DEACTIVATED, RTP.OnZoneChanging)
    EVENT_MANAGER:RegisterForEvent(RTP.ADDON_NAME, EVENT_HOUSING_POPULATION_CHANGED, RTP.OnPopulationChanged)
    EVENT_MANAGER:RegisterForUpdate(RTP.CONST.CHECK_PORTALS_ID, 250, RTP.CheckPortals)
end

function RTP.OnPopulationChanged()
    RTP.UpdateLocationUI()
end
function RTP.OnZoneChanging()
    RTP.Porting = true
end

function RTP.OnZoneChanged()
    if RTP.SetChangedZone then
        RTP.ChangedZone = true
    else
        RTP.SetChangedZone = true
    end
    
    RTP.SetCurrentLocation()
    
    COMPASS_PINS:RefreshPins(RTP.CONST.COMPASS_PIN_TYPE)
    LibMapPins:RefreshPins(RTP.CONST.MAP_PIN_TYPE)
    
    if RTP.CurrentLocation ~= nil then
        local town = RTP.Towns[RTP.CurrentLocation.townId]
        
        RTPZoneChangeIndicatorLabel:SetText(string.format(
                "You have entered %s in the town of %s", RTP.CurrentLocation.name, town.name))
        RTPZoneChangeIndicatorPopulationLabel:SetText(string.format(
                "( Current Population %i of %i)", GetCurrentHousePopulation(), GetCurrentHousePopulationCap()))
        RTPZoneChangeIndicator:SetAlpha(1)
        local animation, timeline = CreateSimpleAnimation(ANIMATION_ALPHA, RTPZoneChangeIndicator)
        
        animation:SetAlphaValues(RTPZoneChangeIndicator:GetAlpha(), 0)
        animation:SetDuration(1000)
        timeline:SetPlaybackType(ANIMATION_PLAYBACK_ONE_SHOT)
        zo_callLater(function() timeline:PlayFromStart() end, 8000)
    end
    
    RTP.Porting = false
end

function RTP.CreateCompassPins()
    COMPASS_PINS:AddCustomPin(RTP.CONST.COMPASS_PIN_TYPE,
            function(pinManager)
                if RTP.CurrentLocation == nil then return end
                
                for _, portal in pairs(RTP.Portals[RTP.CurrentLocation.id]) do
                    if portal.cx == nil then return end
                    
                    local name = RTP.Locations[portal.destination].name
                    pinManager:CreatePin(RTP.CONST.COMPASS_PIN_TYPE, portal, portal.cx, portal.cy, name)
                end
            end,
            { 
                FOV = 3.14,
                maxDistance = 0.11,
                texture = "/esoui/art/treeicons/collection_indexicon_housing_down.dds",
                sizeCallback =
                function(pin, angle, normalizedAngle, normalizedDistance)
                    local newSize = math.max(48 - 48 * normalizedDistance, 16)
                    pin:SetDimensions(newSize, newSize)
                end
            })
end

function RTP.CreateMapPins()
    RTP.MapPinTypeId = LibMapPins:AddPinType(RTP.CONST.MAP_PIN_TYPE, 
            function(pinManager)
                LibMapPins:RemoveCustomPin(RTP.CONST.MAP_PIN_TYPE)
                
                if not LibMapPins:IsEnabled(RTP.CONST.MAP_PIN_TYPE) then return end
                
                if RTP.CurrentLocation == nil or RTP.Portals[RTP.CurrentLocation.id] == nil then
                    return
                end

                for _, portal in pairs(RTP.Portals[RTP.CurrentLocation.id]) do
                    if portal.cx == nil then return end
                    if RTP.HouseMaps[RTP.CurrentLocation.houseId] == nil then return end
                    if RTP.CurrentLocation.owner ~= GetCurrentHouseOwner() then return end
                    
                    local _, subzone = LibMapPins:GetZoneAndSubzone();
                    if RTP.HouseMaps[RTP.CurrentLocation.houseId].map ~= subzone then return end
                    local destination = RTP.Locations[portal.destination]
                    LibMapPins:CreatePin(RTP.CONST.MAP_PIN_TYPE, {portal = portal, destination = destination}, portal.cx, portal.cy)
                end
            end, 
            nil,
            {
                level = 50,
                texture = "/esoui/art/treeicons/collection_indexicon_housing_down.dds",
                size = 30,
            },
            {
                creator = function(pin)
                    local _, pinTag = pin:GetPinTypeAndTag()
                    if pinTag.destination == nil then return end
                    
                    InformationTooltip:AddLine(pinTag.destination.name)
                end,
                tooltip = ZO_MAP_TOOLTIP_MODE.INFORMATION,
            }
    )
    
    LibMapPins:AddPinFilter(RTP.MapPinTypeId, "Role-Play Town Portals", nil, nil, nil, nil)
end

function RTP.CheckPortals()
    if RTP.Porting then
        return
    end
    
    if RTP.CurrentLocation == nil then
        RTP.InPortal = false
        return
    end
    
    local locationId = RTP.CurrentLocation.id

    if RTP.Portals[locationId] == nil then
        RTP.InPortal = false
        return
    end

    local _, x, y, z = GetUnitWorldPosition("player")
    local position = {x = x, y = y, z = z}

    if RTP.UTIL.PositionsEqual(position, RTP.LastPosition) then
        return
    end

    RTP.LastPosition = position

    for key, value in pairs(RTP.Portals[locationId]) do
        if RTP.UTIL.PointWithinCylinder(position, value.cylinder) then
            if not RTP.InPortal then
                RTP.InPortal = true

                if RTP.ChangedZone then
                    RTP.ChangedZone = false
                else
                    RTP.UI.ShowPortalConfirmation(value.destination)
                end
            end
            
            return
        end
    end

    if RTP.InPortal then
        RTP.InPortal = false
        ZO_Dialogs_ReleaseAllDialogs()
        return
    end
    
    RTP.ChangedZone = false
end

function RTP.GenerateCylinders()
    for listKey, listValue in pairs(RTP.Portals) do
        if listValue ~= nil then
            for key, value in pairs(listValue) do
                local radius = 220

                if value.radius ~= nil then
                    radius = value.radius
                end
                value.cylinder = RTP.UTIL.GenerateCylinder({x = value.x, y = value.y, z = value.z}, radius)
            end
        end
    end
end

function RTP.SetCurrentLocation()
    local houseId = GetCurrentZoneHouseId()
    if houseId ~= 0 then
        local owner = GetCurrentHouseOwner()
        
        if RTP.CurrentLocation ~= nil and RTP.CurrentLocation.houseId == houseId and RTP.CurrentLocation.owner == owner then
            return
        end
        
        for key, value in pairs(RTP.Locations) do
            if value.houseId == houseId and value.owner == owner then
                RTP.CurrentLocation = value
                RTP.UpdateLocationUI()
                return
            end
        end
    end
    
    RTP.CurrentLocation = nil
    RTP.UpdateLocationUI()
end

function RTP.UpdateLocationUI()
    local population = GetCurrentHousePopulation()
    local populationCap = GetCurrentHousePopulationCap()
    
    -- Clear out tooltip and indicator labels
    RTPIndicatorTownLabel:SetText("")
    RTPIndicatorLocationLabel:SetText("")
    RTPIndicatorPopulationLabel:SetText("")
    RTP.UI.IndicatorTooltip = "Role-Play Town Portals"
    
    -- Populate appropriate labels
    if RTP.CurrentLocation == nil then
        if RTP.SavedVars.IndicatorMinimized then
            RTP.UI.IndicatorTooltip = "Role-Play Town Portals |cffffff\nLocation: |cFF9400Not in a Town"
        else
            RTPIndicatorTownLabel:SetText("|cFF9400Not in a Town")
        end
    else
        local town = RTP.Towns[RTP.CurrentLocation.townId]

        if RTP.SavedVars.IndicatorMinimized then
            RTP.UI.IndicatorTooltip = "Role-Play Town Portals |cffffff\nLocation: |c00ffff"
                    ..RTP.CurrentLocation.name.." in "..town.name.."|cffffff"
                    .."\nPopulation: |c00ffff"..population.." of "..populationCap
        else
            RTPIndicatorTownLabel:SetText(town.name)
            RTPIndicatorLocationLabel:SetText("-"..RTP.CurrentLocation.name)
            RTPIndicatorPopulationLabel:SetText(population.."/"..populationCap)
        end
    end
end 