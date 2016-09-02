-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_amazon_aws_cloudfront_wd_access_log_1';
--  obj_description
-- -----------------
--  iglu:com.amazon.aws.cloudfront/wd_access_log/jsonschema/1-0-3
--  (1 row)

BEGIN TRANSACTION;

  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "ssl_cipher" VARCHAR(64) ENCODE LZO;
  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "ssl_protocol" VARCHAR(32) ENCODE LZO;
  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "x_edge_response_result_type" VARCHAR(32) ENCODE LZO;
  ALTER TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1
    ADD COLUMN "x_forwarded_for" VARCHAR(45) ENCODE LZO;

  COMMENT ON TABLE atomic.com_amazon_aws_cloudfront_wd_access_log_1 IS 'iglu:com.amazon.aws.cloudfront/wd_access_log/jsonschema/1-0-4';

END TRANSACTION;
