#!/bin/bash
P="ioc_test:"
a=$(tr -cd 0-9 </dev/urandom | head -c 2)
caput ${P}SR_aoDISP.DISP $a
b=$(tr -cd 0-9 </dev/urandom | head -c 2)
caput ${P}SR_ao.PREC $b
c=$(tr -cd 0-9 </dev/urandom | head -c 2)
caput ${P}SR_bo.IVOV $c
d=$(tr -cd 0-9 </dev/urandom | head -c 1)
caput ${P}SR_ao.SCAN $d
e=$(tr -cd 0-9 </dev/urandom | head -c 3)
caput ${P}SR_ao.VAL $e.1
f=$(tr -cd a-z </dev/urandom | head -c 5)
caput ${P}SR_ao.DESC $f
caput ${P}SR_ao.OUT "abc:rec PP"
g=$(tr -cd 0-9 </dev/urandom | head -c 3)
caput ${P}SR_longout $g
h=$(tr -cd 0-9 </dev/urandom | head -c 1)
caput ${P}SR_bi.SVAL $h
i=$(tr -cd a-z </dev/urandom | head -c 5)
caput -S ${P}SR_char_array "$i"
caput -a ${P}SR_double_array $a $b $c $d $e $g
caput -a ${P}SR_float_array $g $a $b $c $d $e $h 
caput -a ${P}SR_long_array $g $a $b $c $d $e $g
caput -a ${P}SR_short_array $g $a $b $c $d $e $g
caput -a ${P}SR_string_array 3 $f abc def ghi
caput -a ${P}SR_uchar_array $g $a $b $c $d $e $g
caput -a ${P}SR_ulong_array $g $a $b $c $d $e $g
caput -a ${P}SR_ushort_array $g $a $b $c $d $e $g
