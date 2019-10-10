Test Procedures
===

# Automatic

```
bash tools/check_autosave_status.bash
```

# Manual

* Run an IOC

```
e3-autosave (master)$ iocsh.bash cmds/as_test.cmd 
```

* Wait for Backup files..
```
...
efe358d.proton.20315 > save_restore:write_save_file: Backup file (/home/jhlee/e3-7.0.3/e3-autosave/cmds/../ioc_test/save/values_pass0.savB) bad or not found.  Writing a new one. [191010-162509]
save_restore:write_save_file: Backup file (/home/jhlee/e3-7.0.3/e3-autosave/cmds/../ioc_test/save/settings.savB) bad or not found.  Writing a new one. [191010-162509]
save_restore:write_save_file: Backup file (/home/jhlee/e3-7.0.3/e3-autosave/cmds/../ioc_test/save/values_pass1.savB) bad or not found.  Writing a new one. [191010-162514]

```
* Check PVs
```
e3-autosave (master)$ bash tools/SR_get.bash > 1 
e3-autosave (master)$ cat 1
ioc_test:SR_aoDISP.DISP        0
ioc_test:SR_ao.PREC            0
ioc_test:SR_bo.IVOV            0
ioc_test:SR_ao.SCAN            Passive
ioc_test:SR_ao.VAL             0
ioc_test:SR_ao.DESC            
ioc_test:SR_ao.OUT             
ioc_test:SR_longout            0
ioc_test:SR_bi.SVAL            0
ioc_test:SR_char_array 12 3 0 0 0 0 0 0 0 0 0 0 0
ioc_test:SR_double_array 12 2.50321e-308 0 0 0 0 0 0 0 0 0 0 0
ioc_test:SR_float_array 12 4.06377e-44 0 0 0 0 0 0 0 0 0 0 0
ioc_test:SR_long_array 12 3 0 0 0 0 0 0 0 0 0 0 0
ioc_test:SR_short_array 12 3 0 0 0 0 0 0 0 0 0 0 0
ioc_test:SR_string_array 12            
ioc_test:SR_uchar_array 12 3 0 0 0 0 0 0 0 0 0 0 0
ioc_test:SR_ulong_array 12 2.50321e-308 0 0 0 0 0 0 0 0 0 0 0
ioc_test:SR_ushort_array 12 3 0 0 0 0 0 0 0 0 0 0 0
```
* Put some values 
```
e3-autosave (master)$ bash tools/SR_put.bash 
Old : ioc_test:SR_aoDISP.DISP        0
New : ioc_test:SR_aoDISP.DISP        27
Old : ioc_test:SR_ao.PREC            0
New : ioc_test:SR_ao.PREC            6
Old : ioc_test:SR_bo.IVOV            0
New : ioc_test:SR_bo.IVOV            67
Old : ioc_test:SR_ao.SCAN            Passive
New : ioc_test:SR_ao.SCAN            .1 second
Old : ioc_test:SR_ao.VAL             0
New : ioc_test:SR_ao.VAL             622.1
Old : ioc_test:SR_ao.DESC            
New : ioc_test:SR_ao.DESC            uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
Old : ioc_test:SR_ao.OUT             
New : ioc_test:SR_ao.OUT             abc:rec PP NMS
Old : ioc_test:SR_longout            0
New : ioc_test:SR_longout            743
Old : ioc_test:SR_bi.SVAL            0
New : ioc_test:SR_bi.SVAL            5
Old : ioc_test:SR_char_array \003
New : ioc_test:SR_char_array uzffe
Old : ioc_test:SR_double_array 12 2.50321e-308 0 0 0 0 0 0 0 0 0 0 0
New : ioc_test:SR_double_array 12 6 67 80 622 743 0 0 0 0 0 0 0
Old : ioc_test:SR_float_array 12 6.5861e-44 0 0 0 0 0 0 0 0 0 0 0
New : ioc_test:SR_float_array 12 27 6 67 80 622 5 0 0 0 0 0 0
Old : ioc_test:SR_long_array 12 3 0 0 0 0 0 0 0 0 0 0 0
New : ioc_test:SR_long_array 12 27 6 67 80 622 743 0 0 0 0 0 0
Old : ioc_test:SR_short_array 12 3 0 0 0 0 0 0 0 0 0 0 0
New : ioc_test:SR_short_array 12 27 6 67 80 622 743 0 0 0 0 0 0
Old : ioc_test:SR_string_array 12            
New : ioc_test:SR_string_array 12 uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi abc def ghi        
Old : ioc_test:SR_uchar_array 12 3 0 0 0 0 0 0 0 0 0 0 0
New : ioc_test:SR_uchar_array 12 27 6 67 80 0 0 0 0 0 0 0 0
Old : ioc_test:SR_ulong_array 12 2.50321e-308 0 0 0 0 0 0 0 0 0 0 0
New : ioc_test:SR_ulong_array 12 27 6 67 80 622 743 0 0 0 0 0 0
Old : ioc_test:SR_ushort_array 12 3 0 0 0 0 0 0 0 0 0 0 0
New : ioc_test:SR_ushort_array 12 27 6 67 80 622 743 0 0 0 0 0 0
```

* Check PVs values

```
e3-autosave (master)$ bash tools/SR_get.bash > 2
jhlee@proton: e3-autosave (master)$ cat 2
ioc_test:SR_aoDISP.DISP        27
ioc_test:SR_ao.PREC            6
ioc_test:SR_bo.IVOV            67
ioc_test:SR_ao.SCAN            .1 second
ioc_test:SR_ao.VAL             622.1
ioc_test:SR_ao.DESC            uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
ioc_test:SR_ao.OUT             abc:rec PP NMS
ioc_test:SR_longout            743
ioc_test:SR_bi.SVAL            5
ioc_test:SR_char_array 12 117 122 102 102 101 0 0 0 0 0 0 0
ioc_test:SR_double_array 12 6 67 80 622 743 0 0 0 0 0 0 0
ioc_test:SR_float_array 12 27 6 67 80 622 5 0 0 0 0 0 0
ioc_test:SR_long_array 12 27 6 67 80 622 743 0 0 0 0 0 0
ioc_test:SR_short_array 12 27 6 67 80 622 743 0 0 0 0 0 0
ioc_test:SR_string_array 12 uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi abc def ghi        
ioc_test:SR_uchar_array 12 27 6 67 80 0 0 0 0 0 0 0 0
ioc_test:SR_ulong_array 12 27 6 67 80 622 743 0 0 0 0 0 0
ioc_test:SR_ushort_array 12 27 6 67 80 622 743 0 0 0 0 0 0
```

* Check the autosave folders
```
e3-autosave (master)$ tree ioc_test/
ioc_test/
├── [jhlee    4.0K]  req
│   ├── [jhlee     123]  settings.req
│   ├── [jhlee      39]  values_pass0.req
│   └── [jhlee     277]  values_pass1.req
└── [jhlee    4.0K]  save
    ├── [jhlee     266]  settings.sav
    ├── [jhlee     211]  settings.sav0
    ├── [jhlee     266]  settings.sav1
    ├── [jhlee     266]  settings.sav2
    ├── [jhlee     266]  settings.savB
    ├── [jhlee     125]  values_pass0.sav
    ├── [jhlee     121]  values_pass0.sav0
    ├── [jhlee     125]  values_pass0.sav1
    ├── [jhlee     125]  values_pass0.sav2
    ├── [jhlee     125]  values_pass0.savB
    ├── [jhlee     767]  values_pass1.sav
    ├── [jhlee     369]  values_pass1.sav0
    ├── [jhlee     371]  values_pass1.sav1
    ├── [jhlee     767]  values_pass1.sav2
    └── [jhlee     767]  values_pass1.savB

 e3-autosave (master)$ more ioc_test/req/*
::::::::::::::
ioc_test/req/settings.req
::::::::::::::
ioc_test:SR_ao.PREC
ioc_test:SR_ao.SCAN
ioc_test:SR_ao.DESC
ioc_test:SR_ao.OUT
ioc_test:SR_aoDISP.DISP
ioc_test:SR_bo.IVOV
::::::::::::::
ioc_test/req/values_pass0.req
::::::::::::::
ioc_test:SR_ao.VAL
ioc_test:SR_bi.SVAL
::::::::::::::
ioc_test/req/values_pass1.req
::::::::::::::
ioc_test:SR_longout.VAL
ioc_test:SR_char_array.VAL
ioc_test:SR_double_array.VAL
ioc_test:SR_float_array.VAL
ioc_test:SR_long_array.VAL
ioc_test:SR_short_array.VAL
ioc_test:SR_string_array.VAL
ioc_test:SR_uchar_array.VAL
ioc_test:SR_ulong_array.VAL
ioc_test:SR_ushort_array.VAL

e3-autosave (master)$ more ioc_test/save/settings.sav*
::::::::::::::
ioc_test/save/settings.sav
::::::::::::::
# autosave R5.3	Automatically generated - DO NOT MODIFY - 191010-162704
ioc_test:SR_ao.PREC 6
ioc_test:SR_ao.SCAN 9
ioc_test:SR_ao.DESC uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
ioc_test:SR_ao.OUT abc:rec PP NMS
ioc_test:SR_aoDISP.DISP 27
ioc_test:SR_bo.IVOV 67
<END>
::::::::::::::
ioc_test/save/settings.sav0
::::::::::::::
# autosave R5.3	Automatically generated - DO NOT MODIFY - 191010-162704
ioc_test:SR_ao.PREC 6
ioc_test:SR_ao.SCAN 9
ioc_test:SR_ao.DESC uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
ioc_test:SR_ao.OUT abc:rec PP NMS
ioc_test:SR_aoDISP.DISP 27
ioc_test:SR_bo.IVOV 67
<END>
::::::::::::::
ioc_test/save/settings.sav1
::::::::::::::
# autosave R5.3	Automatically generated - DO NOT MODIFY - 191010-162704
ioc_test:SR_ao.PREC 6
ioc_test:SR_ao.SCAN 9
ioc_test:SR_ao.DESC uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
ioc_test:SR_ao.OUT abc:rec PP NMS
ioc_test:SR_aoDISP.DISP 27
ioc_test:SR_bo.IVOV 67
<END>
::::::::::::::
ioc_test/save/settings.sav2
::::::::::::::
# autosave R5.3	Automatically generated - DO NOT MODIFY - 191010-162704
ioc_test:SR_ao.PREC 6
ioc_test:SR_ao.SCAN 9
ioc_test:SR_ao.DESC uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
ioc_test:SR_ao.OUT abc:rec PP NMS
ioc_test:SR_aoDISP.DISP 27
ioc_test:SR_bo.IVOV 67
<END>
::::::::::::::
ioc_test/save/settings.savB
::::::::::::::
# autosave R5.3	Automatically generated - DO NOT MODIFY - 191010-162704
ioc_test:SR_ao.PREC 6
ioc_test:SR_ao.SCAN 9
ioc_test:SR_ao.DESC uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
ioc_test:SR_ao.OUT abc:rec PP NMS
ioc_test:SR_aoDISP.DISP 27
ioc_test:SR_bo.IVOV 67
<END>
```

* Exit and restart an IOC
```
efe358d.proton.20315 > exit
e3-autosave (master)$ iocsh.bash cmds/as_test.cmd 

```

* Check autosave values

```
e3-autosave (master)$ bash tools/SR_get.bash > 3
jhlee@proton: e3-autosave (master)$ cat 3
ioc_test:SR_aoDISP.DISP        27
ioc_test:SR_ao.PREC            6
ioc_test:SR_bo.IVOV            67
ioc_test:SR_ao.SCAN            .1 second
ioc_test:SR_ao.VAL             622.1
ioc_test:SR_ao.DESC            uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi
ioc_test:SR_ao.OUT             abc:rec PP NMS
ioc_test:SR_longout            743
ioc_test:SR_bi.SVAL            5
ioc_test:SR_char_array 12 117 122 102 102 101 0 0 0 0 0 0 0
ioc_test:SR_double_array 12 6 67 80 622 743 0 0 0 0 0 0 0
ioc_test:SR_float_array 12 27 6 67 80 622 5 0 0 0 0 0 0
ioc_test:SR_long_array 12 27 6 67 80 622 743 0 0 0 0 0 0
ioc_test:SR_short_array 12 27 6 67 80 622 743 0 0 0 0 0 0
ioc_test:SR_string_array 12 uuanjwiemsfnjjyzwjlaunhlxonfgyirdackcqi abc def ghi        
ioc_test:SR_uchar_array 12 27 6 67 80 0 0 0 0 0 0 0 0
ioc_test:SR_ulong_array 12 27 6 67 80 622 743 0 0 0 0 0 0
ioc_test:SR_ushort_array 12 27 6 67 80 622 743 0 0 0 0 0 0

e3-autosave (master)$ diff 2 3

```

