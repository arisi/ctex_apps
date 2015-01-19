SECTIONS {
  . = 0x0801f000;


  .text : {
    *(buut)
    *(stub)
    *(.text)
  }

  text_end = . ;

  .rodata : {
    *(work)
    *(.rodata)
    *(.rodata.*)
  }

  rodata_end = . ;

  _sidata = . ;

  . = 0x2000054c;
  .data : AT (_sidata) {
    _sdata = . ;
    *(.data)
    _edata = . ;
  }

  .bss : { _sbss = . ;
    *(.bss)
    _ebss = . ;
  }
}
