ALTER TABLE EG_ADVANCEREQUISITION ALTER COLUMN arftype SET NOT NULL;

--rollback ALTER TABLE EG_ADVANCEREQUISITION ALTER COLUMN arftype DROP NOT NULL;