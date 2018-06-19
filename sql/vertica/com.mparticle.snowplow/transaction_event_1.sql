CREATE TABLE IF NOT EXISTS atomic.com_mparticle_snowplow_transaction_event_1 (
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
	name        		varchar(255)		not null    		encoding gzip_comp   ,
	sku         		varchar(255)		not null    		encoding gzip_comp   ,
	category    		varchar(255)		null        		encoding gzip_comp   ,
	affiliation 		varchar(255)		null        		encoding gzip_comp   ,
	unitPrice   		number      		null        		encoding auto        ,
	quantity    		number      		null        		encoding auto        ,
	revenue     		number      		null        		encoding auto        ,
	tax         		number      		null        		encoding auto        ,
	shipping    		number      		null        		encoding auto        ,
	currency    		varchar(255)		null        		encoding gzip_comp   ,
	transactionId		varchar(255)		null        		encoding gzip_comp   
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