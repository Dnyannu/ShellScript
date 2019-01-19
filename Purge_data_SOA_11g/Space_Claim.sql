spool &1 append;
set line 150
set trimspool on
set head off
col OWNER for a15
col OBJECT_NAME for a20
col OBJECT_TYPE for a15
col TABLE_NAME for a25
col TABLESPACE_NAME for a15

select '#### Reclaim Space ####' from dual;
SELECT * FROM (
  SELECT
    owner, object_name, object_type, table_name, ROUND(bytes)/1024/1024 AS meg,
    tablespace_name, extents, initial_extent,
    ROUND(Sum(bytes/1024/1024) OVER (PARTITION BY table_name)) AS total_table_meg
  FROM (
    -- Tables
    SELECT owner, segment_name AS object_name, 'TABLE' AS object_type,
          segment_name AS table_name, bytes,
          tablespace_name, extents, initial_extent
    FROM   dba_segments
    WHERE  segment_type IN ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
    UNION ALL
    -- Indexes
    SELECT i.owner, i.index_name AS object_name, 'INDEX' AS object_type,
          i.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_indexes i, dba_segments s
    WHERE  s.segment_name = i.index_name
    AND    s.owner = i.owner
    AND    s.segment_type IN ('INDEX', 'INDEX PARTITION', 'INDEX SUBPARTITION')
    -- LOB Segments
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_COLUMN' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.segment_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBSEGMENT'
    -- LOB Indexes
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_INDEX' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.index_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBINDEX'
  )
  WHERE --owner in UPPER('schema_name')
  object_name in ('XML_DOCUMENT','AUDIT_TRAIL','AUDIT_DETAILS','REFERENCE_INSTANCE','CUBE_INSTANCE','COMPOSITE_INSTANCE','CUBE_SCOPE')
)
order by MEG desc;

set line 60
set echo on
select ' XML_DOCUMENT' from dual;
alter table XML_DOCUMENT deallocate unused;
alter table XML_DOCUMENT enable row movement;
alter table XML_DOCUMENT shrink space compact;
alter table XML_DOCUMENT shrink space;
alter table XML_DOCUMENT disable row movement;
select ' AUDIT_TRAIL' from dual;
alter table AUDIT_TRAIL deallocate unused;
alter table AUDIT_TRAIL enable row movement;
alter table AUDIT_TRAIL shrink space compact;
alter table AUDIT_TRAIL shrink space;
alter table AUDIT_TRAIL disable row movement;
select ' AUDIT_DETAILS' from dual;
alter table AUDIT_DETAILS deallocate unused;
alter table AUDIT_DETAILS enable row movement;
alter table AUDIT_DETAILS shrink space compact;
alter table AUDIT_DETAILS shrink space;
alter table AUDIT_DETAILS disable row movement;
select ' REFERENCE_INSTANCE' from dual;
alter table REFERENCE_INSTANCE deallocate unused;
alter table REFERENCE_INSTANCE enable row movement;
alter table REFERENCE_INSTANCE shrink space compact;
alter table REFERENCE_INSTANCE shrink space;
alter table REFERENCE_INSTANCE disable row movement;
select ' CUBE_INSTANCE' from dual;
alter table CUBE_INSTANCE deallocate unused;
alter table CUBE_INSTANCE enable row movement;
alter table CUBE_INSTANCE shrink space compact;
alter table CUBE_INSTANCE shrink space;
alter table CUBE_INSTANCE disable row movement;
select ' COMPOSITE_INSTANCE' from dual;
alter table COMPOSITE_INSTANCE deallocate unused;
alter table COMPOSITE_INSTANCE enable row movement;
alter table COMPOSITE_INSTANCE shrink space compact;
alter table COMPOSITE_INSTANCE shrink space;
alter table COMPOSITE_INSTANCE disable row movement;
select ' CUBE_SCOPE' from dual;
alter table CUBE_SCOPE deallocate unused;
alter table CUBE_SCOPE enable row movement;
alter table CUBE_SCOPE shrink space compact;
alter table CUBE_SCOPE shrink space;
alter table CUBE_SCOPE disable row movement;
set echo off

set line 150
col OWNER for a15
col OBJECT_NAME for a20
col OBJECT_TYPE for a15
col TABLE_NAME for a25
col TABLESPACE_NAME for a15
SELECT * FROM (
  SELECT
    owner, object_name, object_type, table_name, ROUND(bytes)/1024/1024 AS meg,
    tablespace_name, extents, initial_extent,
    ROUND(Sum(bytes/1024/1024) OVER (PARTITION BY table_name)) AS total_table_meg
  FROM (
    -- Tables
    SELECT owner, segment_name AS object_name, 'TABLE' AS object_type,
          segment_name AS table_name, bytes,
          tablespace_name, extents, initial_extent
    FROM   dba_segments
    WHERE  segment_type IN ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
    UNION ALL
    -- Indexes
    SELECT i.owner, i.index_name AS object_name, 'INDEX' AS object_type,
          i.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_indexes i, dba_segments s
    WHERE  s.segment_name = i.index_name
    AND    s.owner = i.owner
    AND    s.segment_type IN ('INDEX', 'INDEX PARTITION', 'INDEX SUBPARTITION')
    -- LOB Segments
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_COLUMN' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.segment_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBSEGMENT'
    -- LOB Indexes
    UNION ALL
    SELECT l.owner, l.column_name AS object_name, 'LOB_INDEX' AS object_type,
          l.table_name, s.bytes,
          s.tablespace_name, s.extents, s.initial_extent
    FROM   dba_lobs l, dba_segments s
    WHERE  s.segment_name = l.index_name
    AND    s.owner = l.owner
    AND    s.segment_type = 'LOBINDEX'
  )
  WHERE --owner in UPPER('schema_name')
  object_name in ('XML_DOCUMENT','AUDIT_TRAIL','AUDIT_DETAILS','REFERENCE_INSTANCE','CUBE_INSTANCE','COMPOSITE_INSTANCE','CUBE_SCOPE')
)
order by MEG desc;

select '#### Gather Schema Stat ####' from dual;
EXEC DBMS_STATS.gather_schema_stats('DEV_SOAINFRA');
spool off;
exit;

