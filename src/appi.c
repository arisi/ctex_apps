
#include <stdlib.h>
#include <stdio.h>

int countti=0;
extern unsigned int _sdata,_sidata,_edata,_sbss,_ebss;

void appi_task() {
  if (countti&1)
    printf("Appi-taski %d xxxxxxx!!\n",countti);
  else
    printf("Appi-taski %d uuuu\n",countti);
  countti+=1;
}

#ifdef CONF_TERMINAL
int appi_terminal(int argc,char **argv)
{
  puts("OUJEE!!\n");
  if (strcmp(argv[0],"stat")==0) {
    printf("KAIKKI HYVIN!\n");
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
  sch_add_task("APPIX", 10000, (void*)&appi_task);
  #ifdef CONF_TERMINAL
  terminal_add_cmd("appi",0,(void*)&appi_terminal);
  #endif
  return 0x123456;
}

