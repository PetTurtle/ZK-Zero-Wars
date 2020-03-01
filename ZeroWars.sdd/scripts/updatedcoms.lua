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
    UpdatePaths       = UpdatePaths,
    Create            = Create,
}