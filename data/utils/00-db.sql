CREATE SCHEMA youtube_stats;

CREATE TABLE youtube_stats.channel_info (
  channel_id SERIAL PRIMARY KEY, 
  channel_uri VARCHAR(50) UNIQUE NOT NULL,
  channel_name VARCHAR(128) UNIQUE NOT NULL,
  channel_description TEXT NOT NULL,
  channel_custom_uri VARCHAR(128) NOT NULL,
  channel_creation_date TIMESTAMPTZ NOT NULL,
  channel_topic_list JSONB NOT NULL
);

CREATE TABLE youtube_stats.channel_stats (
  channel_id INT NOT NULL, 
  "timestamp" TIMESTAMPTZ NOT NULL,
  view_count BIGINT NOT NULL,
  subscriber_count INT NOT NULL,
  video_count SMALLINT NOT NULL,
  CONSTRAINT channel_stats_pk PRIMARY KEY (channel_id, "timestamp"),
  FOREIGN KEY (channel_id) REFERENCES youtube_stats.channel_info (channel_id)
);

CREATE TABLE youtube_stats.video_info (
  channel_id INT NOT NULL,
  video_id SERIAL PRIMARY KEY, 
  video_uri VARCHAR(50) UNIQUE NOT NULL,
  video_title VARCHAR(128) NOT NULL,
  video_description TEXT NOT NULL,
  video_creation_date TIMESTAMPTZ NOT NULL,
  video_duration INT NOT NULL,
  video_category SMALLINT NOT NULL,
  video_tags JSONB NOT NULL,
FOREIGN KEY (channel_id) REFERENCES youtube_stats.channel_info (channel_id)
);

CREATE TABLE youtube_stats.video_stats (
  video_id INT NOT NULL, 
  "timestamp" TIMESTAMPTZ NOT NULL,
  view_count BIGINT NOT NULL,
  like_count INT NOT NULL,
  favorite_count INT NOT NULL,
  comment_count INT NOT NULL,
  CONSTRAINT video_stats_pk PRIMARY KEY (video_id, "timestamp"),
  FOREIGN KEY (video_id) REFERENCES youtube_stats.video_info (video_id)
);

CREATE TABLE youtube_stats.error_messages (
  error_id SERIAL PRIMARY KEY, 
  error_timestamp TIMESTAMPTZ NOT NULL, 
  error_process_group VARCHAR(128) NOT NULL,
  error_processor VARCHAR(128) NOT NULL,
  error_flowfile_content TEXT NOT NULL,
  error_metadata JSONB NOT NULL
);

CREATE TABLE youtube_stats.api_key_quota (
  api_key_id SERIAL PRIMARY KEY, 
  api_key VARCHAR(40) UNIQUE NOT NULL,
  api_key_quota INT NOT NULL,
  api_key_restart_date TIMESTAMPTZ NOT NULL
);

CREATE USER nifi WITH PASSWORD 'nifi';
GRANT USAGE ON SCHEMA youtube_stats TO nifi;
GRANT INSERT, UPDATE, SELECT ON youtube_stats.channel_info, youtube_stats.channel_stats, youtube_stats.video_info, youtube_stats.video_stats, youtube_stats.api_key_quota TO nifi;
GRANT INSERT, SELECT, DELETE ON youtube_stats.error_messages TO nifi;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA youtube_stats TO nifi;

CREATE USER grafana WITH PASSWORD 'grafana';
GRANT USAGE ON SCHEMA youtube_stats TO grafana;
GRANT SELECT ON youtube_stats.channel_info, youtube_stats.channel_stats, youtube_stats.video_info, youtube_stats.video_stats, youtube_stats.api_key_quota, youtube_stats.error_messages TO grafana;
