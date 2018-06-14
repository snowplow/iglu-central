-- dcs = device_current_state
CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_mparticle_snowplow_application_state_transition_1 (
    -- Schema of this type
    schema_vendor       varchar(128)        not null        encoding rle,
    schema_name         varchar(128)        not null        encoding rle,
    schema_format       varchar(128)        not null        encoding rle,
    schema_version      varchar(128)        not null        encoding rle,
    -- Parentage of this type
    root_id             char(36)        not null        encoding gzip_comp   ,
    root_tstamp         timestamp           not null        encoding deltaval    ,
    ref_root            varchar(255)        not null        encoding rle         ,
    ref_tree            varchar(1500)       not null        encoding rle         ,
    ref_parent          varchar(255)        not null        encoding rle         ,
    -- Properties of this type
    application_transition_type                     varchar(22)         encoding gzip_comp,
    dcs_application_memory_total_bytes              integer             encoding auto,
    dcs_battery_level                               integer             encoding auto,
    dcs_cpu                                         varchar(1)          encoding gzip_comp,
    dcs_data_connection_type                        varchar(4)          encoding gzip_comp,
    dcs_device_orientation                          integer             encoding auto,
    dcs_disk_space_free_bytes                       integer             encoding auto,
    dcs_gps_state                                   boolean             encoding auto,
    dcs_status_bar_orientation                      integer             encoding auto,
    dcs_system_memory_available_bytes               integer             encoding auto,
    dcs_time_since_start_ms                         integer             encoding auto,
    dcs_total_system_memory_usage_bytes             integer             encoding auto,
    event_id                                        integer             encoding auto,
    location_area_code                              integer             encoding auto,
    location_city_name                              varchar(15)         encoding gzip_comp,
    location_country_code                           varchar(2)          encoding gzip_comp,
    location_country_name                           varchar(13)         encoding gzip_comp,
    location_dma_code                               integer             encoding auto,
    location_metro_code                             integer             encoding auto,
    location_postal_code                            varchar(5)          encoding gzip_comp,
    location_region_code                            varchar(2)          encoding gzip_comp,
    location_region_name                            varchar(7)          encoding gzip_comp,
    session_uuid                                    varchar(36)         encoding gzip_comp,
    timestamp_unixtime_ms                           integer             encoding auto,
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

COMMENT ON TABLE atomic.com_mparticle_snowplow_application_state_transition_1 IS 'iglu:com.mparticle.snowplow/application_state_transition/jsonschema/1-0-0';

