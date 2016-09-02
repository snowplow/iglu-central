-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1';
--  obj_description
-- -----------------
--  iglu:com.snowplowanalytics.snowplow/elasticsearch_enriched_event/jsonschema/1-0-0
--  (1 row)

BEGIN TRANSACTION;

  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "base_currency" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "dvce_sent_tstamp" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "etl_tags" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "geo_timezone" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "mkt_clickid" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "mkt_network" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "refr_domain_userid" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "refr_dvce_tstamp" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "session_id" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "ti_currency" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "ti_price_base" DOUBLE PRECISION ENCODE RAW;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "tr_currency" VARCHAR(4096) ENCODE LZO;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "tr_shipping_base" DOUBLE PRECISION ENCODE RAW;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "tr_tax_base" DOUBLE PRECISION ENCODE RAW;
  ALTER TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1
    ADD COLUMN "tr_total_base" DOUBLE PRECISION ENCODE RAW;

  COMMENT ON TABLE atomic.com_snowplowanalytics_snowplow_elasticsearch_enriched_event_1 IS 'iglu:com.snowplowanalytics.snowplow/elasticsearch_enriched_event/jsonschema/1-0-1';

END TRANSACTION;
