# Helpfully: API Reference: Logger

`Logger` is a class for logging information, warnings, and errors.

## Loading The Module

Invoking `require` upon the module `Helpfully.Logger` will return a `Logger`
configured with default behavior.

[`Logger()`][function-logger] can be invoked to create a `Logger` with
customized behavior.

<figure><figcaption><em>Example: require</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local Logger = require(Helpfully.Logger)

Logger.info("Hello") -- print("[INFO] Hello")

local logger = Logger({ name = "MyLib" })

logger.info("Hello") -- print("[INFO] {MyLib}: Hello")
```

## Class Methods

<table>
<thead>
<tr><th>Function Name</th><th>Description</th></tr>
</thead>
<tbody>
<tr><td><a href='#function-logger'>Logger()</a></td>
<td>Creates and returns a custom <code>Logger</code> with user-defined
behavior.</td></tr>
</tbody></table>

## Instance Methods

<table>
<thead>
<tr><th>Function Name</th><th>Description</th></tr>
</thead>
<tbody>
<tr><td><a href='#logging-functions'>critical</a></td>
<td>Logs messages for events with critical severity.</td></tr>
<tr><td><a href='#logging-functions'>debug</a></td>
<td>Logs messages for events with debug severity.</td></tr>
<tr><td><a href='#logging-functions'>error</a></td>
<td>Logs messages for events with error severity.</td></tr>
<tr><td><a href='#logging-functions'>fatal</a></td>
<td>Logs messages for events with fatal severity.</td></tr>
<tr><td><a href='#logging-functions'>info</a></td>
<td>Logs messages for events with info severity.</td></tr>
<tr><td><a href='#logging-functions'>verbose</a></td>
<td>Logs messages for events with verbose severity.</td></tr>
<tr><td><a href='#logging-functions'>warn</a></td>
<td>Logs messages for events with warn severity.</td></tr>
</tbody></table>

## Constants

### Enumeration: LOG_LEVEL

<table>
<thead>
<tr><th>Name</th><th>Value</th><th>Severity</th></tr>
</thead>
<tbody>
<tr><td>NONE</td><td>100</td><td>Nothing will be logged.</td></tr>
<tr><td>FATAL</td><td>95</td><td>The highest severity; the application
encountered an error from which it cannot recover.</td></tr>
<tr><td>CRITICAL</td><td>85</td><td>High severity; the application encountered
an error that prevents it from working properly.</td></tr>
<tr><td>ERROR</td><td>75</td><td>Medium-high severity; an error occurred, but
the application may recover.</td></tr>
<tr><td>WARN</td><td>65</td><td>Medium-low severity; an event happened that
does not impact full application functionality, but merits attention.
</td></tr>
<tr><td>INFO</td><td>50</td><td>Low severity; information presented for
informational purposes only.</td></tr>
<tr><td>VERBOSE</td><td>35</td><td>Very low severity; provides additional
information that may be useful for detailed analyses.</tr>
<tr><td>DEBUG</td><td>20</td><td>Very low severity; provides copious amounts
of additional information that may be useful for troubleshooting, but is
too voluminous to utilize regularly.</td></tr>
<tr><td>ALL</td><td>0</td><td>Everything will be logged.
</td></tr>
</tbody></table>

## Function: Logger()

Creates and returns a custom `Logger` with user-defined behavior.

##### Signature

```lua
Logger Logger([table config])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>config</td><td><code>table</code> (optional)</td>
<td>An optional <code>table</code> containing configuration properties to
define the behavior of the <code>Logger</code> to be created and
returned.  If not specified, a <code>Logger</code> with default behavior will
be returned.</td></tr>
</tbody>
</table>

##### config Properties

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>level</td><td><code>number</code> or <code>string</code>
(optional)</td>
<td>An optional minimum severity of events to log.  Logging functions with a
lower <a href="#enumeration-log_level">severity level</a> than this will be
ignored when invoked.  Defaults to <code>LOG_LEVEL.ALL</code>.</td></tr>
<tr><td>name</td><td><code>string</code> (optional)</td>
<td>An optional name to report to logging functions.</td></tr>
<tr><td>onLogFn</td><td><code>function</code> (optional)</td>
<td>An optional custom <a href="#log-handler">log handler</a> to invoke when
logging functions are invoked.  If not specified, defaults to the
<a href="#logging-function-defaults">default log handlers</a>.</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>Logger</code></td>
<td>The <code>Logger</code> configured according to the specified
<code>config</code>.</td></tr>
</tbody>
</table>

##### Side-Effects

None.

##### Errors

`Logger()` will throw an error if `config` is present but is not a `table`.

`Logger()` will throw an error if `config.name` is present but is not a
`string`.

`Logger()` will throw an error if `config.level` is present but is not a
`number`, or is a `string` but does not equal the name of a
[log level][enumeration-log_level].

`Logger()` will throw an error if `config.onLogFn` is present but is not a
`function`.

##### Caveats

None.

##### Examples

<figure><figcaption><em>Example: Logger()</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local Logger = require(Helpfully.Logger)

local logger = Logger({
  level = Logger.LOG_LEVEL.INFO, -- Log events of severity INFO or greater.
  name = "MyLib" })

Logger.info("Hello") -- print("[INFO] {MyLib}: Hello")
Logger.verbose("Hello") -- Ignored, is not INFO or greater

local errorCount = 0

local function errorCounter(logLevel, name, message)
  errorCount = errorCount + 1
  print(("ERROR in %s: %s"):format(name, message))

  if (logLevel >= Logger.LOG_LEVEL.CRITICAL) then
    error("Severe error occurred; unable to continue")
  end
end

logger = Logger({
  level = Logger.LOG_LEVEL.ERROR, -- Log events of severity ERROR or greater.
  name = "MyLib",
  onLogFn = errorCounter })

logger.error("First error") -- print("ERROR in MyLib: First error")
logger.error("Second error") -- print("ERROR in MyLib: Second error")
print(errorCount) -- 2
```

## Logging

Executes the user-specified [log handler][log-handler], or an appropriate
[default log handler][logging-function-defaults] if one has not been
[configured][config-properties].

Each of the [logging functions][logging-functions] (`critical`, `debug`,
`error`, `fatal`, `info`, `verbose`, and `warn`) has the same function
signature and behavior, and varies only in the severity level it reports, and
the default log handler it uses if one has not been configured.

### Logging Functions

##### Logging Function Defaults

<table>
<thead>
<tr><th>Function Name</th><th>Reported Severity</th>
<th>Default Log Handler <a href="#default-log-handler-note">*</a></th></tr>
</thead>
<tbody>
<tr><td>critical</td><td>LOG_LEVEL.CRITICAL</td><td>
<code>error</code></td></tr>
<tr><td>debug</td><td>LOG_LEVEL.DEBUG</td><td><code>print</code></td></tr>
<tr><td>error</td><td>LOG_LEVEL.ERROR</td><td><code>error</code></td></tr>
<tr><td>fatal</td><td>LOG_LEVEL.FATAL</td><td><code>error</code></td></tr>
<tr><td>info</td><td>LOG_LEVEL.INFO</td><td><code>print</code></td></tr>
<tr><td>verbose</td><td>LOG_LEVEL.VERBOSE</td><td><code>print</code></td></tr>
<tr><td>warn</td><td>LOG_LEVEL.WARN</td><td><code>warn</code></td></tr>
<tr><td colspan="3">
<span id="default-log-handler-note" class="pedantic-disclaimer">* Actually,
the default log handlers are wrappers around the functions listed here, to
maintain compatibility with function signatures.<span>
</td></tr>
</table>

##### Signature

```lua
[Variant...] critical([Variant... args])
[Variant...] debug([Variant... args])
[Variant...] error([Variant... args])
[Variant...] fatal([Variant... args])
[Variant...] info([Variant... args])
[Variant...] verbose([Variant... args])
[Variant...] warn([Variant... args])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>args</td><td><code>Variant...</code> (optional)</td>
<td>Zero or more arguments to pass to the
<a href="#log-handler">log handler</a>.</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>Variant...</code> (optional)</td>
<td>Zero or more return values, returned from the
<a href="#log-handler">log handler</a>.</td></tr>
</tbody>
</table>

##### Side-Effects

When invoked, each [logging function][logging-functions] will in turn invoke
a [log handler][log-handler], if the [log level][enumeration-log_level]
corresponding to the logging function is equal to or greater than the
threshold log level specified when
[configuring the logger][config-properties].  Thus, if a logger is configured
with the threshold log level `ERROR`, logging functions with lower severity
(`warn`, `info`, `verbose`, and `debug`) will be ignored.

The log handler that any logging function invokes will have been specified
when configuring the logger.  If no custom log handler was
specified, the [default log handler][logging-function-defaults] corresponding
to the log level of the logging function will be used.

Log handlers are invoked with the
[function signature for log handlers][log-handler-signature].

##### Errors

Errors that occur within a custom [log handler][log-handler] are thrown.  To
prevent custom log handlers from throwing errors, wrap their internal logic
with `pcall` or `xpcall`.

##### Caveats

None.

##### Examples

<figure><figcaption><em>Example: Logging Function</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local Logger = require(Helpfully.Logger)

Logger.info("Hello") -- print("[INFO] Hello")
Logger.error("Ooops") -- error("[ERROR] Ooops")
```

### Log Handler

An optional, custom log handler can be specified when
[configuring the logger][config-properties], to process custom logging logic
whenever a [logging function][logging-functions] is invoked. 

##### Signature

```lua
[Variant...] function(number logLevel, string name, [Variant... args])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>logLevel</td><td><code>number</code></td>
<td>The <a href="#enumeration-log_level">log level</a> that corresponds to the
severity of the <a href="#logging-functions">logging function</a> that invoked
this log handler.</td></tr>
<tr><td>name</td><td><code>string</code></td>
<td>The <code>name</code> parameter specified during
<a href="#function-logger">configuration of the logger</a>, or
<code>nil</code> if none was specified.</td></tr>
<tr><td>args</td><td><code>Variant...</code> (optional)</td>
<td>Zero or more arguments that were passed to the
<a href="#logging-functions">logging function</a> that invoked this log
handler.</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>Variant...</code> (optional)</td>
<td>Zero or more return values.</td></tr>
</tbody>
</table>

##### Side Effects

All side effects from custom log handlers are programmed by the developers of
the log handlers.

The [default log handlers][logging-function-defaults] `print`, `warn`, and
`error` each have side effects defined by those built-in functions.

##### Errors

All errors thrown from custom log handlers are programmed by the developers of
the log handlers.

The [default log handler][logging-function-defaults] for logging functions of
severity `critical`, `error`, and `fatal` is the built-in Lua function
`error`, which naturally causes an error to be thrown.

##### Caveats

None.

##### Examples

<figure><figcaption><em>Example: Log Handler</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local Logger = require(Helpfully.Logger)

local errorCount = 0

local function errorCounter(logLevel, name, message)
  errorCount = errorCount + 1
   print(("ERROR in %s: %s"):format(name, message))

  if (logLevel >= Logger.LOG_LEVEL.CRITICAL) then
    error("Severe error occurred; unable to continue")
  end
end

logger = Logger({
  level = Logger.LOG_LEVEL.ERROR, -- Log events of severity ERROR or greater.
  name = "MyLib",
  onLogFn = errorCounter })

logger.error("First error") -- print("ERROR in MyLib: First error")
logger.error("Second error") -- print("ERROR in MyLib: Second error")
print(errorCount) -- 2
```

## Learn More

Read the [API Reference][] to learn about Helpfully modules.

Read the [Installation][] instructions to learn how to make Resourceful
available within your projects.

[config-properties]: #config-properties "config Properties"

[enumeration-log_level]: #enumeration-log_level "Enumeration: LOG_LEVEL"

[function-logger]: #function-logger "Function: Logger()"

[log-handler]: #log-handler "Log Handler"

[log-handler-signature]: #signature_2 "Log Handler: Signature"

[logging-functions]: #logging-functions "Logging Functions"

[logging-function-defaults]: #logging-function-defaults
  "Logging Function Defaults"

[API Reference]: ./index.md "API Reference"

[Installation]: ../installation.md "Installation"