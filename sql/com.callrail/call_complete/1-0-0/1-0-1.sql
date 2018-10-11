-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_callrail_call_complete_1';
--  obj_description
-- -----------------
--  iglu:com.callrail/call_complete/jsonschema/1-0-0
--  (1 row)

BEGIN TRANSACTION;

  ALTER TABLE atomic.com_callrail_call_complete_1
    ADD COLUMN "device_type" VARCHAR(4096) ENCODE ZSTD;

  COMMENT ON TABLE atomic.com_callrail_call_complete_1 IS 'iglu:com.callrail/call_complete/jsonschema/1-0-1';

END TRANSACTION;
