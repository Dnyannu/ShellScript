#!/usr/bin/bash

source /beloracle/beldb/beldb/.profile

cd /beloracle/beldb/beldb/scripts

LOGFILE=soa_fail_instances_scheduler.log

DT=`date '+%d%m%y'`

####### FOR ALL PARTITION EXCEPT #########


CNT=`
sqlplus -s dev_soainfra@soaprd <<EOF
set heads off
set pages 0
select count(1)
from dev_soainfra.COMPOSITE_INSTANCE a,belloggertbl@TOAPPSQRY b
where a.state !='1' and a.LIVE_instances !='1'
and a.id=b.instance_id(+)
and a.CREATED_TIME>=sysdate-1.06/24;
exit;
EOF`

echo CNT for ALL is $CNT >> $LOGFILE

FRMDT=`
sqlplus -s dev_soainfra@soaprd <<EOF
set heads off
set pages 0
select to_char(sysdate-1/24,'DD-MON-YYYY HH24:MI:SS') from dual;
exit;
EOF`

TODT=`
sqlplus -s dev_soainfra@soaprd <<EOF
set heads off
set pages 0
select to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;
exit;
EOF`

#TO=dnyandev.sandav@bajajelectricals.com
#CC=dnyandev.sandav@bajajelectricals.com

TO=bajajcrm@pathinfotech.com,shrikant.biradar@lonarconsulting.com,middlewareconnect@cloverinfotech.com,kamleshk@bajajelectricals.com,archanav@bajajelectricals.com,sonals@bajajelectricals.com,nupurb@bajajelectricals.com,sureshg@bajajelectricals.com
CC=sanjeevw@bajajelectricals.com,parabvy@bajajelectricals.com,NandanK@bajajelectricals.com,dnyandev.sandav@bajajelectricals.com

if [ $CNT -ne 0 ]
                then
                        sqlplus -s /nolog  @/beloracle/beldb/beldb/scripts/soa_fail_instances.sql

                        sed 's/   //g' SOA_FAIL_INSTANCES.html > SOA_FAIL_INSTANCES_$DT.html

                        (echo " Hi All, \n\n\t Please find attached SOA FAILED INSTANCE report from $FRMDT to $TODT . \n\n Regards, \n Dnyandev Sandav." ;uuencode SOA_FAIL_INSTANCES_$DT.html SOA_FAIL_INSTANCES_$DT.html) | /bin/mailx -r "printer@bajajelectricals.com" -c $CC -s " *** CRITICAL *** SOA FAILED INSTANCES DETAILS `date +'%d%m%Y'-'%H':'%M':'%S'`." $TO

                       rm SOA_FAIL_INSTANCES_$DT.html
		       rm SOA_FAIL_INSTANCES.html
                else
                        echo "`date` No data to send for all Partition...." $CNT >> $LOGFILE
                fi
TO=
CC=
CNT=
FRMDT=
TODT=

####### FOR BEL_Ebiz PARTITION #########

CNT=`
sqlplus -s dev_soainfra@soaprd <<EOF
set heads off
set pages 0
select count(1)
from dev_soainfra.COMPOSITE_INSTANCE a,belloggertbl@TOAPPSQRY b 
where a.state !='1' and a.LIVE_instances !='1'
and a.id=b.instance_id(+)
and a.composite_DN like 'BEL_Ebiz%'
and b.error_details not like '119%'
and b.error_details not like '911%'
and b.error_details not like '909%'
and b.error_details not like '116%'
and b.error_details not like '-Invalid%'
and a.CREATED_TIME>=sysdate-1.3/24;
exit;
EOF`

echo CNT for BEL_Ebiz is $CNT >> $LOGFILE

FRMDT=`
sqlplus -s dev_soainfra@soaprd <<EOF
set heads off
set pages 0
select to_char(sysdate-1/24,'DD-MON-YYYY HH24:MI:SS') from dual;
exit;
EOF`

TODT=`
sqlplus -s dev_soainfra@soaprd <<EOF
set heads off
set pages 0
select to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;
exit;
EOF`

#TO=dnyandev.sandav@bajajelectricals.com
#CC=dnyandev.sandav@bajajelectricals.com

TO=santoshj@bajajelectricals.com,sureshg@bajajelectricals.com
CC=sanjeevw@bajajelectricals.com,girisht@bajajelectricals.com,dnyandev.sandav@bajajelectricals.com

if [ $CNT -ne 0 ]
                then
                        sqlplus -s /nolog  @/beloracle/beldb/beldb/scripts/soa_fail_instances_BEL_Ebiz.sql

                        sed 's/   //g' SOA_FAIL_INSTANCES.html > SOA_FAIL_INSTANCES_$DT.html

                        (echo " Hi All, \n\n\t Please find attached SOA FAILED INSTANCE report for BEL_Ebiz partition from $FRMDT to $TODT . \n\n Regards, \n Dnyandev Sandav." ;uuencode SOA_FAIL_INSTANCES_$DT.html SOA_FAIL_INSTANCES_$DT.html) | /bin/mailx -r "printer@bajajelectricals.com" -c $CC -s " *** CRITICAL *** SOA FAILED INSTANCES DETAILS | BEL_Ebiz Partition `date +'%d%m%Y'-'%H':'%M':'%S'`." $TO

                       rm SOA_FAIL_INSTANCES_$DT.html
		       rm SOA_FAIL_INSTANCES.html
                else
                        echo "`date` No data to send for BEL_Ebiz partition...." $CNT >> $LOGFILE
                fi
TO=
CC=
CNT=
FRMDT=
TODT=

echo "------------------" >> $LOGFILE
exit


