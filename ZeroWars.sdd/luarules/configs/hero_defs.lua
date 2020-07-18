local heroDefs = {}

local files = VFS.DirList("luarules/configs/heroes", "*.lua") or {}

for i = 1, #files do
    local index, table = VFS.Include(files[i])
    heroDefs[index] = table
end

return heroDefs
