local util = require("pandoc_vim_help.util")

local M = {}

local link_target_prefix
function M.Meta(e)
  link_target_prefix = e.link_target_prefix
  return e
end

function M.Link(e)
  if not link_target_prefix then
    return e
  end
  if util.starts_with(e.target, "http://") or util.starts_with(e.target, "https://") then
    return e
  end
  e.target = link_target_prefix .. e.target
  return e
end

return M
