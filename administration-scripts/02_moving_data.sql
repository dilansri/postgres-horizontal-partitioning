BEGIN;

ALTER TABLE transactions DETACH PARTITION transactions_legacy;

CREATE TABLE transactions_2023_h1
PARTITION OF transactions
FOR VALUES FROM ('2021-01-01 00:00:00+00') TO ('2022-01-01 00:00:00+00');


WITH rows AS(
  DELETE FROM transactions_legacy t
  WHERE (created_at >= '2021-01-01 00:00:00+00' AND created_at < '2022-01-01 00:00:00+00')
  RETURNING t.*)
INSERT INTO transactions SELECT * from rows;

ALTER TABLE transactions ATTACH PARTITION transactions_legacy DEFAULT;
 
COMMIT;