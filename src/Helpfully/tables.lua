local debug = require(script.Parent.debug)
local getRefLabel = debug.getRefLabel
local trimErrMsgLineNum = debug.trimErrMsgLineNum

local function assign(tbl, ...)
  if type(tbl) ~= 'table' then
    error((
      "Invalid argument #1 to tables.assign " ..
      "(table expected, received %s)"):format(getRefLabel(tbl)), 2)
  end

  local args = table.pack(...)

  for i = 1, args.n do
    local arg = args[i]
    if type(arg) == 'table' then
      for k, v in pairs(arg) do
        tbl[k] = v
      end
    end
  end

  return tbl
end

local function augment(tbl, ...)
  if type(tbl) ~= 'table' then
    error((
      "Invalid argument #1 to tables.augment " ..
      "(table expected, received %s)"):format(getRefLabel(tbl)), 2)
  end

  local args = table.pack(...)

  for i = 1, args.n do
    local arg = args[i]
    if type(arg) == 'table' then
      for k, v in pairs(arg) do
        if tbl[k] == nil then
          tbl[k] = v
        end
      end
    end
  end

  return tbl
end

return {
  assign = assign,
  augment = augment,
}