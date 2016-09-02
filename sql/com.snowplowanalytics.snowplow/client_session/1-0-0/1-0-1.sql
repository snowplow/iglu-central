-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_snowplowanalytics_snowplow_client_session_1';
--  obj_description
-- -----------------
--  iglu:com.snowplowanalytics.snowplow/client_session/jsonschema/1-0-0
--  (1 row)

BEGIN TRANSACTION;

  ALTER TABLE atomic.com_snowplowanalytics_snowplow_client_session_1
    ADD COLUMN "first_event_id" CHAR(36) ENCODE LZO;

  COMMENT ON TABLE atomic.com_snowplowanalytics_snowplow_client_session_1 IS 'iglu:com.snowplowanalytics.snowplow/client_session/jsonschema/1-0-1';

END TRANSACTION;
