-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_amazon_aws_cloudfront_wd_access_log_1';
--  obj_description
-- -----------------
--  iglu:com.amazon.aws.cloudfront/wd_access_log/jsonschema/1-0-1
--  (1 row)

BEGIN TRANSACTION;

  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "cs_bytes" DOUBLE PRECISION ENCODE RAW;
  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "cs_protocol" VARCHAR(5) ENCODE LZO;
  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "x_host_header" VARCHAR(2000) ENCODE LZO;
  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "time_taken" DOUBLE PRECISION ENCODE RAW;

  COMMENT ON TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1 IS 'iglu:com.amazon.aws.cloudfront/wd_access_log/jsonschema/1-0-3';

END TRANSACTION;
