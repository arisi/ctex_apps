
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


void init_mem() {
  memcpy (&_sdata, &_sidata, (void*)&_edata-(void*)&_sdata);
  memset(&_sbss,0,(void*)&_ebss-(void*)&_sbss);
}

int __attribute__((section("buut"))) appi(int z) {
  init_mem();
  printf("Appi initoitu!!\n");

 
  return 0x123456; 
}

