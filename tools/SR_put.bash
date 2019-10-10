#!/bin/bash
#
#  Copyright (c) 2019  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Thursday, October 10 13:49:39 CEST 2019
# version : 0.0.1

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"


function put_funct
{
    local pv=$1; shift;
    local val=$@; 
    local sleep_interval=.1
    ${PUT_CMD} ${pv} ${val}
    sleep ${sleep_interval}
}


declare -a scanlist=("Passive" "Event" "I/O Intr" "10 second" "5 second" "2 second" "1 second" ".5 second" ".2 second" ".1 second")


#options="7"


PUT_CMD="caput"


# while getopts "${options}" opt; do
#     case "${opt}" in
# 	7) PUT_CMD="pvput"     ;;
# 	\?)
# 	    echo "Invalid option: -$OPTARG" >&2
# 	    ;;
#     esac
# done
# shift $((OPTIND-1))

P="$1"

if [ -z $P ]; then
    P="ioc_test:"
else
    P="${P}:"
fi


if hash ${PUT_CMD} 2>/dev/null ; then
    
    a=$(tr -cd 0-9 </dev/urandom | head -c 2)
    put_funct ${P}SR_aoDISP.DISP $a
    #
    b=$(tr -cd 0-9 </dev/urandom | head -c 2)
    put_funct ${P}SR_ao.PREC $b
    #
    c=$(tr -cd 0-9 </dev/urandom | head -c 2)
    put_funct ${P}SR_bo.IVOV $c
    #
    d=$(tr -cd 0-9 </dev/urandom | head -c 2)
    size=${#scanlist[@]}
    index=$(($RANDOM % $size))
    put_funct ${P}SR_ao.SCAN "${scanlist[$index]}"
    #
    e=$(tr -cd 0-9 </dev/urandom | head -c 3)
    put_funct ${P}SR_ao.VAL $e.1
    #
    f=$(tr -cd a-z </dev/urandom | head -c 128)
    put_funct ${P}SR_ao.DESC $f
    #
    put_funct ${P}SR_ao.OUT "abc:rec PP"
    #
    g=$(tr -cd 0-9 </dev/urandom | head -c 3)
    put_funct ${P}SR_longout $g
    #
    h=$(tr -cd 0-9 </dev/urandom | head -c 1)
    put_funct ${P}SR_bi.SVAL $h
    #
    i=$(tr -cd a-z </dev/urandom | head -c 5)
    put_funct -S ${P}SR_char_array "$i"
    
    put_funct -a ${P}SR_double_array $a $b $c $d $e $g
    put_funct -a ${P}SR_float_array $g $a $b $c $d $e $h 
    put_funct -a ${P}SR_long_array $g $a $b $c $d $e $g
    put_funct -a ${P}SR_short_array $g $a $b $c $d $e $g
    put_funct -a ${P}SR_string_array 3 $f abc def ghi
    put_funct -a ${P}SR_uchar_array $g $a $b $c $d 0 0
    put_funct -a ${P}SR_ulong_array $g $a $b $c $d $e $g
    put_funct -a ${P}SR_ushort_array $g $a $b $c $d $e $g

else
    printf "\n>>>> We cannot run $0\n";
    printf "     because we cannot find $GET_CMD in the system\n"
    printf "     please source setE3Env.bash first\n"
    printf "\n"
    exit;
fi
