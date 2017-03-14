.section .init
.global _start

_start:	
	/*Se il codice non viene eseguito dal core 0 allora vai in loop*/
	mrc p15, #0, r0, c0, c0, #5
	ands r0, #3
	bne _loopCore
	
	/*setto il gpio pin 47 come pin di output*/
	bl GetIndirizzoGpio
	mov r1, #1
	lsl r1, #21
	str r1, [r0, #16]

_accendi:	
	/*accendo il led*/
	mov r1, #1
	lsl r1, #15
	str r1, [r0, #32]
	ldr r2, =0x3f000

_loop1:
	sub r2, #0x1
	teq r2, #0
	beq _spegni
	b _loop1
	
_spegni:
	/*spengo il led*/
	mov r1, #1
	lsl r1, #15
	str r1, [r0, #44]
	ldr r2, =0x3f000
	
_loop2:
	sub r2, #0x1
	teq r2, #0
	beq _accendi
	b _loop2
	
_loopCore:
	b _loopCore
	
	
