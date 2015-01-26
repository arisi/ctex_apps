
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
  case 'E':
    p=(void*)htoi(&buf[1]);
    unsigned int blk=((unsigned int)(p-0x8000000))/STM32L_FLASH_BLOCK;
    sprintf(outbuf,"E:%08X:%06X",p,blk);
    STM32L_erase_block(blk);
    break;
  case 'R':
    if (strlen(buf)<10) {
      printf("Error: too short args\n");
      return -1;
    }
    unsigned int checksum=0;
    p=(void*)htoin(&buf[1],8);
    unsigned int len=htoi(&buf[9]);
    if (len>16)
      len=16;
    sprintf(outbuf,"S3%02X%08X",len+5,p);
    for (int i=0; i<len; i++)
      sprintf(&outbuf[strlen(outbuf)],"%02X",p[i]);
    for (int i=2; i<strlen(outbuf); i+=2) {
      unsigned char val=htoin(&outbuf[i],2);
      checksum+=val;
      printf(">> %02X -> %04X\n",val,checksum);
    };
    sprintf(&outbuf[strlen(outbuf)],"%02X",0xff&(~(checksum&0xff)));
    break;
  case 'S':
    //S30D0801F1088DF8453014238DF83A
    //S30D0801E1088DF8453014238DF84A
    //01234567890123456
    if (buf[1]=='3') {
      p=(void*)htoin(&buf[4],8);
      int len=htoin(&buf[2],2)-5;       // 4 for addressa, 1 for checksun, rest is data
      unsigned int checksum=htoin(&buf[12+len*2],2);
      unsigned int cchecksum=0;
      for (int i=2; i<strlen(buf)-2; i+=2) {
        unsigned char val=htoin(&buf[i],2);
        cchecksum+=val;
      };
      cchecksum=0xff&(~(cchecksum&0xff));
      if (checksum!=cchecksum) {
        printf("Checksum Mismatch: %02X != %02X\n",checksum,cchecksum);
        return -1;
      }
      if (((int)p)&0x03) {
        printf("Error: Flash Address must by word-aligned\n");
        return -1;
      }
      if (len>16) {
        printf("Error: Flash block too long %d\n",len);
        return -1;
      }
      sprintf(outbuf,"F:%08X:%d:",p,len);
      char fbuf[16];
      int i;
      for (i=0; i<16; i++)
        fbuf[i]=p[i];       // pick old values ;)
      for (i=0; i<len; i++) {
        char val=htoin(&buf[12+i*2],2);
        fbuf[i]=val;
      };
      STM32L_write((int)p,fbuf,len);
      for (i=0; i<len; i++) {
        sprintf(&outbuf[strlen(outbuf)],"%02X ",p[i]);
      }
    }
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

    char outbuf[150];
    appi_do_low(pac.buf,outbuf);
    if (appi_p3_send(pac.h.proto,pac.h.ip,pac.h.port,outbuf)) {
      // send failed
      appi_p3_send(pac.h.proto,pac.h.ip,pac.h.port,"Error!");
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


void init_mem() {
  memcpy (&_sdata, &_sidata, (void*)&_edata-(void*)&_sdata);
  memset(&_sbss,0,(void*)&_ebss-(void*)&_sbss);
}

int __attribute__((section("buut"))) appi(int z) {
  init_mem();
  printf("Appi initoitu!!\n");

  sch_add_task("APP_P3_IN", 1000, (void*)&appi_p3_in_task);
  sch_add_task("APP_NRF_IN", 1000, (void*)&appi_nRF_in_task);
  return 0x123456;
}

