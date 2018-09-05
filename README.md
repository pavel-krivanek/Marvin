# Marvin

Prototype system based on Self for Pharo

### How to load

```
Metacello new
    baseline: 'Marvin';
    repository: 'github://pavel-krivanek/Marvin/src';
    load
```

### Direct prototypes usage from Pharo
```
| parent object |

parent := MarvinPrototype new.
object := MarvinPrototype new.
object _AddParentSlot: #parent value: parent.
parent _AddReadSlot: #parentData value: 21.
parent _AddReadSlot: #factor value: 2.
object _AddMethod: 'doIt ^ super parentData * self factor'.

object doIt >>> 42.
```
Note: upper-case characters for method names are choosen because they play a role of primitives

### Parser example

```
MarvinPrototype createLobby.
(MarvinParser parse: '
	| object |
	object: (|
		parent* = (|
			parentData = 21.
			factor = 2 |).
		doIt = { ^ resend parentData * factor } |).
	object doIt
') >>> 42
```

### More complex delegation example
```
MarvinPrototype createLobby.
(MarvinParser parse: '
	| p1 |
	p1: (|
		parent* = (|
			parent* = (|
				a = { ^a }.
				b = 1 |).
			a = { ^resend a } |).
		a = (|
			a = 3.
			b = 4 |).
		method = { ^resend a a } |).
	p1 method
') >>> 3
```

### Extending of existing standard objects with new methods and multiple inheritance
```
objectToExtend := Date today.

parent := MarvinPrototype new.
parent _AddMethod: 'suffix ^ self suffixString asUppercase'.
parent _AddReadSlot: #suffixString value: '_suffix'.

object := MarvinPrototype new.
object _AddParentSlot: #parent value: parent.
object _Inject: objectToExtend.
object _AddMethod: 'dayOfWeekName ^ super dayOfWeekName, self suffix'.

object dayOfWeekName >>> 'Thursday_SUFFIX'
```
