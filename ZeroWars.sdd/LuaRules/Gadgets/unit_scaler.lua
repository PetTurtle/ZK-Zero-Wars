function gadget:GetInfo()
    return {
        name = "Unit Scaler",
        desc = "changes the scale of units",
        author = "petturtle",
        date = "2020",
        license = "GNU GPL, v2 or later",
        layer = 0,
        enabled = true,
    }
end

if not gadgetHandler:IsSyncedCode() then
    return false
end

-- SyncedCtrl
local spEcho = Spring.Echo
local spSetUnitPieceMatrix = Spring.SetUnitPieceMatrix

-- SyncedRead
local spGetUnitPieceList = Spring.GetUnitPieceList
local spGetUnitPieceMap = Spring.GetUnitPieceMap
local spGetUnitPieceInfo = Spring.GetUnitPieceInfo
local spGetUnitPieceMatrix = Spring.GetUnitPieceMatrix

local DEBUG = false
local NULL_PIECE = "[null]"

local units_offsets = {}

local function _FindBase(unitID)
    local pieces = spGetUnitPieceList(unitID)
    local pieceMap = spGetUnitPieceMap(unitID)
    for i = 1, #pieces do
        if spGetUnitPieceInfo(unitID, pieceMap[pieces[i]]).parent == NULL_PIECE then
            return pieceMap[pieces[i]]
        end
    end
end


local function _EchoPieceTable(pt)
    spEcho(pt[1], pt[2], pt[3], pt[4])
    spEcho(pt[5], pt[6], pt[7], pt[8])
    spEcho(pt[9], pt[10], pt[11], pt[12])
    spEcho(pt[13], pt[14], pt[15], pt[16])
end


local function _GetUnitOffset(unitID, pieceTable)
    if not units_offsets[unitID] then
        units_offsets[unitID] = {pieceTable[13], pieceTable[14], pieceTable[15]}
    end
    return units_offsets[unitID]
end


local function _SetScale(unitID, base, scale)
    local p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 = spGetUnitPieceMatrix(unitID, base)
    local pieceTable = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16}
    local unit_offset = _GetUnitOffset(unitID, pieceTable)

    pieceTable[1] = scale
    pieceTable[6] = scale
    pieceTable[11] = scale
    pieceTable[13] = unit_offset[1] * scale
    pieceTable[14] = unit_offset[2] * scale
    pieceTable[15] = unit_offset[3] * scale
    spSetUnitPieceMatrix(unitID, base, pieceTable)

    if DEBUG then
        _EchoPieceTable(pieceTable)
    end
end


local function UnitScale(unitID, scale)
    local base = _FindBase(unitID)
    if base then
        _SetScale(unitID, base, scale)
    end
end


function gadget:Initialize()
    if Game.modShortName ~= "ZK" then
        gadgetHandler:RemoveGadget()
        return
    end

    GG.UnitScale = UnitScale
end


function gadget:UnitDestroyed(unitID)
    if units_offsets[unitID] then
        table.remove(units_offsets, unitID)
    end
end