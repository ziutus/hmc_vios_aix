# Synopsis
## Collecting data 
### Script hmc_collect_data.sh
The hmc_collect_data.sh script is connecting to each HMC and taking needed data by calling command by command (check script).
In base directory (default: /var/opt/unix4you/) is created directory with timestamp and than for reach HMC
is created subdirectory. It make life easier when you write Ruby reports (you just make one loop 
for each HMC in directory on some day and time).
```
$ ./hmc_collect_data.sh -h
STDERR Usage of hmc_collect_data.sh
        hmc_collect_data.sh [-h|--help] [-H|--hmcs HMC1[,HMC2[,HMC3...]]] [-f|--file FILE_LIST ] [-r|--report REPORT_TYPE] [-u|--user HMC_USER ]

          -H|--hmcs HMC1[,HMC2[,HMC3...]]] - names of HMCs from which data should be collected
          -f|--file FILENAME               - filename with list of HMCs from which data should be collected
          -u|--user HMC_USER               - name of HMC_USER on which data should be collected (default: hscroot)
          -r|--report REPORT_NAME          - name of report  for which data will be collected (default: ALL)
          -h|--help                        - show this message
          -d|--base-dir                    - base dir for all reports (default: /var/opt/unix4you/data/hmc)
```


## Usefull scripts
### ping_all.rb
The ping_all.rb script is created to make fast check if many servers are up what is useful during network issues (switch down etc).
Nice option is to get list of servers from file and then choose only few of them by regexp.

```
ziutus@server2 bin]$ ./ping_all.rb -h
This script ping in the same time many servers and provide result in nice way
    -s, --server SERVER[,SERVER]     SERVER for test ping
    -f, --filename FILENAME          FILENAME with list of servers to test
    -e, --regexp REGEXP              regexp to take only some servers from list
    -h, --help                       Display this screen

```


# Motivation
## Why this project?
I'm the AIX SysAdmin and I don't like to do every day the same jobs. If something is repetitive, maybe we can write script for that?
This repository hold scripts which I wrote or rewrite from different projects / persons to have all in one place.

## Why OOP (Object-oriented programming) for SA (System Administrators)?
OOP is used in this project as I want to reuse code each time, where it is possible, 
it is not big difference in code when you want to use
output from "lsmap -npiv" to check if all virtual adapters are logged, you want to compare with older output (for example between reboots during
upgrade of system) or need commands to restore settings (after rebuild of system).
OOP allow also refactoring (https://en.wikipedia.org/wiki/Code_refactoring), you can rebuild big part of code and 
with TDD you are always sure that it works. So maintenance of code is much easier and faster.

## Why  Test Driven Developing (TDD)?
AIX systems are typically production systems so each time you change your scripts, you should be sure that it will not hurt your systems.
TDD will help you to be sure that all classes, scripts etc. will behavior as you expect. TDD is also helping you to define what really you 
want (as you are starting from writing tests ;). Other reason is simple, good tests are really good documentation of your code, it shows how
to use classes and functions and what is expected to get as result. This documentation is always updated ;).

## Why Ruby?
I believe first scripts you were writing in bash/ksh but when project was growing you afraid to change anything as your changes could destroy 
others scripts. So you are ended with big number of small scripts which maintenance took longer and longer. Then you started to write it in Perl 
and Object Oriented programming (OOP). Perl was always on AIX machines so you can could scripts on any of your systems. Problem is that OOP in Perl 
is difficult: no internal variables, no isolation etc, so it is time to change base language. 

Why Ruby and not Python or something different? Ruby is used in Chef :). Some part of code can be used in Chef.


## Why AIX 5.3 not current one like 7.1 or 7.2?
Why I'm using in my tests AIX 5.3 and not current AIX like 7.1 or 7.2? because I got this version with my hardware :). 
if you are using newer versions and you are authorized to provide me data to update my scripts I will do it. 
If you known how to really buy newer version of this software please write to me. I was trying to contact sellers but they ignored me :).

I will use some example data found on Internet (manual pages, example data, posts etc) but I can't promise that it will be working on your setup.

# Installation

if you want to add libraries to your path, you can use below code:

```
export RUBYLIB="/home/ziutus/github/hmc_vios_aix-master/inc:/home/ziutus/ruby_local/inc"
```

Configuration file with default data for HMC script (hmc_manage.rb) should provide data like: hmc IP or name, user on HMC and password. It is yaml file. 
Example of config:

```
:hmc: 192.168.200.33
:username: hscroot
:password: TopSecretPasswordAbc1234
```

# API Reference
## Lpar_profile class

The Lpar_profile class is created to analyze profile information for LPAR.
You can read profile output file collected by hmc_collect_data.sh, than
analyze it (by calling lssyscfgProfDecode) and than make what you need :)

```
string_from_file = 'name=normal,lpar_name=nim1,lpar_id=5,lpar_env=aixlinux,all_resources=0,min_mem=2048,desired_mem=6144,max_mem=10240,min_num_huge_pages=0,desired_num_huge_pages=0,max_num_huge_pages=0,mem_mode=ded,hpt_ratio=1:64,proc_mode=shared,min_proc_units=0.1,desired_proc_units=0.3,max_proc_units=0.8,min_procs=1,desired_procs=1,max_procs=2,sharing_mode=cap,uncap_weight=0,io_slots=none,lpar_io_pool_ids=none,max_virtual_slots=10,"virtual_serial_adapters=0/server/1/any//any/1,1/server/1/any//any/1","virtual_scsi_adapters=2/client/2/vios1/2/1,3/client/3/vios2/2/1","virtual_eth_adapters=6/1/6//0/0,7/0/7//0/0",hca_adapters=none,boot_mode=norm,conn_monitoring=0,auto_start=0,power_ctrl_lpar_ids=none,work_group_id=none,redundant_err_path_reporting=0'

profile = Lpar_profile.new(5)
profile.lssyscfgProfDecode(string)
```

Now you can do what you want in your Ruby files, for example:
* Ignore some profiles if name has have something in name

``` 
next if profile.name == /ignore/
```
* Ignore profile if it is VIOS
``` 
next if profile.lpar_env == 'vioserver'
```
etc...

# Tests
In this project we are using Unit Tests. All tests are in /t directory. if you want to run one test, just call:
```
ruby hmc_lpar_profile.rb -n test_profile_decode_6
```

# Contributors

# License
GPL