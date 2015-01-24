
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

int appi_p3_send(char *buf) {
  p3_t spac;
  spac.h.mac=p3_my_mac;
  spac.h.ip=0x14141415;
  spac.h.proto='U';
  spac.h.port=8099;
  spac.h.len=strlen(buf);
  if (spac.h.len>MAX_P3_PACKET_LEN) {
    printf("Error: too long packet\n");
    return -1;
  } else {
    strncpy(spac.buf,buf,spac.h.len);
    rbuf_large_push(p3_obuf, &spac);
  }
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

    if (strncmp(pac.buf,"ping",4)==0) {
      puts("HEY, ITS PING FROM MASTER\n");
      appi_p3_send("PONG ITELLES\n");
    }
    if (strncmp(pac.buf,"s",1)==0) {
      nRF_q_t spac;
      spac.mac=p3_my_mac;
      spac.pipe=0;
      memset(spac.buf,0,sizeof(spac.buf));
      sprintf(spac.buf,"p3>%s",pac.buf);
      rbuf_large_push(nRF_obuf, &spac);
      printf("Sent some!\n");
    } else if (strcmp(pac.buf,"clear\n")==0) {
      nRF_flush();
      printf("Cleared \n");
    }
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
  return 0;
  #ifdef CONF_TERMINAL
  terminal_add_cmd("appi",0,(void*)&appi_terminal);
  #endif
  return 0x123456;
}

