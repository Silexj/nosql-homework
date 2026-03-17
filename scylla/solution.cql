-- Запрос, который бы доставал посты заданного пользователя, упорядоченные по времени создания поста (сначала новые).
-- Должен возвращать: post_id, content, дату создания поста.
CREATE TABLE user_posts (
    user_id bigint,
    created_at timestamp,
    post_id bigint,
    content text,
    username TEXT STATIC,
    email TEXT STATIC,
    PRIMARY KEY (user_id, created_at, post_id)
) WITH CLUSTERING ORDER BY (created_at DESC);

SELECT user_posts.post_id, user_posts.content, user_posts.created_at
FROM user_posts
WHERE user_id = ?;

-- Запрос, который бы доставал последний пост заданного пользователя.
-- Должен возвращать: post_id, content, дату создания поста, username.
SELECT user_posts.post_id, user_posts.content, user_posts.created_at, user_posts.username
FROM user_posts
WHERE user_id = ?
LIMIT 1;

-- Запрос, который бы доставал посты заданного пользователя после заданной даты.
-- Должен возвращать: post_id, content, дату создания поста.
SELECT user_posts.post_id, user_posts.content, user_posts.created_at
FROM user_posts
WHERE user_id = ?
    AND created_at > ?;

-- Запрос, который бы доставал пользователей, сделавших пост в заданный день по заданной теме,
-- упорядоченные по времени (сначала новые). Должен возвращать: user_id, username, post_id, время создания поста.
CREATE TABLE topic_users (
    topic_id bigint,
    day date,
    created_at timestamp,
    post_id bigint,
    user_id bigint,
    username text,
    PRIMARY KEY ((topic_id, day), created_at, post_id)
) WITH CLUSTERING ORDER BY (created_at DESC);

SELECT user_id, username, post_id, created_at
FROM topic_users
WHERE day = ?
    AND topic_id = ?;