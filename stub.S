  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  .section .text

  .weak testeri
testeri:
   b 0x8000165

