
_interrupt:

;MyProject.c,14 :: 		void interrupt(void)
;MyProject.c,16 :: 		if (RCIE_bit == 1 && RCIF_bit == 1) {
	BTFSS       RCIE_bit+0, BitPos(RCIE_bit+0) 
	GOTO        L_interrupt2
	BTFSS       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L_interrupt2
L__interrupt21:
;MyProject.c,17 :: 		RCIF_bit = 0;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;MyProject.c,18 :: 		ReceiveData = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ReceiveData+0 
;MyProject.c,19 :: 		receive_flag = 1;
	BSF         _receive_flag+0, BitPos(_receive_flag+0) 
;MyProject.c,20 :: 		}
L_interrupt2:
;MyProject.c,22 :: 		if (INTCON.INT0IF) { // Ng?t t? RB0
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt3
;MyProject.c,23 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;MyProject.c,24 :: 		LATE.LATE1 = ~LATE.LATE1;
	BTG         LATE+0, 1 
;MyProject.c,25 :: 		count_RB0++;
	INFSNZ      _count_RB0+0, 1 
	INCF        _count_RB0+1, 1 
;MyProject.c,26 :: 		uart_data = 'S'; // Luu d? li?u c?n g?i
	MOVLW       83
	MOVWF       _uart_data+0 
;MyProject.c,27 :: 		uart_flag = 1; // Ðánh d?u d? g?i trong `main()`
	MOVLW       1
	MOVWF       _uart_flag+0 
	MOVLW       0
	MOVWF       _uart_flag+1 
;MyProject.c,30 :: 		}
L_interrupt3:
;MyProject.c,32 :: 		if (INTCON3.INT1IF) { // Ng?t t? RB1
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt4
;MyProject.c,33 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;MyProject.c,34 :: 		LATE.LATE0 = ~LATE.LATE0;
	BTG         LATE+0, 0 
;MyProject.c,35 :: 		count_RB1++;
	INFSNZ      _count_RB1+0, 1 
	INCF        _count_RB1+1, 1 
;MyProject.c,36 :: 		uart_data = 'B'; // Luu d? li?u c?n g?i
	MOVLW       66
	MOVWF       _uart_data+0 
;MyProject.c,37 :: 		uart_flag = 1; // Ðánh d?u d? g?i trong `main()`
	MOVLW       1
	MOVWF       _uart_flag+0 
	MOVLW       0
	MOVWF       _uart_flag+1 
;MyProject.c,40 :: 		}
L_interrupt4:
;MyProject.c,41 :: 		}
L_end_interrupt:
L__interrupt23:
	RETFIE      1
; end of _interrupt

_main:

;MyProject.c,46 :: 		void main(void)
;MyProject.c,51 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;MyProject.c,52 :: 		CMCON  |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;MyProject.c,55 :: 		PORTB = 0x00; LATB = 0x00;
	CLRF        PORTB+0 
	CLRF        LATB+0 
;MyProject.c,56 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;MyProject.c,59 :: 		PORTE = 0x00; LATE = 0x00;
	CLRF        PORTE+0 
	CLRF        LATE+0 
;MyProject.c,60 :: 		TRISE0_bit = 0;  // LED for Connected
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;MyProject.c,61 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;MyProject.c,63 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;MyProject.c,64 :: 		TRISD0_bit = 1;
	BSF         TRISD0_bit+0, BitPos(TRISD0_bit+0) 
;MyProject.c,65 :: 		LATD=0x00;
	CLRF        LATD+0 
;MyProject.c,67 :: 		LATE.LATD1= 0;
	BCF         LATE+0, 1 
;MyProject.c,69 :: 		PORTC = 0x00; LATC = 0x00;
	CLRF        PORTC+0 
	CLRF        LATC+0 
;MyProject.c,70 :: 		TRISC0_bit = 0;  // Reset pin of ESP8266
	BCF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;MyProject.c,73 :: 		INTCON.INT0IF = 0; // Xóa c? ng?t ngoài
	BCF         INTCON+0, 1 
;MyProject.c,74 :: 		INTCON.INT0IE = 1; // Cho phép ng?t ngoài
	BSF         INTCON+0, 4 
;MyProject.c,75 :: 		INTCON2.INTEDG0 = 1; // Ng?t trên c?nh lên
	BSF         INTCON2+0, 6 
;MyProject.c,78 :: 		INTCON3.INT1IF = 0; // Xóa c? ng?t INT1
	BCF         INTCON3+0, 0 
;MyProject.c,79 :: 		INTCON3.INT1IE = 1; // Cho phép ng?t INT1
	BSF         INTCON3+0, 3 
;MyProject.c,80 :: 		INTCON2.INTEDG1 = 1; // Ng?t khi RB1 có c?nh lên
	BSF         INTCON2+0, 5 
;MyProject.c,83 :: 		PIR2.USBIF = 0; // Xóa c? ng?t USB
	BCF         PIR2+0, 5 
;MyProject.c,84 :: 		PIE2.USBIE = 1; // Cho phép ng?t USB
	BSF         PIE2+0, 5 
;MyProject.c,87 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;MyProject.c,88 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;MyProject.c,89 :: 		UART1_Init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       42
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.c,90 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	DECFSZ      R11, 1, 1
	BRA         L_main5
	NOP
	NOP
;MyProject.c,93 :: 		RC0_bit = 0; delay_ms(100); RC0_bit = 1;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;MyProject.c,95 :: 		delay_ms(1000);  // For ESP8266 stable
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
;MyProject.c,102 :: 		RCIF_bit = 0;      // Clear interrupt bit
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;MyProject.c,103 :: 		RCIE_bit = 1;      // Enable the USART receive interrupt
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;MyProject.c,104 :: 		GIE_bit = 1;       // Enable global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;MyProject.c,105 :: 		PEIE_bit = 1;      // Enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;MyProject.c,107 :: 		while(1) {
L_main8:
;MyProject.c,110 :: 		if (uart_flag) {
	MOVF        _uart_flag+0, 0 
	IORWF       _uart_flag+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
;MyProject.c,111 :: 		uart_flag = 0;
	CLRF        _uart_flag+0 
	CLRF        _uart_flag+1 
;MyProject.c,112 :: 		UART1_Write(uart_data); // G?i ký t? S/B
	MOVF        _uart_data+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,113 :: 		}
L_main10:
;MyProject.c,116 :: 		if (receive_flag) {
	BTFSS       _receive_flag+0, BitPos(_receive_flag+0) 
	GOTO        L_main11
;MyProject.c,117 :: 		receive_flag = 0;
	BCF         _receive_flag+0, BitPos(_receive_flag+0) 
;MyProject.c,118 :: 		if (ReceiveData == '@') {
	MOVF        _ReceiveData+0, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;MyProject.c,119 :: 		LATE.LATE1 = 1;
	BSF         LATE+0, 1 
;MyProject.c,120 :: 		UART1_Write('O');
	MOVLW       79
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,121 :: 		}else if (ReceiveData == '$') {
	GOTO        L_main13
L_main12:
	MOVF        _ReceiveData+0, 0 
	XORLW       36
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;MyProject.c,122 :: 		LATE.LATE1 = 0;
	BCF         LATE+0, 1 
;MyProject.c,123 :: 		UART1_Write('S');
	MOVLW       83
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,124 :: 		}  else if (ReceiveData =='B'){
	GOTO        L_main15
L_main14:
	MOVF        _ReceiveData+0, 0 
	XORLW       66
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;MyProject.c,125 :: 		LATE.LATE0 = 1 ;
	BSF         LATE+0, 0 
;MyProject.c,126 :: 		if (RD0_bit == 1) {
	BTFSS       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_main17
;MyProject.c,127 :: 		UART1_Write('B'); // G?i ký t? 'B' n?u RD0 = 1
	MOVLW       66
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,129 :: 		}
L_main17:
;MyProject.c,131 :: 		}else if(ReceiveData=='C'){
	GOTO        L_main18
L_main16:
	MOVF        _ReceiveData+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
;MyProject.c,132 :: 		LATE.LATE0 = 0 ;
	BCF         LATE+0, 0 
;MyProject.c,133 :: 		if (RD0_bit == 0){
	BTFSC       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_main20
;MyProject.c,134 :: 		UART1_Write('C');
	MOVLW       67
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,135 :: 		}
L_main20:
;MyProject.c,137 :: 		}
L_main19:
L_main18:
L_main15:
L_main13:
;MyProject.c,142 :: 		}
L_main11:
;MyProject.c,143 :: 		}
	GOTO        L_main8
;MyProject.c,144 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
