if not RTP then RTP = {} end

RTP.HouseMaps = {
    [16] = {id = 16, map = "glenumbra_base"},
    [28] = {id = 28, map = "therift_base"}, -- Autumns Gate
    [29] = {id = 29, map = "windhelm_base"},
    [30] = {id = 30, map = "therift_base"},
    [40] = {id = 40, map = "grandtopal_base"},
    [47] = {id = 47, map = "coldharbour_base"},
    [48] = {id = 48, map = "falkreathhousing_base"},
    [71] = {id = 71, map = "moonsugarmeadow_base"},
    [75] = {id = 75, map = "forgemasterfalls_base"},
    [81] = {id = 81, map = "antiquariansalpineext_base"},
    [500] = {id = 500, map = "westernskryim_base"},
}
RTP.Towns ={
    {id = 1, name = "Hofborg", startingLocation = 1}
}
RTP.Locations = {
    [1] = {id = 1, houseId = 71, owner = "@Larawyn", townId = 1, name = "The Borg", public = true},
    [2] = {id = 2, houseId = 71, owner = "@mithril52", townId = 1, name = "The Spirit Woods", public = true},
    [3] = {id = 3, houseId = 48, owner = "@Larawyn", townId = 1, name = "The Motherhouse", public = true},
    [4] = {id = 4, houseId = 47, owner = "@Larawyn", townId = 1, name = "Saebjorn Long Hall", public = true},
    [5] = {id = 5, houseId = 75, owner = "@mithril52", townId = 1, name = "The Docks", public = true},
    [6] = {id = 6, houseId = 71, owner = "@Tart56", townId = 1, name = "The Village", public = true},
    [8] = {id = 8, houseId = 29, owner = "@Larawyn", townId = 1, name = "Captain's Apartments"},
    [9] = {id = 9, houseId = 16, owner = "@rainbowbunny8", townId = 1, name = "Hall Mistress Apartments"},
    [10] = {id = 10, houseId = 71, owner = "@TheGreatHrimbo", townId = 1, name = "Clever Cave"},
    [11] = {id = 11, houseId = 81, owner = "@sinath41", townId = 1, name = "Warrior's Respite", desc = "(Thane's Hall)", public = true},
    [12] = {id = 12, houseId = 28, owner = "@AnakinSeth", townId = 1, name = "Bren's Tinkershop"},
    [13] = {id = 13, houseId = 30, owner = "@Larawyn", townId = 1, name = "The Bunkhouse"},
    [14] = {id = 14, houseId = 29, owner = "@Lightsb4ne", townId = 1, name = "Apothecary Backroom"},
    [15] = {id = 15, houseId = 30, owner = "@mithril52", townId = 1, name = "Kyne's Keg", desc = "(Inn)", public = true},
    [16] = {id = 16, houseId = 28, owner = "@ThePageOfCups", townId = 1, name = "Healer's Cottage"},
    [17] = {id = 17, houseId = 28, owner = "@WhenDaxAttacks", townId = 1, name = "Sorcerer's Retreat"},
    [18] = {id = 18, houseId = 28, owner = "@Shadoe12", townId = 1, name = "Property Available"},
    [19] = {id = 19, houseId = 28, owner = "@Svidyger", townId = 1, name = "Eiwa's Lodge"},
    [20] = {id = 20, houseId = 16, owner = "@Larawyn", townId = 1, name = "Temple Dormitory"},
    [21] = {id = 21, houseId = 500, owner = "", townId = 1, name = ""},
    [22] = {id = 22, houseId = 28, owner = "@Shadoe12", townId = 1, name = "Property Available"},
    [23] = {id = 23, houseId = 28, owner = "@Shadoe12", townId = 1, name = "Property Available"},
    [24] = {id = 24, houseId = 28, owner = "@Shadoe12", townId = 1, name = "Property Available", desc = "(Orcish)"},
    [25] = {id = 25, houseId = 28, owner = "@Shadoe12", townId = 1, name = "Property Available"},
    [26] = {id = 26, houseId = 28, owner = "@Shadoe12", townId = 1, name = "Property Available", desc = "(Forgemaster)"},
}
RTP.Portals = {
    [1] = { --Hofborg: The Borg
        {location = 1, destination = 2, x = 59173, y = 29521, z = 54668, cx = 0.325924, cy = 0.313501},
        {location = 1, destination = 3, x = 66138, y = 29242, z = 59534, cx = 0.480059, cy = 0.421380},
        {location = 1, destination = 4, x = 61236, y = 29454, z = 63784, cx = 0.371854, cy = 0.515201},
        {location = 1, destination = 5, x = 67927, y = 29226, z = 71469, cx = 0.519941, cy = 0.685682},
        {location = 1, destination = 14, x = 66110, y = 29300, z = 71976, cx = 0.479732, cy = 0.696960},
        {location = 1, destination = 15, x = 66386, y = 29134, z = 62304, cx = 0.485780, cy = 0.482674},
        {location = 1, destination = 16, x = 63299, y = 29226, z = 69822, cx = 0.417457, cy = 0.649232},
        {location = 1, destination = 6, x = 68205, y = 29222, z = 70409, cx = 0.526152, cy = 0.662144},
        {location = 1, destination = 22, x = 64049, y = 29226, z = 70606, cx = 0.433965, cy = 0.666558},
    },
    [2] = { --Hofborg: The Spirit Woods
        {location = 2, destination = 6, x = 59170, y = 29521, z = 54670, cx = 0.326087, cy = 0.313501},
        {location = 2, destination = 1, x = 70367, y = 28976, z = 70341, cx = 0.574044, cy = 0.660673},
        {location = 2, destination = 10, x = 65871, y = 29338, z = 58991, cx = 0.473848, cy = 0.410592},
        {location = 2, destination = 11, x = 64907, y = 29226, z = 73029, cx = 0.453089, cy = 0.720170},
    },
    [3] = { --Hofborg: The Motherhouse
        {location = 3, destination = 1, x = 50417, y = 39220, z = 94570, cx = 0.277314, cy = 0.799364, radius = 20},
        {location = 3, destination = 6, x = 52148, y = 17738, z = 87341, cx = 0.300159, cy = 0.703814},
        {location = 3, destination = 20, x = 50010, y = 20449, z = 83083, cx = 0.271752, cy = 0.647199},
    },
    [4] = { --Hofborg: Saebjorn Long Hall
        {location = 4, destination = 1, x = 82991, y = 36927, z = 83368, cx = 0.566294, cy = 0.541505},
        {location = 4, destination = 8, x = 81960, y = 37256, z = 88112, cx = 0.566004, cy = 0.542143},
        {location = 4, destination = 9, x = 81731, y = 37254, z = 86133, cx = 0.566059, cy = 0.542607},
    },
    [5] = { --Hofborg: The Docks
        {location = 5, destination = 1, x = 76652, y = 14513, z = 99360, cx = 0.618104, cy = 0.550230},
        {location = 5, destination = 23, x = 81657, y = 14319, z = 101067, cx = 0.787284, cy = 0.607930},
        {location = 5, destination = 24, x = 78111, y = 14516, z = 101327, cx = 0.667422, cy = 0.616718},
        {location = 5, destination = 25, x = 78168, y = 14503, z = 94768, cx = 0.669348, cy = 0.395011},
        {location = 5, destination = 26, x = 81556, y = 14509, z = 95241, cx = 0.783870, cy = 0.410999},
    },
    [6] = { --Hofborg: The Village
        {location = 6, destination = 1, x = 59163, y = 29521, z = 54676, cx = 0.325760, cy = 0.313665},
        {location = 6, destination = 2, x = 72719, y = 28975, z = 62201, cx = 0.626185, cy = 0.481040},
        {location = 6, destination = 12, x = 65158, y = 29226, z = 63763, cx = 0.458647, cy = 0.515038},
        {location = 6, destination = 13, x = 65741, y = 29248, z = 59408, cx = 0.471559, cy = 0.418437},
        {location = 6, destination = 17, x = 71549, y = 28976, z = 66063, cx = 0.600196, cy = 0.565871},
        {location = 6, destination = 18, x = 70553, y = 28975, z = 66568, cx = 0.578130, cy = 0.577149},
        {location = 6, destination = 19, x = 71354, y = 28975, z = 61026, cx = 0.595783, cy = 0.454397},
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
    [12] = { --Hofborg: Bren's Tinkershop
        {location = 12, destination = 6, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [13] = { --Hofborg: The Bunkhouse
        {location = 13, destination = 6, x = 26372, y = 26645, z = 19720, cx = 0.724823, cy = 0.549507},
    },
    [14] = { --Hofborg: Apothecary Backroom
        {location = 14, destination = 1, x = 26332, y = 20019, z = 25491, cx = 0.717911, cy = 0.364741},
    },
    [15] = { --Hofborg: Kyne's Keg, (Inn)
        {location = 15, destination = 1, x = 26319, y = 26643, z = 19711, cx = 0.724690, cy = 0.549485},
        {location = 15, destination = 6, x = 27072, y = 26716, z = 24983, cx = 0.726573, cy = 0.562665},
    },
    [16] = { --Hofborg: Healer's Cottage
        {location = 16, destination = 1, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [17] = { --Kjell's Cottage
        {location = 17, destination = 6, x = 36867, y = 26454, z = 39036, cx = 0.250910, cy = 0.347660},
    },
    [18] = { --Hofborg: Available for Rent/Purchase
        {location = 18, destination = 6, x = 36867, y = 26454, z = 39036, cx = 0.250910, cy = 0.347660},
    },
    [19] = { --Eiwa's Lodge
        {location = 19, destination = 6, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [20] = { --Lara new
        {location = 20, destination = 3, x = 19650, y = 20026, z = 29035, cx = 0.312595, cy = 0.789945},
    },
    [21] = { --Skyrim portal to Hofborg
        {location = 21, destination = 5, x = 85201, y = 22049, z = 163631, cx = 0.117692, cy = 0.356798, radius = 400, height = 200},
    },
}
