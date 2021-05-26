# Helpfully: Installation

## Choosing Where To Install Helpfully

Within a Roblox Studio project, Helpfully can be installed to a single,
shared location where it can be accessed by all project modules that will use
it.  Conversely, it can also be installed as a child within each module that
will use it.

Installing Helpfully to a shared location can ensure that a single, known
version of Helpfully is used across all modules, while also reducing the
file size of the Roblox project.

Installing Helpfully as a child within each module that uses Helpfully may
help simplify the sharing of such modules with other projects, which can be
useful for module libraries.

## Choosing How To Install Helpfully

Helpfully can be installed by loading a Helpfully model file into Roblox
Studio, or by using a developer tool to synchronize Helpfully's source code
into a Roblox Studio project.

### Loading A Helpfully Model File Into Roblox Studio

1. Obtain the latest version of `Helpfully.rbxmx` from the [
GitHub Release Page](https://github.com/BetterThanReal/Helpfully/releases)
2. Insert the model into the chosen parent object(s) within a Roblox Studio
project

### Using A Developer Tool To Synchronize Helpfully

Developers who use tools such as [Rojo](https://rojo.space/) or
[Remodel](https://github.com/rojo-rbx/remodel) can copy the Helpfully source
code to the appropriate location(s):

1. [Download](https://github.com/BetterThanReal/Helpfully/releases) or
[clone](https://github.com/BetterThanReal/Helpfully) the source code for
Helpfully into a local directory
2. Copy or synchronize the `src/Helpfully` folder into a Roblox Studio
project at the appropriate location(s).  Ensure that the new `Instance`
containing Helpfully is named `Helpfully`.

## Invoking Helpfully After Installation

Helpfully can be invoked similarly to any other Roblox module.

Assuming the following project script hierarchy:

```text
> Lib
  > MyLib
    > Helpfully
    Script
```

`Lib.MyLib.Script` can invoke `Lib.MyLib.Helpfully` as needed:

<figure><figcaption><em>Lib.MyLib.Script:</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local debug = require(Helpfully.debug)
local functions = require(Helpfully.functions)
local Logger = require(Helpfully.Logger)
local paths = require(Helpfully.paths)
local tables = require(Helpfully.tables)
```

## Learn More

Read the [API Reference](./api-reference/index.md) to learn about Helpfully modules.