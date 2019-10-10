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
# Date    : Thursday, October 10 17:21:08 CEST 2019
# version : 0.0.1

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"

declare -gr session0="as_test_session0"
declare -gr session1="as_test_session1"

declare -gr test1="pv_values_at_1"
declare -gr test2="pv_values_at_2"
declare -gr test3="pv_values_at_3"


TOP=${SC_TOP}/..
TARGET=${TOP}/.test
PREFIX=autosaveOutputTOP
#STARTUP=${TOP}/cmds/as_test.cmd
STARTUP="${TOP}/cmds/as_auto_test.cmd TARGET=${TARGET} IOCNAME=${PREFIX}"

function iocsh_within_screen
{
    local top="$1"; shift;
    local session_name="$1"; shift;
    local startup_cmd="$1"; shift;
    local sleep_time="$1"; shift;

    cat > ${top}/.screenrc <<EOF
logfile ${top}/output.log
logfile flush 1
log on
logtstamp after 1
logtstamp on
EOF
    
    screen -c ${top}/.screenrc -dm -L -S ${session_name} /bin/bash -c "${E3_REQUIRE_LOCATION}/bin/iocsh.bash ${startup_cmd}" &

    sleep ${sleep_time}
    
    cat ${top}/output.log

    sleep 1
    
}

function kill_screen
{
    local session_name="$1"; shift;
    screen -X -S ${session_name} quit
}
#
mkdir -p ${TARGET}

#
#
echo ">>> Start IOC ........ "
iocsh_within_screen ${TARGET} ${session0} "${STARTUP}" "15"

echo ""
echo ">>> Get, Put, Get PVs"

bash ${SC_TOP}/SR_get.bash "${PREFIX}" > ${TARGET}/${test1}
echo "${TARGET}/${test1}"
cat ${TARGET}/${test1}
bash ${SC_TOP}/SR_put.bash "${PREFIX}"
bash ${SC_TOP}/SR_get.bash "${PREFIX}" > ${TARGET}/${test2}
echo "${TARGET}/${test2}"
cat ${TARGET}/${test2}

echo ""
echo ">>> Give enough time to the IOC  to do autosave their values"
#
# more than lagest one of SETTINGS_PERIOD=5, VALUES_PASS0_PERIOD=5, and VALUES_PASS1_PERIOD=10
SLEEP_TIME=20
echo "    Sleeping ..... ${SLEEP_TIME} secs ..... "
sleep ${SLEEP_TIME}

echo ""
echo ">>> Killing IOC at ${session0}"
kill_screen ${session0}


echo ""
echo ">>> Restart IOC"
iocsh_within_screen ${TARGET} ${session1} "${STARTUP}" "5"
bash ${SC_TOP}/SR_get.bash "${PREFIX}" > ${TARGET}/${test3}
echo "${TARGET}/${test3}"
cat ${TARGET}/${test3}

echo ""
echo ">>> Killing IOC at ${session1}"
kill_screen ${session1}


echo ""
echo ">>> Comparing ${test3} with ${test2}"
cmd="diff ${TARGET}/${test3} ${TARGET}/${test2}"
echo "- $cmd --------------"
$cmd
if [ $? -ne 0 ]; then
    echo "------------------------------------------------------------------------------------------------------------"
    echo ""
    echo ">>>> Ooops! There is something wrong"
    echo "     Please check \"${TARGET}\" to see ....."
else
    echo "------------------------------------------------------------------------------------------------------------"
    echo ""
    echo ">>>> Test passed!"
    echo "     Clearning \"${TARGET}\" ... "
    rm -rf ${TARGET}
    echo "     See you later..."
fi


exit
