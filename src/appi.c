
#include <stdlib.h>
#include <stdio.h>
#include "rbuf.h"
#include "p3.h"
#include "nrf24.h"
#include "scheduler.h"
#include "string.h"
#include "STM32L_flash.h"

int countti=0;
extern unsigned int _sdata,_sidata,_edata,_sbss,_ebss;

void appi_task() {
  printf("Appi-taski %d\n",countti);
  countti+=1;
}

int appi_nRF_send(char proto,unsigned int ip,unsigned int port,char *buf) {
  nRF_q_t spac;
  spac.mac=p3_my_mac;
  spac.pipe=0;
  memset(spac.buf,0,sizeof(spac.buf));
  sprintf(spac.buf,"p3>%s",buf);
  rbuf_large_push(nRF_obuf, &spac);
  printf("Sent some!\n");
  return 0;
}

int appi_p3_send(char proto,unsigned int ip,unsigned int port,char *buf) {
  p3_t spac;
  spac.h.mac=p3_my_mac;
  spac.h.ip=ip;
  spac.h.proto=proto;
  spac.h.port=port;
  spac.h.len=strlen(buf);
  if (spac.h.len>MAX_P3_PACKET_LEN) {
    printf("Error: too long packet\n");
    return -1;
  } else {
    printf("OK: send packet size=%d, max=%d\n",spac.h.len,MAX_P3_PACKET_LEN);
    strncpy(spac.buf,buf,spac.h.len);
    rbuf_large_push(p3_obuf, &spac);
  }
  return 0;
}

int appi_do_low(char *buf, char *outbuf) {
  strcpy(outbuf,"?");
  unsigned char *p;
  switch (buf[0]) {
    case 'P':
      sprintf(outbuf,"pong!");
      break;
    case 'R':
      p=(void*)htoi(&buf[1]); 
      sprintf(outbuf,"%08X:",p);
      for (int i=0;i<4;i++)
        sprintf(&outbuf[strlen(outbuf)],"%02X ",p[i]);
      break;
  }
  printf("done low '%s'\n",outbuf);
  return 0;
}


void appi_p3_in_task(int t) {
  int i=rbuf_items(p3_ibuf);
  if (i) {
    p3_t pac;
    rbuf_large_pull(p3_ibuf,&pac);
    printf("APP-p3 in (mac=%04X, ip=%08X, port=%d,proto=%c):",pac.h.mac,pac.h.ip,pac.h.port,pac.h.proto);
    for (int i=0; i<pac.h.len; i++)
      printf("%02X ",pac.buf[i]);
    printf("\n");
    for (int i=0; i<pac.h.len; i++)
      printf("%c",pac.buf[i]);
    printf("\n");

    char outbuf[50];
    appi_do_low(pac.buf,outbuf);
    appi_p3_send(pac.h.proto,pac.h.ip,pac.h.port,outbuf);
  }
  sch_block_task(t, p3_ibuf);
}

void appi_nRF_in_task(int t) {
  int i=rbuf_items(nRF_ibuf);
  if (i) {
    nRF_q_t pac;
    rbuf_large_pull(nRF_ibuf,&pac);
    printf("APPI-nRF24 in (mac=%04X, pipe=%d):",pac.mac,pac.pipe);
    for (int i=0; i<sizeof(pac.buf); i++)
      printf("%02X ",pac.buf[i]);
    printf("\n");
    char buf[20];
    sprintf(buf,"%d: nRF24 in (mac=%04X, pipe=%d):\n",a,pac.mac,pac.pipe);
    p3_t spac;
    spac.h.mac=p3_my_mac;
    spac.h.ip=0x14141415;
    spac.h.proto='U';
    spac.h.port=8099;
    spac.h.len=strlen(buf);
    if (spac.h.len>MAX_P3_PACKET_LEN)
      printf("Error: too long packet\n");
    else {
      memcpy(spac.buf,buf,spac.h.len);
      rbuf_large_push(p3_obuf, &spac);
    }
  }
  sch_block_task(t, nRF_ibuf);
}


int STM32L_write_block(unsigned int blk,char *buf,unsigned int len)
{
  unsigned int a=0x8000000+blk*STM32L_FLASH_BLOCK;
  STM32L_write(a,buf,len); 
  return(0);
}


#ifdef CONF_TERMINAL
int appi_terminal(int argc,char **argv)
{
  puts("Appitermi\n");
  if (strcmp(argv[0],"erase")==0) {
    unsigned int blk=htoi(argv[1]);
    int iflash_start=0x8000000;
    unsigned int a=iflash_start+blk*STM32L_FLASH_BLOCK;
    printf("STM32L_erase_blockzzz (%X -> %08X)\n",blk,a);
    STM32L_erase_block(blk);
  } else if (strcmp(argv[0],"write")==0) {
    unsigned int blk=htoi(argv[1]);
    int iflash_start=0x8000000;
    unsigned int a=iflash_start+blk*STM32L_FLASH_BLOCK;
    printf("STM32L_write (%X -> %08X)\n",blk,a);
    char *buf="MOIKKAS KAIKKI";
    STM32L_write_block(blk,buf,strlen(buf));
  }
  return(0);
}
#endif


void init_mem() {
  memcpy (&_sdata, &_sidata, (void*)&_edata-(void*)&_sdata);
  memset(&_sbss,0,(void*)&_ebss-(void*)&_sbss);
}

int __attribute__((section("buut"))) appi(int z) {
  init_mem();
  printf("Appi initoitu!\n");

  sch_add_task("APP_TICK", 10000, (void*)&appi_task);
  sch_add_task("APP_P3_IN", 1000, (void*)&appi_p3_in_task);
  sch_add_task("APP_NRF_IN", 1000, (void*)&appi_nRF_in_task);
  // return 0;
  #ifdef CONF_TERMINAL
  terminal_add_cmd("xx",0,(void*)&appi_terminal);
  #endif
  return 0x123456;
}

