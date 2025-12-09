
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

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



// Command: AT+CIPSEND - send data

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