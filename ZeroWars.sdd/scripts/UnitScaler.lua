if GG.SetScale then
    return
end

function GG.SetScale(unitID, base, level, minScale, maxScale)
    local p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 = Spring.GetUnitPieceMatrix(unitID, base)
    local pieceTable = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16}
    local scale = (level / (16 - level)) * (maxScale - minScale) + minScale

    pieceTable[1] = scale
    pieceTable[6] = scale
    pieceTable[11] = scale
    Spring.SetUnitPieceMatrix(unitID, base, pieceTable)
end