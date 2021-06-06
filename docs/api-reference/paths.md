# Helpfully: API Reference: Paths

`paths` contains functions for parsing path strings and finding Instances by
path.

<table>
<thead>
<tr><th>Function Name</th><th>Description</th></tr>
</thead>
<tbody>
<tr><td><a href='#function-findbypath'>findByPath</a></td>
<td>Returns an <code>Instance</code> corresponding to the location within the
Roblox project tree hierarchy represented by the specified <code>string</code> 
path, relative to the project root.</td></tr>
<tr><td><a href='#function-findchildbypath'>findChildByPath</a></td>
<td>Returns an <code>Instance</code> corresponding to the location within the
Roblox project tree hierarchy represented by the specified <code>string</code> 
path, relative to the specified <code>Instance</code>.</td></tr>
<tr><td><a href='#function-separatedpath'>separatedPath</a></td>
<td>Returns an array of path components derived from the specified
<code>string</code> path, separated according to the specified path delimiter.
</td></tr>
</tbody></table>

## Function: findByPath

Returns an `Instance` corresponding to the location within the Roblox project
tree hierarchy represented by the specified `string` path, relative to the
project root.

##### Signature

```lua
Instance findByPath([string path], [string separator])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>path</td><td><code>string</code> (optional)</td>
<td><p>The location within the Roblox project tree hierarchy, relative to the
project root, at which to find and return the corresponding
<code>Instance</code>.</p>
<p>If present, must begin with character "<code>:</code>" (colon), which
represents the name of a service.</p>
<p>If missing or empty, <code>nil</code> will be returned.</p>
<p>Each percent character "<code>%</code>" that appears within
<code>path</code> is interpreted as an escape sequence, which allows the
character that follows to be interpreted literally instead of as a path
separator.  This is useful if any <code>Instance</code> within the Roblox
project tree hierarchy has a name that contains <code>separator</code>.</p>
</td></tr>
<tr><td>separator</td><td><code>string</code> (optional)</td>
<td><p>An optional one-character <code>string</code> delimiter by which
<code>path</code> will be separated.  Defaults to "<code>.</code>" (period).
</p>
<p>If specified to be the percent character "<code>%</code>", percent
characters that appear within <code>path</code> <em>will not</em> be treated
as escape sequences, but instead will be treated as path separators.</p>
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
<tr><td><code>Instance</code> or <code>nil</code>, <code>string</code></td>
<td><p>The <code>Instance</code> corresponding to <code>path</code>.</p>
<p>If the specified <code>Instance</code> could not be found, this function
returns a list containing <code>nil</code> and the <code>string</code> path
component name that could not be found.</p></td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

`findByPath` will throw an error if `path` is specified but is not a `string`,
or contains "`\b`" (bell character), or begins with a character other than the
colon character `:`, which represents the name of a service.

`findByPath` will throw an error if `separator` is specified but is not a
single-character `string`, or is "`\b`" (bell character).

##### Caveats

None.

##### Examples

<figure><figcaption><em>Example: findByPath</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local paths = require(Helpfully.paths)
local findByPath = paths.findByPath

local MyLib = game:GetService("ReplicatedStorage")
  :FindFirstChild("Scripts", false)
  :FindFirstChild("MyLib", false)

print(MyLib == findByPath(":ReplicatedStorage.Scripts.MyLib")) -- true
print(MyLib == findByPath(":ReplicatedStorage/Scripts/MyLib", "/")) -- true
```

## Function: findChildByPath

Returns an `Instance` corresponding to the location within the Roblox project
tree hierarchy represented by the specified `string` path, relative to the
specified `Instance`.

##### Signature

```lua
Instance findChildByPath(Instance instance, [string path], [string separator])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>instance</td><td><code>Instance</code></td>
<td><p>The <code>Instance</code> from which <code>path</code> will be
relative.</p>
<tr><td>path</td><td><code>string</code> (optional)</td>
<td><p>The location within the Roblox project tree hierarchy, relative to
<code>instance</code>, at which to find and return the corresponding
<code>Instance</code>.</p>
<p>If present and beginning with character "<code>:</code>" (colon), which
represents the name of a service, this function will ignore
<code>instance</code> and instead will operate identically to
<code>findByPath</code>.</p>
<p>If missing or empty, <code>instance</code> will be returned.</p>
<p>Each percent character "<code>%</code>" that appears within
<code>path</code> is interpreted as an escape sequence, which allows the
character that follows to be interpreted literally instead of as a path
separator.  This is useful if any <code>Instance</code> within the Roblox
project tree hierarchy has a name that contains <code>separator</code>.</p>
</td></tr>
<tr><td>separator</td><td><code>string</code> (optional)</td>
<td><p>A one-character <code>string</code> delimiter by which <code>path</code>
will be separated.  Defaults to "<code>.</code>" (period).</p>
<p>If specified to be the percent character "<code>%</code>", percent
characters that appear within <code>path</code> <em>will not</em> be treated
as escape sequences, but instead will be treated as path separators.</p>
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
<tr><td><code>Instance</code></td>
<td>The <code>Instance</code> corresponding to <code>path</code>.</td></tr>
<tr><td>nil, string</td>
<td>If the specified <code>Instance</code> could not be found, this function
returns a list containing <code>nil</code> and the <code>string</code> path
component name that could not be found.</td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

`findChildByPath` will throw an error if `instance` is missing or is not an
`Instance`.

`findChildByPath` will throw an error if `path` is specified but is not a
`string`, or contains "`\b`" (bell character).

`findChildByPath` will throw an error if `separator` is specified but is not a
single-character `string`, or is "`\b`" (bell character).

##### Caveats

None. 

##### Examples

<figure><figcaption><em>Example: findChildByPath</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local paths = require(Helpfully.paths)
local findChildByPath = paths.findChildByPath

local shared = game:GetService("ReplicatedStorage")
local scripts = shared:FindFirstChild("Scripts", false)
local MyLib = scripts:FindFirstChild("MyLib", false)

print(scripts == findChildByPath(scripts)) -- true
print(scripts == findChildByPath(shared, "Scripts")) -- true
print(MyLib == findChildByPath(scripts, "MyLib")) -- true
print(MyLib == findChildByPath(shared, "Scripts.MyLib")) -- true
print(MyLib == findChildByPath(shared, "Scripts/MyLib", "/")) -- true

-- The following invocation ignores "MyLib", because "path" begins with
-- service ":ReplicatedStorage", and thus operates like "findByPath".
print(scripts == findChildByPath(MyLib, ":ReplicatedStorage.Scripts")) -- true
```

## Function: separatedPath

Returns an array of path components derived from the specified `string` path,
separated according to the specified path delimiter.

##### Signature

```lua
table separatedPath([string path], [string separator])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>path</td><td><code>string</code> (optional)</td>
<td><p>The <code>string</code> path to separate by <code>separator</code>.</p>
<p>If missing or empty, <code>{}</code> will be returned.</p>
<p>Each percent character "<code>%</code>" that appears within
<code>path</code> is interpreted as an escape sequence, which allows the
character that follows to be interpreted literally instead of as a path
separator.</p>
</td></tr>
<tr><td>separator</td><td><code>string</code> (optional)</td>
<td><p>A one-character <code>string</code> delimiter by which <code>path</code>
will be separated.  Defaults to "<code>.</code>" (period).</p>
<p>If specified to be the percent character "<code>%</code>", percent
characters that appear within <code>path</code> <em>will not</em> be treated
as escape sequences, but instead will be treated as path separators.</p>
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
<tr><td><code>table</code></td>
<td>The array of path components derived from <code>path</code>, separated
according the <code>separator</code>.  Empty path elements are omitted.
</td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

`separatedPath` will throw an error if `path` is specified but is not a
`string`, or contains "`\b`" (bell character).

`separatedPath` will throw an error if `separator` is specified but is not a
single-character `string`, or is "`\b`" (bell character).

##### Caveats

`separatedPath` omits empty path components from its return value, which means
that it cannot be used to determine whether the specified `path` starts with
or ends with the specified `separator`.

##### Examples

<figure><figcaption><em>Example: separatedPath</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local paths = require(Helpfully.paths)
local separatedPath = paths.separatedPath

local path = separatedPath(":ReplicatedStorage.Scripts.MyLib")
print(table.concat(path, "/")) -- :ReplicatedStorage/Scripts/MyLib

path = separatedPath(":ReplicatedStorage/Scripts/MyLib", "/")
print(table.concat(path, ".")) -- :ReplicatedStorage.Scripts.MyLib

local path = separatedPath(":ReplicatedStorage.Scripts%.MyLib")
print(table.concat(path, "/")) -- :ReplicatedStorage/Scripts.MyLib
```
## Learn More

Read the [API Reference][] to learn about Helpfully modules.

Read the [Installation][] instructions to learn how to make Resourceful
available within your projects.

[API Reference]: ./index.md "API Reference"

[Installation]: ../installation.md "Installation"