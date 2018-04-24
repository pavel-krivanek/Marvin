# Marvin

Prototype system based on Self for Pharo

### How to load

```
Metacello new
    baseline: 'Marvin';
    repository: 'github://pavel-krivanek/Marvin/src';
    load
```

### Delegation example

```
MarvinPrototype createLobby.
MarvinParser parse: '
	| p1 |
	p1: (|
		parent* = (|
			parent* = (|
				a = {^a}.
				b = 1 |).
			a = {^resend a} |).
		a = (|
			a = 3.
			b = 4 |).
		method = {^resend a a} |).
	p1 method
'
```