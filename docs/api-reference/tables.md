# Helpfully: API Reference: Tables

`tables` contains functions for manipulating tables.

<table>
<thead>
<tr><th>Function Name</th><th>Description</th></tr>
</thead>
<tbody>
<tr><td><a href='#function-assign'>assign</a></td>
<td>Returns the first passed <code>table</code> argument, first copying all
non-array properties from each successive <code>table</code> argument passed
to the function.</td></tr>
<tr><td><a href='#function-augment'>augment</a></td>
<td>Returns the first passed <code>table</code> argument, first copying all
non-array properties from each successive <code>table</code> argument passed
to the function, for properties that don't yet exist within the table.
</td></tr>
</tbody></table>

## Function: assign

Returns the first passed `table` argument, first copying all non-array
properties from each successive `table` argument passed to the function.

##### Signature

```lua
table assign(table table1, [table... tables])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>table1</td><td>table</td>
<td>The <code>table</code> to modify and return.</td></tr>
<tr><td>tables</td><td>[table...]</td>
<td>Zero or more <code>table</code> values from which to copy non-array
properties into <code>table1</code>.</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>table</td>
<td><code>table1</code></td></tr>
</tbody>
</table>

##### Side Effects

`table1` will be modified, per the logic of this function.

##### Errors

`assign` throws an error if `table1` is missing or is not a `table`.

##### Caveats

`assign` ignores non-`table` values within `tables`.

##### Examples

<figure><figcaption><em>Example: assign</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local tables = require(Helpfully.tables)
local assign = tables.assign

local t1 = {}
assign(t1, { a = 1 }) -- t1 = { a = 1 }
assign(t1, { b = 2 }, { c = 3 }) -- t1 = { a = 1, b = 2, c = 3 }
assign(t1, { a = 2, b = 2 }, { b = 3 }) -- t1 = { a = 2, b = 3, c = 3 }
assign(t1, false, { c = 4 }, 10) -- t1 = { a = 2, b = 3, c = 4 }
local t2 = assign(t1) -- t2 == t1
```

## Function: augment

Returns the first passed `table` argument, first copying all non-array
properties from each successive `table` argument passed to the function, for
properties that don't yet exist within the table.

##### Signature

```lua
table augment(table table1, [table... tables])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>table1</td><td>table</td>
<td>The <code>table</code> to modify and return.</td></tr>
<tr><td>tables</td><td>[table...]</td>
<td>Zero or more <code>table</code> values from which to copy non-array
properties into <code>table1</code>, for properties that don't yet exist
within <code>table1</code>.</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>table</td>
<td><code>table1</code></td></tr>
</tbody>
</table>

##### Side Effects

`table1` will be modified, per the logic of this function.

##### Errors

`augment` throws an error if `table1` is missing or is not a `table`.

##### Caveats

`augment` ignores non-`table` values within `tables`.

##### Examples

<figure><figcaption><em>Example: augment</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local tables = require(Helpfully.tables)
local augment = tables.augment

local t1 = {}
augment(t1, { a = 1 }) -- t1 = { a = 1 }
augment(t1, { b = 2 }) -- t1 = { a = 1, b = 2 }
augment(t1, { a = 2, c = 3 }, { b = 3 }) -- t1 = { a = 1, b = 2, c = 3 }
augment(t1, false, { d = 4 }, 10) -- t1 = { a = 1, b = 2, c = 3, d = 4 }
local t2 = augment(t1) -- t2 == t1
```

## Learn More

Read the [API Reference](./index.md) to learn about Helpfully modules.

Read the [Installation](../installation.md) instructions to learn how to make
Helpfully available within your projects.