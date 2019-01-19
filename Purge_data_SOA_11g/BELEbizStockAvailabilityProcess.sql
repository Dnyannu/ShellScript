set timing on
DECLARE
     max_creation_date timestamp;
     min_creation_date timestamp;
     batch_size integer;
     max_runtime integer;
     retention_period timestamp;
     composite_name varchar2(500);
     soa_partition_name varchar2(200);
     purge_partitioned_component boolean;

    BEGIN

     min_creation_date             := TO_TIMESTAMP(TO_CHAR(sysdate-30, 'YYYY-MM-DD'),'YYYY-MM-DD');
     max_creation_date             := TO_TIMESTAMP(TO_CHAR(sysdate-7, 'YYYY-MM-DD'),'YYYY-MM-DD');
     batch_size                    := 100000;
     max_runtime                   := 600;
     retention_period              := TO_TIMESTAMP(TO_CHAR(sysdate-7, 'YYYY-MM-DD'),'YYYY-MM-DD');
     composite_name                := 'BELEbizStockAvailabilityProcessV1';
     soa_partition_name            := 'BEL_Ebiz';
     purge_partitioned_component   := true;

     soa.delete_instances(
       min_creation_date             => min_creation_date,
       max_creation_date             => max_creation_date,
       batch_size                    => batch_size,
       max_runtime                   => max_runtime,
       retention_period              => retention_period,
       purge_partitioned_component   => purge_partitioned_component,
       composite_name                => composite_name,
       soa_partition_name            => soa_partition_name);
     END;
  /
set timing off
