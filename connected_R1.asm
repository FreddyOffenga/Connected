; Connected
; 128 bytes intro for Outline 2k22
; F#READY 2022-5-23

; Release version 1

; v4 - 128 bytes
; removed run address - 122 bytes
; added sound

; v3 - 128 bytes
; ukraine colors, optimised some bytes
; use clock to switch to ukraine colors after 5 seconds

; v2 - 115 bytes
; other approach, use gfx 2 and enable scrollbits
; choose chars to get a nice pattern

; v1
; F#READY 2-2-2019
	
GPRIOR      = 623

; 6 is /, 7 = \
CHAR_NUMBER = 6
CHAR_BIT    = 1

            org $80

main
            lda #2
            jsr $ef9c

            dec 559
            
            lda #$e2
            sta 756

            ldy #0
filler      
            tya
            and #CHAR_BIT
            ora #CHAR_NUMBER
            
mask_eor = *+1        
            eor #0            
            sta (88),y
            
current_x   = *+1
            ldx #20
            dex
            bne noflip
            ldx #20
            
            lda mask_eor
            eor #CHAR_BIT
            sta mask_eor
noflip
            stx current_x

            iny
            bne filler
            
            lda #$57+$20
            sta $be5c+3
            
            ldx #10
            lda #$17+$20
setscrol
            sta $be5c+6,x
            dex
            bpl setscrol

loop
            ldx $d40b
            bne loop
            
more
            lda 19
            beq waitforit

            tya

            bpl topcol
            ldx #$d8
            dta $2c     ; bit adr
topcol      ldx #$88
            stx kolor

waitforit
            stx $d01f

            tya
            adc 20
            lsr
	    and #15
	    tax			
	    lda wave,x

    	    sta $d40a			
	    sta $d404
	    eor #3
	    sta $d405

            asl

kolor = *+1
	    ora #$22
	    sta $d016
            
	    iny
	    bne more
	    beq loop
		
wave
            dta $01,$01,$02,$02
            dta $03,$03,$03,$02
            dta $02,$02,$01,$01
;           dta $00,$00,$00,$00
        	
        	
            ;run main
