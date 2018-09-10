#
#  Copyright (c) 2017 - Present  Jeong Han Lee
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
# email   : han.lee@esss.se
# Date    : Friday, April  6 13:24:53 CEST 2018
# version : 0.0.1

# Get where_am_I before include driver.makefile.
# After driver.makefile, where_am_I is the epics base,
# so we cannot use it


where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))


include ${E3_REQUIRE_TOOLS}/driver.makefile


# *** ISSUES
# driver.makefile recursively read all include directories which were installed.
# The only way to exclude header files is....



iocStats_VERSION=
#autosave_VERSION=
asyn_VERSION=
busy_VERSION=
modbus_VERSION=
ipmiComm_VERSION=
sequencer_VERSION=
sscan_VERSION=

std_VERSION=
ip_VERSION=
calc_VERSION=
pcre_VERSION=
stream_VERSION=
s7plc_VERSION=
recsync_VERSION=

devlib2_VERSION=
mrfioc2_VERSION=

exprtk_VERSION=
motor_VERSION=
ecmc_VERSION=
ethercatmc_VERSION=
ecmctraining_VERSION=


keypress_VERSION=
sysfs_VERSION=
symbolname_VERSION=
memDisplay_VERSION=
regdev_VERSION=
i2cDev_VERSION=

tosca_VERSION=
tsclib_VERSION=
ifcdaqdrv2_VERSION=

## The main issue is nds3, it is mandatory to disable it
## 
nds3_VERSION=
nds3epics_VERSION=
ifc14edrv_VERSION=
ifcfastint_VERSION=


nds_VERSION=
loki_VERSION=
nds_VERSION=
sis8300drv_VERSION=
sis8300_VERSION=
sis8300llrfdrv_VERSION=
sis8300llrf_VERSION=


ADSupport_VERSION=
ADCore_VERSION=
ADSimDetector_VERSION=
ADAndor_VERSION=
ADAndor3_VERSION=
ADPointGrey_VERSION=
ADProsilica_VERSION=

amcpico8_VERSION=
adpico8_VERSION=
adsis8300_VERSION=
adsis8300bcm_VERSION=
adsis8300bpm_VERSION=
adsis8300fc_VERSION=


# To enable autosaveBuild, use dbLoadRecordsHookRegister.  (But it doesn't
# appear in EPICS base until 3.14.12.5, so disable by default for now.)
# ESS uses the more than 3.14.12.5, so we enable them by default

USR_CFLAGS += -DDBLOADRECORDSHOOKREGISTER


USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function

ASAPP:=asApp

ASAAPDB:= $(ASAPP)/Db
ASAPPSRC:= $(ASAPP)/src

HEADERS += $(ASAPPSRC)/os/Linux/osdNfs.h

SOURCES += $(ASAPPSRC)/dbrestore.c
SOURCES += $(ASAPPSRC)/save_restore.c
SOURCES += $(ASAPPSRC)/initHooks.c
SOURCES += $(ASAPPSRC)/fGetDateStr.c
SOURCES += $(ASAPPSRC)/configMenuSub.c
SOURCES += $(ASAPPSRC)/os/Linux/osdNfs.c
SOURCES += $(ASAPPSRC)/verify.c


DBDS    += $(ASAPPSRC)/asSupport.dbd


TEMPLATES += $(ASAAPDB)/save_restoreStatus.db
TEMPLATES += $(ASAAPDB)/configMenu.db


TEMP_PATH    :=$(where_am_I)O.$(EPICSVERSION)_$(T_A)
ASVERIFY     :=$(TEMP_PATH)/bin/asVerify

BINS += $(ASVERIFY)


vpath %.c   $(where_am_I)$(ASAPPSRC)
vpath %.h   $(where_am_I)$(ASAPPSRC)


verify$(DEP): $(ASVERIFY)
	@echo  $(ASVERIFY)


# We only use linux, so I added $(OP_SYS_LDFLAGS) $(ARCH_DEP_LDFLAGS)
# Fortunately, libautosave.so isn't used to compile asVerify, so we ignore its flags
$(ASVERIFY): asVerify.c $(patsubst %.c,%.o, asVerify.c verify.c )
	@echo ""
	@echo ">>>>> asVerify Init "
	$(RM) $@
	$(MKDIR) -p $(TEMP_PATH)/bin
	$(CCC) -o $@ -L$(EPICS_BASE_LIB) -Wl,-rpath,$(EPICS_BASE_LIB) $(OP_SYS_LDFLAGS) $(ARCH_DEP_LDFLAGS)  $(filter %.o, $^) -lca -lCom 
	@echo "<<<<< asVerify Done"
	@echo ""


# db rule is the default in RULES_E3, so add the empty one


db:
