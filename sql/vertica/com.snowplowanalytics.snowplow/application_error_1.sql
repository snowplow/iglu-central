CREATE TABLE IF NOT EXISTS atomic.com_snowplowanalytics_snowplow_application_error_1 (
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
	programmingLanguage		varchar(255)		not null    		encoding gzip_comp   ,
	message     		varchar(255)		not null    		encoding gzip_comp   ,
	threadName  		varchar(255)		null        		encoding gzip_comp   ,
	threadId    		integer     		null        		encoding auto        ,
	stackTrace  		varchar(255)		null        		encoding gzip_comp   ,
	lineNumber  		integer     		null        		encoding auto        ,
	className   		varchar(255)		null        		encoding gzip_comp   ,
	exceptionName		varchar(255)		null        		encoding gzip_comp   ,
	isFatal     		boolean     		null        		encoding auto        
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