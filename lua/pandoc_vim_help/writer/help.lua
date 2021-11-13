local util = require("pandoc_vim_help.util")

local M = {}

function M.header(output_file, text)
  local file_name = util.splitted_last(output_file, "/")
  local tag = M.tag("", file_name)
  local header = tag
  if #text ~= 0 then
    header = ("%s %s"):format(header, text)
  end
  return header
end

function M.separator(textwidth)
  return ("="):rep(textwidth)
end

function M.tag(prefix, str)
  if prefix ~= "" then
    str = prefix .. "-" .. str
  end
  str = str:gsub(" ", "-")
  return ("*%s*"):format(str)
end

function M.add_tag(textwidth, tag)
  return "\n" .. ("%" .. textwidth .. "s"):format(tag)
end

return M
