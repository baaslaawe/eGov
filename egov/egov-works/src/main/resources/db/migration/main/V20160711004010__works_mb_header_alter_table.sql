------------------START------------------
ALTER TABLE EGW_MB_HEADER ADD COLUMN CANCELLATIONREASON varchar(50);
ALTER TABLE EGW_MB_HEADER ADD COLUMN CANCELLATIONREMARKS varchar(126);
-------------------END-------------------
--rollback ALTER TABLE EGW_MB_HEADER DROP COLUMN CANCELLATIONREMARKS;
--rollback ALTER TABLE EGW_MB_HEADER DROP COLUMN CANCELLATIONREASON; 