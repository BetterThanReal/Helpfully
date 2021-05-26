local bind = require(script.Parent.functions).bind
local getRefLabel = require(script.Parent.debug).getRefLabel

local LOG_LEVEL = {
  NONE = 100,
  FATAL = 95,
  CRITICAL = 85,
  ERROR = 75,
  WARN = 65,
  INFO = 50,
  VERBOSE = 35,
  DEBUG = 20,
  ALL = 0,
}

local PREFIX = {
  [LOG_LEVEL.NONE] = 'NONE',
  [LOG_LEVEL.FATAL] = 'FATAL',
  [LOG_LEVEL.CRITICAL] = 'CRITICAL',
  [LOG_LEVEL.ERROR] = 'ERROR',
  [LOG_LEVEL.WARN] = 'WARN',
  [LOG_LEVEL.INFO] = 'INFO',
  [LOG_LEVEL.VERBOSE] = 'VERBOSE',
  [LOG_LEVEL.DEBUG] = 'DEBUG',
  [LOG_LEVEL.ALL] = 'ALL',
}

local function getLogLevel(level)
  if level == nil then
    return LOG_LEVEL.ALL
  end

  if type(level) == 'number' then
    return level
  end

  if type(level) == 'string' then
    return LOG_LEVEL[string.upper(level)]
  end

  return nil
end

local function getLogPrefix(name, msgLevel)
  local prefix = PREFIX[msgLevel]
  local prefix = prefix and ("[%s] "):format(prefix) or ''
  name = name and ("{%s}: "):format(name) or ''

  return prefix .. name
end

local function noOp() end

local function onLogError(logLevel, name, message)
  error(string.format("%s%s", name or '', message or ''))
end

local function onLogPrint(logLevel, name, message)
  print(string.format("%s%s", name or '', message or ''))
end

local function onLogWarn(logLevel, name, message)
  warn(string.format("%s%s", name or '', message or ''))
end

local function create(config)
  local _ = config or (config == nil and {})

  if type(_) ~= 'table' then
    error((
      "Invalid argument #1 to Logger.create " ..
      "(table expected, received %s)"):format(getRefLabel(_)), 2)
  end

  local name = _.name

  if name ~= nil and type(name) ~= 'string' then
    error((
      "Invalid property 'name' in argument #1 to Logger.create " ..
      "(string expected, received %s)"):format(getRefLabel(name)), 2)
  end

  local level = getLogLevel(_.level)

  if level == nil then
    error((
      "Invalid property 'level' in argument #1 to Logger.create " ..
      "(number or log-level name expected, received %s)"
      ):format(getRefLabel(_.level)), 2)
  end

  local onLogFn = _.onLogFn

  if onLogFn ~= nil and type(onLogFn) ~= 'function' then
    error((
      "Invalid property 'onLogFn' in argument #1 to Logger.create " ..
      "(function expected, received %s)"):format(getRefLabel(onLogFn)), 2)
  end

  local module = {
    critical = LOG_LEVEL.CRITICAL < level and noOp or
      bind(onLogFn or onLogError, LOG_LEVEL.CRITICAL,
        not onLogFn and getLogPrefix(name, LOG_LEVEL.CRITICAL) or name),

    debug = LOG_LEVEL.DEBUG < level and noOp or
      bind(nLogFn or onLogPrint, LOG_LEVEL.DEBUG,
        not onLogFn and getLogPrefix(name, LOG_LEVEL.DEBUG) or name),

    error = LOG_LEVEL.ERROR < level and noOp or
      bind(onLogFn or onLogError, LOG_LEVEL.ERROR,
        not onLogFn and getLogPrefix(name, LOG_LEVEL.ERROR) or name),

    fatal = LOG_LEVEL.FATAL < level and noOp or
      bind(onLogFn or onLogError, LOG_LEVEL.FATAL,
        not onLogFn and getLogPrefix(name, LOG_LEVEL.FATAL) or name),

    info = LOG_LEVEL.INFO < level and noOp or
      bind(onLogFn or onLogPrint, LOG_LEVEL.INFO,
        not onLogFn and getLogPrefix(name, LOG_LEVEL.INFO) or name),

    verbose = LOG_LEVEL.VERBOSE < level and noOp or
      bind(onLogFn or onLogPrint, LOG_LEVEL.VERBOSE,
        not onLogFn and getLogPrefix(name, LOG_LEVEL.VERBOSE) or name),

    warn = LOG_LEVEL.WARN < level and noOp or
      bind(onLogFn or onLogWarn, LOG_LEVEL.WARN,
        not onLogFn and getLogPrefix(name, LOG_LEVEL.WARN) or name),

    LOG_LEVEL = LOG_LEVEL,
  }

  setmetatable(module, { __call = function(table, _) return create(_) end })
  return module
end

return create()