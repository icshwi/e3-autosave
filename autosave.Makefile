include ${REQUIRE_TOOLS}/driver.makefile

USR_CFLAGS   += -Wno-unused-variable
USR_CFLAGS   += -Wno-unused-function
USR_CPPFLAGS += -Wno-unused-variable
USR_CPPFLAGS += -Wno-unused-function

ASAPP:= asApp/src

HEADERS += $(ASAPP)/os/Linux/osdNfs.h

SOURCES += $(ASAPP)/dbrestore.c
SOURCES += $(ASAPP)/save_restore.c
SOURCES += $(ASAPP)/initHooks.c
SOURCES += $(ASAPP)/fGetDateStr.c
SOURCES += $(ASAPP)/configMenuSub.c
SOURCES += $(ASAPP)/verify.c
SOURCES += $(ASAPP)/os/Linux/osdNfs.c


DBDS    += $(ASAPP)/asSupport.dbd

