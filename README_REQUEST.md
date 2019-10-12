How to reuse request files
===

It is highly recommended to use `info` tag instead of the seperated request files. However, this file would like to help them to use existent request files within `autosave.iocsh` within `e3-autosave` according to existent all EPICS modules' req files, own req files, or both. 


## `e3-autosave` 

```
require autosave,5.10.0
...
dbLoadRecords("spinnaker.db", "P=$(PREFIX),R=,PORT=$(PORT)")
...
iocshLoad("$(autosave_DIR)/autosave.iocsh", "AS_TOP=$(TOP),IOCNAME=$(IOCNAME)")
#
iocInit()
```

## `e3-ADSpinnakar`

* Use the same way to use `e3-autosave`

* Define **all** requestfile path before the first `dbLoadRecords`. It is important to open all req files, which are related with all database files. And one has to check where they are. And one has to define them all. 

```
set_requestfile_path("$(ADSpinnaker_DB)", "")
set_requestfile_path("$(ADGenICam_DB)", "")
set_requestfile_path("$(ADCore_DB)", "")
set_requestfile_path("$(calc_DB)", "")
set_requestfile_path("$(busy_DB)", "")
set_requestfile_path("$(TOP)", "cmds")
```

* Create one own req file in a directory (for example, `cmds`).

```
$ more cmds/auto_settings.req 
file "spinnaker_settings.req",            P=$(P),  R=$(R)
file "NDStdArrays_settings.req",          P=$(P),  R=$(R)
file "commonPlugin_settings.req",         P=$(P)
```

* Add the `create_monitor_set` after `iocInit`
```
create_monitor_set("auto_settings.req", 5, "P=$(PREFIX),R=,IMAGE=$(IMAGE):")
```

* Full example for the ADSpinnaker application

```
require ADSpinnaker,2.0.0
require calc,3.7.3
require busy,1.7.2-e45eda2
require autosave,5.10.0

epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")

set_requestfile_path("$(ADSpinnaker_DB)", "")
set_requestfile_path("$(ADGenICam_DB)", "")
set_requestfile_path("$(ADCore_DB)", "")
set_requestfile_path("$(calc_DB)", "")
set_requestfile_path("$(busy_DB)", "")
set_requestfile_path("$(TOP)", "cmds")

ADSpinnakerConfig("$(PORT)", "$(CAMERA_ID)", 0x1, 0)
dbLoadRecords("spinnaker.db", "P=$(PREFIX),R=,PORT=$(PORT)")
dbLoadRecords("PGR_BlackflyS_50S5C.db", "P=$(PREFIX),R=,PORT=$(PORT)")

NDStdArraysConfigure("$(IMAGE)", 5, 0, "$(PORT)", 0, 0)
dbLoadRecords("NDStdArrays.template", "P=$(PREFIX),R=,PORT=$(IMAGE),ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Int16,FTVL=SHORT,NELEMENTS=$(NELEMENTS)")
iocshLoad("$(ADCore_DIR)/commPlugins.iocsh", "P=$(PREFIX),UNIT=1,PORT=$(IMAGE),QSIZE=$(QSIZE),XSIZE=$(XSIZE),YSIZE=$(YSIZE),NCHANS=$(NCHANS),CBUFFS=$(CBUFFS)")

iocshLoad("$(autosave_DIR)/autosave.iocsh", "AS_TOP=$(TOP),IOCNAME=$(IOCNAME)")

iocInit()

create_monitor_set("auto_settings.req", 5, "P=$(PREFIX),R=,IMAGE=$(IMAGE):")
```
