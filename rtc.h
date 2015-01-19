
//extern const char pvtaul[12]; // taulukko jossa paivien lukum/kuukausi
// -- tarvitaanko tata ulkopuolella?

#define API

extern char rtc_time_lost;
void rtcinit();
void    (*kelloas)(int msec,int pvm ) = 0x800a510;
void (*kelloasetus)(int) = 0x800a648;
void (*pvm)(int,int *) = 0x800a3a8;
int (*viikonpv)() = 0x800a428;
int unixdate();
int unixtime();

void wakeup(int);
void sleep(int);
void stop(int);
void standby(int);

#ifdef STM32F1
// uudemman mallisen rtc:n kirjastossa olevien juttujen korvikkeita

typedef struct {
   unsigned char RTC_Hours;
   unsigned char RTC_Minutes;
   unsigned char RTC_Seconds;
   unsigned char RTC_H12;
} RTC_TimeTypeDef;
typedef struct {
   unsigned char RTC_WeekDay;
   unsigned char RTC_Month;
   unsigned char RTC_Date;
   unsigned char RTC_Year;
} RTC_DateTypeDef;

#define RTC_Format_BIN 0
#define RTC_Format_BCD 1
void RTC_GetTime(unsigned int, RTC_TimeTypeDef *);
void pvm(int date,int *pv);
#else
// korvikkeet vanhalle kirjastolle
#define RTC_SetCounter(m) RTC->TR=m
#define RTC_GetCounter() RTC->TR

#endif

extern int time_correction;
#define UNIX_STAMP ((unixdate()*60*60*24+unixtime())+time_correction)
#define UNIX_STAMP_RAW (unixdate()*60*60*24+unixtime())
