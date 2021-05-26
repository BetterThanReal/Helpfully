local getRefLabel = require(script.Parent.debug).getRefLabel

local function bind(fn, ...)
  if type(fn) ~= 'function' then
    error((
      "Invalid argument #1 to functions.bind " ..
      "(function expected, received %s)"):format(getRefLabel(fn)), 1)
  end

  local bound = table.pack(...)
  local boundCount = bound.n

  -- performance optimization for common bind scenarios
  if boundCount == 0 then
    return fn
  elseif boundCount == 1 then
    return function(...)
      return fn(bound[1], ...)
    end
  elseif boundCount == 2 then
    return function(...)
      return fn(bound[1], bound[2], ...)
    end
  elseif boundCount == 3 then
    return function(...)
      return fn(bound[1], bound[2], bound[3], ...)
    end
  elseif boundCount == 4 then
    return function(...)
      return fn(bound[1], bound[2], bound[3], bound[4], ...)
    end
  end

  -- general case which requires table concatenation for
  -- each invocation of the bound function.
  return function(...)
    local fnArgs = {}
    table.move(bound, 1, boundCount, 1, fnArgs)
    local args = table.pack(...)
    table.move(args, 1, #args, boundCount + 1, fnArgs)
    return fn(table.unpack(fnArgs, 1, fnArgs.n))
  end
end

local function listKeep(n, ...)
  local values = table.pack(...)
  local valuesN = values.n

  if n >= valuesN or -(n) >= valuesN then
    return ...
  elseif n < 0 then
    n = n + valuesN
    if n < 0 then
      n = 0
    end
    return table.unpack(values, n + 1, valuesN)
  end

  return table.unpack(values, 1, n)
end

local function listDrop(n, ...)
  local values = table.pack(...)
  local valuesN = values.n

  if n >= valuesN then
    return
  end

  return table.unpack(values, n + 1, valuesN)
end

local function bindWithModify(nFn, n, fn, ...)
  local bound = table.pack(...)
  local boundCount = bound.n

  -- performance optimization for common bind scenarios
  if boundCount == 0 then
    return function(...)
      return nFn(n, fn(...))
    end
  elseif boundCount == 1 then
    return function(...)
      return nFn(n, fn(bound[1], ...))
    end
  elseif boundCount == 2 then
    return function(...)
      return nFn(n, fn(bound[1], bound[2], ...))
    end
  elseif boundCount == 3 then
    return function(...)
      return nFn(n, fn(bound[1], bound[2], bound[3], ...))
    end
  elseif boundCount == 4 then
    return function(...)
      return nFn(n, fn(bound[1], bound[2], bound[3], bound[4], ...))
    end
  end

  -- general case which requires table concatenation for
  -- each invocation of the bound function.
  return function(...)
    local fnArgs = {}
    table.move(bound, 1, boundCount, 1, fnArgs)
    local args = table.pack(...)
    table.move(args, 1, #args, boundCount + 1, fnArgs)
    return nFn(n, fn(table.unpack(fnArgs, 1, fnArgs.n)))
  end
end

local function bindDrop(n, fn, ...)
  if type(n) ~= 'number' then
    error((
      "Invalid argument #1 to functions.bindDrop " ..
      "(number expected, received %s)"):format(getRefLabel(n)), 1)
  end

  if n < 0 then
    error((
      "Invalid argument #1 to functions.bindDrop " ..
      "(non-negative number expected, received %s)"):format(n), 1)
  end

  if type(fn) ~= 'function' then
    error((
      "Invalid argument #2 to functions.bindDrop " ..
      "(function expected, received %s)"):format(getRefLabel(fn)), 1)
  end

  if n == 0 then
    return bind(fn, ...)
  end

  return bindWithModify(listDrop, n, fn, ...)
end

local function bindKeep(n, fn, ...)
  if type(n) ~= 'number' then
    error((
      "Invalid argument #1 to functions.bindKeep " ..
      "(number expected, received %s)"):format(getRefLabel(n)), 1)
  end

  if type(fn) ~= 'function' then
    error((
      "Invalid argument #2 to functions.bindKeep " ..
      "(function expected, received %s)"):format(getRefLabel(fn)), 1)
  end

  if n == 0 then
    local bound = bind(fn, ...)
    return function()
      bound()
    end
  end

  return bindWithModify(listKeep, n, fn, ...)
end

local function noOp() end

return {
  bind = bind,
  bindDrop = bindDrop,
  bindKeep = bindKeep,
  noOp = noOp,
}