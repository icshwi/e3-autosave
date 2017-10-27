include ${REQUIRE_TOOLS}/driver.makefile

#
#
# The following lines must be updated according to your autosave
#
#
ASAPP:= asApp/src

HEADERS += $(ASAPP)/os/Linux/osdNfs.h

SOURCES += $(ASAPP)/dbrestore.c
SOURCES += $(ASAPP)/save_restore.c
SOURCES += $(ASAPP)/initHooks.c
SOURCES += $(ASAPP)/fGetDateStr.c
SOURCES += $(ASAPP)/configMenuSub.c
SOURCES += $(ASAPP)/verify.c
SOURCES += $(ASAPP)/os/Linux/osdNfs.c


#DBDS += $(ASAPP)/asInclude.dbd
DBDS += $(ASAPP)/asSupport.dbd

