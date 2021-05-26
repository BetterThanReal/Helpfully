local function getRefLabel(ref)
  local t = typeof(ref)

  if t == 'Instance' then
    local cn = type(ref.ClassName) == 'string' and
      ref.ClassName ~= '' and ref.ClassName

    local n = type(ref.name) == 'string' and
      ref.name ~= '' and ref.name

    return ("<%s>%s"):format(
      cn or 'Instance', n and (' "%s"'):format(n) or '')
  else
    if t == 'string' then
      return '"' .. ref .. '"'
    elseif t == 'boolean' or t == 'number' or ref == nil then
      return tostring(ref)
    else
      return '<' .. t .. '>'
    end
  end
end

local function trimErrMsgLineNum(message)
  if type(message) ~= 'string' then
    return message
  end
  return ((message):gsub('^[^:]+:[0-9]+: ', '', 1))
end

return {
  getRefLabel = getRefLabel,
  trimErrMsgLineNum = trimErrMsgLineNum,
}