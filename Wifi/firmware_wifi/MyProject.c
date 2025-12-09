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




char TransmitData, ReceiveData;
bit transmit_flag, receive_flag;

int uart_flag = 0;
volatile char uart_data;
int count_RB0,count_RB1;



/**Function to send one byte of data to UART**/
void _esp8266_putch(char bt)
{
    while(!TXIF_bit);   // Gi? chuong trình cho d?n khi b? d?m TX tr?ng
    TXREG = bt;         // Ghi d? li?u vào b? d?m truy?n
}

//================================================================

/**Function to get one byte of data from UART**/
char _esp8266_getch()
{
    if(OERR_bit)        // Ki?m tra l?i
    {
        CREN_bit = 0;   // N?u l?i -> Reset
        CREN_bit = 1;   // N?u l?i -> Reset
    }

    while(!RCIF_bit);   // Gi? chuong trình cho d?n khi b? d?m RX có d? li?u
    return RCREG;       // Nh?n d? li?u và g?i v? hàm chính
}
//=============================================================
//**Function to convert string to byte**
void ESP8266_send_string(char* st_pt)
{
    while(*st_pt) // if there is a char
    {
        _esp8266_putch(*st_pt++); // process it as a byte data
    }
}



//=============================================================
/**
 * Output a string to the ESP module.
 * This is a function for internal use only.
 * @param ptr A pointer to the string to send.
 */
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

/**
 * Restart the module
 * This sends the `AT+RST` command to the ESP and waits until there is a
 * response "OK" and "ready".
 */


void esp8266_restart(void)
{
    _esp8266_print("AT+RST\r\n");     // Command
    _esp8266_waitFor("OK");           // Wait for "OK"
    _esp8266_waitFor("ready");        // Wait for "ready"
}




 void esp8266_isStarted(void)
{
    _esp8266_print("AT\r\n");         // Command
    _esp8266_waitFor("OK");           // Wait for "OK"
}

/**
 * Enable / disable command echoing.
 * Enabling this is useful for debugging: one could sniff the TX line from the
 * ESP8266 with his computer and thus receive both commands and responses.
 * This sends the ATE command to the ESP module and waits until it gets a response "OK".
 *
 * @param echo whether to enable command echoing (1) or not (0)
 */
void esp8266_echoCmds(bool echo)
{
    _esp8266_print("ATE");            // Command
    if (echo)
    {
        _esp8266_putch('1');
    }
    else
    {
        _esp8266_putch('0');
    }
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK");           // Wait for "OK"
}

/**
 * Set the WiFi mode.
 * - ESP8266_STATION : Station mode
 * - ESP8266_SOFTAP  : Access Point mode
 * - ESP8266_BOTH    : Station + Access Point mode
 * This sends the AT+CWMODE command to the ESP module and waits until it gets a response "OK".
 *
 * @param mode an ORed bitmask of ESP8266_STATION, ESP8266_SOFTAP, ESP8266_BOTH
 */
void esp8266_mode(unsigned char mode)
{
    _esp8266_print("AT+CWMODE=");     // Command
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK");           // Wait for "OK"
}


void esp8266_trans_mode(unsigned char mode)
{
    _esp8266_print("AT+CIPMODE=");    // Command
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK");
}
/**
 * Connect to an access point.
 * This sends the AT+CWJAP command to the ESP module and waits until it gets a response "OK".
 * @param ssid The SSID to connect to
 * @param pass The password of the network
 */
void esp8266_connect(unsigned char* ssid, unsigned char* pass)
{
    _esp8266_print("AT+CWJAP=\"");    // Command
    _esp8266_print(ssid);
    _esp8266_print("\",\"");
    _esp8266_print(pass);
    _esp8266_print("\"\r\n");
    _esp8266_waitFor("OK");           // Wait for "OK"
}/**
 * Open a TCP or UDP connection.
 * This sends the AT+CIPSTART command to the ESP module and waits until it gets a response "OK".
 * @param protocol Either ESP8266_TCP or ESP8266_UDP
 * @param ip The IP or hostname to connect to, as a string
 * @param port The port to connect to
 */
unsigned char esp8266_start(unsigned char protocol, unsigned char* ip, unsigned int port)
{
    unsigned char port_str[5] = "\0\0\0\0";
    _esp8266_print("AT+CIPSTART=\"");
    if (protocol == ESP8266_TCP)
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
 /**
 * Read a string of data that is sent to the ESP8266 (for Single Connection as TCP Client).
 * This waits for a +IPD line from the module. If more bytes than the maximum are received, the remaining bytes will be discarded.
 * @param store_in A pointer to a character array to store the data in
 */
void esp8266_receive(unsigned char* store_in)
{
    unsigned char length = 0;
    unsigned char i;
    unsigned char received;

    _esp8266_waitFor("+IPD,");        // Wait for: +IPD - Read data

    do
    {
        received = _esp8266_getch();
        if(received == ':') break;    // Stop when detect ":"
        length = length * 10 + (received - '0'); // Determine data length
    }
    while (received >= '0' && received <= '9');

    for (i = 0; i < length; i++)
    {
        store_in[i] = _esp8266_getch(); // Get bytes of Data
    }
}
void esp8266_send(void)
{
    _esp8266_print("AT+CIPSEND");
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK");
    while (_esp8266_getch() != '>');
}

/**
 * Disconnect from the access point.
 * This sends the AT+CWQAP command to the ESP module.
 */
void esp8266_disconnect(void)
{
    _esp8266_print("AT+CWQAP\r\n");
    _esp8266_waitFor("OK");
}
/**
 * Stop sending data.
 * This sends the +++ to the ESP module.
 */
void esp8266_stop_send(void)
{
    _esp8266_print("+++");
    delay_ms(2000);
}

/**
 * Delete TCP connection
 * This sends the AT+CIPCLOSE command to the ESP module.
 */
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

    if (INTCON.INT0IF) { // Ng?t t? RB0
       INTCON.INT0IF = 0;
       LATE.LATE1 = ~LATE.LATE1;
       count_RB0++;
       uart_data = 'S'; // Luu d? li?u c?n g?i
       uart_flag = 1; // Ðánh d?u d? g?i trong `main()`


    }

    if (INTCON3.INT1IF) { // Ng?t t? RB1
          INTCON3.INT1IF = 0;
          LATE.LATE0 = ~LATE.LATE0;
          count_RB1++;
          uart_data = 'B'; // Luu d? li?u c?n g?i
          uart_flag = 1; // Ðánh d?u d? g?i trong `main()`


    }
}




void main(void)
{
    // Khai báo

    // Chuong trình
    ADCON1 |= 0x0F;
    CMCON  |= 7;

    // C?u hình Port B
    PORTB = 0x00; LATB = 0x00;
    TRISB0_bit = 1;

    // C?u hình Port E
    PORTE = 0x00; LATE = 0x00;
    TRISE0_bit = 0;  // LED for Connected
    TRISE1_bit = 0;

    PORTD = 0x00;
    TRISD0_bit = 1;
    LATD=0x00;

    LATE.LATD1= 0;
    // C?u hình Port C
    PORTC = 0x00; LATC = 0x00;
    TRISC0_bit = 0;  // Reset pin of ESP8266

        // C?u hình ng?t ngoài INT0 (RB0)
    INTCON.INT0IF = 0; // Xóa c? ng?t ngoài
    INTCON.INT0IE = 1; // Cho phép ng?t ngoài
    INTCON2.INTEDG0 = 1; // Ng?t trên c?nh lên

    // C?u hình ng?t ngoài INT1 (RB1)
    INTCON3.INT1IF = 0; // Xóa c? ng?t INT1
    INTCON3.INT1IE = 1; // Cho phép ng?t INT1
    INTCON2.INTEDG1 = 1; // Ng?t khi RB1 có c?nh lên

    // C?u hình ng?t USB
    PIR2.USBIF = 0; // Xóa c? ng?t USB
    PIE2.USBIE = 1; // Cho phép ng?t USB

    // Kích ho?t ng?t toàn c?c
    INTCON.GIE = 1;
    INTCON.PEIE = 1;
    UART1_Init(115200);
    delay_ms(100);

    // Reset for ESP8266 module
    RC0_bit = 0; delay_ms(100); RC0_bit = 1;

    delay_ms(1000);  // For ESP8266 stable



    esp8266_mode(ESP8266_STATION);              // Command: AT+CWMODE=1 - Put the module in Station mode
    esp8266_connect("CV_RoboticX7.6", "J4e4muVG");       // Command: AT+CWJAP="ssid","pass" - Connect to an access point
    esp8266_start(ESP8266_TCP, "192.168.2.100", 8000); // Command: AT+CIPSTART="TCP","ip",port - Start a TCP connection

    RC1_bit = 1; // Warning - Connect to Server
    esp8266_trans_mode(ESP8266_TRANS_PASS); // Command: AT+CIPMODE="mode" - Transparent Receiving Transmission
    esp8266_send();  // Command: AT+CIPSEND - send data

    // Enable interrupts
    RCIF_bit = 0;      // Clear interrupt bit
    RCIE_bit = 1;      // Enable the USART receive interrupt
    GIE_bit = 1;       // Enable global interrupt
    PEIE_bit = 1;      // Enable peripheral interrupts

        while(1) {
            char buffer[10]; // Chu?i ch?a d? li?u g?i

            if (uart_flag) {
                uart_flag = 0;
                UART1_Write(uart_data); // G?i ký t? S/B
            }


        if (receive_flag) {
            receive_flag = 0;
            if (ReceiveData == '@') {
                LATE.LATE1 = 1;
                UART1_Write('O');
            }else if (ReceiveData == '$') {
                LATE.LATE1 = 0;
                UART1_Write('S');
            }  else if (ReceiveData =='B'){
                 LATE.LATE0 = 1 ;
                     if (RD0_bit == 1) {
                     UART1_Write('B'); // G?i ký t? 'B' n?u RD0 = 1

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