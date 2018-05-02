CREATE TABLE IF NOT EXISTS atomic.com_chewy_filter_1 (
    schema_vendor           varchar(128)  not null           encoding rle,
    schema_name             varchar(128)  not null           encoding rle,
    schema_format           varchar(128)  not null           encoding rle,
    schema_version          varchar(128)  not null           encoding rle,
 
    root_id                 char(36)      not null           encoding gzip_comp,
    root_tstamp             timestamp     not null           encoding deltaval,
    ref_root                varchar(255)  not null           encoding rle,
    ref_tree                varchar(1500) not null           encoding rle,
    ref_parent              varchar(255)  not null           encoding rle,

    category_id             varchar(128) null               encoding auto,
    category_level          varchar(512) null               encoding auto,
    category_name           varchar(512) null               encoding auto,
    facet_id                varchar(128) null               encoding auto,
    facet_name              varchar(512) null               encoding auto,
    facet_value             varchar(512) null               encoding auto,
    source_view             varchar(512) null               encoding auto,
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

COMMENT ON TABLE atomic.com_chewy_filter_1 IS 'iglu:com.chewy/filter/jsonschema/1-0-0';
