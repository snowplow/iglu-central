CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_mparticle_snowplow_device_info_1 (
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
    android_advertising_id            varchar(4096)         null        encoding gzip_comp,
    android_uuid                      varchar(4096)         null        encoding gzip_comp,
    bluetooth_enabled                 boolean               null        encoding auto,
    bluetooth_version                 varchar(4096)         null        encoding gzip_comp,
    brand                             varchar(4096)         null        encoding gzip_comp,
    build_identifier                  varchar(4096)         null        encoding gzip_comp,
    cpu_architecture                  varchar(4096)         null        encoding gzip_comp,
    device                            varchar(4096)         null        encoding gzip_comp,
    device_country                    varchar(4096)         null        encoding gzip_comp,
    device_manufacturer               varchar(4096)         null        encoding gzip_comp,
    device_model                      char(9)               null        encoding gzip_comp,
    has_nfc                           boolean               null        encoding auto,
    http_header_user_agent            varchar(4096)         null        encoding gzip_comp,
    ios_advertising_id                char(36)              null        encoding gzip_comp,
    ios_idfv                          char(36)              null        encoding gzip_comp,
    is_dst                            boolean               null        encoding auto,
    is_tablet                         boolean               null        encoding auto,
    limit_ad_tracking                 boolean               null        encoding auto,
    locale_country                    varchar(4096)         null        encoding gzip_comp,
    locale_language                   varchar(4096)         null        encoding gzip_comp,
    network_carrier                   varchar(4096)         null        encoding gzip_comp,
    network_code                      varchar(4096)         null        encoding gzip_comp,
    network_country                   varchar(4096)         null        encoding gzip_comp,
    network_mobile_country_code       varchar(4096)         null        encoding gzip_comp,
    os_version                        char(5)               null        encoding gzip_comp,
    platform                          varchar(4096)         null        encoding gzip_comp,
    product                           varchar(4096)         null        encoding gzip_comp,
    push_notification_sound_enabled   boolean               null        encoding auto,
    push_notification_vibrate_enabled boolean               null        encoding auto,
    push_token                        varchar(4096)         null        encoding gzip_comp,
    radio_access_technology           varchar(4096)         null        encoding gzip_comp,
    screen_dpi                        integer               null        encoding gzip_comp,
    screen_height                     integer               null        encoding gzip_comp,
    screen_width                      integer               null        encoding gzip_comp,
    supports_telephony                varchar(4096)         null        encoding gzip_comp,
    timezone_offset                   integer               null        encoding gzip_comp,
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

COMMENT ON TABLE atomic.com_mparticle_snowplow_device_info_1 IS 'iglu:com.mparticle.snowplow/device_info/jsonschema/1-0-0';
