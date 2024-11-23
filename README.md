# Notaphone

a database project

## Task division

- ### 2.1 Basic Structure of the Database

  - ~a) Write an SQL query to create database called “Telecom_Team_Your Team Number”~
  - ~b) Put the queries that create all the tables of your database with their definition inside this procedure.
    (Mohamed 1-10) needs some minor changes
    (Nour 11-19)~ TO BE REVISED
    - Type: stored procedure
    - Name: createAllTables
    - Input:Nothing
    - output:Nothing
  - c) Drop all tables that your database has inside this procedure. (Yehia)
    - Type: stored procedure
    - Name: dropAllTables
    - Input:Nothing
    - output:Nothing
  - ~d) Drop all implemented stored procedures (except this one), functions and views that you implemented in this milestone. (Abdelhamid)~ TO BE REVISED
    - ~Type: stored procedure~
    - ~Name: dropAllProceduresFunctionsViews~
    - ~Input:Nothing~
    - ~output:Nothing~
  - e) ~Clear all records in all tables existing in your database. (Ahmed)~ TO BE REVISED
    - Type: stored procedure
    - Name: clearAllTables
    - Input:Nothing
    - output:Nothing

- ### 2.2 Basic Data Retrieval
  - ~a) Fetch details for all customer profiles along with their active accounts.~ TO BE REVISED
    - Type: view
    - Name: allCustomerAccounts
    - Input:Nothing
    - Output: Table
  - ~b) Fetch details for all offered Service Plans.~ TO BE REVISED
    - Type: view
    - Name: allServicePlans
    - Input: Nothing
    - Output: Table
  - c) ~Fetch details for all active Benefits.~ TO BE REVISED
    - ~Type: view~
    - ~Name: allBenefits~
    - ~Input:Nothing~
    - ~Output: Table~
  - d) ~Fetch details for all payments along with their corresponding Accounts.~ TO BE REVISED
    - ~Type: view~
    - ~Name: AccountPayments~
    - ~Input: Nothing~
    - ~Output: Table~
  - e) ~Fetch details for all shops.~ TO BE REVISED
    - ~Type: view~
    - ~Name: allShops~
    - ~Input:Nothing~
    - ~Output: Table~
  - f) ~Fetch details for all resolved tickets.~ TO BE REVISED
    - ~Type: view~
    - ~Name: allResolvedTickets~
    - ~Input:Nothing~
    - ~Output: Table~
  - g) Fetch details of all wallets along with their customer names.
    - Type: view
    - Name: CustomerWallet
    - Input:Nothing
    - Output: Table
  - h) Fetch the list of all E-shops along with their redeemed vouchers’s ids and values.
    - Type: view
    - Name: E_shopVouchers
    - Input:Nothing
    - Output: Table
  - i) Fetch the list of all physical stores along with their redeemed vouchers’s ids and values.
    - Type: view
    - Name: PhysicalStoreVouchers
    - Input:Nothing
    - Output: Table
  - j) Fetch number of cashback transactions per each wallet.
    - Type: view
    - Name: Num_of_cashback
    - Input:Nothing
    - Output: Table

## Testing phase

The following procedures/functions reference the sql file testing_file.sql.

Whatever is referenced here and is successfully tested, will be reflected
in the final draft.

### Successfully tested 15/40

- Proc createAllTables
- Data insertions for all tables except ~Eshop~, Exclusive_Offer, ~Cashback~
- View allCustomerAccounts
- View allServicePlans
- View allBenefits
- View allShops
- View allResolvedTickets
- View CustomerWallet
- View E_shopVouchers
- View PhysicalStoreVouchers
- View Num_of_cashback
- Proc Account_Plan
- Proc Account_Usage_Plan
- Proc Account_Payment_Points
- Func Wallet_Transfer_Amount

### Tested but unsuccessful

- Proc dropAllTables (FK constraint doesn't allow to drop, either define
    CASCADE or drop constraints first)
- Proc clearAllTables (FK constraint doesn't allow, similar to dropAllTables)
- View AccountPayments (renaming conflicting column 'status', but unsure which
    names to choose)
- Proc Benefits_Account (FK constrain violation, potential fix is to delete
  in the following order: 1. PPB, 2. sub-entity, 3. benefits)
- Proc Account_SMS_Offers (conflicting column names)

### Added but not tested

- Proc dropAllProceduresFunctionsViews (Can't test untill all
    procedures/functions are added.
