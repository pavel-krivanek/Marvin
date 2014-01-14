accessing
translate: instructions 

	instructions do: [ :instr | 
		instr ifNotNil: [
			instr first caseOf: { 
				[#send:] -> [self bcSend: instr].
				[#selfSend:] -> [self bcSelfSend: instr].
				[#resend:] -> [self bcResend: instr].
				[#pushSelf] -> [self bcPushSelf: instr].
				[#pushLiteral:] -> [self processLiteral: instr].
				[#pop] -> [self bcPop: instr].
				[#returnTop] -> [self bcReturnTop: instr].
				[#returnImplicit] -> [self bcReturnImplicit: instr]} ] ]