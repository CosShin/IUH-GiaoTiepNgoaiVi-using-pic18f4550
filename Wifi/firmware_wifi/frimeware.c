#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

// ESP8266 Constants
#define ESP8266_STATION 0x01
#define ESP8266_SOFTAP 0x02
#define ESP8266_BOTH 0x03
#define ESP8266_TCP 1
#define ESP8266_UDP 0
#define ESP8266_TRANS_PASS 1
#define ESP8266_TRANS_NOR 0
#define ESP8266_OK 1
#define ESP8266_READY 2
#define ESP8266_FAIL 3
#define ESP8266_NOCHANGE 4
#define ESP8266_LINKED 5
#define ESP8266_UNLINK 6
#define ESP8266_CONNECT 7

// Global variables
char TransmitData, ReceiveData;
bit transmit_flag, receive_flag;

void interrupt(void)
{
    if ((RCIE_bit == 1) && (RCIF_bit == 1))
    {
        RCIF_bit = 0; // Clear interrupt bit
        ReceiveData = UART1_Read(); // Read data from UART
        receive_flag = 1;
    }
}

//** Function to send one byte of data to UART **//
void _esp8266_putch(char bt)
{
    while (!TXIF_bit); // Hold the program till TX buffer is free
    TXREG = bt; // Load the transmitter buffer with the received value
}

//** Function to get one byte of data from UART **//
char esp8266_getch()
{
    if (OERR_bit) // Check for error
    {
        CREN_bit = 0;
        CREN_bit = 1; // If error -> Reset
    }

    while (!RCIF_bit); // Hold the program till RX buffer is free
    return RCREG; // Receive the value and send it to main function
}

//** Function to send a string via UART **//
void ESP8266_send_string(char* st_pt)
{
    while (*st_pt) // If there is a char
    {
        _esp8266_putch(*st_pt++); // Process it as byte data
    }
}

//** Function to restart ESP8266 **//
void esp8266_restart(void)
{
    _esp8266_print("AT+RST\r\n"); // Send reset command
    _esp8266_waitFor("OK"); // Wait for "OK"
    _esp8266_waitFor("ready"); // Wait for "ready"
}

//** Function to check if ESP8266 is started **//
void esp8266_isStarted(void)
{
    _esp8266_print("AT\r\n"); // Send AT command
    _esp8266_waitFor("OK"); // Wait for "OK"
}

//** Function to print a string to ESP8266 **//
void _esp8266_print(unsigned char *ptr)
{
    while (*ptr != 0)
    {
        _esp8266_putch(*ptr++);
    }
}

//** Function to wait until a specific string is received **//
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

//** Function to enable or disable command echoing **//
void esp8266_echoCmds(bool echo)
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

//** Function to set ESP8266 mode **//
void esp8266_mode(unsigned char mode)
{
    _esp8266_print("AT+CWMODE=");
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK"); // Wait for "OK"
}

//** Function to set ESP8266 transparent mode **//
void esp8266_trans_mode(unsigned char mode)
{
    _esp8266_print("AT+CIPMODE=");
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK"); // Wait for "OK"
}

//** Function to connect to an access point **//
void esp8266_connect(unsigned char* ssid, unsigned char* pass)
{
    _esp8266_print("AT+CWJAP=\"");
    _esp8266_print(ssid);
    _esp8266_print("\",\"");
    _esp8266_print(pass);
    _esp8266_print("\"\r\n");
    _esp8266_waitFor("OK"); // Wait for "OK"
}

//** Function to start ESP8266 connection **//
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
    _esp8266_print("+++\");
    delay_ms(2000);
}

void esp8266_del_TCP(void)
{
    _esp8266_print("AT+CIPCLOSE\r\n");
    _esp8266_waitFor("OK");
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
    TRISE0_bit = 0;    // LED for Connected
    TRISE1_bit = 0;

    // C?u hình Port C
    PORTC = 0x00; LATC = 0x00;
    TRISC0_bit = 0;    // Reset pin of ESP8266

    UART1_Init(115200);
    delay_ms(100);

    // Reset for ESP8266 module
    RC0_bit = 0;
    delay_ms(100);
    RC0_bit = 1;

    delay_ms(1000);    // For ESP8266 stable

    //=================================================
    // Configure: Station, TCP Client Single connection UART-Wifi Passthrough
    esp8266_restart();    // Command: AT+RST - Restart module
    esp8266_echoCmds(0);  // Command: ATE0 - Enable(1)/Disable(0) echo
    esp8266_isStarted();  // Command: AT - Wait till the ESP send back "OK"

    esp8266_mode(ESP8266_STATION);  // Command: AT+CWMODE=1 - Put the module in Station mode
    esp8266_connect("TOI_AI LAB", "pqtri2002");  // Command: AT+CWJAP="ssid","pass" - Connect to an access point
    esp8266_start(ESP8266_TCP, "192.168.1.49", 8000);  // Command: AT+CIPSTART="protocol","ip",port - Start a TCP network in that IP and port

    RE0_bit = 1;  // LED Connect ON
    esp8266_trans_mode(ESP8266_TRANS_PASS);  // Command: AT+CIPMODE="mode" - Select Passthrough Receiving Mode (Transparent Receiving Transmission)
    esp8266_send();  // Command: AT+CIPSEND - Send data

    //=================================================
    RCIF_bit = 0;    // Clear interrupt bit
    PIE1.RCIE = 1;   // Enable the EUSART receive interrupt
    GIE_bit = 1;     // Enable global interrupt
    PEIE_bit = 1;    // Enable peripheral interrupts

    while(1)
    {
        /******* Button 1 ****************************/
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
            else if (ReceiveData == 'Z') // Ng?t k?t n?i
            {
                GIE_bit = 0;  // Disable global interrupt
                RE0_bit = 0;  // Warning: Disconnect Server (LED Connect OFF)

                esp8266_stop_send();  // Command: +++ - Stop sending data
                esp8266_trans_mode(ESP8266_TRANS_NOR);  // Command: AT+CIPMODE="mode" - Disable UART - WiFi passthrough mode (transparent transmission)
                esp8266_del_TCP();  // Command: AT+CIPCLOSE - Delete TCP connection
            }
        }
    }
}

}