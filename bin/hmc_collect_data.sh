#! /bin/bash
set -x

MYNAME=$(basename $0)
DATE=$(date +"%Y%m%d_%H%M")
DIR_BASE='/var/opt/unix4you/data/hmc'
PASSWORD='XXX'

#HMCS=$(cat conifg/hmcs.txt)
HMCS='192.168.200.33'
HMC_USER='hscroot'
REPORT='frames_profiles'
SSH='/usr/bin/ssh '

[ $PASSWORD == 'XXX' ] && echo 'Default password has been not changed, please update it. Exiting...' && exit 2
[ ! -d $DIR_BASE ] &&  echo "The data dir $DIR_BASE doesn't exist, did you install correctly package? Exiting..." && exit 3

#TODO: add check if directory can be written 

for HMC in $HMCS 
do
	echo ">>Working on HMC: $HMC"
	DIR=$DIR_BASE/$DATE/$HMC/
	mkdir -p $DIR 	

	#TODO: Add check if used is key and is possible to connect by ssh
	
	
	if [ $REPORT == 'frames_profiles' ]
	then

		$SSH $HMC_USER@$HMC 'lssyscfg -r sys -F name,serial_num,state' > $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt

		for FRAME in `cat $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1`; 
		do 
			$SSH $HMC_USER@$HMC "lssyscfg -r prof -m $FRAME" > "$DIR/${FRAME}_prof.txt"
			$SSH $HMC_USER@$HMC "lshwres -m $FRAME -r io --rsubtype slot" > "$DIR/${FRAME}_io_slot.txt"
		done 	
	fi

	if [ $REPORT == 'ALL' ]
	then

		$SSH $HMC_USER@$HMC 'lssyscfg -r sys -F name,serial_num,state' > $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt

		for FRAME in `cat $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1`; 
		do 
			$SSH  $HMC_USER@$HMC "lssyscfg -r prof -m $FRAME" > "$DIR/${FRAME}_prof.txt"
			$SSH  $HMC_USER@$HMC "lshwres -m $FRAME -r io --rsubtype slot" > "$DIR/${FRAME}_io_slot.txt"
		done 	
	fi

	
done	

echo "All data have been written to $DIR_BASE/$DATE" 
exit 0