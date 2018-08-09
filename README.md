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
object AddParentSlot: #parent value: parent.
parent AddReadSlot: #parentData value: 21.
parent AddReadSlot: #factor value: 2.
object AddMethod: 'doIt ^ super parentData * self factor'.

object doIt >>> 42.
```
Note: upper-case characters for method names are choosen because they play a role of primitives

### Parser example

```
MarvinPrototype createLobby.
MarvinParser parse: '
	| object |
	object: (|
		parent* = (|
			parentData = 21.
			factor = 2 |).
		doIt = { ^ resend parentData * factor } |).
	object doIt
	'
```

### More complex delegation example
```
MarvinPrototype createLobby.
MarvinParser parse: '
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
'
```

### Extending of existing standard objects with new methods and multiple inheritance
```
parent := MarvinPrototype new.
parent AddReadSlot: #suffix value: '_suffix'.

object := MarvinPrototype new.
object AddParentSlot: #parent value: parent.
object Inject: Date today.
object AddMethod: 'dayOfWeekName ^ super dayOfWeekName, self suffix'.

object dayOfWeekName.
```
