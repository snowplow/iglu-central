-- Copyright (c) 2014 Snowplow Analytics Ltd. All rights reserved.
--
-- This program is licensed to you under the Apache License Version 2.0,
-- and you may not use this file except in compliance with the Apache License Version 2.0.
-- You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the Apache License Version 2.0 is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.
--
-- Authors:       Alex Dean
-- Copyright:     Copyright (c) 2014 Snowplow Analytics Ltd
-- License:       Apache License Version 2.0
--
-- Compatibility: iglu:org.w3/PerformanceTiming/jsonschema/1-0-0

CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.org_w3_performance_timing_1 (
    -- Schema of this type
    "schema_vendor"                  VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_name"                    VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_format"                  VARCHAR(128)  ENCODE ZSTD NOT NULL,
    "schema_version"                 VARCHAR(128)  ENCODE ZSTD NOT NULL,
    -- Parentage of this type
    "root_id"                        CHAR(36)      ENCODE RAW  NOT NULL,
    "root_tstamp"                    TIMESTAMP     ENCODE ZSTD NOT NULL,
    "ref_root"                       VARCHAR(255)  ENCODE ZSTD NOT NULL,
    "ref_tree"                       VARCHAR(1500) ENCODE ZSTD NOT NULL,
    "ref_parent"                     VARCHAR(255)  ENCODE ZSTD NOT NULL,
    -- Properties of this type
    "chrome_first_paint"             BIGINT        ENCODE ZSTD,
    "connect_end"                    BIGINT        ENCODE ZSTD,
    "connect_start"                  BIGINT        ENCODE ZSTD,
    "dom_complete"                   BIGINT        ENCODE ZSTD,
    "dom_content_loaded_event_end"   BIGINT        ENCODE ZSTD,
    "dom_content_loaded_event_start" BIGINT        ENCODE ZSTD,
    "dom_interactive"                BIGINT        ENCODE ZSTD,
    "dom_loading"                    BIGINT        ENCODE ZSTD,
    "domain_lookup_end"              BIGINT        ENCODE ZSTD,
    "domain_lookup_start"            BIGINT        ENCODE ZSTD,
    "fetch_start"                    BIGINT        ENCODE ZSTD,
    "load_event_end"                 BIGINT        ENCODE ZSTD,
    "load_event_start"               BIGINT        ENCODE ZSTD,
    "ms_first_paint"                 BIGINT        ENCODE ZSTD,
    "navigation_start"               BIGINT        ENCODE ZSTD,
    "proxy_end"                      BIGINT        ENCODE ZSTD,
    "proxy_start"                    BIGINT        ENCODE ZSTD,
    "redirect_end"                   BIGINT        ENCODE ZSTD,
    "redirect_start"                 BIGINT        ENCODE ZSTD,
    "request_end"                    BIGINT        ENCODE ZSTD,
    "request_start"                  BIGINT        ENCODE ZSTD,
    "response_end"                   BIGINT        ENCODE ZSTD,
    "response_start"                 BIGINT        ENCODE ZSTD,
    "secure_connection_start"        BIGINT        ENCODE ZSTD,
    "unload_event_end"               BIGINT        ENCODE ZSTD,
    "unload_event_start"             BIGINT        ENCODE ZSTD,
    FOREIGN KEY (root_id) REFERENCES atomic.events(event_id)
)
DISTSTYLE KEY
DISTKEY (root_id)
SORTKEY (root_tstamp);

COMMENT ON TABLE atomic.org_w3_performance_timing_1 IS 'iglu:org.w3/PerformanceTiming/jsonschema/1-0-0';
