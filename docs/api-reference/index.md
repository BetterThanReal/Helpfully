# Helpfully: API Reference

Helpfully consists of the following modules:

| Module | Description |
| --- | --- |
| [debug][] | Functions to aid debugging |
| [functions][] | Functions for creating functions |
| [Logger][] | A class for logging information, warnings, and errors |
| [paths][] | Functions for parsing path strings and finding Instances by path |
| [tables][] | Functions for manipulating tables |

## Loading The Module

Invoking `require` upon the `Helpfully` module will return a `table` with all
of the modules as properties:

```lua
-- Requiring the modules all at once:
local Helpfully = require(script.Parent.Helpfully)
local debug = Helpfully.debug
local functions = Helpfully.functions
local Logger = Helpfully.Logger
local paths = Helpfully.paths
local tables = Helpfully.tables
```

Modules can also be required individually:

```lua
-- Requiring the modules manually, on-demand:
local Helpfully = script.Parent.Helpfully
local debug = require(Helpfully.debug)
local functions = require(Helpfully.functions)
local Logger = require(Helpfully.Logger)
local paths = require(Helpfully.paths)
local tables = require(Helpfully.tables)
```

## Learn More

Read the [Installation][] instructions to learn how to make Resourceful
available within your projects.

[debug]: ./debug.md "API Reference: debug"

[functions]: ./functions.md "API Reference: functions"

[Logger]: ./Logger.md "API Reference: Logger"

[paths]: ./paths.md "API Reference: paths"

[tables]: ./tables.md "API Reference: tables"

[Installation]: ../installation.md "Installation"