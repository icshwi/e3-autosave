
#- iocshLoad "$(AUTOSAVE_CMD_TOP)/save_restore_after_init.cmd" "P=$(P),R=$(R), IOC=$(IOC), AS_TOP=$(TOP)"
#- Save other things every thirty seconds
epicsEnvSet(AS_NAME,   "autosave")
epicsEnvSet(AS_PREFIX, "$(P)$(R):$(AS_NAME):")
epicsEnvSet(AS_PATH,   "$(AS_TOP)/$(AS_NAME)")

makeAutosaveFileFromDbInfo("$(AS_PATH)/req/$(IOC)_settings.req", "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("$(AS_PATH)/req/$(IOC)_values.req",   "autosaveFields")


create_monitor_set("$(IOC)_settings.req", 5, "P=$(AS_PREFIX)")
create_monitor_set("$(IOC)_values.req",   5, "P=$(AS_PREFIX)")

