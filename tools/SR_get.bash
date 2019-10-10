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
# Date    : Thursday, October 10 13:48:25 CEST 2019
# version : 0.0.1

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"

GET_CMD="caget"

function get_funct
{
    local pv=$1; shift;
    local sleep_interval=.02
    ${GET_CMD} ${pv}
    sleep ${sleep_interval}
}


options="7"



while getopts "${options}" opt; do
    case "${opt}" in
	7) GET_CMD="pvget"     ;;
	\?)
	    echo "Invalid option: -$OPTARG" >&2
	    ;;
    esac
done
shift $((OPTIND-1))

P="$1"

if [ -z $P ]; then
    P="ioc_test:"
else
    P="${P}:"
fi

if hash ${GET_CMD} 2>/dev/null ; then
    
    get_funct ${P}SR_aoDISP.DISP
    get_funct ${P}SR_ao.PREC
    get_funct ${P}SR_bo.IVOV
    get_funct ${P}SR_ao.SCAN
    get_funct ${P}SR_ao.VAL
    get_funct ${P}SR_ao.DESC
    get_funct ${P}SR_ao.OUT
    get_funct ${P}SR_longout
    get_funct ${P}SR_bi.SVAL
    get_funct ${P}SR_char_array
    get_funct ${P}SR_double_array
    get_funct ${P}SR_float_array
    get_funct ${P}SR_long_array
    get_funct ${P}SR_short_array
    get_funct ${P}SR_string_array
    get_funct ${P}SR_uchar_array
    get_funct ${P}SR_ulong_array
    get_funct ${P}SR_ushort_array
else
    printf "\n>>>> We cannot run $0\n";
    printf "     because we cannot find $GET_CMD in the system\n"
    printf "     please source setE3Env.bash first\n"
    printf "\n"
    exit;
fi
