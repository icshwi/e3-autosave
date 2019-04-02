require iocStats,ae5d083
require autosave,5.9.0
require std,3.5.0

epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")

epicsEnvSet("SEC", "SEC")
epicsEnvSet("SUB", "SUB01")
epicsEnvSet("P", "$(SEC)-$(SUB):")
epicsEnvSet("DIS", "DIS")
epicsEnvSet("DEV", "DEV-01")
epicsEnvSet("R", "$(DIS)-$(DEV)")
epicsEnvSet("IOCNAME", "ioc_test")


iocshLoad("$(TOP)/iocsh/autosave.iocsh", "AS_TOP=$(TOP),IOCNAME=$(IOCNAME),SEQ_PERIOD=60")

dbLoadRecords("$(TOP)/template/SR_test_info.db","P=$(IOCNAME):,N=12")


iocInit()

dbl > "${IOCNAME}_PVs.list"

