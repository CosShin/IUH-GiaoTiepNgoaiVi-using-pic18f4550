
__esp8266_putch:

;MyProject.c,40 :: 		void _esp8266_putch(char bt)
;MyProject.c,42 :: 		while(!TXIF_bit);   // Gi? chuong trình cho d?n khi b? d?m TX tr?ng
L__esp8266_putch0:
	BTFSC       TXIF_bit+0, BitPos(TXIF_bit+0) 
	GOTO        L__esp8266_putch1
	GOTO        L__esp8266_putch0
L__esp8266_putch1:
;MyProject.c,43 :: 		TXREG = bt;         // Ghi d? li?u vào b? d?m truy?n
	MOVF        FARG__esp8266_putch_bt+0, 0 
	MOVWF       TXREG+0 
;MyProject.c,44 :: 		}
L_end__esp8266_putch:
	RETURN      0
; end of __esp8266_putch

__esp8266_getch:

;MyProject.c,49 :: 		char _esp8266_getch()
;MyProject.c,51 :: 		if(OERR_bit)        // Ki?m tra l?i
	BTFSS       OERR_bit+0, BitPos(OERR_bit+0) 
	GOTO        L__esp8266_getch2
;MyProject.c,53 :: 		CREN_bit = 0;   // N?u l?i -> Reset
	BCF         CREN_bit+0, BitPos(CREN_bit+0) 
;MyProject.c,54 :: 		CREN_bit = 1;   // N?u l?i -> Reset
	BSF         CREN_bit+0, BitPos(CREN_bit+0) 
;MyProject.c,55 :: 		}
L__esp8266_getch2:
;MyProject.c,57 :: 		while(!RCIF_bit);   // Gi? chuong trình cho d?n khi b? d?m RX có d? li?u
L__esp8266_getch3:
	BTFSC       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L__esp8266_getch4
	GOTO        L__esp8266_getch3
L__esp8266_getch4:
;MyProject.c,58 :: 		return RCREG;       // Nh?n d? li?u và g?i v? hàm chính
	MOVF        RCREG+0, 0 
	MOVWF       R0 
;MyProject.c,59 :: 		}
L_end__esp8266_getch:
	RETURN      0
; end of __esp8266_getch

_ESP8266_send_string:

;MyProject.c,62 :: 		void ESP8266_send_string(char* st_pt)
;MyProject.c,64 :: 		while(*st_pt) // if there is a char
L_ESP8266_send_string5:
	MOVFF       FARG_ESP8266_send_string_st_pt+0, FSR0L+0
	MOVFF       FARG_ESP8266_send_string_st_pt+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ESP8266_send_string6
;MyProject.c,66 :: 		_esp8266_putch(*st_pt++); // process it as a byte data
	MOVFF       FARG_ESP8266_send_string_st_pt+0, FSR0L+0
	MOVFF       FARG_ESP8266_send_string_st_pt+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG__esp8266_putch_bt+0 
	CALL        __esp8266_putch+0, 0
	INFSNZ      FARG_ESP8266_send_string_st_pt+0, 1 
	INCF        FARG_ESP8266_send_string_st_pt+1, 1 
;MyProject.c,67 :: 		}
	GOTO        L_ESP8266_send_string5
L_ESP8266_send_string6:
;MyProject.c,68 :: 		}
L_end_ESP8266_send_string:
	RETURN      0
; end of _ESP8266_send_string

__esp8266_print:

;MyProject.c,78 :: 		void _esp8266_print(unsigned char *ptr) {
;MyProject.c,79 :: 		while (*ptr != 0)
L__esp8266_print7:
	MOVFF       FARG__esp8266_print_ptr+0, FSR0L+0
	MOVFF       FARG__esp8266_print_ptr+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__esp8266_print8
;MyProject.c,81 :: 		_esp8266_putch(*ptr++);
	MOVFF       FARG__esp8266_print_ptr+0, FSR0L+0
	MOVFF       FARG__esp8266_print_ptr+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG__esp8266_putch_bt+0 
	CALL        __esp8266_putch+0, 0
	INFSNZ      FARG__esp8266_print_ptr+0, 1 
	INCF        FARG__esp8266_print_ptr+1, 1 
;MyProject.c,82 :: 		}
	GOTO        L__esp8266_print7
L__esp8266_print8:
;MyProject.c,83 :: 		}
L_end__esp8266_print:
	RETURN      0
; end of __esp8266_print

__esp8266_waitFor:

;MyProject.c,85 :: 		inline uint16_t _esp8266_waitFor(unsigned char *string)
;MyProject.c,87 :: 		unsigned char so_far = 0;
	CLRF        _esp8266_waitFor_so_far_L0+0 
	CLRF        _esp8266_waitFor_counter_L0+0 
	CLRF        _esp8266_waitFor_counter_L0+1 
;MyProject.c,90 :: 		do
L__esp8266_waitFor9:
;MyProject.c,92 :: 		received = _esp8266_getch();
	CALL        __esp8266_getch+0, 0
;MyProject.c,93 :: 		counter++;
	INFSNZ      _esp8266_waitFor_counter_L0+0, 1 
	INCF        _esp8266_waitFor_counter_L0+1, 1 
;MyProject.c,94 :: 		if (received == string[so_far])
	MOVF        _esp8266_waitFor_so_far_L0+0, 0 
	ADDWF       FARG__esp8266_waitFor_string+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG__esp8266_waitFor_string+1, 0 
	MOVWF       FSR2L+1 
	MOVF        R0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__esp8266_waitFor12
;MyProject.c,96 :: 		so_far++;
	INCF        _esp8266_waitFor_so_far_L0+0, 1 
;MyProject.c,97 :: 		}
	GOTO        L__esp8266_waitFor13
L__esp8266_waitFor12:
;MyProject.c,100 :: 		so_far = 0;
	CLRF        _esp8266_waitFor_so_far_L0+0 
;MyProject.c,101 :: 		}
L__esp8266_waitFor13:
;MyProject.c,103 :: 		while (string[so_far] != 0);
	MOVF        _esp8266_waitFor_so_far_L0+0, 0 
	ADDWF       FARG__esp8266_waitFor_string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG__esp8266_waitFor_string+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__esp8266_waitFor9
;MyProject.c,104 :: 		return counter;
	MOVF        _esp8266_waitFor_counter_L0+0, 0 
	MOVWF       R0 
	MOVF        _esp8266_waitFor_counter_L0+1, 0 
	MOVWF       R1 
;MyProject.c,105 :: 		}
L_end__esp8266_waitFor:
	RETURN      0
; end of __esp8266_waitFor

_esp8266_restart:

;MyProject.c,114 :: 		void esp8266_restart(void)
;MyProject.c,116 :: 		_esp8266_print("AT+RST\r\n");     // Command
	MOVLW       ?lstr1_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr1_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,117 :: 		_esp8266_waitFor("OK");           // Wait for "OK"
	MOVLW       ?lstr2_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr2_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,118 :: 		_esp8266_waitFor("ready");        // Wait for "ready"
	MOVLW       ?lstr3_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr3_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,119 :: 		}
L_end_esp8266_restart:
	RETURN      0
; end of _esp8266_restart

_esp8266_isStarted:

;MyProject.c,124 :: 		void esp8266_isStarted(void)
;MyProject.c,126 :: 		_esp8266_print("AT\r\n");         // Command
	MOVLW       ?lstr4_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr4_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,127 :: 		_esp8266_waitFor("OK");           // Wait for "OK"
	MOVLW       ?lstr5_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr5_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,128 :: 		}
L_end_esp8266_isStarted:
	RETURN      0
; end of _esp8266_isStarted

_esp8266_echoCmds:

;MyProject.c,138 :: 		void esp8266_echoCmds(bool echo)
;MyProject.c,140 :: 		_esp8266_print("ATE");            // Command
	MOVLW       ?lstr6_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr6_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,141 :: 		if (echo)
	MOVF        FARG_esp8266_echoCmds_echo+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_esp8266_echoCmds14
;MyProject.c,143 :: 		_esp8266_putch('1');
	MOVLW       49
	MOVWF       FARG__esp8266_putch_bt+0 
	CALL        __esp8266_putch+0, 0
;MyProject.c,144 :: 		}
	GOTO        L_esp8266_echoCmds15
L_esp8266_echoCmds14:
;MyProject.c,147 :: 		_esp8266_putch('0');
	MOVLW       48
	MOVWF       FARG__esp8266_putch_bt+0 
	CALL        __esp8266_putch+0, 0
;MyProject.c,148 :: 		}
L_esp8266_echoCmds15:
;MyProject.c,149 :: 		_esp8266_print("\r\n");
	MOVLW       ?lstr7_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr7_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,150 :: 		_esp8266_waitFor("OK");           // Wait for "OK"
	MOVLW       ?lstr8_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr8_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,151 :: 		}
L_end_esp8266_echoCmds:
	RETURN      0
; end of _esp8266_echoCmds

_esp8266_mode:

;MyProject.c,162 :: 		void esp8266_mode(unsigned char mode)
;MyProject.c,164 :: 		_esp8266_print("AT+CWMODE=");     // Command
	MOVLW       ?lstr9_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr9_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,165 :: 		_esp8266_putch(mode + '0');
	MOVLW       48
	ADDWF       FARG_esp8266_mode_mode+0, 0 
	MOVWF       FARG__esp8266_putch_bt+0 
	CALL        __esp8266_putch+0, 0
;MyProject.c,166 :: 		_esp8266_print("\r\n");
	MOVLW       ?lstr10_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr10_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,167 :: 		_esp8266_waitFor("OK");           // Wait for "OK"
	MOVLW       ?lstr11_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr11_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,168 :: 		}
L_end_esp8266_mode:
	RETURN      0
; end of _esp8266_mode

_esp8266_trans_mode:

;MyProject.c,171 :: 		void esp8266_trans_mode(unsigned char mode)
;MyProject.c,173 :: 		_esp8266_print("AT+CIPMODE=");    // Command
	MOVLW       ?lstr12_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr12_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,174 :: 		_esp8266_putch(mode + '0');
	MOVLW       48
	ADDWF       FARG_esp8266_trans_mode_mode+0, 0 
	MOVWF       FARG__esp8266_putch_bt+0 
	CALL        __esp8266_putch+0, 0
;MyProject.c,175 :: 		_esp8266_print("\r\n");
	MOVLW       ?lstr13_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr13_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,176 :: 		_esp8266_waitFor("OK");
	MOVLW       ?lstr14_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr14_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,177 :: 		}
L_end_esp8266_trans_mode:
	RETURN      0
; end of _esp8266_trans_mode

_esp8266_connect:

;MyProject.c,184 :: 		void esp8266_connect(unsigned char* ssid, unsigned char* pass)
;MyProject.c,186 :: 		_esp8266_print("AT+CWJAP=\"");    // Command
	MOVLW       ?lstr15_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr15_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,187 :: 		_esp8266_print(ssid);
	MOVF        FARG_esp8266_connect_ssid+0, 0 
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVF        FARG_esp8266_connect_ssid+1, 0 
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,188 :: 		_esp8266_print("\",\"");
	MOVLW       ?lstr16_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr16_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,189 :: 		_esp8266_print(pass);
	MOVF        FARG_esp8266_connect_pass+0, 0 
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVF        FARG_esp8266_connect_pass+1, 0 
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,190 :: 		_esp8266_print("\"\r\n");
	MOVLW       ?lstr17_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr17_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,191 :: 		_esp8266_waitFor("OK");           // Wait for "OK"
	MOVLW       ?lstr18_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr18_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,198 :: 		*/
L_end_esp8266_connect:
	RETURN      0
; end of _esp8266_connect

_esp8266_start:

;MyProject.c,199 :: 		unsigned char esp8266_start(unsigned char protocol, unsigned char* ip, unsigned int port)
;MyProject.c,201 :: 		unsigned char port_str[5] = "\0\0\0\0";
	CLRF        esp8266_start_port_str_L0+0 
	CLRF        esp8266_start_port_str_L0+1 
	CLRF        esp8266_start_port_str_L0+2 
	CLRF        esp8266_start_port_str_L0+3 
	CLRF        esp8266_start_port_str_L0+4 
;MyProject.c,202 :: 		_esp8266_print("AT+CIPSTART=\"");
	MOVLW       ?lstr19_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr19_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,203 :: 		if (protocol == ESP8266_TCP)
	MOVF        FARG_esp8266_start_protocol+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_esp8266_start16
;MyProject.c,205 :: 		_esp8266_print("TCP");
	MOVLW       ?lstr20_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr20_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,206 :: 		}
	GOTO        L_esp8266_start17
L_esp8266_start16:
;MyProject.c,209 :: 		_esp8266_print("UDP");
	MOVLW       ?lstr21_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr21_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,210 :: 		}
L_esp8266_start17:
;MyProject.c,211 :: 		_esp8266_print("\",\"");
	MOVLW       ?lstr22_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr22_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,212 :: 		_esp8266_print(ip);
	MOVF        FARG_esp8266_start_ip+0, 0 
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVF        FARG_esp8266_start_ip+1, 0 
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,213 :: 		_esp8266_print("\",");
	MOVLW       ?lstr23_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr23_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,215 :: 		sprintf(port_str, "%u", port);
	MOVLW       esp8266_start_port_str_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(esp8266_start_port_str_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_24_MyProject+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_24_MyProject+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_24_MyProject+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        FARG_esp8266_start_port+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        FARG_esp8266_start_port+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;MyProject.c,216 :: 		_esp8266_print(port_str);
	MOVLW       esp8266_start_port_str_L0+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(esp8266_start_port_str_L0+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,217 :: 		_esp8266_print("\r\n");
	MOVLW       ?lstr25_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr25_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,219 :: 		_esp8266_waitFor("OK");
	MOVLW       ?lstr26_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr26_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,220 :: 		}
L_end_esp8266_start:
	RETURN      0
; end of _esp8266_start

_esp8266_receive:

;MyProject.c,226 :: 		void esp8266_receive(unsigned char* store_in)
;MyProject.c,228 :: 		unsigned char length = 0;
	CLRF        esp8266_receive_length_L0+0 
;MyProject.c,232 :: 		_esp8266_waitFor("+IPD,");        // Wait for: +IPD - Read data
	MOVLW       ?lstr27_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr27_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,234 :: 		do
L_esp8266_receive18:
;MyProject.c,236 :: 		received = _esp8266_getch();
	CALL        __esp8266_getch+0, 0
	MOVF        R0, 0 
	MOVWF       esp8266_receive_received_L0+0 
;MyProject.c,237 :: 		if(received == ':') break;    // Stop when detect ":"
	MOVF        R0, 0 
	XORLW       58
	BTFSS       STATUS+0, 2 
	GOTO        L_esp8266_receive21
	GOTO        L_esp8266_receive19
L_esp8266_receive21:
;MyProject.c,238 :: 		length = length * 10 + (received - '0'); // Determine data length
	MOVLW       10
	MULWF       esp8266_receive_length_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       esp8266_receive_length_L0+0 
	MOVLW       48
	SUBWF       esp8266_receive_received_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       esp8266_receive_length_L0+0, 1 
;MyProject.c,240 :: 		while (received >= '0' && received <= '9');
	MOVLW       48
	SUBWF       esp8266_receive_received_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__esp8266_receive51
	MOVF        esp8266_receive_received_L0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L__esp8266_receive51
	GOTO        L_esp8266_receive18
L__esp8266_receive51:
L_esp8266_receive19:
;MyProject.c,242 :: 		for (i = 0; i < length; i++)
	CLRF        esp8266_receive_i_L0+0 
L_esp8266_receive24:
	MOVF        esp8266_receive_length_L0+0, 0 
	SUBWF       esp8266_receive_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_esp8266_receive25
;MyProject.c,244 :: 		store_in[i] = _esp8266_getch(); // Get bytes of Data
	MOVF        esp8266_receive_i_L0+0, 0 
	ADDWF       FARG_esp8266_receive_store_in+0, 0 
	MOVWF       FLOC__esp8266_receive+0 
	MOVLW       0
	ADDWFC      FARG_esp8266_receive_store_in+1, 0 
	MOVWF       FLOC__esp8266_receive+1 
	CALL        __esp8266_getch+0, 0
	MOVFF       FLOC__esp8266_receive+0, FSR1L+0
	MOVFF       FLOC__esp8266_receive+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,242 :: 		for (i = 0; i < length; i++)
	INCF        esp8266_receive_i_L0+0, 1 
;MyProject.c,245 :: 		}
	GOTO        L_esp8266_receive24
L_esp8266_receive25:
;MyProject.c,246 :: 		}
L_end_esp8266_receive:
	RETURN      0
; end of _esp8266_receive

_esp8266_send:

;MyProject.c,247 :: 		void esp8266_send(void)
;MyProject.c,249 :: 		_esp8266_print("AT+CIPSEND");
	MOVLW       ?lstr28_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr28_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,250 :: 		_esp8266_print("\r\n");
	MOVLW       ?lstr29_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr29_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,251 :: 		_esp8266_waitFor("OK");
	MOVLW       ?lstr30_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr30_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,252 :: 		while (_esp8266_getch() != '>');
L_esp8266_send27:
	CALL        __esp8266_getch+0, 0
	MOVF        R0, 0 
	XORLW       62
	BTFSC       STATUS+0, 2 
	GOTO        L_esp8266_send28
	GOTO        L_esp8266_send27
L_esp8266_send28:
;MyProject.c,253 :: 		}
L_end_esp8266_send:
	RETURN      0
; end of _esp8266_send

_esp8266_disconnect:

;MyProject.c,259 :: 		void esp8266_disconnect(void)
;MyProject.c,261 :: 		_esp8266_print("AT+CWQAP\r\n");
	MOVLW       ?lstr31_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr31_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,262 :: 		_esp8266_waitFor("OK");
	MOVLW       ?lstr32_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr32_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,263 :: 		}
L_end_esp8266_disconnect:
	RETURN      0
; end of _esp8266_disconnect

_esp8266_stop_send:

;MyProject.c,268 :: 		void esp8266_stop_send(void)
;MyProject.c,270 :: 		_esp8266_print("+++");
	MOVLW       ?lstr33_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr33_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,271 :: 		delay_ms(2000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_esp8266_stop_send29:
	DECFSZ      R13, 1, 1
	BRA         L_esp8266_stop_send29
	DECFSZ      R12, 1, 1
	BRA         L_esp8266_stop_send29
	DECFSZ      R11, 1, 1
	BRA         L_esp8266_stop_send29
	NOP
	NOP
;MyProject.c,272 :: 		}
L_end_esp8266_stop_send:
	RETURN      0
; end of _esp8266_stop_send

_esp8266_del_TCP:

;MyProject.c,278 :: 		void esp8266_del_TCP(void)
;MyProject.c,280 :: 		_esp8266_print("AT+CIPCLOSE\r\n");
	MOVLW       ?lstr34_MyProject+0
	MOVWF       FARG__esp8266_print_ptr+0 
	MOVLW       hi_addr(?lstr34_MyProject+0)
	MOVWF       FARG__esp8266_print_ptr+1 
	CALL        __esp8266_print+0, 0
;MyProject.c,281 :: 		_esp8266_waitFor("OK");
	MOVLW       ?lstr35_MyProject+0
	MOVWF       FARG__esp8266_waitFor_string+0 
	MOVLW       hi_addr(?lstr35_MyProject+0)
	MOVWF       FARG__esp8266_waitFor_string+1 
	CALL        __esp8266_waitFor+0, 0
;MyProject.c,282 :: 		}
L_end_esp8266_del_TCP:
	RETURN      0
; end of _esp8266_del_TCP

_interrupt:

;MyProject.c,283 :: 		void interrupt(void)
;MyProject.c,285 :: 		if (RCIE_bit == 1 && RCIF_bit == 1) {
	BTFSS       RCIE_bit+0, BitPos(RCIE_bit+0) 
	GOTO        L_interrupt32
	BTFSS       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L_interrupt32
L__interrupt52:
;MyProject.c,286 :: 		RCIF_bit = 0;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;MyProject.c,287 :: 		ReceiveData = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ReceiveData+0 
;MyProject.c,288 :: 		receive_flag = 1;
	BSF         _receive_flag+0, BitPos(_receive_flag+0) 
;MyProject.c,289 :: 		}
L_interrupt32:
;MyProject.c,291 :: 		if (INTCON.INT0IF) { // Ng?t t? RB0
	BTFSS       INTCON+0, 1 
	GOTO        L_interrupt33
;MyProject.c,292 :: 		INTCON.INT0IF = 0;
	BCF         INTCON+0, 1 
;MyProject.c,293 :: 		LATE.LATE1 = ~LATE.LATE1;
	BTG         LATE+0, 1 
;MyProject.c,294 :: 		count_RB0++;
	INFSNZ      _count_RB0+0, 1 
	INCF        _count_RB0+1, 1 
;MyProject.c,295 :: 		uart_data = 'S'; // Luu d? li?u c?n g?i
	MOVLW       83
	MOVWF       _uart_data+0 
;MyProject.c,296 :: 		uart_flag = 1; // Ðánh d?u d? g?i trong `main()`
	MOVLW       1
	MOVWF       _uart_flag+0 
	MOVLW       0
	MOVWF       _uart_flag+1 
;MyProject.c,299 :: 		}
L_interrupt33:
;MyProject.c,301 :: 		if (INTCON3.INT1IF) { // Ng?t t? RB1
	BTFSS       INTCON3+0, 0 
	GOTO        L_interrupt34
;MyProject.c,302 :: 		INTCON3.INT1IF = 0;
	BCF         INTCON3+0, 0 
;MyProject.c,303 :: 		LATE.LATE0 = ~LATE.LATE0;
	BTG         LATE+0, 0 
;MyProject.c,304 :: 		count_RB1++;
	INFSNZ      _count_RB1+0, 1 
	INCF        _count_RB1+1, 1 
;MyProject.c,305 :: 		uart_data = 'B'; // Luu d? li?u c?n g?i
	MOVLW       66
	MOVWF       _uart_data+0 
;MyProject.c,306 :: 		uart_flag = 1; // Ðánh d?u d? g?i trong `main()`
	MOVLW       1
	MOVWF       _uart_flag+0 
	MOVLW       0
	MOVWF       _uart_flag+1 
;MyProject.c,309 :: 		}
L_interrupt34:
;MyProject.c,310 :: 		}
L_end_interrupt:
L__interrupt71:
	RETFIE      1
; end of _interrupt

_main:

;MyProject.c,315 :: 		void main(void)
;MyProject.c,320 :: 		ADCON1 |= 0x0F;
	MOVLW       15
	IORWF       ADCON1+0, 1 
;MyProject.c,321 :: 		CMCON  |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;MyProject.c,324 :: 		PORTB = 0x00; LATB = 0x00;
	CLRF        PORTB+0 
	CLRF        LATB+0 
;MyProject.c,325 :: 		TRISB0_bit = 1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;MyProject.c,328 :: 		PORTE = 0x00; LATE = 0x00;
	CLRF        PORTE+0 
	CLRF        LATE+0 
;MyProject.c,329 :: 		TRISE0_bit = 0;  // LED for Connected
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;MyProject.c,330 :: 		TRISE1_bit = 0;
	BCF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;MyProject.c,332 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;MyProject.c,333 :: 		TRISD0_bit = 1;
	BSF         TRISD0_bit+0, BitPos(TRISD0_bit+0) 
;MyProject.c,334 :: 		LATD=0x00;
	CLRF        LATD+0 
;MyProject.c,336 :: 		LATE.LATD1= 0;
	BCF         LATE+0, 1 
;MyProject.c,338 :: 		PORTC = 0x00; LATC = 0x00;
	CLRF        PORTC+0 
	CLRF        LATC+0 
;MyProject.c,339 :: 		TRISC0_bit = 0;  // Reset pin of ESP8266
	BCF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;MyProject.c,342 :: 		INTCON.INT0IF = 0; // Xóa c? ng?t ngoài
	BCF         INTCON+0, 1 
;MyProject.c,343 :: 		INTCON.INT0IE = 1; // Cho phép ng?t ngoài
	BSF         INTCON+0, 4 
;MyProject.c,344 :: 		INTCON2.INTEDG0 = 1; // Ng?t trên c?nh lên
	BSF         INTCON2+0, 6 
;MyProject.c,347 :: 		INTCON3.INT1IF = 0; // Xóa c? ng?t INT1
	BCF         INTCON3+0, 0 
;MyProject.c,348 :: 		INTCON3.INT1IE = 1; // Cho phép ng?t INT1
	BSF         INTCON3+0, 3 
;MyProject.c,349 :: 		INTCON2.INTEDG1 = 1; // Ng?t khi RB1 có c?nh lên
	BSF         INTCON2+0, 5 
;MyProject.c,352 :: 		PIR2.USBIF = 0; // Xóa c? ng?t USB
	BCF         PIR2+0, 5 
;MyProject.c,353 :: 		PIE2.USBIE = 1; // Cho phép ng?t USB
	BSF         PIE2+0, 5 
;MyProject.c,356 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;MyProject.c,357 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;MyProject.c,358 :: 		UART1_Init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       42
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.c,359 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main35:
	DECFSZ      R13, 1, 1
	BRA         L_main35
	DECFSZ      R12, 1, 1
	BRA         L_main35
	DECFSZ      R11, 1, 1
	BRA         L_main35
	NOP
	NOP
;MyProject.c,362 :: 		RC0_bit = 0; delay_ms(100); RC0_bit = 1;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main36:
	DECFSZ      R13, 1, 1
	BRA         L_main36
	DECFSZ      R12, 1, 1
	BRA         L_main36
	DECFSZ      R11, 1, 1
	BRA         L_main36
	NOP
	NOP
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
;MyProject.c,364 :: 		delay_ms(1000);  // For ESP8266 stable
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main37:
	DECFSZ      R13, 1, 1
	BRA         L_main37
	DECFSZ      R12, 1, 1
	BRA         L_main37
	DECFSZ      R11, 1, 1
	BRA         L_main37
	NOP
;MyProject.c,368 :: 		esp8266_mode(ESP8266_STATION);              // Command: AT+CWMODE=1 - Put the module in Station mode
	MOVLW       1
	MOVWF       FARG_esp8266_mode_mode+0 
	CALL        _esp8266_mode+0, 0
;MyProject.c,369 :: 		esp8266_connect("CV_RoboticX7.6", "J4e4muVG");       // Command: AT+CWJAP="ssid","pass" - Connect to an access point
	MOVLW       ?lstr36_MyProject+0
	MOVWF       FARG_esp8266_connect_ssid+0 
	MOVLW       hi_addr(?lstr36_MyProject+0)
	MOVWF       FARG_esp8266_connect_ssid+1 
	MOVLW       ?lstr37_MyProject+0
	MOVWF       FARG_esp8266_connect_pass+0 
	MOVLW       hi_addr(?lstr37_MyProject+0)
	MOVWF       FARG_esp8266_connect_pass+1 
	CALL        _esp8266_connect+0, 0
;MyProject.c,370 :: 		esp8266_start(ESP8266_TCP, "192.168.2.100", 8000); // Command: AT+CIPSTART="TCP","ip",port - Start a TCP connection
	MOVLW       1
	MOVWF       FARG_esp8266_start_protocol+0 
	MOVLW       ?lstr38_MyProject+0
	MOVWF       FARG_esp8266_start_ip+0 
	MOVLW       hi_addr(?lstr38_MyProject+0)
	MOVWF       FARG_esp8266_start_ip+1 
	MOVLW       64
	MOVWF       FARG_esp8266_start_port+0 
	MOVLW       31
	MOVWF       FARG_esp8266_start_port+1 
	CALL        _esp8266_start+0, 0
;MyProject.c,372 :: 		RC1_bit = 1; // Warning - Connect to Server
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
;MyProject.c,373 :: 		esp8266_trans_mode(ESP8266_TRANS_PASS); // Command: AT+CIPMODE="mode" - Transparent Receiving Transmission
	MOVLW       1
	MOVWF       FARG_esp8266_trans_mode_mode+0 
	CALL        _esp8266_trans_mode+0, 0
;MyProject.c,374 :: 		esp8266_send();  // Command: AT+CIPSEND - send data
	CALL        _esp8266_send+0, 0
;MyProject.c,377 :: 		RCIF_bit = 0;      // Clear interrupt bit
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;MyProject.c,378 :: 		RCIE_bit = 1;      // Enable the USART receive interrupt
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;MyProject.c,379 :: 		GIE_bit = 1;       // Enable global interrupt
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;MyProject.c,380 :: 		PEIE_bit = 1;      // Enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;MyProject.c,382 :: 		while(1) {
L_main38:
;MyProject.c,385 :: 		if (uart_flag) {
	MOVF        _uart_flag+0, 0 
	IORWF       _uart_flag+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main40
;MyProject.c,386 :: 		uart_flag = 0;
	CLRF        _uart_flag+0 
	CLRF        _uart_flag+1 
;MyProject.c,387 :: 		UART1_Write(uart_data); // G?i ký t? S/B
	MOVF        _uart_data+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,388 :: 		}
L_main40:
;MyProject.c,391 :: 		if (receive_flag) {
	BTFSS       _receive_flag+0, BitPos(_receive_flag+0) 
	GOTO        L_main41
;MyProject.c,392 :: 		receive_flag = 0;
	BCF         _receive_flag+0, BitPos(_receive_flag+0) 
;MyProject.c,393 :: 		if (ReceiveData == '@') {
	MOVF        _ReceiveData+0, 0 
	XORLW       64
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
;MyProject.c,394 :: 		LATE.LATE1 = 1;
	BSF         LATE+0, 1 
;MyProject.c,395 :: 		UART1_Write('O');
	MOVLW       79
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,396 :: 		}else if (ReceiveData == '$') {
	GOTO        L_main43
L_main42:
	MOVF        _ReceiveData+0, 0 
	XORLW       36
	BTFSS       STATUS+0, 2 
	GOTO        L_main44
;MyProject.c,397 :: 		LATE.LATE1 = 0;
	BCF         LATE+0, 1 
;MyProject.c,398 :: 		UART1_Write('S');
	MOVLW       83
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,399 :: 		}  else if (ReceiveData =='B'){
	GOTO        L_main45
L_main44:
	MOVF        _ReceiveData+0, 0 
	XORLW       66
	BTFSS       STATUS+0, 2 
	GOTO        L_main46
;MyProject.c,400 :: 		LATE.LATE0 = 1 ;
	BSF         LATE+0, 0 
;MyProject.c,401 :: 		if (RD0_bit == 1) {
	BTFSS       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_main47
;MyProject.c,402 :: 		UART1_Write('B'); // G?i ký t? 'B' n?u RD0 = 1
	MOVLW       66
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,404 :: 		}
L_main47:
;MyProject.c,406 :: 		}else if(ReceiveData=='C'){
	GOTO        L_main48
L_main46:
	MOVF        _ReceiveData+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
;MyProject.c,407 :: 		LATE.LATE0 = 0 ;
	BCF         LATE+0, 0 
;MyProject.c,408 :: 		if (RD0_bit == 0){
	BTFSC       RD0_bit+0, BitPos(RD0_bit+0) 
	GOTO        L_main50
;MyProject.c,409 :: 		UART1_Write('C');
	MOVLW       67
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;MyProject.c,410 :: 		}
L_main50:
;MyProject.c,412 :: 		}
L_main49:
L_main48:
L_main45:
L_main43:
;MyProject.c,417 :: 		}
L_main41:
;MyProject.c,418 :: 		}
	GOTO        L_main38
;MyProject.c,419 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
