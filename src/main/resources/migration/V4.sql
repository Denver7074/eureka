-- region BEFORE DEPLOY
-- region feature/DEV-5162
DELETE FROM billing.service_method_types
WHERE (name, payment_method_type) IN (('viet_e_wallet', 'WEB_REDIRECT'));
-- endregion

-- endregion
