as yet unclassified
setText: aText
  str:=aText asString.
  Compiler evaluate: str for: protobj logged: false.
  ^true