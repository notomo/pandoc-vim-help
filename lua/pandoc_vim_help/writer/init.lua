for k, v in pairs(require("pandoc_vim_help.writer.pandoc")) do
  _G[k] = v
end
setmetatable(_G, {
  __index = function(_, k)
    io.stderr:write(("WARNING: Undefined function '%s'\n"):format(k))
    return function()
      return ""
    end
  end,
})
