-- AUTO-GENERATED BY igluctl DO NOT EDIT
-- Generator: igluctl 0.4.0
-- Generated: 2018-06-19 16:53 UTC

CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_getvero_unsubscribed_1 (
    "schema_vendor"   VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_name"     VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_format"   VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_version"  VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "root_id"         CHAR(36)      ENCODE RAW  NOT NULL,
    "root_tstamp"     TIMESTAMP     ENCODE ZSTD NOT NULL,
    "ref_root"        VARCHAR(255)  ENCODE ZSTD NOT NULL,
    "ref_tree"        VARCHAR(1500) ENCODE ZSTD NOT NULL,
    "ref_parent"      VARCHAR(255)  ENCODE ZSTD NOT NULL,
    "type"            VARCHAR(12)   ENCODE ZSTD,
    "unsubscribed_at" TIMESTAMP     ENCODE ZSTD,
    "user.email"      VARCHAR(255)  ENCODE ZSTD,
    "user.id"         VARCHAR(255)  ENCODE ZSTD,
    FOREIGN KEY (root_id) REFERENCES atomic.events(event_id)
)
DISTSTYLE KEY
DISTKEY (root_id)
SORTKEY (root_tstamp);

COMMENT ON TABLE atomic.com_getvero_unsubscribed_1 IS 'iglu:com.getvero/unsubscribed/jsonschema/1-0-0';
