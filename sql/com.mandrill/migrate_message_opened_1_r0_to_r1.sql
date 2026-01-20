-- WARNING: only apply this file to your database if the following SQL returns the expected:
--
-- SELECT pg_catalog.obj_description(c.oid) FROM pg_catalog.pg_class c WHERE c.relname = 'com_mandrill_message_opened_1';
--  obj_description
-- -----------------
--  iglu:com.mandrill/message_opened/jsonschema/1-0-0
--  (1 row)

BEGIN TRANSACTION;

  ALTER TABLE atomic.com_mandrill_message_opened_1
    ADD COLUMN "msg.subaccount" VARCHAR(255) ENCODE raw;

END TRANSACTION;
