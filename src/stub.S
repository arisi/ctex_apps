  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  .section stub

  .type memcpy,%function
  .global memcpy
  .set memcpy,0x8009a79
  .type memset,%function
  .global memset
  .set memset,0x8009a95
  .type my_fprintf,%function
  .global my_fprintf
  .set my_fprintf,0x8007835
  .type stdout,%object
  .global stdout
  .set stdout,0x20000260
