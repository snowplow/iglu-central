-- AUTO-GENERATED BY igluctl DO NOT EDIT
-- Generator: igluctl 0.2.0
-- Generated: 2017-12-13 10:21

CREATE SCHEMA IF NOT EXISTS atomic;

CREATE TABLE IF NOT EXISTS atomic.com_olark_transcript_1 (
    "schema_vendor"                        VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "schema_name"                          VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "schema_format"                        VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "schema_version"                       VARCHAR(128)  ENCODE RUNLENGTH NOT NULL,
    "root_id"                              CHAR(36)      ENCODE RAW       NOT NULL,
    "root_tstamp"                          TIMESTAMP     ENCODE LZO       NOT NULL,
    "ref_root"                             VARCHAR(255)  ENCODE RUNLENGTH NOT NULL,
    "ref_tree"                             VARCHAR(1500) ENCODE RUNLENGTH NOT NULL,
    "ref_parent"                           VARCHAR(255)  ENCODE RUNLENGTH NOT NULL,
    "groups"                               VARCHAR(5000) ENCODE LZO,
    "id"                                   VARCHAR(128)  ENCODE LZO,
    "items"                                VARCHAR(5000) ENCODE LZO,
    "kind"                                 VARCHAR(64)   ENCODE LZO,
    "manually_submitted"                   BOOLEAN       ENCODE RUNLENGTH,
    "operators"                            VARCHAR(4096) ENCODE LZO,
    "tags"                                 VARCHAR(5000) ENCODE LZO,
    "visitor.browser"                      VARCHAR(128)  ENCODE LZO,
    "visitor.chat_feedback.comments"       VARCHAR(4096) ENCODE LZO,
    "visitor.chat_feedback.friendliness"   SMALLINT      ENCODE LZO,
    "visitor.chat_feedback.knowledge"      SMALLINT      ENCODE LZO,
    "visitor.chat_feedback.overall_chat"   SMALLINT      ENCODE LZO,
    "visitor.chat_feedback.responsiveness" SMALLINT      ENCODE LZO,
    "visitor.city"                         VARCHAR(128)  ENCODE LZO,
    "visitor.conversation_begin_page"      VARCHAR(8192) ENCODE LZO,
    "visitor.country"                      VARCHAR(128)  ENCODE LZO,
    "visitor.country_code"                 VARCHAR(8)    ENCODE LZO,
    "visitor.email_address"                VARCHAR(256)  ENCODE LZO,
    "visitor.full_name"                    VARCHAR(256)  ENCODE LZO,
    "visitor.id"                           VARCHAR(64)   ENCODE LZO,
    "visitor.ip"                           VARCHAR(15)   ENCODE LZO,
    "visitor.kind"                         VARCHAR(64)   ENCODE LZO,
    "visitor.operating_system"             VARCHAR(128)  ENCODE LZO,
    "visitor.organization"                 VARCHAR(128)  ENCODE LZO,
    "visitor.phone_number"                 VARCHAR(64)   ENCODE LZO,
    "visitor.region"                       VARCHAR(8)    ENCODE LZO,
    FOREIGN KEY (root_id) REFERENCES atomic.events(event_id)
)
DISTSTYLE KEY
DISTKEY (root_id)
SORTKEY (root_tstamp);

COMMENT ON TABLE atomic.com_olark_transcript_1 IS 'iglu:com.olark/transcript/jsonschema/1-0-0';
