include ${REQUIRE_TOOLS}/driver.makefile

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
SOURCES += $(ASAPPSRC)/verify.c
SOURCES += $(ASAPPSRC)/os/Linux/osdNfs.c

DBDS    += $(ASAPPSRC)/asSupport.dbd


TEMPLATES += $(wildcard $(ASAAPDB)/*.db)
