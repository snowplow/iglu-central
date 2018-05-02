CREATE TABLE IF NOT EXISTS atomic.com_chewy_search_1 (
    schema_vendor           varchar(128)  not null           encoding rle,
    schema_name             varchar(128)  not null           encoding rle,
    schema_format           varchar(128)  not null           encoding rle,
    schema_version          varchar(128)  not null           encoding rle,
    root_id                 char(36)      not null           encoding gzip_comp,
    root_tstamp             timestamp     not null           encoding deltaval,
    ref_root                varchar(255)  not null           encoding rle,
    ref_tree                varchar(1500) not null           encoding rle,
    ref_parent              varchar(255)  not null           encoding rle,
    search_term             varchar(2048) null               encoding gzip_comp,
    search_term_corrected   varchar(2048) null               encoding gzip_comp,
    search_term_relaxed     varchar(2048) null               encoding gzip_comp,
    search_redirect         varchar(2048) null               encoding gzip_comp,
    search_redirect_type    varchar(2048) null               encoding gzip_comp,
    source_view             varchar(2048) null               encoding gzip_comp,
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

COMMENT ON TABLE atomic.com_chewy_search_1 IS 'iglu:com.chewy/search/jsonschema/1-0-0';