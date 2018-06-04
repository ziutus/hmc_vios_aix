#! /bin/bash

. ../inc_sh/password_in_file.sh

MYNAME=$(basename $0)
DATE=$(date +"%Y%m%d_%H%M")
DIR_BASE='/var/opt/unix4you/data/hmc'
PASSWORD=''

HMC=''
HMC_USER='hscroot'
REPORT='ALL'
HMC_FILE=''
HMC_STRING=''
DEBUG=0

function usage {

    echo STDERR "Usage of $MYNAME
        $MYNAME [-h|--help] [-H|--hmcs HMC1[,HMC2[,HMC3...]]] [-f|--file FILE_LIST ] [-r|--report REPORT_TYPE] [-u|--user HMC_USER ]

          -H|--hmcs HMC1[,HMC2[,HMC3...]]] - names of HMCs from which data should be collected
          -f|--file FILENAME               - filename with list of HMCs from which data should be collected
          -u|--user HMC_USER               - name of HMC_USER on which data should be collected (default: $HMC_USER)
          -r|--report REPORT_NAME          - name of report  for which data will be collected (default: $REPORT)
          -h|--help                        - show this message
          -d|--base-dir                    - base dir for all reports (default: $DIR_BASE)
          -p|--password                    - password for user on HMC
          --verbose                        - verbose level (9 give all information)
    "

    exit 2
}


while [ $# -gt 0 ];
do
    case $1 in
    -h|--help)   shift;              usage;;
    -H|--hmcs)   shift; HMC_STRING=$1; shift;;
    -f|--file)   shift; HMC_FILE=$1;   shift;;
    -r|--report) shift; REPORT=$1;     shift;;
    -u|--user)   shift; HMC_USER=$1;   shift;;
    -d|--base-dir) shift; DIR_BASE=$1; shift;;
    -p|--password|--passwd) shift; PASSWORD=$1; shift;;
    --verbose) shift; DEBUG=$1; shift;;

    *) echo "Wrong option $1"; exit 1;
    esac
done

(($DEBUG >= 9)) && set -x


if [ ! -z $HMC_FILE ]
then

    for HMC in `cat $HMC_FILE`
    do
        INDEX=${#HMCS[*]}
        HMCS[$INDEX]=$HMC
    done
fi

if [ ! -z $HMC_STRING ]
then
    for HMC in `echo $HMC_STRING | tr ',' "\n"`
    do
        INDEX=${#HMCS[*]}
        HMCS[$INDEX]=$HMC
    done
fi

HMC_OK=0
HMC_ERRORS=0

if [ -x /opt/tectia/bin/sshg3 ]
then
    SSH="/opt/tectia/bin/sshg3 -q -l ${HMC_USER} --batch-mode  --password=file://$PASSWORD_FILE --tcp-connect-timeout=5 "
    password_write_to_file_if_empty
else
    SSH="/usr/bin/ssh -l ${HMC_USER} "
fi

[ "${PASSWORD}" == 'XXX' ] && echo 'Default password has been not changed, please update it. Exiting...' && exit 2
#[ ! -d ${DIR_BASE} ]       && echo "The data dir $DIR_BASE doesn't exist, did you install correctly package? Exiting..." && exit 3

#TODO: add check if directory can be written 

for HMC in ${HMCS[*]}

do
	echo ">>Working on HMC: ${HMC}"

    #ping test
    ping -c4  $HMC > /dev/null
    RC=$?
    if [ $RC -ne 0 ]
    then
		echo "Can't ping HMC ${HMC}"
        ((HMC_ERRORS=$HMC_ERRORS+1))
		continue
    fi

    #ssh connection test (without asking about password)
	${SSH} ${HMC} 'uname -n'
	RC=$?
	if [ $RC -ne 0 ]
	then
		echo "Can't connect by SSH to HMC ${HMC}"
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


    if [ ${REPORT} == 'HMC_resouceroles' ]
    then
        ${SSH} ${HMC} 'lsaccfg  -t resourcerole' > ${DIR}/resourceroles.txt
		${SSH} ${HMC} 'lssyscfg -r sys -F name,type_model,serial_num,state' > ${DIR}/lssyscfg_r_sys_4resourceroles.txt

		for SYS in `cat $DIR/lssyscfg_r_sys_4resourceroles.txt | grep -v "\." | cut -d "," -f 1`;
		do
    		${SSH} ${HMC} "lssyscfg -r lpar -m $SYS -F name,lpar_id,state" > ${DIR}/lssyscfg_r_sys_4resourceroles.txt
        done

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
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r mem --level sys"    > ${DIR}/${FRAME}_mem.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r proc --level sys"   > ${DIR}/${FRAME}_proc.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r io --rsubtype slot" > ${DIR}/${FRAME}_io_slot.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r mem --level lpar"   > ${DIR}/${FRAME}_mem_lpar.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r proc --level lpar"  > ${DIR}/${FRAME}_proc_lpar.txt

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
        ${SSH} ${HMC} 'lshmcldap -r config'      > ${DIR}/ldap.txt
        ${SSH} ${HMC} 'lshmcusr'                 > ${DIR}/lshmcusr.txt
        ${SSH} ${HMC} 'lsaccfg  -t resourcerole' > ${DIR}/resourceroles.txt

        ${SSH} ${HMC} 'lshmc -n'                 > ${DIR}/lshmc_n.txt
        ${SSH} ${HMC} 'lshmc -v'                 > ${DIR}/lshmc_v.txt
        ${SSH} ${HMC} 'lshmc -V'                 > ${DIR}/lshmc_V.txt
        ${SSH} ${HMC} 'lshmc -r'                 > ${DIR}/lshmc_r.txt

		${SSH} ${HMC} 'lssysconn -r all' > ${DIR}/lssysconn_r_all.txt
		${SSH} ${HMC} 'lssyscfg -r frame -F name,serial_num'             > ${DIR}/lssysscfg_r_frame_F_name_serial_num_state.txt
		${SSH} ${HMC} 'lssyscfg -r sys   -F name,serial_num,state'       > ${DIR}/lssyscfg_r_sys_F_name_serial_num_state.txt
		${SSH} ${HMC} 'lssyscfg -r sys   -F name,type_serial,serial_num,state'       > ${DIR}/lssyscfg_r_sys_F_name_type_model_serial_num_state.txt

		for FRAME in `cat $DIR/lssyscfg_r_sys_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1`;
		do

            ${SSH} ${HMC} "lssyscfg -m ${FRAME} -r lpar"              > ${DIR}/${FRAME}_lpar.txt
			${SSH} ${HMC} "lssyscfg -m ${FRAME} -r prof"               > ${DIR}/${FRAME}_prof.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r mem --level sys"    > ${DIR}/${FRAME}_mem.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r proc --level sys"   > ${DIR}/${FRAME}_proc.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r io --rsubtype slot" > ${DIR}/${FRAME}_io_slot.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r mem --level lpar"   > ${DIR}/${FRAME}_mem_lpar.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r proc --level lpar"  > ${DIR}/${FRAME}_proc_lpar.txt

			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype slot"   > ${DIR}/${FRAME}_virtual_slot.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype serial" > ${DIR}/${FRAME}_virtual_serial.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype fc"     > ${DIR}/${FRAME}_virtual_fc.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype eth"    > ${DIR}/${FRAME}_virtual_eth.txt
			${SSH} ${HMC} "lshwres  -m ${FRAME} -r virtualio --level lpar --rsubtype scsi"   > ${DIR}/${FRAME}_virtual_scsi.txt
		done

		for FRAME in `cat $DIR/lssysscfg_r_frame_F_name_serial_num_state.txt | grep -v "\." | cut -d "," -f 1 `;
		do
		    ${SSH} ${HMC} "lssyscfg -r cage -e $FRAME" > ${DIR}/lssyscfg_r_cage_e_${FRAME}.txt
		done

	fi
    ((HMC_OK=$HMC_OK+1))
done	

if [ -x /opt/tectia/bin/sshg3 ]
then
    password_remove_file
fi

echo ''
echo "HMC OK: ${HMC_OK}, HMC no connection: ${HMC_ERRORS}"
if [ ${HMC_OK} -gt 0 ]
then
    echo "All data have been written to ${DIR_BASE}/${DATE}"
else
    echo 'No HMC available to connect, no data collected...'
fi

exit 0