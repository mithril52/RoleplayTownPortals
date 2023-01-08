if not RTP then RTP = {} end

RTP.HouseMaps = {
    [16] = {id = 16, map = "glenumbra_base"},
    [17] = {id = 17, map = "rivenspire_base"}, -- Ravenhurst
    [18] = {id = 18, map = "wayrest_base"}, -- Gardner
    [28] = {id = 28, map = "therift_base"}, -- Autumns Gate
    [29] = {id = 29, map = "windhelm_base"},
    [30] = {id = 30, map = "therift_base"}, --Old Mistveil Manor
    [40] = {id = 40, map = "grandtopal_base"},
    [47] = {id = 47, map = "coldharbour_base"},
    [48] = {id = 48, map = "falkreathhousing_base"},
    [63] = {id = 63, map = "snowglobe_base"}, --Snowglobe
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
    [4] = {id = 4, houseId = 47, owner = "@Larawyn", townId = 1, name = "The Great Hall", public = true},
    [5] = {id = 5, houseId = 75, owner = "@mithril52", townId = 1, name = "The Docks", public = true},
    [6] = {id = 6, houseId = 71, owner = "@Tart56", townId = 1, name = "The Village", public = true},
    [8] = {id = 8, houseId = 29, owner = "@Larawyn", townId = 1, name = "The Guard House"},
    [9] = {id = 9, houseId = 16, owner = "@rainbowbunny8", townId = 1, name = "Hall Mistress Apartments"},
    [10] = {id = 10, houseId = 71, owner = "@TheGreatHrimbo", townId = 1, name = "Clever Cave"},
    [11] = {id = 11, houseId = 81, owner = "@sinath41", townId = 1, name = "Warrior's Respite"},
    [12] = {id = 12, houseId = 28, owner = "@AnakinSeth", townId = 1, name = "Bren's Tinkershop"},
    [13] = {id = 13, houseId = 30, owner = "@Larawyn", townId = 1, name = "The Bunkhouse"},
    [14] = {id = 14, houseId = 29, owner = "@Lightsb4ne", townId = 1, name = "Hexen's Dungeon"},
    [15] = {id = 15, houseId = 30, owner = "@mithril52", townId = 1, name = "Kyne's Keg", desc = "(Inn)", public = true},
    [16] = {id = 16, houseId = 28, owner = "@ThePageOfCups", townId = 1, name = "Healer's Cottage"},
    [17] = {id = 17, houseId = 28, owner = "@WhenDaxAttacks", townId = 1, name = "Sorcerer's Retreat"},
    [18] = {id = 18, houseId = 28, owner = "@Paulw3030", townId = 1, name = "Shore-Strider's Leather & Supplies"},
    [19] = {id = 19, houseId = 28, owner = "@Svidyger", townId = 1, name = "Eiwa's Lodge"},
    [20] = {id = 20, houseId = 16, owner = "@Larawyn", townId = 1, name = "Temple Dormitory"},
    [21] = {id = 21, houseId = 500, owner = "", townId = 1, name = ""},
    [22] = {id = 22, houseId = 30, owner = "@RavenNoble", townId = 1, name = "Murtagh's Place"},
    [23] = {id = 23, houseId = 63, owner = "@BoneDecipherer", townId = 1, name = "Mercury & Maps", desc = "(Alchemical Shop)"},
    [24] = {id = 24, houseId = 18, owner = "@Larawyn", townId = 1, name = "The Wharf Rat", desc = "(Tavern)"},
    [25] = {id = 25, houseId = 28, owner = "@Zulavi", townId = 1, name = "Malraz's Workshop"},
    [26] = {id = 26, houseId = 28, owner = "@Shadoe12", townId = 1, name = "Property Available", desc = "(Forgemaster)"},
    [27] = {id = 27, houseId = 17, owner = "@Larawyn", townId = 1, name = "Captain's Quarters"},
}
RTP.Portals = {
    [1] = { --Hofborg: The Borg
        {id = 1, location = 1, destinations = {2}, x = 59173, y = 29521, z = 54668, cx = 0.325924, cy = 0.313501},
        {id = 2, location = 1, destinations = {3}, x = 66138, y = 29242, z = 59534, cx = 0.480059, cy = 0.421380},
        {id = 3, location = 1, destinations = {4}, x = 61236, y = 29454, z = 63784, cx = 0.371854, cy = 0.515201},
        {id = 4, location = 1, destinations = {14}, x = 65873, y = 29226, z = 66023, cx = 0.474501, cy = 0.565054,
         nameOverride = "Owl Square", showMulti = true, portalDescription = 
         "Just behind the carpenter and blacksmith a small neighborhood of private shops can be found. Many of them are small but upscale and well cared for. The shops may be completely public or owner-occupied with sleeping accommodations"},
        {id = 5, location = 1, destinations = {15}, x = 66386, y = 29134, z = 62304, cx = 0.485780, cy = 0.482674},
        --{location = 1, destinations = {16}, x = 63299, y = 29226, z = 69822, cx = 0.417457, cy = 0.649232}, --moving to village
        {id = 6, location = 1, destinations = {22}, x = 64051, y = 29226, z = 70608, cx = 0.434129, cy = 0.666558, 
         showMulti = true, nameOverride = "Rowan Hills", portalDescription = 
         "Leading east out of the Borg is a relatively broad lane which is home to most of the larger houses. Dotted out in a line along the lane each home sits on two or more acres and may offer a variety of services or upscale housing. While many of the homes feature protective walls, the inhabitants, like the other villagers are likely to retreat to the Great Hall or Motherhouse in times of trouble"},
        {id = 7, location = 1, destinations = {8}, x = 61842, y = 29226, z = 67202, cx = 0.385093, cy = 0.591206},
        {id = 8, location = 1, destinations = {5,6}, x = 68156, y = 29208, z = 70752, cx = 0.525008, cy = 0.669827,
         portalDescription = 
         "Something nifty here about the North Gate?"},
    },
    [2] = { --Hofborg: The Spirit Woods
        {id = 2, location = 2, destinations = {6}, x = 59170, y = 29521, z = 54670, cx = 0.326087, cy = 0.313501},
        {id = 2, location = 2, destinations = {1}, x = 70367, y = 28976, z = 70341, cx = 0.574044, cy = 0.660673},
        {id = 2, location = 2, destinations = {10}, x = 65871, y = 29338, z = 58991, cx = 0.473848, cy = 0.410592},
        {id = 2, location = 2, destinations = {11}, x = 64907, y = 29226, z = 73029, cx = 0.453089, cy = 0.720170, 
         nameOverride = "Hawk Claw Trail", showMulti = true, portalDescription = 
         "Branching off from the Spirit Woods is a narrow gate that leads farther away from Hofborg proper and deeper into the heart of Western Skyrim where the style of home is evocative of Solitude's stone walls, heavy wooden posts and wood planking"},
    },
    [3] = { --Hofborg: The Motherhouse
        {id = 2, location = 3, destinations = {1}, x = 50417, y = 39220, z = 94570, cx = 0.277314, cy = 0.799364, radius = 20},
        {id = 2, location = 3, destinations = {2}, x = 52148, y = 17738, z = 87341, cx = 0.300159, cy = 0.703814},
        {id = 2, location = 3, destinations = {20}, x = 50010, y = 20449, z = 83083, cx = 0.271752, cy = 0.647199},
    },
    [4] = { --Hofborg: Saebjorn Long Hall
        {id = 2, location = 4, destinations = {1}, x = 82991, y = 36927, z = 83368, cx = 0.566294, cy = 0.541505},
        {id = 2, location = 4, destinations = {9}, x = 81731, y = 37254, z = 86133, cx = 0.566059, cy = 0.542607},
    },
    [5] = { --Hofborg: The Docks
        {id = 1, location = 5, destinations = {1}, x = 76652, y = 14513, z = 99360, cx = 0.618104, cy = 0.550230},
        {id = 2, location = 5, destinations = {23}, x = 81657, y = 14319, z = 101067, cx = 0.787284, cy = 0.607930,
         nameOverride = "Beacon Row", showMulti = true, portalDescription = 
         "The craggy rock strew coastline east of the main Hofborg docks is strewn with narrow towers and defunct lighthouses. Many of them are more then an hour apart from each other; consider taking one of the small skiffs to visit"},
        {id = 3, location = 5, destinations = {24}, x = 78111, y = 14516, z = 101327, cx = 0.667422, cy = 0.616718},
        --{location = 5, destinations = {25}, x = 78168, y = 14503, z = 94768, cx = 0.669348, cy = 0.395011}, --Moving to village
        {id = 4, location = 5, destinations = {}, x = 78168, y = 14503, z = 94768, cx = 0.669348, cy = 0.395011,
         nameOverride = "The Narrows", showMulti = true, portalDescription = 
         "A rabbit warren of narrow streets, shops and private homes the back alleys of Brigg-Bottom are built in a style more familiar in High Rock, heavy stone and Tudor being the predominent building materials of these converted warehouses, many of which haven't been used in decades"},
        {id = 5, location = 5, destinations = {}, x = 81556, y = 14509, z = 95241, cx = 0.783870, cy = 0.410999,
         nameOverride = "Horker Cove", showMulti = true, portalDescription = 
         "West along the coast from Hofborg's main docks lies another set of docks in need of repairs. Small homes dot the landscape perched above the cascading river falls. Many of the smaller docks and private homes lie within a short boat ride to Hofborg, while at least one or more are nearly conjoined and considered part of Hofborg's Brigg-bottom"},
    },
    [6] = { --Hofborg: The Village
        {id = 1, location = 6, destinations = {1}, x = 59163, y = 29521, z = 54676, cx = 0.325760, cy = 0.313665},
        {id = 2, location = 6, destinations = {2}, x = 72719, y = 28975, z = 62201, cx = 0.626185, cy = 0.481040},
        {id = 3, location = 6, destinations = {12}, x = 65158, y = 29226, z = 63763, cx = 0.458647, cy = 0.515038},
        {id = 4, location = 6, destinations = {13}, x = 65741, y = 29248, z = 59408, cx = 0.471559, cy = 0.418437},
        {id = 5, location = 6, destinations = {17}, x = 71549, y = 28976, z = 66063, cx = 0.600196, cy = 0.565871},
        {id = 6, location = 6, destinations = {18}, x = 70553, y = 28975, z = 66568, cx = 0.578130, cy = 0.577149},
        {id = 7, location = 6, destinations = {19}, x = 71354, y = 28975, z = 61026, cx = 0.595783, cy = 0.454397},
    },
    [8] = { --Hofborg: Guard House
        {id = 1, location = 8, destinations = {1}, x = 26343, y = 20019, z = 25502, cx = 0.717911, cy = 0.364741},
    },
    [9] = { --Hofborg: Hall Mistress Apartments
        {id = 1, location = 9, destinations = {4}, x = 19650, y = 20026, z = 29035, cx = 0.312595, cy = 0.789945},
    },
    [10] = { --Hofborg: Clever Cave
        {id = 1, location = 10, destinations = {2}, x = 59186, y = 29521, z = 54656, cx = 0.326087, cy = 0.313338},
    },
    [11] = { --Hofborg: Hammer Long Hall
        {id = 1, location = 11, destinations = {2}, x = 165387, y = 27707, z = 152042, cx = 0.669159, cy = 0.167601},
    },
    [12] = { --Hofborg: Bren's Tinkershop
        {id = 1, location = 12, destinations = {6}, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [13] = { --Hofborg: The Bunkhouse
        {id = 1, location = 13, destinations = {6}, x = 26372, y = 26645, z = 19720, cx = 0.724823, cy = 0.549507},
    },
    [14] = { --Hofborg: Apothecary Backroom
        {id = 1, location = 14, destinations = {1}, x = 26332, y = 20019, z = 25491, cx = 0.717911, cy = 0.364741},
    },
    [15] = { --Hofborg: Kyne's Keg, (Inn)
        {id = 1, location = 15, destinations = {1}, x = 26319, y = 26643, z = 19711, cx = 0.724690, cy = 0.549485},
        {id = 2, location = 15, destinations = {24}, x = 27072, y = 26716, z = 24983, cx = 0.726573, cy = 0.562665, nameOverride = "Back Alley to The Wharf Rat"},
    },
    [16] = { --Hofborg: Healer's Cottage
        {id = 1, location = 16, destinations = {1}, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [17] = { --Hofborg: Kjell's Cottage
        {id = 1, location = 17, destinations = {6}, x = 36867, y = 26454, z = 39036, cx = 0.250910, cy = 0.347660},
    },
    [18] = { --Hofborg: Available for Rent/Purchase
        {id = 1, location = 18, destinations = {6}, x = 36867, y = 26454, z = 39036, cx = 0.250910, cy = 0.347660},
    },
    [19] = { --Hofborg: Eiwa's Lodge
        {id = 1, location = 19, destinations = {6}, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [20] = { --Lara new
        {id = 1, location = 20, destinations = {3}, x = 19650, y = 20026, z = 29035, cx = 0.312595, cy = 0.789945},
    },
    [21] = { --Skyrim portal to Hofborg
        {id = 1, location = 21, destinations = {5}, x = 85201, y = 22049, z = 163631, cx = 0.117692, cy = 0.356798, radius = 400, height = 200},
    },
    [22] = { --Hofborg: Murtagh's Place
        {id = 1, location = 22, destinations = {1}, x = 26346, y = 26646, z = 19686, cx = 0.724757, cy = 0.549423},
    },
    [23] = { --Hofborg: Mercury & Maps
        {id = 1, location = 23, destinations = {5}, x = 132375, y = 33456, z = 124428, cx = 0.749466, cy = 0.645753},
    },
    [24] = { --Hofborg: The Wharf Rat
        {id = 1, location = 24, destinations = {5}, x = 66592, y = 7603, z = 74518, cx = 0.642293, cy = 0.206978},
        {id = 2, location = 24, destinations = {27}, x = 68160, y = 7604, z = 73100, cx = 0.664907, cy = 0.186526, radius = 120},
        {id = 3, location = 24, destinations = {15}, x = 64789, y = 7604, z = 73233, cx = 0.616289, cy = 0.188445, radius = 120, nameOverride = "Back Alley to Kyne's Keg"},
    },
    [25] = { --Hofborg: Malraz's Workshop
        {id = 1, location = 25, destinations = {5}, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [26] = { --Hofborg: Property Available
        {id = 1, location = 26, destinations = {5}, x = 36926, y = 26424, z = 39052, cx = 0.251058, cy = 0.347700},
    },
    [27] = { --Hofborg: Captain's Quarters
        {id = 1, location = 27, destinations = {24}, x = 58055, y = 9701, z = 31194, cx = 0.697752, cy = 0.419204},
    },
}
