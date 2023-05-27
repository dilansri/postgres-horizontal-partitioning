BEGIN;
-- rename the existing table, indexes and others
ALTER TABLE transactions RENAME TO transactions_legacy;
ALTER INDEX transactions_created_at_idx RENAME TO transactions_legacy_created_at_idx;
--rest of the alter statements...

-- a new partitioned table in town with all the indexes ...
-- same as the previous table
CREATE TABLE transactions(
  id uuid DEFAULT uuid_generate_v4 (),
  amount_in_cents INT NOT NULL,
  amount_currency TEXT NOT NULL DEFAULT 'EUR',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL
) PARTITION BY RANGE(created_at);

CREATE INDEX transactions_created_at_idx ON transactions(created_at);

-- partition for the upcoming data
CREATE TABLE transactions_2023_h2
PARTITION OF transactions
FOR VALUES FROM ('2023-07-01 00:00:00+00') TO ('2024-01-01 00:00:00+00');

-- attaching the legacy table as a partition
ALTER TABLE transactions ATTACH PARTITION transactions_legacy DEFAULT;

COMMIT;