--[========================================================================[
    This is free and unencumbered software released into the public domain.

    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.

    In jurisdictions that recognize copyright laws, the author or authors
    of this software dedicate any and all copyright interest in the
    software to the public domain. We make this dedication for the benefit
    of the public at large and to the detriment of our heirs and
    successors. We intend this dedication to be an overt act of
    relinquishment in perpetuity of all present and future rights to this
    software under copyright law.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
    OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
    ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

    For more information, please refer to <http://unlicense.org/>
--]========================================================================]

local MAJOR, MINOR = "LibDialog", 1.25
if _G[MAJOR] ~= nil and (_G[MAJOR].version and _G[MAJOR].version >= MINOR) then return end

--Library table, name and version
local lib = {}
lib.name    = MAJOR
lib.version = MINOR


------------------------------------------------------------------------
-- 	TESTING ONLY!
------------------------------------------------------------------------
--Disable if not testing!
local LibraryTestMode = false
local function isBaertramTesting()
    --Is the testing enabled?
    if not LibraryTestMode == true then return false end
    --Security check for displayname/account name @Baertram. If you want to test as well comment this line below!
    --if GetDisplayName() ~= "@Baertram" then return false end
    return true
end


------------------------------------------------------------------------
-- 	Global variables
------------------------------------------------------------------------
_G[MAJOR] = lib --Create global "LibDialog"

------------------------------------------------------------------------
-- 	Local variables, global for the library
------------------------------------------------------------------------
local existingDialogs = {} -- all the created dialogs of this library
local dialogTextParams = {} -- the dialog textParams
local dialogAdditionalOptions = {} -- the dialogs additionalOptions
--ZOs standard eventHandler functions at radioButtons in the dialog
local dialogRadioButtonOrigHandlerAtRadioButton = {} -- the original handler of the ZO_Dialogs1 radioButton. subtable [handlerName][radioButtonNumber]
--Custom added eventHandler functions at radioButtons in the dialog
local dialogRadioButtonHandlersAdded = {} -- the dialogs radioButton handlers added flag (for the callback fucntion of the dialog, in order to only add the handlers once). subtables [dialogName]
local dialogRadioButtonHandlerAtRadioButtonAdded = {} -- was a handler added to the dialog's radio button number? subtables [dialogName][radioButtonNumber][handlerName]

lib.lastShownDialogAddonName = nil
lib.lastShownDialogDialogName = nil
lib.lastShownDialogData = {}
lib.lastZO_Dialogs_ShowDialogReturnedDialog = {}


------------------------------------------------------------------------
-- ZO_Dialogs - constants
------------------------------------------------------------------------
local em = EVENT_MANAGER
local wm = WINDOW_MANAGER
local rbContainerControlNameOfZoDialog = "ZO_Dialog1RadioButtonContainer"


------------------------------------------------------------------------
-- ZO_Dialogs - possible parameters
------------------------------------------------------------------------

--Valid dialog additional options
--Options like "editBox = { ... }, warning, or "customControl = {...}"
--You can find all options here in the lines ff
--https://github.com/esoui/esoui/blob/0569f38e70254b4e08a5eab088c4ce5e7e46be55/esoui/libraries/zo_dialog/zo_dialog.lua#L568

--Valid additional dialog parameters
local validAdditionalOptions = {
    ["canQueue"]        = { paramTypes = {"boolean", "function"} },
    ["title"]           = { paramTypes = {"table", } },
    -- text: String or function returning a string (can contain placeholders <<1>> etc. for zo_strformat)
    -- align: TEXT_ALIGN_* member to set the alignment of the text (TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, or TEXT_ALIGN_CENTER....left is default).
    -- timer: index,  which indicates that a certain parameter should be treated as seconds in a timer, and converted to time format
    --      (so if title contains "timer = 2", the 2nd parameter (<<2>>) in title.text is converted via zo_strformat to time format before being placed
    --      in the string).
    --Can this dialog be queued and called later, or not?
    ["mainText"]        = { paramTypes = {"table", } },
    -- text: String or function returning a string (can contain placeholders <<1>> etc. for zo_strformat)
    -- align: TEXT_ALIGN_* member to set the alignment of the text (TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, or TEXT_ALIGN_CENTER....left is default).
    -- timer: index,  which indicates that a certain parameter should be treated as seconds in a timer, and converted to time format
    --      (so if mainText contains "timer = 2", the 2nd parameter (<<2>>) in mainText.text is converted via zo_strformat to time format before being placed
    --      in the string).
    --Can this dialog be queued and called later, or not?
    ["callback"]        = { paramTypes = {"function"}, },
    -- A callback function of the dialog, fired as the dialog is shown via ZO_Dialogs_ShowDialog
    -- 1 parameter in the callback function: number dialogID
    ["updateFn"]        = { paramTypes = {"function"}, },
    -- an update function called automatically as OnUpdate fires for the dialog
    ["gamepadInfo"]     = { paramTypes = {"table"} },
    --dialogType = any dialog of GAMEPAD_DIALOGS:
    --->GAMEPAD_DIALOGS.BASIC
    --->GAMEPAD_DIALOGS.CENTERED
    --->GAMEPAD_DIALOGS.COOLDOWN
    --->GAMEPAD_DIALOGS.CUSTOM
    --->GAMEPAD_DIALOGS.ITEM_SLIDER
    --->GAMEPAD_DIALOGS.PARAMETRIC
    --->GAMEPAD_DIALOGS.STATIC_LIST
    --text = number e.g. SI_DIALOG_CANCEL string constant, string text, or function returning a string
    --allowShowOnNextScene = boolean
    ["showLoadingIcon"] = { paramTypes = {"boolean"} },
    --An option to show an animated loading icon near the main text. See parameter "loadingIcon" below
    ["customLoadingIcon"]     = { paramTypes = {"string", "function"} },
    --You can specify your own texture here which should be used as the loading icon.
    --dialog.loadingIcon = "string texture" (see https://github.com/esoui/esoui/blob/0569f38e70254b4e08a5eab088c4ce5e7e46be55/esoui/libraries/zo_dialog/zo_dialog.lua#L580)
    --As the "dialog" table will be created within function ZO_Dialogs_ShowDialog we need to apply our custom texture somehow to the control.
    --We will use the "callback" function of the dialog to achieve this! If a callback function was already defined we will "PreHook" this function to insert the texture first.
    ["modal"]           = { paramTypes = {"boolean"} },
    --Show the dialog modal or not
    ["warning"]         = { paramTypes = {"table"} },
    --Show a warning text at teh dialog.
    -- table with parameters
    --->string or function text,
    --->number timer,
    -----> You specify the timer index number here.
    -----> And inside the table "textParams" (see below) the warningParams the key must be the timer index, and the value the milliseconds left of that timer.
    -----> The attribute above (warning.text) should contain placeholders like <<1>> and <<2>> for a zo_strformat with the timer numbers! It will show a countdown then.
    --->boolean verboseTimer,
    ----> Show more details at the cooldown
    ["editBox"]         = { paramTypes = {"table"} },
    --Table specifiying an input edit control at the dialog. The following parameters can be added to the table:
    --->defaultText: number (will be used with function GetString(number)), or string. The default text shown at the edit box. Will be replaced upon typing in it
    --->textType: a textType constant (nil will be using TEXT_TYPE_ALL)
    ---->  TEXT_TYPE_ALL = 0
    ---->  TEXT_TYPE_PASSWORD = 1
    ---->  TEXT_TYPE_NUMERIC = 2
    ---->  TEXT_TYPE_NUMERIC_UNSIGNED_INT = 3
    ---->  TEXT_TYPE_ALPHABETIC = 4
    ---->  TEXT_TYPE_ALPHABETIC_NO_FULLWIDTH_LATIN = 5
    --->specialCharacters: a table with characters which can be entered into the input field. Table key is a number, value a character
    --->maxInputCharacters: number of maximum possible entered characters
    --->validatesText: boolean should the text in the editbox be validated
    --->validator: function for the text validation
    --->matchingString: string, Should the input into the editbox be compared to this matching string (e.g. used for DESTROY confirm dialog)
    --->autoComplete: table, containing info for a ZO_AutoComplete control attached to the editBox (will be created new if not existing).
    ---->subtable includeFlags: table with the include flags of the ZO_AutoComplete, e.g. { AUTO_COMPLETE_FLAG_GUILD, AUTO_COMPLETE_FLAG_RECENT, AUTO_COMPLETE_FLAG_RECENT_TARGET, AUTO_COMPLETE_FLAG_RECENT_CHAT },
    ---->subtable excludeFlags: table with the exclude flags of the ZO_AutoComplete, e.g.  {AUTO_COMPLETE_FLAG_FRIEND },
    ---->boolean onlineOnly: boolean parameter online only, e.g. AUTO_COMPLETION_ONLINE_OR_OFFLINE
    ---->number maxResults: number parameter max results, e.g. MAX_AUTO_COMPLETION_RESULTS
    ["radioButtons"]  = { paramTypes = {"table"} },
    -->Table specifiying radio buttons at the dialog. The table needs the radioButtonIndex as key and a subTable as value for each radio button.
    -->The following parameters can be added to the subTable of each radioButton:
    --->text: String
    --->data: Table with data of the radioButton
    ["customControl"]   = { paramTypes = {"userdata", "function"} },
    --An own created control you would like to anchor and show in the dialog
}

--Valid "special" additional dialog parameters
local specialAdditionalOptions = {
    ["buttonData"]      = { paramTypes = {"table"} }, -- needs to be a table with key = buttonIndex (1 or 2). Subdata can be visible (boolean or function returning a boolean)
    -->Table with key = buttonIndex (1 or 2) and a table as value. This table can contain the following entries:
    --->text: number (read via GetString(number), function returning a string, or string
    --->callback: function
    --->visible: function returning boolean, or boolean
    --->keybind: function returning a keybind, or keybind (if nil DIALOG_PRIMARY will be used for buttonIndex1 and DIALOG_NEGATIVE for buttonIndex2)
    --->noReleaseOnClick: boolean
    --->enabled: function returning boolean, or boolean
    --->clickSound: SOUNDS.SOUND_NAME
    --->requiresTextInput: boolean
}

--Valid text parameters (3rd parameter of function ZO_Dialogs_ShowDialog)
local validTextParams = {
    ["titleParams"]             = { paramTypes = {"table"} },
    --table containing key = number 1 to n and value = string or function returning a string.
    --Used to change the placeholders <<1>>, <<2>> etc. in the dialog's title.text string
    ["mainTextParams"]          = { paramTypes = {"table"} },
    --table containing key = number 1 to n and value = string text or function returning string.
    --Used to change the placeholders <<1>>, <<2>> etc. in the dialog's mainText.text string
    --Example:
    -- If the main text in the dialog has 2 parameters (e.g "Hello <<1>> <<2>>"), then the 3rd parameter of ZO_Dialogs_ShowDialog should contain a subtable called
    -- "mainTextParams" which itself contains 2 members, the first will go into the <<1>> and the second will go into the <<2>>. The 3rd parameter
    -- in ZO_Dialogs_ShowDialog can also contain a titleParams subtable which is used to fill in the parameters in the title, if needed.
    --
    -- So as an example, let's say you had defined a dialog in InGameDialogs called "TEST_DIALOG" with
    --      title = { text = "Dialog <<1>>" } and mainText = { text = "Main <<1>> Text <<2>>" }
    -- And you called
    --      ZO_Dialogs_ShowDialog("TEST_DIALOG", {5}, {titleParams={"Test1"}, mainTextParams={"Test2", "Test3"}})
    -- The resulting dialog would have a title that read "Dialog Test1" and a main text field that read "Main Test2 Text Test3".
    -- The 5 passed in the second parameter could be used by the callback functions to perform various tasks based on this value.
    ["warningParams"]           = { paramTypes = {"table"} },
    --table with parameters: Like the mainTextparams table is acting for maintext, this table is acrting for the warning table.
    --{ number timer }
    --The table here needs as key the parameter which should be replaced in the warning.text field placeholder <<[table key]>>
    ["buttonTextOverrides"]     = { paramTypes = {"table"} },
    --needs to be a table with key = buttonIndex (1 or 2) and will then overwrite the text of the buttons
    ["initialEditText"]         = { paramTypes = {"string"} },
    --used for additionalOptions.editBox as initial edit box text shown
}


------------------------------------------------------------------------------------------------------------------------
-- 	Helper functions
------------------------------------------------------------------------------------------------------------------------
local function StringOrFunctionOrGetString(stringVar)
    if type(stringVar) == "function" then
        return stringVar()
    elseif type(stringVar) == "number" then
        return GetString(stringVar)
    end
    return stringVar
end

--Check and assert that the dialog of the addon exists
local function assertDialogExists(uniqueAddonName, uniqueDialogName, dialogName)
    dialogName = dialogName or (uniqueAddonName .. "_" .. uniqueDialogName)
    assert(dialogName ~= nil and dialogName ~= "_" and ESO_Dialogs[dialogName] ~= nil, string.format("[" .. MAJOR .. "]Error: Dialog with the unique identifier \'%s\' does not exist in ESO_Dialogs, addon \'%s\'!", tostring(uniqueDialogName), tostring(uniqueAddonName)))
    local dialogs = existingDialogs[uniqueAddonName]
    assert(dialogs ~= nil and dialogs[uniqueDialogName] ~= nil, string.format("[" .. MAJOR .. "]Error: Dialog with the unique identifier \'%s\' does not exist for the addon \'%s\'!", tostring(uniqueDialogName), tostring(uniqueAddonName)))
    return dialogName, dialogs[uniqueDialogName]
end

--Get the dialog data
local function getDialogBaseData(uniqueAddonName, uniqueDialogName, dialogName)
    assertDialogExists(uniqueAddonName, uniqueDialogName, dialogName)
    local baseDataOfDialog = ESO_Dialogs[dialogName]
    if not baseDataOfDialog then
        return
    end
    return baseDataOfDialog
end

--Get the additionalOptions of the dialog
local function getDialogAdditionalData(dialogName)
    local additionalData = dialogAdditionalOptions[dialogName]
    --No additional options found for the the dialog? Then no editBox was added before via this library
    if not additionalData then return end
    return additionalData
end

--Get the textParameters of the dialog
local function getDialogTextParams(dialogName)
    local textParams = dialogTextParams[dialogName]
    --No additional options found for the the dialog? Then no editBox was added before via this library
    if not textParams then return end
    return textParams
end

--Get the dialog base data, additionalOptions and textParams
local function getAllDialogData(uniqueAddonName, uniqueDialogName, dialogName)
    if dialogName == nil or ( uniqueAddonName == nil or uniqueAddonName == "" or uniqueDialogName == nil or uniqueDialogName == "") then
        return nil, nil, nil
    end
    dialogName = dialogName or uniqueAddonName .. "_" .. uniqueDialogName
    local baseData          = getDialogBaseData(uniqueAddonName, uniqueDialogName, dialogName)
    local additionalData    = getDialogAdditionalData(dialogName)
    local textParams        = getDialogTextParams(dialogName)
    return baseData, additionalData, textParams
end

--Check if the ZO_Dialogs radiobutton control container exists and return the number of children (radiobuttons)
local function getDialogRadioButtonContainerAndCount()
    --Check if the ZO_Dialogs radiobutton control container exists
    local rbContainer = wm:GetControlByName(rbContainerControlNameOfZoDialog)
    if not rbContainer then return nil, nil end
    --Get the number of radioButton children
    local numChildren = rbContainer:GetNumChildren()
    if numChildren == 0 then return nil, nil end
    return rbContainer, numChildren
end

--Check if any handler on the radioButtons need to be removed as well
local function checkAndRemoveCustomRadioButtonOnMouseUpHandler(p_dialogName, p_radioButtonNumber, p_rbControl)
    if not p_radioButtonNumber then return end
    --Check if the ZO_Dialogs radiobutton control container exists
    local rbContainer
    if p_rbControl == nil then
        rbContainer = getDialogRadioButtonContainerAndCount()
    end
    if p_rbControl ~= nil or (rbContainer ~= nil and rbContainer:GetChild(p_radioButtonNumber) ~= nil) then
        if dialogRadioButtonHandlersAdded[p_dialogName] == true then
            if dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName] and dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName][p_radioButtonNumber]
            and dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName][p_radioButtonNumber]["OnMouseUp"] == true then
                local origRBButtonOnMouseUpHandlerBase = dialogRadioButtonOrigHandlerAtRadioButton and dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"]
                    and dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][p_radioButtonNumber]
                if origRBButtonOnMouseUpHandlerBase ~= nil then
                    local rbControl = p_rbControl or (rbContainer and rbContainer:GetChild(p_radioButtonNumber))
                    if rbControl and origRBButtonOnMouseUpHandlerBase.rbHandler ~= nil then
                        rbControl:SetHandler("OnMouseUp", nil)
                        rbControl:SetHandler("OnMouseUp", origRBButtonOnMouseUpHandlerBase.rbHandler)
                    end
                    if origRBButtonOnMouseUpHandlerBase.rbLabelHandler ~= nil then
                        local rbLabelControl = rbControl and rbControl.label
                        if rbLabelControl then
                            rbLabelControl:SetHandler("OnMouseUp", nil)
                            rbLabelControl:SetHandler("OnMouseUp", origRBButtonOnMouseUpHandlerBase.rbLabelHandler)
                        end
                    end
                end
            end
        end
    end
end

--Did any dialog register a custom radioButton <eventHandlerName> (e.g. OnMouseUp) at the radio button with number <radioButtonNr>
--Returns boolean wasRegistered, string dialogName
local function didAnyDialogRegisterACustomHandlerOnTheRadioButton(eventHandlerName, radioButtonNr)
    if not eventHandlerName or eventHandlerName == "" or not radioButtonNr or radioButtonNr <=0 then return false, nil end
    --Check if any dialog has added an event handler of that type at all
    local wasAnyEventHandlerAddedForRadioButtons = false
    for dialogName, wasAdded in pairs(dialogRadioButtonHandlersAdded) do
        if wasAdded == true then
            wasAnyEventHandlerAddedForRadioButtons = true
            break
        end
    end
    if wasAnyEventHandlerAddedForRadioButtons == true then
        --Check if any dialog's eventHandler equals the given eventHandlerName
        for dialogName, dialogEventHandlerDataOfRadioButtons in pairs(dialogRadioButtonHandlerAtRadioButtonAdded) do
            for radioButtonNumber, dialogEventHandlerDataOfRadioButton in pairs(dialogEventHandlerDataOfRadioButtons) do
                if radioButtonNumber == radioButtonNr then
                    for eventHandlerNameInRBData, isRegistered in pairs(dialogEventHandlerDataOfRadioButton) do
                        if eventHandlerNameInRBData == eventHandlerName and isRegistered == true then
                            return true, dialogName
                        end
                    end
                end
            end
        end
    end
    return false, nil
end

------------------------------------------------------------------------------------------------------------------------
-- 	Dialog creation functions
------------------------------------------------------------------------------------------------------------------------
--register the unique dialog name at the global ESO_Dialogs namespace
local function RegisterCustomDialogAtZOsDialogs(dialogName, title, body)
    if not dialogName or dialogName == "" then return end

    --Define a new custom ESO dialog now
    ESO_Dialogs[dialogName] = {
        canQueue = true,
        uniqueIdentifier = "",
        title = {
            text = "",
        },
        mainText = {
            text = "",
        },
        buttons =  {
            [1] = {
                text = SI_DIALOG_CONFIRM,
                callback = function(dialog) d("what?!?") end,
                visible = function() return false end
            },
            [2] = {
                text = SI_DIALOG_CANCEL,
                callback = function(dialog) end,
            }
        },
        setup = function(dialog, data) end,
    }

    --Check if additional options were specified and exchange/add the values within ESO_DIALOGS[dialogName]
    local additionalOptionsCreatedHere = false
    local additionalOptions = getDialogAdditionalData(dialogName)
    if not additionalOptions then
        dialogAdditionalOptions[dialogName] = {}
        additionalOptions = dialogAdditionalOptions[dialogName]
        additionalOptionsCreatedHere = true
    end
    if additionalOptions["title"] == nil then
        additionalOptions["title"] = { text = title }
    end
    if additionalOptions["mainText"] == nil then
        additionalOptions["mainText"] = { text = body }
    end

    if not additionalOptionsCreatedHere and additionalOptions ~= nil then
        local callBackRegisteredData
        local customLoadingIconData
        local showLoadingIcon = false
        --d(">Add. options will be added")
        for additionalOptionTag, additionalOptionData in pairs(additionalOptions) do
            --d(">>checking additionalOptionTag: " ..tostring(additionalOptionTag))
            local validAdditionalOptionsOption = validAdditionalOptions[additionalOptionTag]
            local specialValidAdditionalOptionsOption = specialAdditionalOptions[additionalOptionTag]
            local typeOfParam = type(additionalOptionData)

            --Normal additions like defined in /esoui/libraries/zo_dialog.lua
            if validAdditionalOptionsOption ~= nil and validAdditionalOptionsOption.paramTypes ~= nil then
                --d(">>>checking valid params of this additional option")
                for _, validParamType in ipairs(validAdditionalOptionsOption.paramTypes) do
                    if validParamType == typeOfParam then
                        --d(">>>>adding this additional option")
                        ESO_Dialogs[dialogName][additionalOptionTag] = additionalOptionData
                        --Checks for special added tags
                        if additionalOptionTag == "showLoadingIcon" then
                            showLoadingIcon = true
                        elseif additionalOptionTag == "callback" then
                            callBackRegisteredData = additionalOptionData
                        elseif additionalOptionTag == "customLoadingIcon" then
                            customLoadingIconData = additionalOptionData
                        end
                    end
                end
            end

            --Was a custom loading icon registered?
            if showLoadingIcon == true and customLoadingIconData ~= nil then
                local function updateCustomLoadingIconTexture()
                    local textCtrl = GetControl(ZO_Dialog1, "Loading")
                    local loadingIconCtrl = GetControl(ZO_Dialog1, "LoadingIcon")
                    if loadingIconCtrl ~= nil and loadingIconCtrl.SetTexture then
                        local texturePath
                        if type(customLoadingIconData) == "function" then
                            texturePath = customLoadingIconData()
                        else
                            texturePath = customLoadingIconData
                        end
                        loadingIconCtrl:SetTexture(texturePath)
                        --ZO_Dialogs_SetDialogLoadingIcon(loadingIconCtrl, textCtrl, showLoadingIcon)
                    end
                end
                --Was a callback also registered already?
                if callBackRegisteredData ~= nil then
                    --Create a new function, calling our code for the custom loading icon first,
                    --and then the exisitng callback
                    local allreadyRegisteredCallback = ESO_Dialogs[dialogName]["callback"]
                    local function dialogCallBackNew()
                        updateCustomLoadingIconTexture()
                        allreadyRegisteredCallback()
                    end
                    ESO_Dialogs[dialogName]["callback"] = function() dialogCallBackNew() end
                else
                    --No callback registeerd yet, so use this for the csutom loading icon
                    --Create a callback function to regisetr the custom loading icon
                    ESO_Dialogs[dialogName]["callback"] = function() updateCustomLoadingIconTexture() end
                end
            end

            --Special dialog stuff like visible function/value of buttons etc.
            if specialValidAdditionalOptionsOption ~= nil and specialValidAdditionalOptionsOption.paramTypes ~= nil then
                --d(">Special add. options will be added")
                for _, validSpecialParamType in ipairs(specialValidAdditionalOptionsOption.paramTypes) do
                    --d(">>checking validSpecialParamType: " ..tostring(validSpecialParamType))
                    if validSpecialParamType == typeOfParam then
                        --Buttons
                        if additionalOptionTag == "buttonData" then
                            --d(">>>buttonData found")
                            for buttonIndex, actualButtonData in pairs(ESO_Dialogs[dialogName].buttons) do
                                --d(">>>>checking button #: " ..tostring(buttonIndex))
                                local newButtonData = additionalOptionData[buttonIndex]
                                if newButtonData ~= nil then
                                    --d(">>>>>new button data found!")
                                    for newButtonDataKey, newButtonDataValue in pairs(newButtonData) do
                                        --d(">>>>>>apply new button data: " ..tostring(newButtonDataKey))
                                        ESO_Dialogs[dialogName].buttons[buttonIndex][newButtonDataKey] = newButtonDataValue
                                    end
                                end
                            end
                        end
                    end
                end
            end

        end -- for additionalOptionTag, additionalOptionData in pairs(additionalOptions) do

        --Add the additional options table completely to the dialog
        ESO_Dialogs[dialogName]._additionalOptions = additionalOptions
    end

    --Should custom text parameters be used?
    local textParams = dialogTextParams[dialogName]
    if textParams ~= nil then
        --Validate the text parameters
        for textParamsTag, textParamsData in pairs(textParams) do
            local validTextParamsOption = validTextParams[textParamsTag]
            local typeOfParam = type(textParamsData)

            --Check the parameter type
            if validTextParamsOption ~= nil and validTextParamsOption.paramTypes ~= nil then
                for _, validParamType in ipairs(validTextParamsOption.paramTypes) do
                    if validParamType ~= typeOfParam then
                        dialogTextParams[dialogName][textParamsTag] = nil
                    end
                end
            end
        end

        --Add the textParams table completely to the dialog
        ESO_Dialogs[dialogName]._textParams = textParams
    end

    --return the created ESO custom dialog
    return ESO_Dialogs[dialogName]
end

--Create the new dialog now
local function createCustomDialog(uniqueAddonName, uniqueDialogName, title, body, callbackYes, callbackNo, callbackSetup)
    local dialogName = uniqueAddonName .. "_" .. uniqueDialogName
    --Register the unique dialog name at the global ESO_Dialogs namespace now, and add 2 buttons (confirm, reject)
    local dialog = RegisterCustomDialogAtZOsDialogs(dialogName, title, body)
    dialog.createdForAddon = uniqueAddonName
    dialog.addonsDialogName = uniqueDialogName
    dialog.uniqueIdentifier = dialogName
    dialog.buttons[1].callback = callbackYes
    dialog.buttons[2].callback = callbackNo
    dialog.setup = callbackSetup
    return dialog
end


------------------------------------------------------------------------------------------------------------------------
-- Dialog show functions
------------------------------------------------------------------------------------------------------------------------
--Show the dialog now
local function showDialogNow(uniqueDialogName, data)
    --Were textParams provided?
    local textParams = dialogTextParams[uniqueDialogName]
    --Show the dialog now, and provide it the data
    local dialog = ZO_Dialogs_ShowDialog(uniqueDialogName, data, textParams)
    --Saved the last shown dialog (return value "dialog" of function ZO_Dialogs_ShowDialog in the table of the lib
    if dialog ~= nil then
        lib.lastZO_Dialogs_ShowDialogReturnedDialog[uniqueDialogName] = dialog
    end
end


--======================================================================================================================
--======================================================================================================================
--======================================================================================================================


------------------------------------------------------------------------------------------------------------------------
-- 	Library API functions
------------------------------------------------------------------------------------------------------------------------
function lib:RegisterDialog(uniqueAddonName, uniqueDialogName, title, body, callbackYes, callbackNo, callbackSetup, forceUpdate, additionalOptions, textParams)
    --Is any of the needed variables not given?
    local titleStr = StringOrFunctionOrGetString(title)
    local bodyStr = StringOrFunctionOrGetString(body)
    assert (titleStr ~= nil, string.format("[" .. MAJOR .. "]Error: Missing title for dialog with the unique identifier \'%s\', addon \'%s\'!", tostring(uniqueDialogName), tostring(uniqueAddonName)))
    assert (bodyStr ~= nil, string.format("[" .. MAJOR .. "]Error: Missing body text for dialog with the unique identifier \'%s\', addon \'%s\'!", tostring(uniqueDialogName), tostring(uniqueAddonName)))
    forceUpdate = forceUpdate or false
    if callbackYes == nil then
        callbackYes = function() end
    end
    if callbackNo == nil then
        callbackNo = function() end
    end
    if callbackSetup == nil then
        callbackSetup = function(dialog, data) end
    end
    --Is there already a dialog for this addon and does the uniqueDialogName already exist?
    if existingDialogs[uniqueAddonName] == nil then
        existingDialogs[uniqueAddonName] = {}
    end
    local dialogs = existingDialogs[uniqueAddonName]
    if not forceUpdate then
        assert(dialogs[uniqueDialogName] == nil, string.format("[" .. MAJOR .. "]Error: Dialog with the unique identifier \'%s\' is already registered for the addon \'%s\'!", tostring(uniqueDialogName), tostring(uniqueAddonName)))
    end
    --Create the table for the dialog in the addon
    dialogs[uniqueDialogName] = {}
    local dialog = dialogs[uniqueDialogName]
    if not dialog then return end
    local dialogName = uniqueAddonName .. "_" .. uniqueDialogName
    --Were additionalOptions specified as well?
    if additionalOptions ~= nil and type(additionalOptions) == "table" then
        --Cached them in the library so they can be fetched as ZO_Dialogs_ShowDialog is used via LibDialog:ShowDialog
        dialogAdditionalOptions[dialogName] = additionalOptions
    end
    --Were textParams specified as well?
    if textParams ~= nil and type(textParams) == "table" then
        --Cached them in the library so they can be fetched as ZO_Dialogs_ShowDialog is used via LibDialog:ShowDialog
        dialogTextParams[dialogName] = textParams
    end
    --Create the dialog now
    dialog.dialog = createCustomDialog(uniqueAddonName, uniqueDialogName, title, body, callbackYes, callbackNo, callbackSetup)
    --return the new created dialog now
    return dialog.dialog
end


--Add an editBox with parameters to a dialog
--You can either pass in a table "editBoxParams" with the following contents (see below)
--[[
    Possible parameters in editBoxParams table could be:
    --->defaultText: number (will be used with function GetString(number)), or string. The default text shown at the edit box. Will be replaced upon typing in it
    --->textType: a textType constant (nil will be using TEXT_TYPE_ALL)
    ---->  TEXT_TYPE_ALL = 0
    ---->  TEXT_TYPE_PASSWORD = 1
    ---->  TEXT_TYPE_NUMERIC = 2
    ---->  TEXT_TYPE_NUMERIC_UNSIGNED_INT = 3
    ---->  TEXT_TYPE_ALPHABETIC = 4
    ---->  TEXT_TYPE_ALPHABETIC_NO_FULLWIDTH_LATIN = 5
    --->specialCharacters: a table with characters which can be entered into the input field. Table key is a number, value a character
    --->maxInputCharacters: number of maximum possible entered characters
    --->validatesText: boolean should the text in the editbox be validated
    --->validator: function for the text validation
    --->matchingString: string, Should the input into the editbox be compared to this matching string (e.g. used for DESTROY confirm dialog)
    --->autoComplete: table, containing info for a ZO_AutoComplete control attached to the editBox (will be created new if not existing).
    ---->subtable includeFlags: table with the include flags of the ZO_AutoComplete, e.g. { AUTO_COMPLETE_FLAG_GUILD, AUTO_COMPLETE_FLAG_RECENT, AUTO_COMPLETE_FLAG_RECENT_TARGET, AUTO_COMPLETE_FLAG_RECENT_CHAT },
    ---->subtable excludeFlags: table with the exclude flags of the ZO_AutoComplete, e.g.  {AUTO_COMPLETE_FLAG_FRIEND },
    ---->boolean onlineOnly: boolean parameter online only, e.g. AUTO_COMPLETION_ONLINE_OR_OFFLINE
    ---->number maxResults: number parameter max results, e.g. MAX_AUTO_COMPLETION_RESULTS
]]
--Or you can use the single parameters after that editBoxParams, starting with "textType".
--->The single parameters are of the same type as described above in the "editBoxParams" table.
function lib:AddEditBox(uniqueAddonName, uniqueDialogName, editBoxParams, defaultText, textType, specialCharacters, maxInputCharacters, matchingString, validatesText, validator, autoComplete)
    local dialogName, dialog = assertDialogExists(uniqueAddonName, uniqueDialogName)
    local baseData, additionalOptions, textParams = getAllDialogData(uniqueAddonName, uniqueDialogName, dialogName)
    --Did the function pass in params as table for the editBox or not?
    --If not, check the other params and pass them to the table parameter
    if editBoxParams == nil then
        editBoxParams.defaultText = defaultText
        editBoxParams.defaultText = defaultText
        editBoxParams.textType = textType
        editBoxParams.specialCharacters = specialCharacters
        editBoxParams.maxInputCharacters = maxInputCharacters
        editBoxParams.matchingString = matchingString
        editBoxParams.validatesText = validatesText
        editBoxParams.validator = validator
        editBoxParams.autoComplete = autoComplete
    end
    --Add the editbox params table to the additional options
    additionalOptions = additionalOptions or {}
    additionalOptions["editBox"] = editBoxParams
    --Re-Register the dialog with the settings from before, so force the update!
    self:RegisterDialog(uniqueAddonName, uniqueDialogName, baseData.title, baseData.mainText, baseData.buttonCallbackYes, baseData.buttonCallbackNo, baseData.setup,
                        true,
                        additionalOptions,
                        textParams)
end


--Remove an editBox from a dialog
function lib:RemoveEditBox(uniqueAddonName, uniqueDialogName)
    local dialogName, dialog = assertDialogExists(uniqueAddonName, uniqueDialogName)
    local baseData, additionalOptions, textParams = getAllDialogData(uniqueAddonName, uniqueDialogName, dialogName)
    --Remove the editbox from the additional options
    additionalOptions["editBox"] = nil
    --Re-Register the dialog with the settings from before, so force the update!
    self:RegisterDialog(uniqueAddonName, uniqueDialogName, baseData.title, baseData.mainText, baseData.buttonCallbackYes, baseData.buttonCallbackNo, baseData.setup,
                        true,
                        additionalOptions,
                        textParams)
end


--Add radio buttons with parameters to a dialog
--You can either pass in a table "radioButtonsParams" with the following contents (see below)
--[[
    -->Table specifiying radio buttons at the dialog. The table needs the radioButtonIndex as key and a subTable as value for each radio button.
    -->The following parameters can be added to the subTable of each radioButton:
    --->text: String
    --->data: Table with data of the radioButton
    --->clickedCallback: function called as the radio button was clicked. parameters of the function are:
    ---->radioButtonControl control
    ---->mouseButton MOUSE_BUTTON_INDEX_*, e.g.
    ----->MOUSE_BUTTON_INDEX_LEFT = 1
    ----->MOUSE_BUTTON_INDEX_RIGHT = 2
    ----->MOUSE_BUTTON_INDEX_MIDDLE = 3
    ----->MOUSE_BUTTON_INDEX_4 = 4
    ----->MOUSE_BUTTON_INDEX_5 = 5
    ----->MOUSE_BUTTON_INDEX_LEFT_AND_RIGHT = 6
    ---->upInside boolean, was the mouse released over the control
    ---->shift boolean: Was SHIFT key pressed
    ---->alt boolean: Was ALT key pressed
    ---->ctrl boolean: Was CTRL key pressed
    ---->command boolean: Was COMMAND (MAC only!) key pressed
]]
--Or you can use the single parameters after that radioButtonsParams, starting with "rb<number>", e.g. rb1Text, rb1Data, rb1Callback and so on.
--->The single parameters are of the same type as described above in the "radioButtonsParams" table.
function lib:AddRadioButtons(uniqueAddonName, uniqueDialogName, radioButtonsParams, rb1Text, rb1Data, rb1ClickedCallback, rb2Text, rb2Data, rb2ClickedCallback, rb3Text, rb3Data, rb3ClickedCallback, rb4Text, rb4Data, rb4ClickedCallback, rb5Text, rb5Data, rb5ClickedCallback)
    local dialogName, dialog = assertDialogExists(uniqueAddonName, uniqueDialogName)
    local baseData, additionalOptions, textParams = getAllDialogData(uniqueAddonName, uniqueDialogName, dialogName)
    local radioButtonOnMouseUpHandlersNeeded = {}
    --Did the function pass in params as table for the editBox or not?
    --If not, check the other params and pass them to the table parameter
    if radioButtonsParams == nil then
        radioButtonsParams = {}
        local radioButtonTab
        if rb1Text and rb1Text ~= "" then
            radioButtonTab = {
                text = rb1Text,
                data = rb1Data,
                clickedCallback = rb1ClickedCallback,
            }
            table.insert(radioButtonsParams, radioButtonTab)
            if rb1ClickedCallback ~= nil and type(rb1ClickedCallback) == "function" then
                radioButtonOnMouseUpHandlersNeeded[#radioButtonsParams] = true
            end
        end
        if rb2Text and rb2Text ~= ""  then
            radioButtonTab = {
                text = rb2Text,
                data = rb2Data,
                clickedCallback = rb2ClickedCallback,
            }
            table.insert(radioButtonsParams, radioButtonTab)
            if rb2ClickedCallback ~= nil and type(rb2ClickedCallback) == "function" then
                radioButtonOnMouseUpHandlersNeeded[#radioButtonsParams] = true
            end
        end
        if rb3Text and rb3Text ~= ""  then
            radioButtonTab = {
                text = rb3Text,
                data = rb3Data,
                clickedCallback = rb3ClickedCallback,
            }
            table.insert(radioButtonsParams, radioButtonTab)
            if rb3ClickedCallback ~= nil and type(rb3ClickedCallback) == "function" then
                radioButtonOnMouseUpHandlersNeeded[#radioButtonsParams] = true
            end
        end
        if rb4Text and rb4Text ~= ""  then
            radioButtonTab = {
                text = rb4Text,
                data = rb4Data,
                clickedCallback = rb4ClickedCallback,
            }
            table.insert(radioButtonsParams, radioButtonTab)
            if rb4ClickedCallback ~= nil and type(rb4ClickedCallback) == "function" then
                radioButtonOnMouseUpHandlersNeeded[#radioButtonsParams] = true
            end
        end
        if rb5Text and rb5Text ~= ""  then
            radioButtonTab = {
                text = rb5Text,
                data = rb5Data,
                clickedCallback = rb5ClickedCallback,
            }
            table.insert(radioButtonsParams, radioButtonTab)
            if rb5ClickedCallback ~= nil and type(rb5ClickedCallback) == "function" then
                radioButtonOnMouseUpHandlersNeeded[#radioButtonsParams] = true
            end
        end
    else
        for radioButtonNr, rbData in ipairs(radioButtonsParams) do
            local clickedCallbackOrRb = rbData.clickedCallback
            if clickedCallbackOrRb ~= nil and type(clickedCallbackOrRb) == "function" then
                radioButtonOnMouseUpHandlersNeeded[radioButtonNr] = true
            end
        end
    end
    local countRadioButtons = #radioButtonsParams
    if countRadioButtons <= 0 then return end
    --Add the editbox params table to the additional options
    additionalOptions = additionalOptions or {}
    additionalOptions["radioButtons"] = radioButtonsParams

    --Was a callback function for the radion button OnClick given?
    --Register this callback function as PostHookHandler of the original radioButton OnMouseUp eventHandler.
    --As the radiobutton does not exist yet here we need to add this preehook in the callback function of the dialog (dialog created and ready function)!
    --Check if any radioButton OnMouseUp callback functions were registered
    local function addRadioButtonsOnMouseUpEvent(p_dialogId, p_dialogName, p_radioButtonOnMouseUpHandlersNeeded, p_radioButtonsParams)
        if #p_radioButtonOnMouseUpHandlersNeeded > 0 then
            --Check if the ZO_Dialogs radiobutton control container exists
            local rbContainer, numChildren = getDialogRadioButtonContainerAndCount()
            if rbContainer ~= nil then
                --Check each available radioButton
                for radioButtonNr=1, numChildren, 1 do
                    --Which radiobuttons needs an OnMouseUp event handler?
                    if p_radioButtonOnMouseUpHandlersNeeded[radioButtonNr] == true then
                        local rbControlAtNr = rbContainer:GetChild(radioButtonNr)
                        if rbControlAtNr ~= nil then
                            --Get the label control
                            local rbLabel = rbControlAtNr.label
                            if rbLabel ~= nil then
                                --Get the wished OnMouseUp handler function of the radioButton
                                local rbOnMouseUpHandlerFunc = p_radioButtonsParams and p_radioButtonsParams[radioButtonNr] and p_radioButtonsParams[radioButtonNr].clickedCallback
                                if rbOnMouseUpHandlerFunc ~= nil and type(rbOnMouseUpHandlerFunc) == "function" then
                                    --Did we add the handler already for the current unique dialog and radioButtonButton?
                                    --Or did we add it for any other dialog, as the radioButtons share the same pool controls!
                                    --Then remove the old first by going back to the standard handler
                                    local wasAnyOnMouseUpEventHandlerRegistered, registeredOnMouseUpEventHandlerOnDialog = didAnyDialogRegisterACustomHandlerOnTheRadioButton("OnMouseUp",radioButtonNr)
--d(">wasAnyOnMouseUpEventHandlerRegistered: " ..tostring(wasAnyOnMouseUpEventHandlerRegistered) .. ", registeredOnDialog: " ..tostring(registeredOnMouseUpEventHandlerOnDialog))
                                    if  (    dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName] ~= nil
                                        and dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName][radioButtonNr] ~= nil
                                        and dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName][radioButtonNr]["OnMouseUp"] == true)
                                        or ( wasAnyOnMouseUpEventHandlerRegistered == true )
                                    then
                                        local origBase = dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"] and dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr]
                                        local oldOrigHandler = origBase and origBase.rbHandler
                                        if oldOrigHandler ~= nil and type(oldOrigHandler) == "function" then
                                            rbControlAtNr:SetHandler("OnMouseUp", nil)
                                            rbControlAtNr:SetHandler("OnMouseUp", oldOrigHandler)
                                        end
                                        local oldOrigLabelHandler = origBase and origBase.rbLabelHandler
                                        if oldOrigLabelHandler ~= nil and type(oldOrigLabelHandler) == "function" then
                                            rbLabel:SetHandler("OnMouseUp", nil)
                                            rbLabel:SetHandler("OnMouseUp", oldOrigLabelHandler)
                                        end
                                    end

                                    --Get current radioButton's OnMouseUp handler and PostHook it
                                    local currentRBOnMouseUpHandler = ZO_PostHookHandler(rbControlAtNr, "OnMouseUp",
                                        function(radioButtonControl, mouseButton, upInside, shift, ctrl, alt, command)
                                            rbOnMouseUpHandlerFunc(radioButtonControl, mouseButton, upInside, shift, ctrl, alt, command)
                                        end
                                    )
                                    --Remember we have PostHooked the radiobutton handler and safe the original handler function
                                    if not dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"] or not dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr] or not dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr].rbHandler then
                                        dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"] = dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"] or {}
                                        dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr] = dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr] or {}
                                        dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr].rbHandler = currentRBOnMouseUpHandler
                                    end

                                    --Get current radioButton.label's OnMouseUp handler and PostHook it
                                    local currentRBLabelOnMouseUpHandler = ZO_PostHookHandler(rbLabel, "OnMouseUp",
                                        function(rbLabelControl, mouseButton, upInside, shift, ctrl, alt, command)
                                            rbOnMouseUpHandlerFunc(rbControlAtNr, mouseButton, upInside, shift, ctrl, alt, command)
                                        end
                                    )
                                    --Remember we have PostHooked the label handler and safe the original handler function
                                    if not dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"] or not dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr] or not dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr].rbLabelHandler then
                                        dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"] = dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"] or {}
                                        dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr] = dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr] or {}
                                        dialogRadioButtonOrigHandlerAtRadioButton["OnMouseUp"][radioButtonNr].rbLabelHandler = currentRBLabelOnMouseUpHandler
                                    end
                                    --Save that we had added the "OnMouseUp" handler at the radio button number
                                    dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName] = dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName] or {}
                                    dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName][radioButtonNr] = dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName][radioButtonNr] or {}
                                    dialogRadioButtonHandlerAtRadioButtonAdded[p_dialogName][radioButtonNr]["OnMouseUp"] = true
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    --Check if additionalOptions of the dialog already uses a callback function. If so, call this first and then the radioButtons'
    --"Add OnMouseUp" event handlers. Else directly call the "OnMouseUp" event handlers
    --Attention: This will re-add the OnMouseUp handler each time the dialog's callback function was run.
    --So assure via the unique dialogName that it will only be added once in total to the callback function of the dialog.
    if not dialogRadioButtonHandlersAdded[dialogName] then
        if additionalOptions.callback then
            local origCallback = additionalOptions.callback
            additionalOptions.callback = function(dialogId)
                origCallback(dialogId)
                addRadioButtonsOnMouseUpEvent(dialogId, dialogName, radioButtonOnMouseUpHandlersNeeded, radioButtonsParams)
            end
        else
            additionalOptions.callback = function(dialogId)
                addRadioButtonsOnMouseUpEvent(dialogId, dialogName, radioButtonOnMouseUpHandlersNeeded, radioButtonsParams)
            end
        end
        dialogRadioButtonHandlersAdded[dialogName] = true
    end
    --Re-Register the dialog with the settings from before, so force the update!
    self:RegisterDialog(uniqueAddonName, uniqueDialogName, baseData.title, baseData.mainText, baseData.buttonCallbackYes, baseData.buttonCallbackNo, baseData.setup,
            true,
            additionalOptions,
            textParams)
end


--Remove the radioButtons from a dialog
--radioButtonNumbers table: key is the radioButtonNumber which should be removed, and value boolean true -> remove
-->if table radioButtonNumbers is not given ALL radioButtons will be removed
function lib:RemoveRadioButtons(uniqueAddonName, uniqueDialogName, radioButtonNumbers)
    local dialogName, dialog = assertDialogExists(uniqueAddonName, uniqueDialogName)
    local baseData, additionalOptions, textParams = getAllDialogData(uniqueAddonName, uniqueDialogName, dialogName)

    --Remove all radio buttons
    if radioButtonNumbers == nil then
        --Remove the radioButtons from the additional options
        local additionalOptionsRadioButtons = additionalOptions["radioButtons"]
        for radioButtonNrToRemove, _ in ipairs(additionalOptionsRadioButtons) do
            checkAndRemoveCustomRadioButtonOnMouseUpHandler(dialogName, radioButtonNrToRemove)
        end
        additionalOptions["radioButtons"] = nil
    --Remove only specified radio buttons
    elseif radioButtonNumbers and type(radioButtonNumbers) == "table" then
        local additionalOptionsRadioButtons = additionalOptions["radioButtons"]
        if additionalOptionsRadioButtons ~= nil and #additionalOptionsRadioButtons > 0 then
            for rdbNumberToRemove, rbDoRemove in pairs(radioButtonNumbers) do
                if rbDoRemove == true then
                    additionalOptionsRadioButtons[rdbNumberToRemove] = nil
                    checkAndRemoveCustomRadioButtonOnMouseUpHandler(dialogName, rdbNumberToRemove)
                end
            end
        end
    end

    --Re-Register the dialog with the settings from before, so force the update!
    self:RegisterDialog(uniqueAddonName, uniqueDialogName, baseData.title, baseData.mainText, baseData.buttonCallbackYes, baseData.buttonCallbackNo, baseData.setup,
                        true,
                        additionalOptions,
                        textParams)
end


--Show a registered dialog now
function lib:ShowDialog(uniqueAddonName, uniqueDialogName, data)
    --Is there already a dialog for this addon and does the uniqueDialogName already exist?
    local dialogName, dialog = assertDialogExists(uniqueAddonName, uniqueDialogName)
    --Show the dialog now
    lib.lastShownDialogAddonName = uniqueAddonName
    lib.lastShownDialogDialogName = uniqueDialogName
    lib.lastShownDialogData = data
    showDialogNow(dialogName, data)
    return true
end



--======================================================================================================================
--v-- TEST FUNCTION - BEGIN - Enable via setting variable "LibraryTestMode"=true at the top of this file!          --v--
--======================================================================================================================
    local clickedCallback = function(rbCtrl, mouseButton, upInside, shift, ctrl, alt, command)
        if upInside and mouseButton == MOUSE_BUTTON_INDEX_LEFT then
            d("Raidobutton clicked: " ..tostring(rbCtrl.data.rb))
        end
    end

    --Create a new dialog and show it 3 seconds after EVENT_ADD_ON_LOADED
    local function loadTest(forceUpdate)
        if not isBaertramTesting() then return end

        forceUpdate = forceUpdate or false

        --See file LibDialog.lua for the descriptions of the tables additionalOptions and textParams
        --and in addition check this source code file of ZOs code here:
        --https://github.com/esoui/esoui/blob/0569f38e70254b4e08a5eab088c4ce5e7e46be55/esoui/libraries/zo_dialog/zo_dialog.lua#L351
        --function ZO_Dialogs_ShowDialog(name, data, textParams, isGamepad) and it's description above the function
        local additionalOptions = {
            canQueue = true,
            callback = function(dialogId) d("callback func was called for dialog: " ..tostring(dialogId)) end,
            --updateFn = function() d("updateFn func was called") end,
            showLoadingIcon = true,
            customLoadingIcon = "/esoui/art/icons/ability_u26_vampire_infection_stage0.dds",
            --[[
            title = {
                text = "Title <<1>>",
                timer = 1,
            },
            mainText = {
                text = "Test Body <<1>> <<2>>",
                timer = 2,
            },
            ]]
            warning = {
                text = function() return "WARNING - Time left: <<1>>" end,
                timer = 1,
                verboseTimer = true,
            },
            modal = false,
            editBox = {
                textType = TEXT_TYPE_ALL,
                specialCharacters = {"a", "b", "c", "d"},
                maxInputCharacters = 3,
                defaultText = "a",
            },

            -->Table with key = buttonIndex (1 or 2) and a table as value. This table can contain the following entries:
            --->text: number (read via GetString(number), function returning a string, or string
            --->callback: function
            --->visible: function returning boolean, or boolean
            --->keybind: function returning a keybind, or keybind (if nil DIALOG_PRIMARY will be used for buttonIndex1 and DIALOG_NEGATIVE for buttonIndex2)
            --->noReleaseOnClick: boolean
            --->enabled: function returning boolean, or boolean
            --->clickSound: SOUNDS.SOUND_NAME
            --->requiresTextInput: boolean
            buttonData      = {
                [1] = {
                    visible = function() return true end,
                },
                [2] = {
                    enabled = function() return true end,
                },
            },
            --[[
            radioButtons = {
                [1] = {
                    text = "rb1",
                    data = {rb=1}
                },
                [2] = {
                    text = "rb2",
                    data = {rb=2}
                },
                [3] = {
                    text = "rb3",
                    data = {rb=3}
                },
            }
            ]]
        }
        -- textParams:
        --  ["warningParams"]           = { paramTypes = {"table"} },   --table with parameters { number timer }
        --  ["buttonTextOverrides"]     = { paramTypes = {"table"} },   --needs to be a table with key number buttonIndex (1 or 2) and String value for the buttonText
        --  ["initialEditText"]         = { paramTypes = {"string"} },  --used for additionalOptions.editBox as initial edit box text shown
        --  ["titleParams"]             = { "Text here" or function },  --used to change the title
        --  ["mainTextParams"]          = { "Text here" or function },  --used to change the mainText
        local textParams = {
            ["warningParams"] = { [1] = 10000 }, --The table key 1 is the timer index set within table additionalOptions.warning.timer !
            ["titleParams"] = { [1] = 7000 }, --The table key 1 is the timer index set within table additionalOptions.warning.timer !
            ["mainTextParams"] = {
                [1] = "ahoi",
                [2] = 5000
            }, --The table key 1 is the timer index set within table additionalOptions.warning.timer !
            ["buttonTextOverrides"] = {
                [1] = "Test YES",
                [2] = "Test NO",
            },
            ["initialEditText"] = "AFK!",
        }

        --Create and call the new dialog 3 seconds after event_add_on_loaded e.g.
        zo_callLater(function()
            lib:RegisterDialog("MyAddonTest", "MyAddonTest_Dialog1", "Title", "body", function() d("yes") end, function() d("no") end, nil, forceUpdate, additionalOptions, textParams)
            --[[
            local radioButtons = {
                [1] = {
                    text = "rb1",
                    data = {rb=1},
                    clickedCallback = function(rbCtrl, mouseButton, upInside, shift, ctrl, alt, command)
                        if upInside and mouseButton == MOUSE_BUTTON_INDEX_LEFT then
                            d("Raidobutton clicked: " ..tostring(rbCtrl.data.rb))
                        end
                    end,
                },
                [2] = {
                    text = "rb2",
                    data = {rb=2},
                    clickedCallback = function(rbCtrl, mouseButton, upInside, shift, ctrl, alt, command)
                        if upInside and mouseButton == MOUSE_BUTTON_INDEX_LEFT then
                            d("Raidobutton clicked: " ..tostring(rbCtrl.data.rb))
                        end
                    end,
                },
                [3] = {
                    text = "rb3",
                    data = {rb=3},
                },
                [4] = {
                    text = "rb4",
                    data = {rb=4},
                },
                [5] = {
                    text = "rb5",
                    data = {rb=5},
                },

            }
            ]]
            lib:AddRadioButtons("MyAddonTest", "MyAddonTest_Dialog1", nil, "rb1Text", {rb=1}, clickedCallback, "rb2Text", {rb=2}, clickedCallback)
            lib:ShowDialog("MyAddonTest", "MyAddonTest_Dialog1", nil)

            --TODO: RadioButton's OnMouseUp for different Dialogs (also same addon!) will "append" each other to the OnMouseUp event handler.
            --TODO: This example here raises 2 OnMouseUp event handler callback function calls for each radiobutton click on the 2nd dialg (1 from 1st dialog, and one from 2nd).
            lib:RegisterDialog("MyAddonTest", "MyAddonTest_Dialog2", "Title2", "body2", function() d("yes2") end, function() d("no2") end, nil, forceUpdate)
            lib:AddRadioButtons("MyAddonTest", "MyAddonTest_Dialog2", nil, "rb4Text", {rb=1}, clickedCallback, "rb6Text", {rb=2}, clickedCallback)
            lib:ShowDialog("MyAddonTest", "MyAddonTest_Dialog2", nil)
        end, 3000)
    end

    function lib:testRb1()
        if not isBaertramTesting() then return end

        loadTest(true)
    end

    function lib:testRb2()
        if not isBaertramTesting() then return end

        self:RemoveRadioButtons("MyAddonTest", "MyAddonTest_Dialog1", {false, true})
        self:AddRadioButtons("MyAddonTest", "MyAddonTest_Dialog1", nil, nil, {rb=1}, clickedCallback, "RadioButton2", {rb=2}, clickedCallback)
        self:ShowDialog("MyAddonTest", "MyAddonTest_Dialog1", nil)

        self:RemoveRadioButtons("MyAddonTest", "MyAddonTest_Dialog2", {true, true})
        self:AddRadioButtons("MyAddonTest", "MyAddonTest_Dialog2", nil, "RadioButton1", {rb=1}, clickedCallback)
        self:ShowDialog("MyAddonTest", "MyAddonTest_Dialog2", nil)
    end
--======================================================================================================================
--^-- TEST FUNCTION - END                                                                                          --^--
--======================================================================================================================



------------------------------------------------------------------------------------------------------------------------
-- Load the library LibDialog
------------------------------------------------------------------------------------------------------------------------
    --Addon loaded function
    function lib:OnLibraryLoaded(event, name)
        d("LibDialog loading")
    --Only load lib if ingame
    --if name:find("^ZO_") then return end
        --em:UnregisterForEvent(MAJOR, EVENT_ADD_ON_LOADED)
        --Provide the library the "list of registered dialogs"
        lib.dialogs = existingDialogs
        lib.dialogTextParams = dialogTextParams
        lib.dialogAdditionalOptions = dialogAdditionalOptions

        --For testing only
        loadTest()
    end

    --Load the addon now
    --em:UnregisterForEvent(MAJOR, EVENT_ADD_ON_LOADED)
    --em:RegisterForEvent(MAJOR, EVENT_ADD_ON_LOADED, OnLibraryLoaded)
------------------------------------------------------------------------------------------------------------------------
