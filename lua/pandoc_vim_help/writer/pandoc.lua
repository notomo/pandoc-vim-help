PANDOC_STATE = PANDOC_STATE or {}
PANDOC_DOCUMENT = PANDOC_DOCUMENT or {}

local option = require("pandoc_vim_help.writer.option").new(PANDOC_DOCUMENT.meta, PANDOC_STATE.output_file)
local help = require("pandoc_vim_help.writer.help")
local util = require("pandoc_vim_help.util")

local separator = help.separator(option.textwidth)

local M = {}

function M.Doc(body)
  local buffer = {}
  -- TODO: custom header
  table.insert(buffer, help.header(PANDOC_STATE.output_file))
  table.insert(buffer, body)
  table.insert(buffer, separator)
  -- TODO: custom footer
  table.insert(buffer, help.footer(option.textwidth, option.tabstop))
  return table.concat(buffer, "\n") .. "\n"
end

function M.Header(_, s)
  -- TODO handle separator and tag by level option
  local tag = help.tag(option.tag_prefix, s)
  return separator .. "\n" .. s .. "\n" .. ("%" .. option.textwidth .. "s"):format(tag)
end

function M.BulletList(items)
  -- TODO handle nested list?
  local buffer = {}
  for _, item in ipairs(items) do
    table.insert(buffer, "・" .. item)
  end
  return "\n" .. table.concat(buffer, "\n") .. "\n"
end

function M.OrderedList(items)
  -- TODO handle nested list?
  local buffer = {}
  for i, item in ipairs(items) do
    table.insert(buffer, ("%d. %s"):format(i, item))
  end
  return "\n" .. table.concat(buffer, "\n") .. "\n"
end

function M.DefinitionList(items)
  local buffer = {}
  for _, item in pairs(items) do
    local k, v = next(item)
    -- TODO: fix?
    table.insert(buffer, k .. "\n" .. util.indent(table.concat(v, "\n"), 2))
  end
  return "\n" .. table.concat(buffer, "\n") .. "\n"
end

function M.Table(_, _, _, headers, rows)
  -- TODO: align

  local buffer = {}

  local header_row = {}
  local empty_header = true
  for _, h in pairs(headers) do
    table.insert(header_row, h)
    empty_header = empty_header and h == ""
  end
  if not empty_header then
    table.insert(buffer, table.concat(header_row, " "))
  end

  for _, row in pairs(rows) do
    table.insert(buffer, table.concat(row, " "))
  end

  return table.concat(buffer, "\n")
end

function M.CodeBlock(s)
  return ">\n" .. util.indent(s, 2) .. "\n>"
end

function M.LineBlock(ls)
  return table.concat(ls, "\n")
end

function M.Link(title, url)
  return ("%s (%s)"):format(title, url)
end

function M.Image(_, src, title)
  return ("%s (%s)"):format(title, src)
end

function M.CaptionedImage(_, title, caption)
  return ("%s (%s)"):format(title, caption)
end

function M.Code(s)
  return ([[`%s`]]):format(s)
end

function M.SingleQuoted(s)
  -- NOTE: 'name' means vim option name in help
  return ([[`%s`]]):format(s)
end

function M.DoubleQuoted(s)
  return ([["%s"]]):format(s)
end

function M.HorizontalRule()
  return separator
end

function M.Blocksep()
  return "\n\n"
end

function M.SoftBreak()
  return "\n"
end

function M.LineBreak()
  return "\n"
end

function M.Space()
  return " "
end

function M.RawBlock(_, s)
  -- should be ignored?
  return s
end

function M.RawInline(_, s)
  -- should be ignored?
  return s
end

function M.Strong(s)
  return s
end

function M.Emph(s)
  return s
end

function M.Str(s)
  return s
end

function M.Plain(s)
  return s
end

function M.Para(s)
  return s
end

function M.BlockQuote(s)
  return s
end

function M.Cite(s)
  return s
end

function M.DisplayMath(s)
  return s
end

function M.InlineMath(s)
  return s
end

function M.Div(s)
  return s
end

function M.Note(s)
  return s
end

function M.SmallCaps(s)
  return s
end

function M.Span(s)
  return s
end

function M.Strikeout(s)
  return s
end

function M.Subscript(s)
  return s
end

function M.Superscript(s)
  return s
end

return M