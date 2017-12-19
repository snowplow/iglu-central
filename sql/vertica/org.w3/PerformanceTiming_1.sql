CREATE TABLE IF NOT EXISTS atomic.org_w3_PerformanceTiming_1 (
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
	navigationStart		integer     		null        		encoding auto        ,
	redirectStart		integer     		null        		encoding auto        ,
	redirectEnd 		integer     		null        		encoding auto        ,
	fetchStart  		integer     		null        		encoding auto        ,
	domainLookupStart		integer     		null        		encoding auto        ,
	domainLookupEnd		integer     		null        		encoding auto        ,
	connectStart		integer     		null        		encoding auto        ,
	secureConnectionStart		integer     		null        		encoding auto        ,
	connectEnd  		integer     		null        		encoding auto        ,
	requestStart		integer     		null        		encoding auto        ,
	responseStart		integer     		null        		encoding auto        ,
	responseEnd 		integer     		null        		encoding auto        ,
	unloadEventStart		integer     		null        		encoding auto        ,
	unloadEventEnd		integer     		null        		encoding auto        ,
	domLoading  		integer     		null        		encoding auto        ,
	domInteractive		integer     		null        		encoding auto        ,
	domContentLoadedEventStart		integer     		null        		encoding auto        ,
	domContentLoadedEventEnd		integer     		null        		encoding auto        ,
	domComplete 		integer     		null        		encoding auto        ,
	loadEventStart		integer     		null        		encoding auto        ,
	loadEventEnd		integer     		null        		encoding auto        ,
	msFirstPaint		integer     		null        		encoding auto        ,
	chromeFirstPaint		integer     		null        		encoding auto        ,
	requestEnd  		integer     		null        		encoding auto        ,
	proxyStart  		integer     		null        		encoding auto        ,
	proxyEnd    		integer     		null        		encoding auto        
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