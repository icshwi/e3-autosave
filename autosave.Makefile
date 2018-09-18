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
# Date    : Tuesday, September 18 09:39:32 CEST 2018
# version : 0.0.2

# Get where_am_I before include driver.makefile.
# After driver.makefile, where_am_I is the epics base,
# so we cannot use it

# LEGACY_RSET should be defined before driver.makefile
# require-ess from 3.0.1
LEGACY_RSET = YES


where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include ${E3_REQUIRE_TOOLS}/driver.makefile
include $(where_am_I)/../configure/DECOUPLE_FLAGS


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

# e3-autosave/iocsh
SCRIPTS += ../iocsh/autosave.iocsh
#SCRIPTS += $(wildcard ../iocsh/*.iocsh)
# e3-autosave/autosave/iocsh
#SCRIPTS += $(wildcard iocsh/*.iocsh)


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
