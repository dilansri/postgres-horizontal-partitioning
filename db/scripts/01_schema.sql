BEGIN;
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions(
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4 (),
  amount_in_cents INT NOT NULL,
  amount_currency TEXT NOT NULL DEFAULT 'EUR',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE INDEX IF NOT EXISTS transactions_created_at_idx ON transactions(created_at);

COMMIT;