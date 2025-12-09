#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>


// ESP8266 Constants
#define ESP8266_STATION      0x01
#define ESP8266_SOFTAP       0x02
#define ESP8266_BOTH         0x03


#define ESP8266_TCP          1
#define ESP8266_UDP          0
#define ESP8266_TRANS_PASS   1
#define ESP8266_TRANS_NOR    0


#define ESP8266_OK           1
#define ESP8266_READY        2
#define ESP8266_FAIL         3
#define ESP8266_NOCHANGE     4
#define ESP8266_LINKED       5
#define ESP8266_UNLINK       6
#define ESP8266_CONNECT      7
#define NULL 0

// Global variables
char TransmitData, ReceiveData;
volatile bit transmit_flag, receive_flag;

// Function prototypes
void _esp8266_putch(char bt);
char _esp8266_getch(void);
void _esp8266_send_string(char* st_pt);
void _esp8266_print(unsigned char *ptr);
uint16_t _esp8266_waitFor(unsigned char *string);
void _esp8266_restart(void);
void _esp8266_isStarted(void);
void _esp8266_echoCmds(bool echo);
void _esp8266_mode(unsigned char mode);
void _esp8266_trans_mode(unsigned char mode);
void _esp8266_connect(unsigned char* ssid, unsigned char* pass);
unsigned char _esp8266_start(unsigned char protocol, unsigned char* ip, unsigned int port);
void _esp8266_send(void);
void _esp8266_receive(unsigned char* store_in);
void _esp8266_disconnect(void);
void _esp8266_stop_send(void);
void _esp8266_del_TCP(void);

// Interrupt handler
void interrupt(void) {
    if (PIR1.RCIF && PIE1.RCIE) {
        PIR1.RCIF = 0;
        ReceiveData = UART1_Read();
        receive_flag = 1;
    }
}

void _esp8266_putch(char bt) {
    while (!TXIF_bit);
    TXREG = bt;
}

char _esp8266_getch() {
    if (OERR_bit) {
        CREN_bit = 0;
        CREN_bit = 1;
    }
    while (!RCIF_bit);
    return RCREG;
}
void _esp8266_print(unsigned char *ptr) {
    while (*ptr != 0) {
        _esp8266_putch(*ptr++);
    }
}
uint16_t _esp8266_waitFor(unsigned char *string) {
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


void _esp8266_restart(void)
{
    _esp8266_print("AT+RST\r\n"); // Send reset command
    _esp8266_waitFor("OK"); // Wait for "OK"
    _esp8266_waitFor("ready"); // Wait for "ready"
}

 void _esp8266_isStarted(void) {
    _esp8266_print("AT\r\n");
    _esp8266_waitFor("OK");
}
  
  void _esp8266_echoCmds(bool echo)
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
    _esp8266_waitFor("OK"); // Wait for "OK"
}

void _esp8266_mode(unsigned char mode)
{
    _esp8266_print("AT+CWMODE=");
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK"); // Wait for "OK"
}
void _esp8266_trans_mode(unsigned char mode)
{
    _esp8266_print("AT+CIPMODE=");
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK"); // Wait for "OK"
}
void _esp8266_connect(unsigned char* ssid, unsigned char* pass)
{
    _esp8266_print("AT+CWJAP=\"");
    _esp8266_print(ssid);
    _esp8266_print("\",\"");
    _esp8266_print(pass);
    _esp8266_print("\"\r\n");
    _esp8266_waitFor("OK"); // Wait for "OK"
}

/**
 * Open a TCP or UDP connection.
 * This sends the AT+CIPSTART command to the ESP module and waits until it gets a response "OK".
 * @param protocol Either ESP8266_TCP or ESP8266_UDP
 * @param ip The IP or hostname to connect to; as a string
 * @param port The port to connect to
 */
unsigned char _esp8266_start(unsigned char protocol, unsigned char* ip, unsigned int port) {
    unsigned char port_str[6]; // Ch?nh size d? d? ch?a chu?i s?
    sprintf(port_str, "%u", port);

    _esp8266_print("AT+CIPSTART=\"");
    _esp8266_print((protocol == ESP8266_TCP) ? "TCP" : "UDP");
    _esp8266_print("\",\"");
    _esp8266_print(ip);
    _esp8266_print("\",");
    _esp8266_print(port_str);
    _esp8266_print("\r\n");

    return _esp8266_waitFor("OK"); // Ð?m b?o hàm có return
}




void _esp8266_send(void) {
    _esp8266_print("AT+CIPSEND\r\n");
    _esp8266_waitFor("OK");
    while (_esp8266_getch() != '>');
}
void _esp8266_stop_send(void) {
    _esp8266_print("+++");
    delay_ms(2000);
}



void _esp8266_del_TCP(void) {
    _esp8266_print("AT+CIPCLOSE\r\n");
    _esp8266_waitFor("OK");
}

void main(void) {
    ADCON1 |= 0x0 ;
    CMCON  |= 7;

    PORTB = 0x00; LATB = 0x00;
    TRISB0_bit = 1;

    PORTE = 0x00; LATE = 0x00;
    TRISE0_bit = 0;
    TRISE1_bit = 0;

    PORTC = 0x00; LATC = 0x00;
    TRISC0_bit = 0;

    UART1_Init(9600);
    delay_ms(100);

    RC0_bit = 0;
    delay_ms(100);
    RC0_bit = 1;

    delay_ms(1000);
    RCIF_bit = 0;
    PIE1.RCIE = 1;
    GIE_bit = 1;
    PEIE_bit = 1;

    _esp8266_restart();
    _esp8266_echoCmds(0);
    _esp8266_isStarted();
    _esp8266_mode(ESP8266_STATION);
    _esp8266_connect("Tang2_5G", "1234567890@");
    _esp8266_start(ESP8266_TCP, "192.168.2.32", 8000);

    RE0_bit = 1;
    _esp8266_trans_mode(ESP8266_TRANS_PASS);
    _esp8266_send();



    while (1) {
        if (Button(&PORTB, 0, 10, 0)) {
            while (Button(&PORTB, 0, 10, 0));
            TransmitData = 'S';
            UART1_Write(TransmitData);
        }

        if (receive_flag == 1) {
            receive_flag = 0;
            ReceiveData = UART1_Read();
            if (ReceiveData == '0') {
                LATE1_bit = 1;
                TransmitData = 'O';
                UART1_Write(TransmitData);
            } else if (ReceiveData == 'S') {
                LATE1_bit = 0;
                TransmitData = 'F';
                UART1_Write(TransmitData);
            } else if (ReceiveData == 'Z') {
                GIE_bit = 0;
                RE0_bit = 0;
                _esp8266_stop_send();
                _esp8266_trans_mode(ESP8266_TRANS_NOR);
                _esp8266_del_TCP();
            }
        }
    }
}