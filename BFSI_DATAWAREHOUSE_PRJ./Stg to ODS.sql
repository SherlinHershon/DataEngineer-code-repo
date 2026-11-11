# ODS loads from staging with exact copy
# ODS Load from Staging with load_dt and load_ts

#IS QUERY (ETL), TRANSFORMATION - SCRUBBING, STANDARDIZATION, cleansing (filteration/de-duplication), Enrichment
INSERT INTO odsdb_hershon.ods_accounts
SELECT distinct #De-duplication/filtering
AccountID,
trim(AccountType), #scrubbing
Balance,CreditScore,
upper(Currency), #standardization
CustomerID,DateOpened,ManagerID,ODLimit,
CURRENT_DATE AS load_dt, #Enrichment
CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_accounts
where (AccountID is not null or AccountID<>''); #filtering
       
INSERT INTO odsdb_hershon.ods_transactions
SELECT t.*, 
       CURRENT_DATE AS load_dt, 
       CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_transactions t;

INSERT INTO odsdb_hershon.ods_payments
SELECT p.*, 
       CURRENT_DATE AS load_dt, 
       CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_payments p;

INSERT INTO odsdb_hershon.ods_creditcard
SELECT c.*, 
       CURRENT_DATE AS load_dt, 
       CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_creditcard c;

INSERT INTO odsdb_hershon.ods_loans
SELECT l.*, 
       CURRENT_DATE AS load_dt, 
       CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_loans l;

INSERT INTO odsdb_hershon.ods_cust_profile
SELECT Address,
    BranchID,
    CustomerID,
    DateOfBirth,
    Email,
    trim(FirstName),
    trim(LastName),
    substr(PhoneNumber,1,20), 
    CURRENT_DATE AS load_dt, 
    CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_cust_profile cp;

INSERT INTO odsdb_hershon.ods_branches
SELECT b.*, 
       CURRENT_DATE AS load_dt, 
       CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_branches b;

INSERT INTO odsdb_hershon.ods_employees
SELECT e.*, 
       CURRENT_DATE AS load_dt, 
       CURRENT_TIMESTAMP AS load_ts
FROM stgdb_hershon.stg_employees e;