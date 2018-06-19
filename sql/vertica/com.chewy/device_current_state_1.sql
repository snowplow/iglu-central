CREATE TABLE IF NOT EXISTS atomic.com_chewy_device_current_state_1 (
    schema_vendor                      varchar(128)     not null           encoding rle,
    schema_name                        varchar(128)     not null           encoding rle,
    schema_format                      varchar(128)     not null           encoding rle,
    schema_version                     varchar(128)     not null           encoding rle,
    root_id                            char(36)         not null           encoding gzip_comp,
    root_tstamp                        timestamp        not null           encoding deltaval,
    ref_root                           varchar(255)     not null           encoding rle,
    ref_tree                           varchar(1500)    not null           encoding rle,
    ref_parent                         varchar(255)     not null           encoding rle,
    application_memory_available_bytes numeric(37,15)   null               encoding gzip_comp,
    application_memory_max_bytes       numeric(37,15)   null               encoding gzip_comp,
    application_memory_total_bytes     numeric(37,15)   null               encoding gzip_comp,
    battery_level                      double precision null               encoding auto,
    cpu                                char(1)          null               encoding gzip_comp,
    data_connection_type               char(4)          null               encoding gzip_comp,
    data_connection_type_detail        varchar(4096)    null               encoding gzip_comp,
    device_orientation                 char(8)          null               encoding gzip_comp,
    disk_space_free_bytes              bigint           null               encoding gzip_comp,
    external_disk_space_free_bytes     numeric(37,15)   null               encoding gzip_comp,
    gps_state                          boolean          null               encoding auto,
    status_bar_orientation             char(8)          null               encoding gzip_comp,
    system_memory_available_bytes      numeric(37,15)   null               encoding gzip_comp,
    system_memory_low                  varchar(4096)    null               encoding gzip_comp,
    system_memory_threshold_bytes      numeric(37,15)   null               encoding gzip_comp,
    time_since_start_ms                int              null               encoding gzip_comp,
    total_system_memory_usage_bytes    numeric(37,15)   null               encoding gzip_comp,
    event_id                            bigint          null               encoding gzip_comp,
    timestamp_unixtime_ms               bigint          null               encoding gzip_comp,
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