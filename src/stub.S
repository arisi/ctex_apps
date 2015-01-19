  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  .section stub

  .type my_fprintf,%function
  .global my_fprintf
  .set my_fprintf,0x8007bdd
  .type stdout,%object
  .global stdout
  .set stdout,0x2000027d
  .type fputs,%function
  .global fputs
  .set fputs,0x8008875
  .type strcmp,%function
  .global strcmp
  .set strcmp,0x8009fb5
  .type memcpy,%function
  .global memcpy
  .set memcpy,0x8009e81
  .type memset,%function
  .global memset
  .set memset,0x8009e9d
  .type sch_add_task,%function
  .global sch_add_task
  .set sch_add_task,0x800a781
  .type terminal_add_cmd,%function
  .global terminal_add_cmd
  .set terminal_add_cmd,0x800ad11