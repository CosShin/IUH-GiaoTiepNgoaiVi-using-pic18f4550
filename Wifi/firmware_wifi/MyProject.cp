#line 1 "D:/giaotiepngoaivi/WIFI/MyProject.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 30 "D:/giaotiepngoaivi/WIFI/MyProject.c"
char TransmitData, ReceiveData;
bit transmit_flag, receive_flag;

int uart_flag = 0;
volatile char uart_data;
int count_RB0,count_RB1;




void _esp8266_putch(char bt)
{
 while(!TXIF_bit);
 TXREG = bt;
}




char _esp8266_getch()
{
 if(OERR_bit)
 {
 CREN_bit = 0;
 CREN_bit = 1;
 }

 while(!RCIF_bit);
 return RCREG;
}


void ESP8266_send_string(char* st_pt)
{
 while(*st_pt)
 {
 _esp8266_putch(*st_pt++);
 }
}
#line 78 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void _esp8266_print(unsigned char *ptr) {
 while (*ptr != 0)
 {
 _esp8266_putch(*ptr++);
 }
}

inline uint16_t _esp8266_waitFor(unsigned char *string)
{
 unsigned char so_far = 0;
 unsigned char received;
 uint16_t counter = 0;
 do
 {
 received = _esp8266_getch();
 counter++;
 if (received == string[so_far])
 {
 so_far++;
 }
 else
 {
 so_far = 0;
 }
 }
 while (string[so_far] != 0);
 return counter;
}
#line 114 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_restart(void)
{
 _esp8266_print("AT+RST\r\n");
 _esp8266_waitFor("OK");
 _esp8266_waitFor("ready");
}




 void esp8266_isStarted(void)
{
 _esp8266_print("AT\r\n");
 _esp8266_waitFor("OK");
}
#line 138 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_echoCmds( _Bool  echo)
{
 _esp8266_print("ATE");
 if (echo)
 {
 _esp8266_putch('1');
 }
 else
 {
 _esp8266_putch('0');
 }
 _esp8266_print("\r\n");
 _esp8266_waitFor("OK");
}
#line 162 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_mode(unsigned char mode)
{
 _esp8266_print("AT+CWMODE=");
 _esp8266_putch(mode + '0');
 _esp8266_print("\r\n");
 _esp8266_waitFor("OK");
}


void esp8266_trans_mode(unsigned char mode)
{
 _esp8266_print("AT+CIPMODE=");
 _esp8266_putch(mode + '0');
 _esp8266_print("\r\n");
 _esp8266_waitFor("OK");
}
#line 184 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_connect(unsigned char* ssid, unsigned char* pass)
{
 _esp8266_print("AT+CWJAP=\"");
 _esp8266_print(ssid);
 _esp8266_print("\",\"");
 _esp8266_print(pass);
 _esp8266_print("\"\r\n");
 _esp8266_waitFor("OK");
#line 198 "D:/giaotiepngoaivi/WIFI/MyProject.c"
}
unsigned char esp8266_start(unsigned char protocol, unsigned char* ip, unsigned int port)
{
 unsigned char port_str[5] = "\0\0\0\0";
 _esp8266_print("AT+CIPSTART=\"");
 if (protocol ==  1 )
 {
 _esp8266_print("TCP");
 }
 else
 {
 _esp8266_print("UDP");
 }
 _esp8266_print("\",\"");
 _esp8266_print(ip);
 _esp8266_print("\",");

 sprintf(port_str, "%u", port);
 _esp8266_print(port_str);
 _esp8266_print("\r\n");

 _esp8266_waitFor("OK");
}
#line 226 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_receive(unsigned char* store_in)
{
 unsigned char length = 0;
 unsigned char i;
 unsigned char received;

 _esp8266_waitFor("+IPD,");

 do
 {
 received = _esp8266_getch();
 if(received == ':') break;
 length = length * 10 + (received - '0');
 }
 while (received >= '0' && received <= '9');

 for (i = 0; i < length; i++)
 {
 store_in[i] = _esp8266_getch();
 }
}
void esp8266_send(void)
{
 _esp8266_print("AT+CIPSEND");
 _esp8266_print("\r\n");
 _esp8266_waitFor("OK");
 while (_esp8266_getch() != '>');
}
#line 259 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_disconnect(void)
{
 _esp8266_print("AT+CWQAP\r\n");
 _esp8266_waitFor("OK");
}
#line 268 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_stop_send(void)
{
 _esp8266_print("+++");
 delay_ms(2000);
}
#line 278 "D:/giaotiepngoaivi/WIFI/MyProject.c"
void esp8266_del_TCP(void)
{
 _esp8266_print("AT+CIPCLOSE\r\n");
 _esp8266_waitFor("OK");
}
void interrupt(void)
{
 if (RCIE_bit == 1 && RCIF_bit == 1) {
 RCIF_bit = 0;
 ReceiveData = UART1_Read();
 receive_flag = 1;
 }

 if (INTCON.INT0IF) {
 INTCON.INT0IF = 0;
 LATE.LATE1 = ~LATE.LATE1;
 count_RB0++;
 uart_data = 'S';
 uart_flag = 1;


 }

 if (INTCON3.INT1IF) {
 INTCON3.INT1IF = 0;
 LATE.LATE0 = ~LATE.LATE0;
 count_RB1++;
 uart_data = 'B';
 uart_flag = 1;


 }
}




void main(void)
{



 ADCON1 |= 0x0F;
 CMCON |= 7;


 PORTB = 0x00; LATB = 0x00;
 TRISB0_bit = 1;


 PORTE = 0x00; LATE = 0x00;
 TRISE0_bit = 0;
 TRISE1_bit = 0;

 PORTD = 0x00;
 TRISD0_bit = 1;
 LATD=0x00;

 LATE.LATD1= 0;

 PORTC = 0x00; LATC = 0x00;
 TRISC0_bit = 0;


 INTCON.INT0IF = 0;
 INTCON.INT0IE = 1;
 INTCON2.INTEDG0 = 1;


 INTCON3.INT1IF = 0;
 INTCON3.INT1IE = 1;
 INTCON2.INTEDG1 = 1;


 PIR2.USBIF = 0;
 PIE2.USBIE = 1;


 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 UART1_Init(115200);
 delay_ms(100);


 RC0_bit = 0; delay_ms(100); RC0_bit = 1;

 delay_ms(1000);



 esp8266_mode( 0x01 );
 esp8266_connect("CV_RoboticX7.6", "J4e4muVG");
 esp8266_start( 1 , "192.168.2.100", 8000);

 RC1_bit = 1;
 esp8266_trans_mode( 1 );
 esp8266_send();


 RCIF_bit = 0;
 RCIE_bit = 1;
 GIE_bit = 1;
 PEIE_bit = 1;

 while(1) {
 char buffer[10];

 if (uart_flag) {
 uart_flag = 0;
 UART1_Write(uart_data);
 }


 if (receive_flag) {
 receive_flag = 0;
 if (ReceiveData == '@') {
 LATE.LATE1 = 1;
 UART1_Write('O');
 }else if (ReceiveData == '$') {
 LATE.LATE1 = 0;
 UART1_Write('S');
 } else if (ReceiveData =='B'){
 LATE.LATE0 = 1 ;
 if (RD0_bit == 1) {
 UART1_Write('B');

 }

 }else if(ReceiveData=='C'){
 LATE.LATE0 = 0 ;
 if (RD0_bit == 0){
 UART1_Write('C');
 }

 }




 }
 }
}
