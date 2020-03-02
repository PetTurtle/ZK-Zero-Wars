function GG.SetScale(unitID, base, scale)
    local p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 = Spring.GetUnitPieceMatrix(unitID, base)
    local pieceTable = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16}

    pieceTable[1] = scale
    pieceTable[6] = scale
    pieceTable[11] = scale
    Spring.SetUnitPieceMatrix(unitID, base, pieceTable)
end

local function UpdatePaths(path1, path2, path3, path4)

end

local function Create()
    UpdatePaths(
        Spring.GetUnitRulesParam(unitID, "path1"),
        Spring.GetUnitRulesParam(unitID, "path2"),
        Spring.GetUnitRulesParam(unitID, "path3"),
        Spring.GetUnitRulesParam(unitID, "path4")
    )
end

return {
    SetScale          = SetScale,
    UpdatePaths       = UpdatePaths,
    Create            = Create,
}