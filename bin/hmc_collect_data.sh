#! /bin/bash
#set -x

. ../inc_sh/password_in_file.sh

MYNAME=$(basename $0)
DATE=$(date +"%Y%m%d_%H%M")
DIR_BASE='/var/opt/unix4you/data/hmc'
PASSWORD=''


#HMCS=$(cat conifg/hmcs.txt)
HMCS='192.168.200.33'
HMC_USER='hscroot'
REPORT='ALL'

HMC_OK=0
HMC_ERRORS=0

password_write_to_file_if_empty


if [ -x /opt/tectia/bin/sshg3 ]
then
    SSH="/opt/tectia/bin/sshg3 -q -l ${HMC_USER} --batch-mode  --password=file://$PASSWORD_FILE --tcp-connect-timeout=5 "
else
    SSH="/usr/bin/ssh -l ${HMC_USER} "
fi


[ "${PASSWORD}" == 'XXX' ] && echo 'Default password has been not changed, please update it. Exiting...' && exit 2
[ ! -d ${DIR_BASE} ]       && echo "The data dir $DIR_BASE doesn't exist, did you install correctly package? Exiting..." && exit 3

#TODO: add check if directory can be written 

for HMC in ${HMCS}
do
	echo ">>Working on HMC: ${HMC}"

	#TODO: Add check if used is key and is possible to connect by ssh
	${SSH} ${HMC} 'uname -n' 
	RC=$?
	if [ $RC -ne 0 ]
	then
		echo "Can't connect to HMC ${HMC}" 
        ((HMC_ERRORS=$HMC_ERRORS+1))
		continue
	fi

	DIR=${DIR_BASE}/${DATE}/${HMC}/
	mkdir -p ${DIR}
	
	
	if [ ${REPORT} == 'report_hmc_events' ]
	then
		${SSH} ${HMC} 'lssvcevents -t hardware --filter "status=open"' > ${DIR}/lssvcevents_hardware.txt
    fi

	if [ ${REPORT} == 'HMC_users' ]
	then
		${SSH} ${HMC} 'lshmcusr' > ${DIR}/lshmcusr.txt
    fi


	if [ ${REPORT} == 'frames_connected' ]
	then
		${SSH} ${HMC} 'lssysconn -r all' > ${DIR}/lssysconn_r_all.txt
		${SSH} ${HMC} 'lssyscfg -r sys   -F name,serial_num,state' > ${DIR}/lssysscfg_r_sys_F_name_serial_num_state.txt
		${SSH} ${HMC} 'lssyscfg -r frame -F name,serial_num'       > ${DIR}/lssysscfg_r_frame_F_name_serial_num_state.txt

		for FRAME in `cat $DIR/lssysscfg_r_frame_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1`;
		do
		    ${SSH} ${HMC} "lssyscfg -r cage -e $FRAME" > ${DIR}/lssyscfg_r_cage_e_${FRAME}.txt
		done
    fi



	if [ ${REPORT} == 'frames_profiles' ]
	then

		${SSH} ${HMC} 'lssyscfg -r sys -F name,serial_num,state' > ${DIR}/lssyscfg_r_sys_F_name_serial_num_state.txt

		for FRAME in `cat $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1`; 
		do 
			${SSH} ${HMC} "lssyscfg -m ${FRAME} -r prof"               > ${DIR}/${FRAME}_prof.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r io --rsubtype slot" > ${DIR}/${FRAME}_io_slot.txt
		done 	
	fi

	if [ ${REPORT} == 'profiles_vs_real' ]
	then

		${SSH} ${HMC} 'lssyscfg -r sys -F name,serial_num,state' > ${DIR}/lssyscfg_r_sys_F_name_serial_num_state.txt

		for FRAME in `cat $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1`;
		do
			${SSH} ${HMC} "lssyscfg -m ${FRAME} -r prof"               > ${DIR}/${FRAME}_prof.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r mem"                > ${DIR}/${FRAME}_mem.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r proc"               > ${DIR}/${FRAME}_proc.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r io --rsubtype slot" > ${DIR}/${FRAME}_io_slot.txt

			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype slot"   > ${DIR}/${FRAME}_virtual_slot.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype serial" > ${DIR}/${FRAME}_virtual_serial.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype fc"     > ${DIR}/${FRAME}_virtual_fc.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype eth"    > ${DIR}/${FRAME}_virtual_eth.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype scsi"   > ${DIR}/${FRAME}_virtual_scsi.txt
		done

    fi

	if [ ${REPORT} == 'ALL' ]
	then

		${SSH} ${HMC} 'lssvcevents -t hardware --filter "status=open"'   > ${DIR}/lssvcevents_hardware.txt
		${SSH} ${HMC} 'lssyscfg -r sys   -F name,serial_num,state'       > ${DIR}/lssyscfg_r_sys_F_name_serial_num_state.txt
		${SSH} ${HMC} 'lssyscfg -r frame -F name,serial_num'             > ${DIR}/lssysscfg_r_frame_F_name_serial_num_state.txt
		${SSH} ${HMC} 'lssysconn -r all' > ${DIR}/lssysconn_r_all.txt

		for FRAME in `cat $DIR/lssysscfg_r_frame_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1 `;
		do
		    ${SSH} ${HMC} "lssyscfg -r cage -e $FRAME" > ${DIR}/lssyscfg_r_cage_e_${FRAME}.txt
		done

		for FRAME in `cat $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1`;
		do

			${SSH} ${HMC} "lssyscfg -m ${FRAME} -r prof"               > ${DIR}/${FRAME}_prof.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r io --rsubtype slot" > ${DIR}/${FRAME}_io_slot.txt

			${SSH} ${HMC} "lshwres  -m ${FRAME} -r mem"                > ${DIR}/${FRAME}_mem.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r proc"               > ${DIR}/${FRAME}_proc.txt

			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype slot"   > ${DIR}/${FRAME}_virtual_slot.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype serial" > ${DIR}/${FRAME}_virtual_serial.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype fc"     > ${DIR}/${FRAME}_virtual_fc.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype eth"    > ${DIR}/${FRAME}_virtual_eth.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype scsi"   > ${DIR}/${FRAME}_virtual_scsi.txt
		done
	fi
    ((HMC_OK=$HMC_OK+1))
done	

password_remove_file

echo "HMC OK: ${HMC_OK}, HMC no connection: ${HMC_ERRORS}"
if [ $HMC_OK -gt 0 ]
then
    echo "All data have been written to ${DIR_BASE}/${DATE}"
else
    echo 'No HMC available to connect, no data collected...'
fi

exit 0