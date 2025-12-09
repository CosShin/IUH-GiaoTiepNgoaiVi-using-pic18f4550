# 1 "Wifi.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 285 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include/language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "Wifi.c" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdbool.h" 1 3
# 2 "Wifi.c" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdint.h" 1 3



# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/musl_xc8.h" 1 3
# 5 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdint.h" 2 3
# 26 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdint.h" 3
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 1 3
# 133 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef unsigned __int24 uintptr_t;
# 148 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef __int24 intptr_t;
# 164 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef signed char int8_t;




typedef short int16_t;




typedef __int24 int24_t;




typedef long int32_t;





typedef long long int64_t;
# 194 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef long long intmax_t;





typedef unsigned char uint8_t;




typedef unsigned short uint16_t;




typedef __uint24 uint24_t;




typedef unsigned long uint32_t;





typedef unsigned long long uint64_t;
# 235 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef unsigned long long uintmax_t;
# 27 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdint.h" 2 3

typedef int8_t int_fast8_t;

typedef int64_t int_fast64_t;


typedef int8_t int_least8_t;
typedef int16_t int_least16_t;

typedef int24_t int_least24_t;
typedef int24_t int_fast24_t;

typedef int32_t int_least32_t;

typedef int64_t int_least64_t;


typedef uint8_t uint_fast8_t;

typedef uint64_t uint_fast64_t;


typedef uint8_t uint_least8_t;
typedef uint16_t uint_least16_t;

typedef uint24_t uint_least24_t;
typedef uint24_t uint_fast24_t;

typedef uint32_t uint_least32_t;

typedef uint64_t uint_least64_t;
# 148 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdint.h" 3
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/stdint.h" 1 3
typedef int16_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef uint16_t uint_fast16_t;
typedef uint32_t uint_fast32_t;
# 149 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdint.h" 2 3
# 3 "Wifi.c" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdio.h" 1 3
# 10 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdio.h" 3
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/features.h" 1 3
# 11 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdio.h" 2 3
# 24 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdio.h" 3
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 1 3
# 12 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef void * va_list[1];




typedef void * __isoc_va_list[1];
# 128 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef unsigned size_t;
# 143 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef __int24 ssize_t;
# 255 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef long long off_t;
# 409 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef struct _IO_FILE FILE;
# 25 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdio.h" 2 3
# 52 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/stdio.h" 3
typedef union _G_fpos64_t {
 char __opaque[16];
 double __align;
} fpos_t;

extern FILE *const stdin;
extern FILE *const stdout;
extern FILE *const stderr;





FILE *fopen(const char *restrict, const char *restrict);
FILE *freopen(const char *restrict, const char *restrict, FILE *restrict);
int fclose(FILE *);

int remove(const char *);
int rename(const char *, const char *);

int feof(FILE *);
int ferror(FILE *);
int fflush(FILE *);
void clearerr(FILE *);

int fseek(FILE *, long, int);
long ftell(FILE *);
void rewind(FILE *);

int fgetpos(FILE *restrict, fpos_t *restrict);
int fsetpos(FILE *, const fpos_t *);

size_t fread(void *restrict, size_t, size_t, FILE *restrict);
size_t fwrite(const void *restrict, size_t, size_t, FILE *restrict);

int fgetc(FILE *);
int getc(FILE *);
int getchar(void);





int ungetc(int, FILE *);
int getch(void);

int fputc(int, FILE *);
int putc(int, FILE *);
int putchar(int);





void putch(char);

char *fgets(char *restrict, int, FILE *restrict);

char *gets(char *);


int fputs(const char *restrict, FILE *restrict);
int puts(const char *);

__attribute__((__format__(__printf__, 1, 2)))
int printf(const char *restrict, ...);
__attribute__((__format__(__printf__, 2, 3)))
int fprintf(FILE *restrict, const char *restrict, ...);
__attribute__((__format__(__printf__, 2, 3)))
int sprintf(char *restrict, const char *restrict, ...);
__attribute__((__format__(__printf__, 3, 4)))
int snprintf(char *restrict, size_t, const char *restrict, ...);

__attribute__((__format__(__printf__, 1, 0)))
int vprintf(const char *restrict, __isoc_va_list);
int vfprintf(FILE *restrict, const char *restrict, __isoc_va_list);
__attribute__((__format__(__printf__, 2, 0)))
int vsprintf(char *restrict, const char *restrict, __isoc_va_list);
__attribute__((__format__(__printf__, 3, 0)))
int vsnprintf(char *restrict, size_t, const char *restrict, __isoc_va_list);

__attribute__((__format__(__scanf__, 1, 2)))
int scanf(const char *restrict, ...);
__attribute__((__format__(__scanf__, 2, 3)))
int fscanf(FILE *restrict, const char *restrict, ...);
__attribute__((__format__(__scanf__, 2, 3)))
int sscanf(const char *restrict, const char *restrict, ...);

__attribute__((__format__(__scanf__, 1, 0)))
int vscanf(const char *restrict, __isoc_va_list);
int vfscanf(FILE *restrict, const char *restrict, __isoc_va_list);
__attribute__((__format__(__scanf__, 2, 0)))
int vsscanf(const char *restrict, const char *restrict, __isoc_va_list);

void perror(const char *);

int setvbuf(FILE *restrict, char *restrict, int, size_t);
void setbuf(FILE *restrict, char *restrict);

char *tmpnam(char *);
FILE *tmpfile(void);




FILE *fmemopen(void *restrict, size_t, const char *restrict);
FILE *open_memstream(char **, size_t *);
FILE *fdopen(int, const char *);
FILE *popen(const char *, const char *);
int pclose(FILE *);
int fileno(FILE *);
int fseeko(FILE *, off_t, int);
off_t ftello(FILE *);
int dprintf(int, const char *restrict, ...);
int vdprintf(int, const char *restrict, __isoc_va_list);
void flockfile(FILE *);
int ftrylockfile(FILE *);
void funlockfile(FILE *);
int getc_unlocked(FILE *);
int getchar_unlocked(void);
int putc_unlocked(int, FILE *);
int putchar_unlocked(int);
ssize_t getdelim(char **restrict, size_t *restrict, int, FILE *restrict);
ssize_t getline(char **restrict, size_t *restrict, FILE *restrict);
int renameat(int, const char *, int, const char *);
char *ctermid(char *);







char *tempnam(const char *, const char *);
# 4 "Wifi.c" 2
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/string.h" 1 3
# 25 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/string.h" 3
# 1 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 1 3
# 421 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/bits/alltypes.h" 3
typedef struct __locale_struct * locale_t;
# 26 "C:\\Program Files\\Microchip\\xc8\\v3.00\\pic\\include\\c99/string.h" 2 3

void *memcpy (void *restrict, const void *restrict, size_t);
void *memmove (void *, const void *, size_t);
void *memset (void *, int, size_t);
int memcmp (const void *, const void *, size_t);
void *memchr (const void *, int, size_t);

char *strcpy (char *restrict, const char *restrict);
char *strncpy (char *restrict, const char *restrict, size_t);

char *strcat (char *restrict, const char *restrict);
char *strncat (char *restrict, const char *restrict, size_t);

int strcmp (const char *, const char *);
int strncmp (const char *, const char *, size_t);

int strcoll (const char *, const char *);
size_t strxfrm (char *restrict, const char *restrict, size_t);

char *strchr (const char *, int);
char *strrchr (const char *, int);

size_t strcspn (const char *, const char *);
size_t strspn (const char *, const char *);
char *strpbrk (const char *, const char *);
char *strstr (const char *, const char *);
char *strtok (char *restrict, const char *restrict);

size_t strlen (const char *);

char *strerror (int);




char *strtok_r (char *restrict, const char *restrict, char **restrict);
int strerror_r (int, char *, size_t);
char *stpcpy(char *restrict, const char *restrict);
char *stpncpy(char *restrict, const char *restrict, size_t);
size_t strnlen (const char *, size_t);
char *strdup (const char *);
char *strndup (const char *, size_t);
char *strsignal(int);
char *strerror_l (int, locale_t);
int strcoll_l (const char *, const char *, locale_t);
size_t strxfrm_l (char *restrict, const char *restrict, size_t, locale_t);




void *memccpy (void *restrict, const void *restrict, int, size_t);
# 5 "Wifi.c" 2
# 29 "Wifi.c"
char TransmitData, ReceiveData;
volatile bit transmit_flag, receive_flag;


void _esp8266_putch(char bt);
char _esp8266_getch(void);
void _esp8266_send_string(char* st_pt);
void _esp8266_print(unsigned char *ptr);
uint16_t _esp8266_waitFor(unsigned char *string);
void _esp8266_restart(void);
void _esp8266_isStarted(void);
void _esp8266_echoCmds(_Bool echo);
void _esp8266_mode(unsigned char mode);
void _esp8266_trans_mode(unsigned char mode);
void _esp8266_connect(unsigned char* ssid, unsigned char* pass);
unsigned char _esp8266_start(unsigned char protocol, unsigned char* ip, unsigned int port);
void _esp8266_send(void);
void _esp8266_receive(unsigned char* store_in);
void _esp8266_disconnect(void);
void _esp8266_stop_send(void);
void _esp8266_del_TCP(void);


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
    _esp8266_print("AT+RST\r\n");
    _esp8266_waitFor("OK");
    _esp8266_waitFor("ready");
}

 void _esp8266_isStarted(void) {
    _esp8266_print("AT\r\n");
    _esp8266_waitFor("OK");
}

  void _esp8266_echoCmds(_Bool echo)
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

void _esp8266_mode(unsigned char mode)
{
    _esp8266_print("AT+CWMODE=");
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK");
}
void _esp8266_trans_mode(unsigned char mode)
{
    _esp8266_print("AT+CIPMODE=");
    _esp8266_putch(mode + '0');
    _esp8266_print("\r\n");
    _esp8266_waitFor("OK");
}
void _esp8266_connect(unsigned char* ssid, unsigned char* pass)
{
    _esp8266_print("AT+CWJAP=\"");
    _esp8266_print(ssid);
    _esp8266_print("\",\"");
    _esp8266_print(pass);
    _esp8266_print("\"\r\n");
    _esp8266_waitFor("OK");
}
# 155 "Wifi.c"
unsigned char _esp8266_start(unsigned char protocol, unsigned char* ip, unsigned int port) {
    unsigned char port_str[6];
    sprintf(port_str, "%u", port);

    _esp8266_print("AT+CIPSTART=\"");
    _esp8266_print((protocol == 1) ? "TCP" : "UDP");
    _esp8266_print("\",\"");
    _esp8266_print(ip);
    _esp8266_print("\",");
    _esp8266_print(port_str);
    _esp8266_print("\r\n");

    return _esp8266_waitFor("OK");
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
    CMCON |= 7;

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
    _esp8266_mode(0x01);
    _esp8266_connect("Tang2_5G", "1234567890@");
    _esp8266_start(1, "192.168.2.32", 8000);

    RE0_bit = 1;
    _esp8266_trans_mode(1);
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
                _esp8266_trans_mode(0);
                _esp8266_del_TCP();
            }
        }
    }
}
