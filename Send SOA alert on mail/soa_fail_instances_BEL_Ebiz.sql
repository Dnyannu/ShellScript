connect dev_soainfra/soa2dba@soaprd
set serveroutput on size 1000000
set termout off
set lines 500
set pages 0
set head off
set feedback off
set term off
set VERIFY off
col bytes for 999999999999999.99
col value for 999999999999999.99
break on grantee
col filename new_value fname
col username new_value uname
col spoolfile new_value spf

--select 'E:\scr\' filename from dual;
select '/beloracle/beldb/beldb/scripts/' filename from dual;
--select username as username from dba_users where username='&name';
select '&fname' || 'SOA_FAIL_INSTANCES.html' spoolfile from dual,dba_users;
--select '&fname' || 'SOA_FAILED_INSTANCES_' || to_char(sysdate,'DDMMRR') || '.html' spoolfile from dual,dba_users;
--select '&fname' || 'CHECK_SCHEMA_' || username || '_.html' spoolfile from dual,dba_users where username not in ('SYS','SYSTEM','OUTLN','SCOTT','ADAMS','JONES','CLARK','BLAKE','HR','OE','SH','DEMO','ANONYMOUS','AURORA$ORB$UNAUTHENTICATED','AWR_STAGE','CSMIG','CTXSYS','DBSNMP','DIP','DMSYS','DSSYS','EXFSYS','LBACSYS','MDSYS','ORACLE_OCM','ORDPLUGINS','ORDSYS','PERFSTAT','TRACESVR','TSMSYS','XDB') ;
spool &spf

select '<body bgcolor="f7f7d7"><BR><CENTER><FONT FACE="VERDANA" SIZE=4>SOA FAILED INSTANCES</FONT>
<BR><BR><B><FONT FACE="VERDANA" SIZE=1>PREPARED BY</FONT></B>
<BR><BR><FONT FACE="VERDANA" SIZE=4>BAJAJ ELECTRICALS</FONT></CENTER><br><hr>' from dual;

select '<br><FONT FACE="VERDANA" SIZE=2  color="#0000FF">Created on : ' || 
to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') || ' </font> <BR>' from dual;

select '<br><FONT FACE="VERDANA" SIZE=2  color="#0000FF">From : ' || 
to_char(sysdate-1/24,'HH24:MI:SS') || ' </font> <BR>' from dual;

select '<br><FONT FACE="VERDANA" SIZE=2  color="#0000FF">To : ' || 
to_char(sysdate,'HH24:MI:SS') || ' </font> <BR>' from dual;

select '<BR><FONT FACE="VERDANA" SIZE=4>SOA FAILED INSTANCES INFORMATION IN PAST ONE HOURS : <BR><BR></FONT>' from dual;
select '<table border=1 cellpadding=2 cellspacing=1>' from dual;
select 
'<th bgcolor="#000951"><FONT FACE="VERDANA" SIZE=1 COLOR="#FFFFFF">INSTANCE NO
<th bgcolor="#000951"><FONT FACE="VERDANA" SIZE=1 COLOR="#FFFFFF">CREATED TIME
<th bgcolor="#000951"><FONT FACE="VERDANA" SIZE=1 COLOR="#FFFFFF">COMPOSITE NAME
<th bgcolor="#000951"><FONT FACE="VERDANA" SIZE=1 COLOR="#FFFFFF">REFERENCE NO
<th bgcolor="#000951"><FONT FACE="VERDANA" SIZE=1 COLOR="#FFFFFF">STATUS
<th bgcolor="#000951"><FONT FACE="VERDANA" SIZE=1 COLOR="#FFFFFF">SOURCE OPERATION NAME
<th bgcolor="#000951"><FONT FACE="VERDANA" SIZE=1 COLOR="#FFFFFF">ERROR SUMMARY' from dual;

--select '<tr>
--<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || A.ID ||
--'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || A.CREATED_TIME ||
--'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || substr(composite_DN,1,instr(a.composite_DN,'!',1)-1) ||
--'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || A.TITLE ||
--'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || (case when a.state=0 then 'Running'
--when a.state=1 then 'Completed'
--when a.state=2 then 'Running with faults'
--when a.state=3 then 'Completed with faults'
--when a.state=4 then 'Running with recovery required'
--when a.state=5 then 'Completed with recovery required'
--when a.state=6 then 'Running with faults and recovery required'
--when a.state=7 then 'Completed with faults and recovery required'
--when a.state=8 then 'Running with suspended'
--when a.state=9 then 'Completed with suspended'
--when a.state=10 then 'Running with faults and suspended'
--when a.state=11 then 'Completed with faults and suspended'
--when a.state=12 then 'Running with recovery required and suspended'
--when a.state=13 then 'Completed with recovery required and suspended'
--when a.state=14 then 'Running with faults, recovery required, and suspended'
--when a.state=15 then 'Completed with faults, recovery required, and suspended'
--when a.state=16 then 'Running with terminated'
--when a.state=17 then 'Completed with terminated'
--when a.state=18 then 'Running with faults and terminated'
--when a.state=19 then 'Completed with faults and terminated'
--when a.state=20 then 'Running with recovery required and terminated'
--when a.state=21 then 'Completed with recovery required and terminated'
--when a.state=22 then 'Running with faults, recovery required, and terminated'
--when a.state=23 then 'Completed with faults, recovery required, and terminated'
--when a.state=24 then 'Running with suspended and terminated'
--when a.state=25 then 'Completed with suspended and terminated'
--when a.state=26 then 'Running with faulted, suspended, and terminated'
--when a.state=27 then 'Completed with faulted, suspended, and terminated'
--when a.state=28 then 'Running with recovery required, suspended, and terminated'
--when a.state=29 then 'Completed with recovery required, suspended, and terminated'
--when a.state=30 then 'Running with faulted, recovery required, suspended, and terminated'
--when a.state=31 then 'Completed with faulted, recovery required, suspended, and terminated'
--when a.state=32 then 'Unknown'
--when a.state=64 then '-'
--ELSE a.STATE || 'NOT FOUND' END) ||
--'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || a.source_action_name ||
--'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || substr(b.error_details,0,500) from dev_soainfra.COMPOSITE_INSTANCE a,belloggertbl@TOAPPSQRY b 
--where a.state !='1' and a.LIVE_instances !='1'
--and a.id=b.instance_id(+)
--and a.composite_DN like 'BEL_Ebiz%'
--and b.error_details not like '119%'
--and b.error_details not like '911%'
--and b.error_details not like '909%'
--and b.error_details not like '116%'
--and b.error_details not like '-Invalid%'
--and a.CREATED_TIME>=sysdate-6.3/24
--order by a.CREATED_TIME desc;
----'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || B.COMMENTS FROM DBA_SCHEDULER_JOB_RUN_DETAILS A, DBA_SCHEDULER_JOBS B WHERE A.JOB_NAME=B.JOB_NAME AND TRUNC(A.ACTUAL_START_DATE)=TRUNC(SYSDATE-1) AND A.STATUS!='SUCCEEDED' ORDER BY A.ACTUAL_START_DATE DESC;
--select '</table>' from dual;

select '<tr>
<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || INSTANCE ||
'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || CDATE ||
'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || COMPOSITE ||
'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || TITLE ||
'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || status ||
'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || source_action_name ||
'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || error  from (
select A.ID INSTANCE
, A.CREATED_TIME CDATE
, substr(composite_DN,1,instr(a.composite_DN,'!',1)-1)  COMPOSITE
, A.TITLE  TITLE
, (case when a.state=0 then 'Running'
when a.state=1 then 'Completed'
when a.state=2 then 'Running with faults'
when a.state=3 then 'Completed with faults'
when a.state=4 then 'Running with recovery required'
when a.state=5 then 'Completed with recovery required'
when a.state=6 then 'Running with faults and recovery required'
when a.state=7 then 'Completed with faults and recovery required'
when a.state=8 then 'Running with suspended'
when a.state=9 then 'Completed with suspended'
when a.state=10 then 'Running with faults and suspended'
when a.state=11 then 'Completed with faults and suspended'
when a.state=12 then 'Running with recovery required and suspended'
when a.state=13 then 'Completed with recovery required and suspended'
when a.state=14 then 'Running with faults, recovery required, and suspended'
when a.state=15 then 'Completed with faults, recovery required, and suspended'
when a.state=16 then 'Running with terminated'
when a.state=17 then 'Completed with terminated'
when a.state=18 then 'Running with faults and terminated'
when a.state=19 then 'Completed with faults and terminated'
when a.state=20 then 'Running with recovery required and terminated'
when a.state=21 then 'Completed with recovery required and terminated'
when a.state=22 then 'Running with faults, recovery required, and terminated'
when a.state=23 then 'Completed with faults, recovery required, and terminated'
when a.state=24 then 'Running with suspended and terminated'
when a.state=25 then 'Completed with suspended and terminated'
when a.state=26 then 'Running with faulted, suspended, and terminated'
when a.state=27 then 'Completed with faulted, suspended, and terminated'
when a.state=28 then 'Running with recovery required, suspended, and terminated'
when a.state=29 then 'Completed with recovery required, suspended, and terminated'
when a.state=30 then 'Running with faulted, recovery required, suspended, and terminated'
when a.state=31 then 'Completed with faulted, recovery required, suspended, and terminated'
when a.state=32 then 'Unknown'
when a.state=64 then '-'
ELSE a.STATE || 'NOT FOUND' END) STATUS
, a.source_action_name source_action_name
, substr(b.error_details,0,500) ERROR
 from dev_soainfra.COMPOSITE_INSTANCE a,belloggertbl@TOAPPSQRY b
where a.state !='1' and a.LIVE_instances !='1'
and a.id=b.instance_id(+) 
and a.composite_DN like 'BEL_Ebiz%'
and b.error_details not like '119%'
and b.error_details not like '911%'
and b.error_details not like '909%'
and b.error_details not like '116%'
and b.error_details not like '-Invalid%' 
--and a.CREATED_TIME>=sysdate-1.3/24
and a.CREATED_TIME>=sysdate-1.06/24
UNION
select A.ID 
, A.CREATED_TIME CDATE
, substr(composite_DN,1,instr(a.composite_DN,'!',1)-1)  COMPOSITE
, A.TITLE 
, (case when a.state=0 then 'Running'
when a.state=1 then 'Completed'
when a.state=2 then 'Running with faults'
when a.state=3 then 'Completed with faults'
when a.state=4 then 'Running with recovery required'
when a.state=5 then 'Completed with recovery required'
when a.state=6 then 'Running with faults and recovery required'
when a.state=7 then 'Completed with faults and recovery required'
when a.state=8 then 'Running with suspended'
when a.state=9 then 'Completed with suspended'
when a.state=10 then 'Running with faults and suspended'
when a.state=11 then 'Completed with faults and suspended'
when a.state=12 then 'Running with recovery required and suspended'
when a.state=13 then 'Completed with recovery required and suspended'
when a.state=14 then 'Running with faults, recovery required, and suspended'
when a.state=15 then 'Completed with faults, recovery required, and suspended'
when a.state=16 then 'Running with terminated'
when a.state=17 then 'Completed with terminated'
when a.state=18 then 'Running with faults and terminated'
when a.state=19 then 'Completed with faults and terminated'
when a.state=20 then 'Running with recovery required and terminated'
when a.state=21 then 'Completed with recovery required and terminated'
when a.state=22 then 'Running with faults, recovery required, and terminated'
when a.state=23 then 'Completed with faults, recovery required, and terminated'
when a.state=24 then 'Running with suspended and terminated'
when a.state=25 then 'Completed with suspended and terminated'
when a.state=26 then 'Running with faulted, suspended, and terminated'
when a.state=27 then 'Completed with faulted, suspended, and terminated'
when a.state=28 then 'Running with recovery required, suspended, and terminated'
when a.state=29 then 'Completed with recovery required, suspended, and terminated'
when a.state=30 then 'Running with faulted, recovery required, suspended, and terminated'
when a.state=31 then 'Completed with faulted, recovery required, suspended, and terminated'
when a.state=32 then 'Unknown'
when a.state=64 then '-'
ELSE a.STATE || 'NOT FOUND' END) STATUS
, a.source_action_name 
, null
--, substr(b.error_details,0,500)
 from dev_soainfra.COMPOSITE_INSTANCE a,belloggertbl@TOAPPSQRY b
where a.state !='1' and a.LIVE_instances !='1' 
and a.id=b.instance_id(+) and b.error_details is null
and a.composite_DN like 'BEL_Ebiz%'
--and b.error_details not like '119%'
--and b.error_details not like '911%'
--and b.error_details not like '909%'
--and b.error_details not like '116%'
--and b.error_details not like '-Invalid%' 
--and a.CREATED_TIME>=sysdate-1.3/24
and a.CREATED_TIME>=sysdate-1.06/24
order by CDATE desc);
--'<td bgcolor="#ccccff"><FONT FACE="VERDANA" SIZE=2>' || B.COMMENTS FROM DBA_SCHEDULER_JOB_RUN_DETAILS A, DBA_SCHEDULER_JOBS B WHERE A.JOB_NAME=B.JOB_NAME AND TRUNC(A.ACTUAL_START_DATE)=TRUNC(SYSDATE-1) AND A.STATUS!='SUCCEEDED' ORDER BY A.ACTUAL_START_DATE DESC;
select '</table>' from dual;
	
select  '</tr></table></RIGHT>' from dual;
select '<br>
	<CENTER>
	<FONT COLOR="RED">
	<BIG>
	<B>***********END OF REPORT**********</B>
	</BIG>
	</FONT>
	</CENTER>
	</br>' from dual;

set termout on;
set heading on;
set feedback on;
undefine uname;
spool off;
exit


