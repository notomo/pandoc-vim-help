local M = {}

function M.indent(str, count)
  local indent = (" "):rep(count)
  local lines = {}
  for _, line in ipairs(M.split(str, "\n")) do
    if line == "" then
      table.insert(lines, "")
    else
      table.insert(lines, indent .. line)
    end
  end
  return table.concat(lines, "\n")
end

function M.split(str, sep)
  local strs = {}
  for s in str:gmatch("([^" .. sep .. "]+)") do
    table.insert(strs, s)
  end
  return strs
end

function M.splitted_last(str, sep)
  local splitted = M.split(str, sep)
  return splitted[#splitted]
end

function M.splitted_first(str, sep)
  local splitted = M.split(str, sep)
  local others = M.slice(splitted, 2)
  return splitted[1], table.concat(others, sep)
end

function M.starts_with(str, prefix)
  return str:sub(1, #prefix) == prefix
end

function M.slice(tbl, s, e)
  local sliced = {}
  for i = s or 1, e or #tbl do
    sliced[#sliced + 1] = tbl[i]
  end
  return sliced
end

return M
