#line 1 "D:/giaotiepngoaivi/Bluetooth/MyProject.c"
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
#line 7 "D:/giaotiepngoaivi/Bluetooth/MyProject.c"
char TransmitData, ReceiveData;
bit transmit_flag, receive_flag;

int uart_flag = 0;
volatile char uart_data;
int count_RB0,count_RB1;

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
