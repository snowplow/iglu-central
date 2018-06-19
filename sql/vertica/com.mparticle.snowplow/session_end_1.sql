CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_mparticle_snowplow_session_end_1 (
    -- Schema of this type
    schema_vendor       varchar(128)        not null        encoding rle,
    schema_name         varchar(128)        not null        encoding rle,
    schema_format       varchar(128)        not null        encoding rle,
    schema_version      varchar(128)        not null        encoding rle,
    -- Parentage of this type
    root_id             char(36)            not null        encoding gzip_comp   ,
    root_tstamp         timestamp           not null        encoding deltaval    ,
    ref_root            varchar(255)        not null        encoding rle         ,
    ref_tree            varchar(1500)       not null        encoding rle         ,
    ref_parent          varchar(255)        not null        encoding rle         ,
    -- Properties of this type
    session_duration_ms         integer         null        encoding gzip_comp,
    session_uuid                varchar(255)    null        encoding gzip_comp,
    source_message_id           varchar(255)    null        encoding gzip_comp,
    timestamp_unixtime_ms       integer         null        encoding gzip_comp,
    custom_attributes           varchar(4096)   null        encoding gzip_comp,
    FOREIGN KEY (root_id) REFERENCES atomic.events(event_id)
)
ORDER BY
    schema_vendor,
    schema_name,
    schema_format,
    schema_version,
    ref_root,
    ref_tree,
    ref_parent,
    root_tstamp,
    root_id
SEGMENTED BY
    hash(root_id) ALL NODES
;

COMMENT ON TABLE atomic.com_mparticle_snowplow_session_end_1 IS 'iglu:com.mparticle.snowplow/session_end/jsonschema/1-0-0';