# Helpfully: API Reference: Functions

`functions` contains functions for creating functions.

<table>
<thead>
<tr><th>Function Name</th><th>Description</th></tr>
</thead>
<tbody>
<tr><td><a href='#function-bind'>bind</a></td>
<td>Returns a new bound <code>function</code> that invokes the specified
<code>function</code> with the specified arguments.</td></tr>
<tr><td><a href='#function-binddrop'>bindDrop</a></td>
<td>Returns a new bound <code>function</code> that invokes the specified
<code>function</code> with the specified arguments, but removes the specified
number of return values from the bound function.</td></tr>
<tr><td><a href='#function-bindkeep'>bindKeep</a></td>
<td>Returns a new bound <code>function</code> that invokes the specified
<code>function</code> with the specified arguments, keeping only the specified
number of return values from the bound function.</td></tr>
<tr><td><a href='#function-noop'>noOp</a></td>
<td>A function that literally does nothing.</td></tr>
</tbody></table>

## Function: bind

Returns a new bound `function` that invokes the specified `function` with the
specified arguments.

##### Signature

```lua
function bind(function fn, [Variant... args])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>fn</td><td><code>function</code></td>
<td>A new bound <code>function</code> that invokes <code>fn</code> with
<code>args</code>.</td></tr>
<tr><td>args</td><td><code>Variant...</code> (optional)</td>
<td>Zero or more arguments to pass to <code>fn</code> when invoking it.
</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>function</code></td>
<td>The function bound to <code>fn</code>.</td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

`bind` will throw an error if `fn` is missing or is not a `function`.

##### Caveats

Calling `bind` with five or more arguments will incur a slight performance
penalty during each invocation of the bound function, since the bound function
must `pack`, `move`, and `unpack` the values within `args` into the arguments
separately passed to the bound function, every time the bound function is
invoked.

Note that the common scenario of calling `bind` with less than five arguments
has been optimized, and does not incur this performance penalty. 

##### Examples

<figure><figcaption><em>Example: bind</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local functions = require(Helpfully.functions)
local bind = functions.bind

local function multiply(num1, num2)
  return num1 * num2
end

local double = bind(multiply, 2)
print(double(5)) -- 10

local function valstr(...)
  return table.concat({ ... }, ":")
end

local bound = bind(valstr, "hello", "there")
print(bound("user")) -- "hello:there:user"
```

## Function: bindDrop

Returns a new bound `function` that invokes the specified `function` with the
specified arguments, but removes the specified number of return values from
the bound function.

##### Signature

```lua
function bindDrop(number n, function fn, [Variant... args])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>n</td><td><code>number</code></td>
<td><p>The number of return values to remove from the function bound to
<code>fn</code>.</p>
<p>When positive or <code>0</code>, removes the first <code>n</code> values
from the beginning of the bound function's return values.</p></td></tr>
<tr><td>fn</td><td><code>function</code></td>
<td>A new <code>function</code> that invokes <code>fn</code> with
<code>args</code>.</td></tr>
<tr><td>args</td><td><code>Variant...</code> (optional)</td>
<td>Zero or more arguments to pass to <code>fn</code> when invoking it.
</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>function</code></td>
<td>The function bound to <code>fn</code>.</td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

`bindDrop` will throw an error if `n` is less than `0`.

`bindDrop` will throw an error if `fn` is missing or is not a `function`.

##### Caveats

All the [performance caveats of `bind`](#caveats) also hold true for
`bindDrop`.

Additionally, the act of altering the number of return values from the bound
function also incurs a slight performance penalty, due to needing to `pack`
and `unpack` the bound function's return values.

##### Examples

<figure><figcaption><em>Example: bindDrop</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local functions = require(Helpfully.functions)
local bindDrop = functions.bindDrop

local function divisionStats(d, n)
  local isPositive = (n / d) > 0
  local isWhole = n % d == 0
  return isPositive, isWhole
end

print(divisionStats(2, 4)) -- true    true

local isEven = bindDrop(1, divisionStats, 2)
print(isEven(4)) -- true

local function greet(greeting, name)
  return ("%s, %s!"):format(greeting or "Hello", name or "person")
end

print(xpcall(greet, error)) -- "true    Hello, person!"

local safeGreet = bindDrop(1, xpcall, greet, error)
print(safeGreet()) -- Hello, person!

safeGreet = bindDrop(1, xpcall, greet, error, "Hi")
print(safeGreet("user")) -- Hi, user!
```

## Function: bindKeep

Returns a new bound `function` that invokes the specified `function` with the
specified arguments, keeping only the specified number of return values from
the bound function.

##### Signature

```lua
function bindKeep(number n, function fn, [Variant... args])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>n</td><td><code>number</code></td>
<td><p>The number of return values to keep from the function bound to
<code>fn</code>.</p>
<p>When positive or <code>0</code>, keeps only the first <code>n</code> values
from the beginning of the bound function's return values.</p>
<p>When negative, keeps only the last <code>math.abs(n)</code> values from
the end of the bound function's return values.</p>
<p>When <code>n</code> or <code>math.abs(n)</code> is greater than the number
of arguments received by the bound function, keeps all return values.</p>
</td></tr>
<tr><td>fn</td><td><code>function</code></td>
<td>A new <code>function</code> that invokes <code>fn</code> with
<code>args</code>.</td></tr>
<tr><td>args</td><td><code>Variant...</code> (optional)</td>
<td>Zero or more arguments to pass to <code>fn</code> when invoking it.
</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>function</code></td>
<td>The function bound to <code>fn</code>.</td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

`bindKeep` will throw an error if `fn` is missing or is not a `function`.

##### Caveats

All the [performance caveats of `bind`](#caveats) also hold true for
`bindKeep`.

Additionally, the act of altering the number of return values from the bound
function also incurs a slight performance penalty, due to needing to `pack`
and `unpack` the bound function's return values.

##### Examples

<figure><figcaption><em>Example: bindKeep</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local functions = require(Helpfully.functions)
local bindKeep = functions.bindKeep

local function greetPets(greeting, ...)
  local greetings = {}

  for _, pet in ipairs({...}) do
    local petGreeting = ("%s, %s!"):format(greeting or "Hello", pet or "pet")
    greetings[#greetings + 1] = petGreeting
  end

  return table.unpack(greetings, 1, #greetings)
end

print(greetPets("Hi", "cat", "dog", "bird", "mouse"))
-- Hi, cat!    Hi, dog!    Hi, bird!    Hi, mouse!

local hiPets = bindKeep(3, greetPets, "Hi", "cat", "dog")
print(hiPets("bird", "mouse")) -- Hi, cat!    Hi, dog!    Hi, bird!

hiPets = bindKeep(-3, greetPets, "Hi", "cat", "dog")
print(hiPets("bird", "mouse")) -- Hi, dog!    Hi, bird!    Hi, mouse!
```

## Function: noOp

A function that literally does nothing.

##### Signature

```lua
void noOp()
```

##### Parameters

None.

##### Returns

None.

##### Side Effects

None.

##### Errors

None.

##### Caveats

None.

##### Examples

<figure><figcaption><em>Example: noOp</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local functions = require(Helpfully.functions)
local noOp = functions.noOp

print(noOp()) -- Prints nothing.
```

## Learn More

Read the [API Reference][] to learn about Helpfully modules.

Read the [Installation][] instructions to learn how to make Resourceful
available within your projects.

[API Reference]: ./index.md "API Reference"

[Installation]: ../installation.md "Installation"