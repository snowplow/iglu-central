CREATE TABLE IF NOT EXISTS atomic.com_snowplowanalytics_snowplow_ua_parser_context_1 (
	-- Schema of this type
	schema_vendor		varchar(128)		not null		encoding rle,
	schema_name 		varchar(128)		not null		encoding rle,
	schema_format		varchar(128)		not null		encoding rle,
	schema_version		varchar(128)		not null		encoding rle,
	-- Parentage of this type
	root_id     		varchar(36) 		not null		encoding gzip_comp   ,
	root_tstamp 		timestamp   		not null		encoding deltaval    ,
	ref_root    		varchar(255)		not null		encoding rle         ,
	ref_tree    		varchar(1500)		not null		encoding rle         ,
	ref_parent  		varchar(255)		not null		encoding rle         ,
	-- Properties of this type
	useragentFamily		varchar(255)		not null    		encoding gzip_comp   ,
	useragentMajor		varchar(255)		not null    		encoding gzip_comp   ,
	useragentMinor		varchar(255)		not null    		encoding gzip_comp   ,
	useragentPatch		varchar(255)		null        		encoding gzip_comp   ,
	useragentVersion		varchar(255)		null        		encoding gzip_comp   ,
	osFamily    		varchar(255)		not null    		encoding gzip_comp   ,
	osMajor     		varchar(255)		null        		encoding gzip_comp   ,
	osMinor     		varchar(255)		null        		encoding gzip_comp   ,
	osPatch     		varchar(255)		null        		encoding gzip_comp   ,
	osPatchMinor		varchar(255)		null        		encoding gzip_comp   ,
	osVersion   		varchar(255)		null        		encoding gzip_comp   ,
	deviceFamily		varchar(255)		not null    		encoding gzip_comp   
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