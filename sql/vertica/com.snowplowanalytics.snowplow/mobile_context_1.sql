CREATE TABLE IF NOT EXISTS atomic.com_snowplowanalytics_snowplow_mobile_context_1 (
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
	osType      		varchar(255)		not null    		encoding gzip_comp   ,
	osVersion   		varchar(255)		not null    		encoding gzip_comp   ,
	deviceManufacturer		varchar(255)		not null    		encoding gzip_comp   ,
	deviceModel 		varchar(255)		not null    		encoding gzip_comp   ,
	carrier     		varchar(255)		null        		encoding gzip_comp   ,
	openIdfa    		varchar(255)		null        		encoding gzip_comp   ,
	appleIdfa   		varchar(255)		null        		encoding gzip_comp   ,
	appleIdfv   		varchar(255)		null        		encoding gzip_comp   ,
	androidIdfa 		varchar(255)		null        		encoding gzip_comp   
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