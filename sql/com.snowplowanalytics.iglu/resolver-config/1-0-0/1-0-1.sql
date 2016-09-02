-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_snowplowanalytics_iglu_resolver_config_1';
--  obj_description
-- -----------------
--  iglu:com.snowplowanalytics.iglu/resolver-config/jsonschema/1-0-0
--  (1 row)

BEGIN TRANSACTION;

-- NO ADDED COLUMNS CAN BE EXPRESSED IN SQL MIGRATION

  COMMENT ON TABLE atomic.com_snowplowanalytics_iglu_resolver_config_1 IS 'iglu:com.snowplowanalytics.iglu/resolver-config/jsonschema/1-0-1';

END TRANSACTION;
