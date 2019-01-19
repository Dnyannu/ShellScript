#!/usr/bin/bash

source /soaoracle/soadb/soadb/12c_profile.env
cd /soaoracle/soadb/soadb/purge_soa

SPOOL_FILE1=SOA_PURGE_$(date +%y%m%d_%H%M%S).log
WEEKDAY=`date +%a | tr '[:lower:]' '[:upper:]'`

echo "========================================================================"
echo $SPOOL_FILE1

sqlplus -s dev_soainfra/soa2dba <<EOF
SET serveroutput on
SET linesize 250
SET pagesize00
alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
ALTER PROCEDURE DEBUG_PURGE COMPILE PLSQL_CCFLAGS = 'debug_on:TRUE' REUSE SETTINGS;
ALTER PROCEDURE LOG_INFO COMPILE PLSQL_CCFLAGS = 'debug_on:TRUE' REUSE SETTINGS;
spool ${SPOOL_FILE1};
select '#### Purge Data ####' from dual;
select 'BELEbizStockAvailabilityProcess' from dual;
select '-------------------------------' from dual;
@/soaoracle/soadb/soadb/purge_soa/BELEbizStockAvailabilityProcess.sql
select ' ' from dual;
select '************************************************' from dual;
select ' ' from dual;
select 'BEL_OracleSalesCloud' from dual;
select '-------------------------------' from dual;
@/soaoracle/soadb/soadb/purge_soa/BEL_OracleSalesCloud.sql
spool off;
ALTER PROCEDURE debug_purge COMPILE PLSQL_CCFLAGS = 'debug_on:false' REUSE SETTINGS;
ALTER PROCEDURE log_info COMPILE PLSQL_CCFLAGS = 'debug_on:false' REUSE SETTINGS;
exit;
EOF

if [ $WEEKDAY == "SAT" ]; then
   echo "Today is " $WEEKDAY
   sqlplus -s dev_soainfra/soa2dba @/soaoracle/soadb/soadb/purge_soa/Space_Claim.sql ${SPOOL_FILE1}
 else
   echo "Today is not Saturday."
fi


TO=user1@test.com
CC=user2@test.com


( echo " Hi, \n\n\t Please find attached SOA purging spool. \n\n Regards, \n Bajaj Electricals." ; uuencode $SPOOL_FILE1 $SPOOL_FILE1 ) | /bin/mailx -r "noReplySOA@test.com" -c $CC -s "** CRITICAL ** SOA Purging details | `date +'%d%m%Y'-'%H':'%M':'%S'`." $TO

exit
