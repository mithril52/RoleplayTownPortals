if not RTP then RTP = { } end
if not RTP.UTIL then RTP.UTIL = { } end

function RTP.UTIL.PointWithinCylinder(point, cylinder)
    local dx = cylinder.top.x - cylinder.bottom.x
    local dy = cylinder.top.y - cylinder.bottom.y
    local dz = cylinder.top.z - cylinder.bottom.z
    local pdx = point.x - cylinder.bottom.x
    local pdy = point.y - cylinder.bottom.y
    local pdz = point.z - cylinder.bottom.z
    local dot = pdx * dx + pdy * dy + pdz * dz

    if dot < 0 or dot > cylinder.lengthSq then
        return false
    else
        local dsq = (pdx*pdx + pdy*pdy + pdz*pdz) - dot*dot/cylinder.lengthSq

        if dsq > cylinder.radiusSq then
            return false
        else
            return true
        end
    end
end

function RTP.UTIL.GenerateCylinder(location, radius, height)
    local cylinder = {
        top = {
            x = location.x,
            y = location.y + (height / 2),
            z = location.z
        },
        bottom = {
            x = location.x,
            y = location.y - (height / 2),
            z = location.z
        },
        lengthSq = height * height,
        radiusSq = radius * radius
    }
    
    return cylinder;
end

function RTP.UTIL.Distance(p1, p2)
    return math.sqrt(((p2.x - p1.x)^2) + ((p2.y - p1.y)^2))
end 

function RTP.UTIL.PositionsEqual(position1, position2)
    if position1 == nil or position2 == nil then
        return false
    end

    return position1.x == position2.x and position1.y == position2.y and position1.z == position2.z
end

function GetTableLength(tbl)
    local getN = 0
    for n in pairs(tbl) do
        getN = getN + 1
    end
    return getN
end