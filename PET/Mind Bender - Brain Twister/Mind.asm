		processor 6502
		
		ORG $5000
		
		lda #$80	;screen start
		sta $01
		lda #$00
		sta $00
		tay
loop	lda #$01	;base char
		sta ($00),y
		iny
		cpy #$00
		bne loop
		inc $01
		lda $01
		cmp #$88	;screen full?
		bne loop
		lda #$0c
		sta $e84c	;set graphic
loop2	lda $e84c
		eor #$02	;toggle toggle
		sta $e84c	;textmode
		lda $97		;key pressed?
		cmp #$ff
		beq lop		;no, do delay
		cmp #$31	;yes, is it a 1?
		bne next	;no, change delay
		rts			;yes, end
next	dec $02		;alter delay
lop		ldx $02		;and do one
lop1	dex
		bne lop1
		jmp loop2