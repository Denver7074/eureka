-- region BETWEEN STOP
-- region feature/DEV-5167
alter table shared.customer_account_tokens
    drop column guid;

alter table shared.customer_account_tokens
    drop column destination;

alter table shared.customer_account_tokens
    drop column check_sum;

alter table shared.customer_account_tokens
    add constraint i_customer_account_tokens_crypto_hash unique (crypto_hash);

drop index billing.i_transactions_card_guid;

alter table billing.transactions
    drop column card_guid;

alter table billing.transactions
    add column account_token text;

CREATE INDEX i_transactions_account_token_notnull
    ON billing.transactions (account_token)
    WHERE billing.transactions.account_token IS NOT NULL;


drop index payouts.i_payout_transactions_card_guid;


alter table payouts.payout_transactions
    drop column card_guid;

alter table payouts.payout_transactions
    add column account_token text;

CREATE INDEX i_payout_transactions_account_token_notnull
    ON payouts.payout_transactions (account_token)
    WHERE payouts.payout_transactions.account_token IS NOT NULL;

drop index payouts.i_partner_payout_destinations_card_guid;

alter table payouts.partner_payout_destinations
    drop column card_guid;

alter table payouts.partner_payout_destinations
    add column account_token text;

CREATE INDEX i_partner_payout_destinations_account_token_notnull
    ON payouts.partner_payout_destinations (account_token)
    WHERE payouts.partner_payout_destinations.account_token IS NOT NULL;

drop index shared.i_customer_blacklist_card_guid;


alter table shared.customer_blacklist
    drop column card_guid;

alter table shared.customer_blacklist
    add column account_token text;

CREATE INDEX i_customer_blacklist_account_token_notnull
    ON shared.customer_blacklist (account_token)
    WHERE shared.customer_blacklist.account_token IS NOT NULL;

drop index billing.i_card_whitelist_service_guid;


alter table billing.card_whitelist
    drop column card_guid;

alter table billing.card_whitelist
    add column account_token text;

CREATE INDEX i_card_whitelist_service_account_token_not_null
    ON billing.card_whitelist (service_id, account_token)
    WHERE billing.card_whitelist.account_token IS NOT NULL;

drop index billing.i_card_fraud_entries_card_guid;

alter table billing.card_fraud_entries
    drop column card_guid;

alter table billing.card_fraud_entries
    add column account_token text;

CREATE INDEX i_card_fraud_entries_account_token_notnull
    ON billing.card_fraud_entries (account_token)
    WHERE billing.card_fraud_entries.account_token IS NOT NULL;

alter table billing.recurrent_tokens
    drop column card_guid;

alter table billing.recurrent_tokens
    add column account_token text;


alter table payouts.partner_payout_destinations
    add column encrypted_destination text;

alter table payouts.payout_transactions
    add column encrypted_destination text;

alter table shared.customer_blacklist
    add column encrypted_customer_account text;

CREATE INDEX i_customer_blacklist_encrypted_notnull
    ON shared.customer_blacklist (encrypted_customer_account)
    WHERE encrypted_customer_account IS NOT NULL;

-- endregion
-- endregion