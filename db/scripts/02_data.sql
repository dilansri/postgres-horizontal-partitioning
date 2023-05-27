-- randomly inserting ~ 1 million of rows to transaction table
INSERT INTO transactions(amount_in_cents, created_at)
SELECT 
 floor(random() * 50000 + 1)::int AS amount_in_cents,
 generate_series(now() - interval '2 years', now(), '1 minutes') AS created_at;