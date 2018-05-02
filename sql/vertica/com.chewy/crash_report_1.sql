CREATE TABLE IF NOT EXISTS atomic.com_chewy_crash_report_1 (
    schema_vendor               varchar(128)  not null           encoding rle,
    schema_name                 varchar(128)  not null           encoding rle,
    schema_format               varchar(128)  not null           encoding rle,
    schema_version              varchar(128)  not null           encoding rle,
    root_id                     char(36)      not null           encoding gzip_comp,
    root_tstamp                 timestamp     not null           encoding deltaval,
    ref_root                    varchar(255)  not null           encoding rle,
    ref_tree                    varchar(1500) not null           encoding rle,
    ref_parent                  varchar(255)  not null           encoding rle,
    class_name                  char(26)      null               encoding gzip_comp,
    event_id                    bigint        null               encoding gzip_comp,
    ios_image_base_address      bigint        null               encoding gzip_comp,
    ios_image_size              int           null               encoding gzip_comp,
    message                     char(78)      null               encoding gzip_comp,
    pl_crash_report_file_base64 char(18)      null               encoding gzip_comp,
    severity                    char(5)       null               encoding gzip_comp,
    stack_trace                 char(24)      null               encoding gzip_comp,
    timestamp_unixtime_ms       bigint        null               encoding gzip_comp,
    topmost_context             char(17)      null               encoding gzip_comp,
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

COMMENT ON TABLE atomic.com_chewy_crash_report_1 IS 'iglu:com.chewy/crash_report/jsonschema/1-0-0';