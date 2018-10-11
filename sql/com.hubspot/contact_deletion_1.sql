-- AUTO-GENERATED BY igluctl DO NOT EDIT
-- Generator: igluctl 0.4.1
-- Generated: 2018-10-11 00:45 UTC

CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_hubspot_contact_deletion_1 (
    "schema_vendor"   VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_name"     VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_format"   VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_version"  VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "root_id"         CHAR(36)      ENCODE RAW  NOT NULL,
    "root_tstamp"     TIMESTAMP     ENCODE ZSTD NOT NULL,
    "ref_root"        VARCHAR(255)  ENCODE ZSTD NOT NULL,
    "ref_tree"        VARCHAR(1500) ENCODE ZSTD NOT NULL,
    "ref_parent"      VARCHAR(255)  ENCODE ZSTD NOT NULL,
    "app_id"          INT           ENCODE ZSTD,
    "attempt_number"  INT           ENCODE ZSTD,
    "change_flag"     VARCHAR(128)  ENCODE ZSTD,
    "change_source"   VARCHAR(128)  ENCODE ZSTD,
    "event_id"        INT           ENCODE ZSTD,
    "object_id"       INT           ENCODE ZSTD,
    "occured_at"      TIMESTAMP     ENCODE ZSTD,
    "portal_id"       INT           ENCODE ZSTD,
    "subscription_id" INT           ENCODE ZSTD,
    FOREIGN KEY (root_id) REFERENCES atomic.events(event_id)
)
DISTSTYLE KEY
DISTKEY (root_id)
SORTKEY (root_tstamp);

COMMENT ON TABLE atomic.com_hubspot_contact_deletion_1 IS 'iglu:com.hubspot/contact_deletion/jsonschema/1-0-0';
