-- Решение заданий по ClickHouse

-- 1. Создание таблицы
-- TODO: скопируйте и доработайте CREATE TABLE из schema.sql
CREATE TABLE IF NOT EXISTS server_logs
(
    `timestamp` DateTime,
    `user_id` UInt64,
    `endpoint` String,
    `response_time_ms` Int32,
    `status_code` Int16,
) ENGINE = MergeTree()
ORDER BY (`timestamp`, `endpoint`);


-- 2. Загрузка данных из CSV
-- Подсказка: можно использовать clickhouse-client с параметром --query
-- Пример команды (выполняется в терминале):
-- cat server_logs.csv | clickhouse-client --query="INSERT INTO server_logs FORMAT CSVWithNames"


-- 3. Запрос: Топ-5 самых медленных endpoint'ов (по среднему времени ответа)
-- TODO: напишите SELECT запрос
SELECT endpoint, avg(response_time_ms) as avg_response_time_ms
FROM server_logs
GROUP BY endpoint
ORDER BY avg(response_time_ms) DESC
LIMIT 5;


-- 4. Запрос: Количество запросов по часам за весь период в логах
-- TODO: напишите SELECT запрос с использованием функции toHour() или formatDateTime()
SELECT formatDateTime(`timestamp`, '%Y-%m-%d %H') as hour, count() as total_count
FROM server_logs
GROUP BY hour;


-- 5. Запрос: Процент ошибок (status_code >= 400) для каждого endpoint'а
-- TODO: напишите SELECT запрос с вычислением процента ошибок
SELECT endpoint, countIf(status_code >= 400) as total_errors,
       count() as total_count,
       round(total_errors / total_count * 100, 2) as error_percentage
FROM server_logs
GROUP BY endpoint;