local debug = require(script.Parent.debug)
local getRefLabel = debug.getRefLabel

local function _separatedPath(path, separator)
  if path == nil then
    return {}
  end

  if separator == nil then
    separator = '.'
  end

  local _path = path
  local hasPercent = false

  if separator ~= '%' and (path):find('%%') then
    _path = (path)
      :gsub('%%%%', '\bp'):gsub('%%%' .. separator, '\bs')
      :gsub('\bp', '%%'):gsub('%%(.)', '%1')
    hasPercent = true
  end

  local paths = (_path):split(separator)
  local _paths = {}

  for _, subpath in pairs(paths) do
    if subpath ~= '' then
      if hasPercent then
        subpath = (subpath):gsub('\bs', separator)
      end
      _paths[#_paths + 1] = subpath
    end
  end

  return _paths
end

local function separatedPath(path, separator)
  if path ~= nil then
    if type(path) ~= 'string' then
      error((
        "Invalid argument #1 to paths.separatedPath " ..
        "(string expected, received %s)"):format(getRefLabel(path)), 2)
    end

    if path:find('\b') then
      error((
        "Invalid argument #1 to paths.separatedPath " ..
        "(string must not contain '\\b' (bell character), received '%s')"
        ):format(path), 2)
    end
  end

  if separator ~= nil then
    if type(separator) ~= 'string' then
      error((
        "Invalid argument #2 to paths.separatedPath " ..
        "(string expected, received %s)"):format(getRefLabel(separator)), 2)
    end

    if #separator ~= 1 then
      error((
        "Invalid argument #2 to paths.separatedPath " ..
        "(single-character string expected, received '%s')"
        ):format(separator), 2)
    end

    if separator == '\b' then
      error((
        "Invalid argument #2 to paths.separatedPath " ..
        "(string must not contain '\\b' (bell character), received '%s')"
        ):format(separator), 2)
    end
  end

  return _separatedPath(path, separator)
end

local function _findByPath(path, separator)
  if (path or '') == '' then
    return nil, nil
  end

  local subpaths = _separatedPath(path, separator)

  if #subpaths == 0 then
    return nil, nil
  end

  local serviceName = subpaths[1]:sub(2)

  local _, instance = pcall(function()
    return game:GetService(serviceName)
  end)

  if typeof(instance) ~= 'Instance' then
    return nil, serviceName
  end

  for i = 2, #subpaths do
    local subpath = subpaths[i]
    instance = instance:FindFirstChild(subpath, false)

    if typeof(instance) ~= 'Instance' then
      return nil, subpath
    end
  end
  return instance
end

local function findByPath(path, separator)
  if path ~= nil then
    if type(path) ~= 'string' then
      error((
        "Invalid argument #1 to paths.findByPath " ..
        "(string expected, received %s)"):format(getRefLabel(path)), 2)
    end

    if not(
      path:sub(1, 1) == ':' or
      (path:sub(1, 2) == '%:' and separator ~= '%')) then

      error((
        "Invalid argument #1 to paths.findByPath " ..
        "(string must begin with a service name prefixed with ':', " ..
        "received '%s')"):format(path), 2)
    end

    if path:find('\b') then
      error((
        "Invalid argument #1 to paths.findByPath " ..
        "(string must not contain '\\b' (bell character), received '%s')"
        ):format(path), 2)
    end
  end

  if separator ~= nil then
    if type(separator) ~= 'string' then
      error((
        "Invalid argument #2 to paths.findByPath " ..
        "(string expected, received %s)"):format(getRefLabel(separator)), 2)
    end

    if #separator ~= 1 then
      error((
        "Invalid argument #2 to paths.findByPath " ..
        "(single-character string expected, received '%s')"
        ):format(separator), 2)
    end

    if separator == '\b' then
      error((
        "Invalid argument #2 to paths.findByPath " ..
        "(string must not contain '\\b' (bell character), received '%s')"
        ):format(separator), 2)
    end
  end

  return _findByPath(path, separator)
end

local function _findChildByPath(instance, path, separator)
  if path == nil then
    return instance
  end

  if path:sub(1, 1) == ':' or
    (path:sub(1, 2) == '%:' and separator ~= '%') then

    return _findByPath(path, separator)
  end

  local subpaths = _separatedPath(path, separator)

  for i = 1, #subpaths do
    local subpath = subpaths[i]
    instance = instance:FindFirstChild(subpath, false)

    if typeof(instance) ~= 'Instance' then
      return nil, subpath
    end
  end
  return instance, nil
end

local function findChildByPath(instance, path, separator)
  if typeof(instance) ~= 'Instance' then
    error((
      "Invalid argument #1 to paths.findChildByPath " ..
      "(Instance expected, received %s)"):format(getRefLabel(instance)), 2)
  end

  if path ~= nil and type(path) ~= 'string' then
    error((
      "Invalid argument #2 to paths.findChildByPath " ..
      "(string expected, received %s)"):format(getRefLabel(path)), 2)
  end

  if separator ~= nil then
    if type(separator) ~= 'string' then
      error((
        "Invalid argument #3 to paths.findChildByPath " ..
        "(string expected, received %s)"):format(getRefLabel(separator)), 2)
    end

    if #separator ~= 1 then
      error((
        "Invalid argument #3 to paths.findChildByPath " ..
        "(single-character string expected, received '%s')"
        ):format(separator), 2)
    end

    if separator == '\b' then
      error(
        "Invalid argument #3 to paths.findChildByPath " ..
        "(string must not be '\\b' (bell character))", 2)
    end
  end

  return _findChildByPath(instance, path, separator)
end

return {
  findByPath = findByPath,
  findChildByPath = findChildByPath,
  separatedPath = separatedPath,
}