
; PIC16F628A Configuration Bit Settings

; Assembly source line config statements

; CONFIG
  CONFIG  FOSC = INTOSCIO       ; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = ON            ; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is MCLR)
  CONFIG  BOREN = OFF           ; Brown-out Detect Enable bit (BOD disabled)
  CONFIG  LVP = OFF             ; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EE Memory Code Protection bit (Data memory code protection off)
  CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)

// config statements should precede project file includes.
#include <xc.inc>

; When assembly code is placed in a psect, it can be manipulated as a
; whole by the linker and placed in memory.  
;
; In this example, barfunc is the program section (psect) name, 'local' means
; that the section will not be combined with other sections even if they have
; the same name.  class=CODE means the barfunc must go in the CODE container.
; PIC18 should have a delta (addressible unit size) of 1 (default) since they
; are byte addressible.  PIC10/12/16 have a delta of 2 since they are word
; addressible.  PIC18 should have a reloc (alignment) flag of 2 for any
; psect which contains executable code.  PIC10/12/16 can use the default
; reloc value of 1.  Use one of the psects below for the device you use:

psect   barfunc,local,class=CODE,delta=2 ; PIC10/12/16
; psect   barfunc,local,class=CODE,reloc=2 ; PIC18

global _bar ; extern of bar function goes in the C source file
_bar:
    clrf    PORTA		    ;Clear porta
    clrf    PORTB		    ;Clear portb
    
    movlw   0x07		    ;Value for turning off
    movwf   CMCON		    ;comparators in porta
    
    bcf	    STATUS, 6		    ;RP1 off
    bsf	    STATUS, 5		    ;RP0 on, bank 1 selected.
    
    movlw   0x1F		    ;Value for data direction
    
    movwf   TRISA		    ;PortA as an input.
    
    movlw   0x00		    ;Value for data direction
    
    movwf   TRISB		    ;PortB as an output.
    
    bcf	    STATUS, 6		    ;RP1 off
    bcf	    STATUS, 5		    ;RP0 off, bank 0 selected.
    
 principal:
    swapf   PORTA,W
    movwf   PORTB
    goto    principal
    
    
    return
