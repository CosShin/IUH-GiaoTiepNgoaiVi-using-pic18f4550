#line 1 "D:/giaotiepngoaivi/WIFI/frimeware.c"
#line 1 "d:/giaotiepngoaivi/mikroc pro for pic/include/stdbool.h"



 typedef char _Bool;
#line 1 "d:/giaotiepngoaivi/mikroc pro for pic/include/stdint.h"




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
#line 1 "d:/giaotiepngoaivi/mikroc pro for pic/include/stdio.h"
#line 1 "d:/giaotiepngoaivi/mikroc pro for pic/include/string.h"





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
#line 23 "D:/giaotiepngoaivi/WIFI/frimeware.c"
char TransmitData, ReceiveData;
bit transmit_flag, receive_flag;

void interrupt(void)
{
 if ((RCIE_bit == 1) && (RCIF_bit == 1))
 {
 RCIF_bit = 0;
 ReceiveData = UART1_Read();
 receive_flag = 1;
 }
}


void _esp8266_putch(char bt)
{
 while (!TXIF_bit);
 TXREG = bt;
}


char esp8266_getch()
{
 if (OERR_bit)
 {
 CREN_bit = 0;
 CREN_bit = 1;
 }

 while (!RCIF_bit);
 return RCREG;
}


void ESP8266_send_string(char* st_pt)
{
 while (*st_pt)
 {
 _esp8266_putch(*st_pt++);
 }
}


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


void _esp8266_print(unsigned char *ptr)
{
 while (*ptr != 0)
 {
 _esp8266_putch(*ptr++);
 }
}


uint16_t _esp8266_waitFor(unsigned char *string)
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


void esp8266_connect(unsigned char* ssid, unsigned char* pass)
{
 _esp8266_print("AT+CWJAP=\"");
 _esp8266_print(ssid);
 _esp8266_print("\",\"");
 _esp8266_print(pass);
 _esp8266_print("\"\r\n");
 _esp8266_waitFor("OK");
}


void esp8266_send(void)
{
 _esp8266_print("AT+CIPSEND\r\n");
 _esp8266_waitFor("OK");
 while (_esp8266_getch() != '>');
}

void esp8266_receive(unsigned char* store_in)
{
 unsigned char length = 0;
 unsigned char received;

 _esp8266_waitFor("+IPD,");
 do {
 received = _esp8266_getch();
 if (received == ':') break;
 length = length * 10 + (received - '0');
 } while (received >= '0' && received <= '9');

 for (unsigned char i = 0; i < length; i++)
 {
 store_in[i] = _esp8266_getch();
 }
}

void esp8266_disconnect(void)
{
 _esp8266_print("AT+CWQAP\r\n");
 _esp8266_waitFor("OK");
}

void esp8266_stop_send(void)
{
 delay_ms(2000);
}

void esp8266_del_TCP(void)
{
 _esp8266_print("AT+CIPCLOSE\r\n");
 _esp8266_waitFor("OK");
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


 PORTC = 0x00; LATC = 0x00;
 TRISC0_bit = 0;

 UART1_Init(115200);
 delay_ms(100);


 RC0_bit = 0;
 delay_ms(100);
 RC0_bit = 1;

 delay_ms(1000);



 esp8266_restart();
 esp8266_echoCmds(0);
 esp8266_isStarted();

 esp8266_mode( 0x01 );
 esp8266_connect("TOI_AI LAB", "pqtri2002");
 esp8266_start( 1 , "192.168.1.49", 8000);

 RE0_bit = 1;
 esp8266_trans_mode( 1 );
 esp8266_send();


 RCIF_bit = 0;
 PIE1.RCIE = 1;
 GIE_bit = 1;
 PEIE_bit = 1;

 while(1)
 {

 if (Button(&PORTB, 0, 10, 0))
 {
 while (Button(&PORTB, 0, 10, 0));
 TransmitData = 'S';
 UART1_Write(TransmitData);
 }

 if (receive_flag == 1)
 {
 receive_flag = 0;
 ReceiveData = UART1_Read();
 if (ReceiveData == '0')
 {
 LATE1_bit = 1;
 TransmitData = 'O';
 UART1_Write(TransmitData);
 }
 else if (ReceiveData == 'S')
 {
 LATE1_bit = 0;
 TransmitData = 'F';
 UART1_Write(TransmitData);
 }
 else if (ReceiveData == 'Z')
 {
 GIE_bit = 0;
 RE0_bit = 0;

 esp8266_stop_send();
 esp8266_trans_mode( 0 );
 esp8266_del_TCP();
 }
 }
 }
}

}
