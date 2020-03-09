-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_snowplowanalytics_snowplow_mobile_context_1';
--  obj_description
-- -----------------
--  iglu:com.snowplowanalytics.snowplow/mobile_context/jsonschema/1-0-0
--  (1 row)

BEGIN TRANSACTION;

  ALTER TABLE atomic.com_snowplowanalytics_snowplow_mobile_context_1
    ADD COLUMN "network_technology" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_mobile_context_1
    ADD COLUMN "network_type" VARCHAR(7) ENCODE LZO;

  COMMENT ON TABLE atomic.com_snowplowanalytics_snowplow_mobile_context_1 IS 'iglu:com.snowplowanalytics.snowplow/mobile_context/jsonschema/1-0-1';

END TRANSACTION;
