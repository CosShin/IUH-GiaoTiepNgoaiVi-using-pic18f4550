#line 1 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
#line 1 "d:/giaotiepngoaivi/wifi/esp8266_pic librarey/esp8266_pic librarey/esp8266.h"
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
#line 67 "d:/giaotiepngoaivi/wifi/esp8266_pic librarey/esp8266_pic librarey/esp8266.h"
void _esp8266_putch(unsigned char);
unsigned char _esp8266_getch(void);



bit esp8266_isStarted(void);
bit esp8266_restart(void);
void esp8266_echoCmds( _Bool );


void esp8266_mode(unsigned char);


unsigned char esp8266_connect(unsigned char*, unsigned char*);


void esp8266_disconnect(void);


void esp8266_ip(char*);


bit esp8266_start(unsigned char protocol, char* ip, unsigned char port);


bit esp8266_send(unsigned char*);


void esp8266_receive(unsigned char*, uint16_t,  _Bool );




void _esp8266_print(unsigned const char *);


inline uint16_t _esp8266_waitFor(unsigned char *);

inline unsigned char _esp8266_waitResponse(void);
#line 1 "d:/giaotiepngoaivi/mikroc pro for pic/include/stdio.h"
#line 1 "d:/giaotiepngoaivi/mikroc pro for pic/include/string.h"
#line 42 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
void Initialize_ESP8266(void)
{

 TRISC6 = 0;
 TRISC7 = 1;
#line 51 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
 SPBRG = 10;
 BRGH = 1;



 SYNC = 0;
 SPEN = 1;


 TXEN = 1;
 CREN = 1;



 TX9 = 0;
 RX9 = 0;

}



void _esp8266_putch(char bt)
{
 while(!TXIF);
 TXREG = bt;
}



char _esp8266_getch()
{
 if(OERR)
 {
 CREN = 0;
 CREN = 1;
 }

 while(!RCIF);

 return RCREG;
}




void ESP8266_send_string(char* st_pt)
{
 while(*st_pt)
 _esp8266_putch(*st_pt++);
}
#line 117 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
bit esp8266_isStarted(void) {
 _esp8266_print("AT\r\n");
 return (_esp8266_waitResponse() ==  1 );
}
#line 130 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
bit esp8266_restart(void) {
 _esp8266_print("AT+RST\r\n");
 if (_esp8266_waitResponse() !=  1 ) {
 return  0 ;
 }
 return (_esp8266_waitResponse() ==  2 );
}
#line 148 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
void esp8266_echoCmds( _Bool  echo) {
 _esp8266_print("ATE");
 if (echo) {
 _esp8266_putch('1');
 } else {
 _esp8266_putch('0');
 }
 _esp8266_print("\r\n");
 _esp8266_waitFor("OK");
}
#line 169 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
void esp8266_mode(unsigned char mode) {
 _esp8266_print("AT+CWMODE=");
 _esp8266_putch(mode + '0');
 _esp8266_print("\r\n");
 _esp8266_waitResponse();
}
#line 185 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
unsigned char esp8266_connect(unsigned char* ssid, unsigned char* pass) {
 _esp8266_print("AT+CWJAP=\"");
 _esp8266_print(ssid);
 _esp8266_print("\",\"");
 _esp8266_print(pass);
 _esp8266_print("\"\r\n");
 return _esp8266_waitResponse();
}
#line 199 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
void esp8266_disconnect(void) {
 _esp8266_print("AT+CWQAP\r\n");
 _esp8266_waitFor("OK");
}
#line 215 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
void esp8266_ip(unsigned char* store_in) {
 _esp8266_print("AT+CIFSR\r\n");
 unsigned char received;
 do {
 received = _esp8266_getch();
 } while (received < '0' || received > '9');
 for (unsigned char i = 0; i < 4; i++) {
 store_in[i] = 0;
 do {
 store_in[i] = 10 * store_in[i] + received - '0';
 received = _esp8266_getch();
 } while (received >= '0' && received <= '9');
 received = _esp8266_getch();
 }
 _esp8266_waitFor("OK");
}
#line 243 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
bit esp8266_start(unsigned char protocol, char* ip, unsigned char port) {
 _esp8266_print("AT+CIPSTART=\"");
 if (protocol ==  1 ) {
 _esp8266_print("TCP");
 } else {
 _esp8266_print("UDP");
 }
 _esp8266_print("\",\"");
 _esp8266_print(ip);
 _esp8266_print("\",");
 unsigned char port_str[5] = "\0\0\0\0";
 sprintf(port_str, "%u", port);
 _esp8266_print(port_str);
 _esp8266_print("\r\n");
 if (_esp8266_waitResponse() !=  1 ) {
 return 0;
 }
 if (_esp8266_waitResponse() !=  5 ) {
 return 0;
 }
 return 1;
}
#line 276 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
bit esp8266_send(unsigned char* data) {
 unsigned char length_str[6] = "\0\0\0\0\0";
 sprintf(length_str, "%u", strlen(data));
 _esp8266_print("AT+CIPSEND=");
 _esp8266_print(length_str);
 _esp8266_print("\r\n");
 while (_esp8266_getch() != '>');
 _esp8266_print(data);
 if (_esp8266_waitResponse() ==  1 ) {
 return 1;
 }
 return 0;
}
#line 301 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
void esp8266_receive(unsigned char* store_in, uint16_t max_length,  _Bool  discard_headers) {
 _esp8266_waitFor("+IPD,");
 uint16_t length = 0;
 unsigned char received = _esp8266_getch();
 do {
 length = length * 10 + received - '0';
 received = _esp8266_getch();
 } while (received >= '0' && received <= '9');

 if (discard_headers) {
 length -= _esp8266_waitFor("\r\n\r\n");
 }

 if (length < max_length) {
 max_length = length;
 }
#line 321 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
 uint16_t i;
 for (i = 0; i < max_length; i++) {
 store_in[i] = _esp8266_getch();
 }
 store_in[i] = 0;
 for (; i < length; i++) {
 _esp8266_getch();
 }
 _esp8266_waitFor("OK");
}
#line 339 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
void _esp8266_print(unsigned const char *ptr) {
 while (*ptr != 0) {
 _esp8266_putch(*ptr++);
 }
}
#line 355 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
inline uint16_t _esp8266_waitFor(unsigned char *string) {
 unsigned char so_far = 0;
 unsigned char received;
 uint16_t counter = 0;
 do {
 received = _esp8266_getch();
 counter++;
 if (received == string[so_far]) {
 so_far++;
 } else {
 so_far = 0;
 }
 } while (string[so_far] != 0);
 return counter;
}
#line 389 "D:/giaotiepngoaivi/WIFI/ESP8266_PIC librarey/ESP8266_PIC librarey/esp8266.c"
inline unsigned char _esp8266_waitResponse(void) {
 unsigned char so_far[6] = {0,0,0,0,0,0};
 unsigned const char lengths[6] = {2,5,4,9,6,6};
 unsigned const char* strings[6] = {"OK", "ready", "FAIL", "no change", "Linked", "Unlink"};
 unsigned const char responses[6] = { 1 ,  2 ,  3 ,  4 ,  5 ,  6 };
 unsigned char received;
 unsigned char response;
  _Bool  continue_loop =  1 ;
 while (continue_loop) {
 received = _esp8266_getch();
 for (unsigned char i = 0; i < 6; i++) {
 if (strings[i][so_far[i]] == received) {
 so_far[i]++;
 if (so_far[i] == lengths[i]) {
 response = responses[i];
 continue_loop =  0 ;
 }
 } else {
 so_far[i] = 0;
 }
 }
 }
 return response;
}
