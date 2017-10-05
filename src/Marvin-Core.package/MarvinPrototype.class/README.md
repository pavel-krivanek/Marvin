p1 := MarvinPrototype new.
p1 AddAssignSlot: #pData value: 12.
p1 AddAssignSlot: #data value: 1.
p1 AddMethod: 'pMsg1 
	self data: 64 + self pData.
	'.

p2 := MarvinPrototype new.
p2 AddMethod: 'pMsg2
	^ self pMsg1'.

p3 := MarvinPrototype new.
p3 AddParentSlot: #parent value: p2.

o := MarvinPrototype new.
o AddAssignSlot: #data value: 12.
o AddParentSlot: #parent value: p3.
o AddParentSlot: #parent value: p1.
o AddMethod: 'msg 
	self pMsg2.
	^ self data'.
	
o msg.


parent := MarvinPrototype new.
parent AddAssignSlot: #parentData value: 1.
parent AddMethod: 'msg 
	^ self data'.
	
o := MarvinPrototype new.
o AddParentSlot: #parent value: parent.
o AddAssignSlot: #data value: 2.

o AddMethod: 'msg 
	^ self data + self parentData + super msg'.

o msg.




