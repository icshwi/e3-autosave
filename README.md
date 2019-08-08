e3-autosave
==

## Autosave settings

We try to enclose most possible autosave configuration within `autosave.iocsh`. 

## Preparation of DB

Each record in database file that needs to have values saved by `autosave` must have the one of following `info` tags. Such as
```
 info(autosaveFields, "PREC SCAN DESC OUT")
 info(autosaveFields_pass0, "VAL")
 info(autosaveFields_pass1, "VAL")
```

Each info tag should be matched with what one would like to use such as


* `autosaveFields` : before and after record initialization
  - `settings.sav` : in `$(AS_TOP)/$(IOCNAME)/save`
  - `settings.req` : in `$(AS_TOP)/$(IOCNAME)/req`
 
* `autosaveFields_pass0` : before record initialization
  - `values_pass0.sav` : in `$(AS_TOP)/$(IOCNAME)/save`
  - `values_pass0.req` : in `$(AS_TOP)/$(IOCNAME)/req`

* `autosaveFields_pass1`: after record initialization (Most autosave values can be restored at Pass 0 and Pass 1 using the `autosaveFields` info tag.)
  - `values_pass1.sav`    : in `$(AS_TOP)/$(IOCNAME)/save`
  - `values_pass1.req`    : in `$(AS_TOP)/$(IOCNAME)/req`

Please look at the example in [Autosave DB example](template/SR_test_info.db).

## How to enable it within e3


```
require autosave,5.9.0

epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")
epicsEnvSet("IOCNAME", "as_test")

iocshLoad("$(autosave_DIR)/autosave.iocsh", "AS_TOP=$(TOP),IOCNAME=$(IOCNAME)")
```
