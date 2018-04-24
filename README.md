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
parent AddReadSlot: #parentData value: 42.
parent AddReadSlot: #data value: 1.
object AddMethod: 'doIt ^ super parentData'.

object doIt >>> 42.
```
Note: upper-case characters for method names are choosen because they play a role of primitives

### Parser example

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