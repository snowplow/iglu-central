-- Edited manually
-- Increased size of "task_states" as this is of an indeterminate size (but larger than 5000)
-- Generator: igluctl 0.2.0
-- Generated: 2016-10-24 17:57

CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_snowplowanalytics_factotum_job_update_1 (
    "schema_vendor"                 VARCHAR(128)     ENCODE RUNLENGTH NOT NULL,
    "schema_name"                   VARCHAR(128)     ENCODE RUNLENGTH NOT NULL,
    "schema_format"                 VARCHAR(128)     ENCODE RUNLENGTH NOT NULL,
    "schema_version"                VARCHAR(128)     ENCODE RUNLENGTH NOT NULL,
    "root_id"                       CHAR(36)         ENCODE RAW       NOT NULL,
    "root_tstamp"                   TIMESTAMP        ENCODE LZO       NOT NULL,
    "ref_root"                      VARCHAR(255)     ENCODE RUNLENGTH NOT NULL,
    "ref_tree"                      VARCHAR(1500)    ENCODE RUNLENGTH NOT NULL,
    "ref_parent"                    VARCHAR(255)     ENCODE RUNLENGTH NOT NULL,
    "application_context.name"      VARCHAR(4096)    ENCODE LZO       NOT NULL,
    "application_context.version"   VARCHAR(4096)    ENCODE LZO       NOT NULL,
    "factfile"                      VARCHAR(max)     ENCODE LZO       NOT NULL,
    "job_name"                      VARCHAR(4096)    ENCODE LZO       NOT NULL,
    "job_reference"                 VARCHAR(4096)    ENCODE LZO       NOT NULL,
    "run_duration"                  VARCHAR(4096)    ENCODE LZO       NOT NULL,
    "run_reference"                 VARCHAR(4096)    ENCODE LZO       NOT NULL,
    "run_state"                     VARCHAR(9)       ENCODE LZO       NOT NULL,
    "start_time"                    TIMESTAMP        ENCODE LZO       NOT NULL,
    "tags"                          VARCHAR(4096)    ENCODE LZO       NOT NULL,
    "task_states"                   VARCHAR(max)     ENCODE LZO       NOT NULL,
    "job_transition.current_state"  VARCHAR(9)       ENCODE LZO,
    "job_transition.previous_state" VARCHAR(9)       ENCODE LZO,
    FOREIGN KEY (root_id) REFERENCES atomic.events(event_id)
)
DISTSTYLE KEY
DISTKEY (root_id)
SORTKEY (root_tstamp);

COMMENT ON TABLE atomic.com_snowplowanalytics_factotum_job_update_1 IS 'iglu:com.snowplowanalytics.factotum/job_update/jsonschema/1-0-0';
