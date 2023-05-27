BEGIN;

ALTER TABLE transactions DETACH PARTITION transactions_legacy;

DROP TABLE transactions_legacy;
 
COMMIT;