# Helpfully: API Reference: Debug

`debug` contains functions to aid debugging.

<table>
<thead>
<tr><th>Function Name</th><th>Description</th></tr>
</thead>
<tbody>
<tr><td><a href='#function-getreflabel'>getRefLabel</a></td>
<td>Returns a human-readable string label describing the type of data
specified.  Useful for reporting mismatched function parameters.</td></tr>
<tr><td><a href='#function-trimerrmsglinenum'>trimErrMsgLineNum</a></td>
<td>Returns a version of the specified error message string, but without a
prefix containing the error source and line number.  Useful for re-throwing
error messages from wrapper functions.</td></tr>
</tbody></table>

## Function: getRefLabel

Returns a human-readable string label describing the type of data specified.
Useful for reporting mismatched function parameters.

##### Signature

```lua
string getRefLabel(string ref)
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>ref</td><td><code>string</code> (optional)</td>
<td>The data for which a human-readable string label should be
returned.</td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>string</code></td>
<td>The human-readable string label for <code>ref</code>.</td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

None.

##### Caveats

`getRefLabel` does not escape special characters within string literal values
of `ref`.

##### Examples

<figure><figcaption><em>Example: getRefLabel</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local debug = require(Helpfully.debug)
local getRefLabel = debug.getRefLabel

print(getRefLabel(nil)) -- nil
print(getRefLabel(false)) -- false
print(getRefLabel(function() end)) -- <function>
print(getRefLabel(5)) -- 5
print(getRefLabel(Instance.new("Part"))) -- <Part> "Part"
print(getRefLabel(game.ReplicatedStorage.Scripts)) -- <Folder> "Scripts"
print(getRefLabel("hello")) -- "hello"
print(getRefLabel({})) -- <table>

-- Caveat: getRefLabel does not escape special characters within strings:
print(getRefLabel('"\\hello"')) -- ""\hello""
```

## Function: trimErrMsgLineNum

Returns a version of the specified error message string, but without a prefix
containing the error source and line number.  Useful for re-throwing error
messages from wrapper functions.

##### Signature

```lua
string trimErrMsgLineNum([string message])
```

##### Parameters

<table>
<thead>
<tr class='header'>
  <th>Name</th><th>Type</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td>message</td><td><code>string</code> (optional)</td>
<td><p>The error message for which the prefix containing the error source and
line number should be removed.</p>
<p>If a non-<code>string</code> value, it will be returned without
modification.</p></td></tr>
</tbody>
</table>

##### Returns

<table>
<thead>
<tr class='header'>
  <th>Type(s)</th><th>Synopsis</th></tr>
</thead>
<tbody>
<tr><td><code>string</code></td>
<td>A version of <code>message</code> without a prefix containing the error
source and line number.</td></tr>
</tbody>
</table>

##### Side Effects

None.

##### Errors

None.

##### Caveats

`trimErrMsgLineNum` performs a simple string substitution to remove the error
message prefix containing an error source and line number.  If the error
source happens to contain a number surrounded on each side by colons,
`trimErrMsgLineNum` will return a `string` with the wrong results, as it will
be impossible to unambiguously determine where the error source string
terminates.

##### Examples

<figure><figcaption><em>Example: trimErrMsgLineNum</em></figcaption></figure>

```lua
local Helpfully = script.Parent.Helpfully
local debug = require(Helpfully.debug)
local trimErrMsgLineNum = debug.trimErrMsgLineNum

print(trimErrMsgLineNum(
  "ServerScriptService.MyLib:100: An error occurred!")) -- An error occurred!
print(trimErrMsgLineNum()) -- nil
print(trimErrMsgLineNum(false)) -- false
print(trimErrMsgLineNum(5)) -- 5
```

## Learn More

Read the [API Reference][] to learn about Helpfully modules.

Read the [Installation][] instructions to learn how to make Resourceful
available within your projects.

[API Reference]: ./index.md "API Reference"

[Installation]: ../installation.md "Installation"