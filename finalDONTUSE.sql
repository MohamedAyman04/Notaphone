CREATE DATABASE Telecom_Team_10

GO

USE Telecom_Team_10;

GO

CREATE FUNCTION calculate_remaining_balance (
    @plan INT,
    @paymentID INT
)
RETURNS DECIMAL(10, 1)
AS
BEGIN

DECLARE @price DECIMAL(10, 1)
DECLARE @amount DECIMAL(10, 1)
DECLARE @result DECIMAL(10, 1)

SELECT @price = CAST(SP.price AS DECIMAL(10,1))
    FROM Service_Plan SP
    WHERE SP.planID = @plan

SELECT TOP 1 @amount = P.amount
    FROM Payment P
    WHERE P.paymentID = @paymentID

SET @result = CASE 
WHEN @price > @amount 
    THEN @price - @amount 
    ELSE 0 
END

RETURN @result

END

GO

CREATE FUNCTION calculate_amount (
    @plan INT,
    @paymentID INT
)
RETURNS DECIMAL(10, 1)
AS
BEGIN
DECLARE @price DECIMAL(10, 1)
DECLARE @amount DECIMAL(10, 1)
DECLARE @result DECIMAL(10, 1)

SELECT @price = CAST(SP.price AS DECIMAL(10,1))
    FROM Service_Plan SP
    WHERE SP.planID = @plan

SELECT TOP 1 @amount = P.amount
    FROM Payment P
    WHERE P.paymentID = @paymentID

SET @result = CASE
WHEN @price < @amount 
    THEN @amount - @price 
    ELSE 0 
END

RETURN @result
END

GO

CREATE PROCEDURE createAllTables
AS

    CREATE TABLE Customer_profile (
        nationalID INT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(50),
        address VARCHAR(50),
        date_of_birth DATE
    );

    CREATE TABLE Customer_Account (
        mobileNo CHAR(11) PRIMARY KEY,
        pass VARCHAR(50),
        balance DECIMAL(10, 1),
        account_type VARCHAR(50) CHECK (account_type IN ('Post Paid', 'Prepaid', 'Pay_as_you_go')),
        start_date DATE,
        status VARCHAR(50) CHECK (status IN ('active', 'onhold')),
        point INT DEFAULT 0,
        nationalID INT,
        CONSTRAINT FK_Customer_Account_nationalID FOREIGN KEY (nationalID) REFERENCES Customer_profile(nationalID)
    );

    CREATE TABLE Service_Plan (
        planID INT PRIMARY KEY IDENTITY(1, 1),
        SMS_offered INT,
        minutes_offered INT,
        data_offered INT,
        name VARCHAR(50),
        price INT,
        description VARCHAR(50)
    );

    CREATE TABLE Subscription (
        mobileNo CHAR(11),
        planID INT,
        subscription_date DATE,
        status VARCHAR(50) CHECK (status in ('active', 'onhold')),
        PRIMARY KEY (mobileNo, planID),
        CONSTRAINT FK_Subscription_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
        CONSTRAINT FK_Subscription_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
    );

    CREATE TABLE Plan_Usage (
        usageID INT PRIMARY KEY IDENTITY(1, 1),
        start_date DATE,
        end_date DATE,
        data_consumption INT,
        minutes_used INT,
        SMS_sent INT,
        mobileNo CHAR(11),
        planID INT,
        CONSTRAINT FK_Plan_Usage_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
        CONSTRAINT FK_Plan_Usage_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
    );

    CREATE TABLE Payment (
        paymentID INT PRIMARY KEY IDENTITY(1, 1),
        amount DECIMAL(10, 1),
        date_of_payment DATE,
        payment_method VARCHAR(50) CHECK (payment_method in ('cash', 'credit')),
        status VARCHAR(50) CHECK (status in ('successful', 'pending', 'rejected')),
        mobileNo CHAR(11),
        CONSTRAINT FK_Payment_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
    );

    CREATE TABLE Process_Payment (
        paymentID INT PRIMARY KEY,
        planID INT,
        remaining_balance AS dbo.calculate_remaining_balance(planID, paymentID),
        extra_amount AS dbo.calculate_amount(planID, paymentID),
        CONSTRAINT FK_Process_Payment_paymentID FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
        CONSTRAINT FK_Process_Payment_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
    );

    CREATE TABLE Wallet (
        walletID INT PRIMARY KEY IDENTITY(1, 1),
        current_balance DECIMAL(10, 1),
        currency VARCHAR(50),
        last_modified_date DATE,
        nationalID INT,
        mobileNo CHAR(11),
        CONSTRAINT FK_Wallet_nationalID FOREIGN KEY (nationalID) REFERENCES Customer_profile(nationalID)
    );

    CREATE TABLE Transfer_money (
        walletID1 INT,
        walletID2 INT,
        transfer_id INT IDENTITY(1,1),
        amount DECIMAL(10, 1),
        transfer_date DATE,
        PRIMARY KEY (walletID1, walletID2, transfer_id),
        CONSTRAINT FK_Transfer_money_walletID1 FOREIGN KEY (walletID1) REFERENCES Wallet(walletID),
        CONSTRAINT FK_Transfer_money_walletID2 FOREIGN KEY (walletID2) REFERENCES Wallet(walletID)
    );


    CREATE TABLE Benefits (
        benefitID INT PRIMARY KEY IDENTITY(1, 1),
        description VARCHAR(50),
        validity_date DATE,
        status VARCHAR(50) CHECK (status in ('active', 'expired')),
        mobileNo CHAR(11),
        CONSTRAINT FK_Benefits_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
    );

    CREATE TABLE Points_Group (
        pointID INT IDENTITY (1,1),
        benefitID INT,
        pointsAmount DECIMAL(10, 1),
        PaymentID INT,
        PRIMARY KEY (pointID, benefitID),
        CONSTRAINT FK_Points_Group_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
        CONSTRAINT FK_Points_Group_paymentID FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
    )

    CREATE TABLE Exclusive_Offer (
        offerID INT IDENTITY (1,1),
        benefitID INT,
        internet_offered INT,
        SMS_offered INT,
        minutes_offered INT,
        PRIMARY KEY (offerID, benefitID),
        CONSTRAINT FK_Exclusive_Offer_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
    )

    CREATE TABLE Cashback (
        CashbackID INT IDENTITY (1,1),
        benefitID INT,
        walletID INT,
        amount DECIMAL(10, 1),
        credit_date DATE,
        PRIMARY KEY (CashbackID, benefitID),
        CONSTRAINT FK_Cashback_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
        CONSTRAINT FK_Cashback_walletID FOREIGN KEY (walletID) REFERENCES Wallet(walletID)
    )

    CREATE TABLE Plan_Provides_Benefits (
        benefitID INT,
        planID INT,
        PRIMARY KEY (benefitID, planID),
        CONSTRAINT FK_Plan_Provides_Benefits_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
        CONSTRAINT FK_Plan_Provides_Benefits_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
    )

    CREATE TABLE Shop (
        shopID INT IDENTITY (1,1),
        name VARCHAR(50),
        category VARCHAR(50),
        PRIMARY KEY (shopID)
    )

    CREATE TABLE Physical_Shop (
        shopID INT,
        address VARCHAR(50),
        working_hours VARCHAR(50),
        PRIMARY KEY (shopID),
        CONSTRAINT FK_Physical_Shop_shopID FOREIGN KEY (shopID) REFERENCES Shop(shopID)
    )

    CREATE TABLE E_shop (
        shopID INT,
        URL VARCHAR(50),
        rating INT,
        PRIMARY KEY (shopID),
        CONSTRAINT FK_E_shop_shopID FOREIGN KEY (shopID) REFERENCES Shop(shopID)
    )

    CREATE TABLE Voucher (
        voucherID INT IDENTITY (1,1),
        value INT,
        expiry_date DATE,
        points INT,
        mobileNo CHAR(11),
        shopID INT,
        redeem_date DATE,
        PRIMARY KEY (voucherID),
        CONSTRAINT FK_Voucher_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
        CONSTRAINT FK_Voucher_shopID FOREIGN KEY (shopID) REFERENCES Shop(shopID)
    )

    CREATE TABLE Technical_Support_Ticket (
        ticketID INT IDENTITY (1,1),
        mobileNo CHAR(11),
        Issue_description VARCHAR(50),
        priority_level INT,
        status VARCHAR(50) CHECK (status in ('Open', 'In Progress', 'Resolved')),
        PRIMARY KEY (ticketID, mobileNo),
        CONSTRAINT FK_Technical_Support_Ticket_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
    )

GO

EXECUTE createAllTables

go

CREATE PROCEDURE dropAllTables
AS
-- Drop tables with foreign keys referencing other tables first
DROP TABLE Points_Group;
DROP TABLE Exclusive_Offer;
DROP TABLE Cashback;
DROP TABLE Plan_Provides_Benefits;
DROP TABLE Physical_Shop;
DROP TABLE E_shop;
DROP TABLE Voucher;
DROP TABLE Technical_Support_Ticket;
DROP TABLE Transfer_money;
DROP TABLE Subscription;
DROP TABLE Plan_Usage;
DROP TABLE Process_Payment;
DROP TABLE Payment;
DROP TABLE Benefits;
DROP TABLE Wallet;
DROP TABLE Customer_Account;
DROP TABLE Service_Plan;
DROP TABLE Shop;
DROP TABLE Customer_profile;

GO

CREATE PROC dropAllProceduresFunctionsViews
AS
DROP PROCEDURE createAllTables
DROP PROCEDURE dropAllTables
DROP PROCEDURE clearAllTables
DROP PROCEDURE Account_Plan
DROP PROCEDURE Benefits_Account
DROP PROCEDURE Account_Payment_Points
DROP PROCEDURE Total_Points_Account
DROP PROCEDURE Unsubscribed_Plans
DROP PROCEDURE Ticket_Account_Customer
DROP PROCEDURE Account_Highest_Voucher
DROP PROCEDURE Top_Successful_Payments
DROP PROCEDURE Initiate_plan_payment
DROP PROCEDURE Payment_wallet_cashback
DROP PROCEDURE Initiate_balance_payment
DROP PROCEDURE Redeem_voucher_points
DROP VIEW allCustomerAccounts
DROP VIEW allServicePlans
DROP VIEW allBenefits
DROP VIEW AccountPayments
DROP VIEW allShops
DROP VIEW allResolvedTickets
DROP VIEW CustomerWallet
DROP VIEW E_shopVouchers
DROP VIEW PhysicalStoreVouchers
DROP VIEW Num_of_cashback
DROP FUNCTION Account_Plan_date
DROP FUNCTION Account_Usage_Plan
DROP FUNCTION Account_SMS_Offers
DROP FUNCTION Wallet_Cashback_Amount
DROP FUNCTION Wallet_Transfer_Amount
DROP FUNCTION Wallet_MobileNo
DROP FUNCTION AccountLoginValidation
DROP FUNCTION Consumption
DROP FUNCTION Usage_Plan_CurrentMonth
DROP FUNCTION Cashback_Wallet_Customer
DROP FUNCTION Remaining_plan_amount
DROP FUNCTION Extra_plan_amount
DROP FUNCTION Subscribed_plans_5_Months

GO

CREATE PROC clearAllTables
AS
-- Drop foreign key constraints
ALTER TABLE Customer_Account
DROP CONSTRAINT FK_Customer_Account_nationalID;

ALTER TABLE Subscription
DROP CONSTRAINT FK_Subscription_mobileNo;
ALTER TABLE Subscription
DROP CONSTRAINT FK_Subscription_planID;

ALTER TABLE Plan_Usage
DROP CONSTRAINT FK_Plan_Usage_mobileNo;
ALTER TABLE Plan_Usage
DROP CONSTRAINT FK_Plan_Usage_planID;

ALTER TABLE Payment
DROP CONSTRAINT FK_Payment_mobileNo;

ALTER TABLE Process_Payment
DROP CONSTRAINT FK_Process_Payment_paymentID;
ALTER TABLE Process_Payment
DROP CONSTRAINT FK_Process_Payment_planID;

ALTER TABLE Wallet
DROP CONSTRAINT FK_Wallet_nationalID;

ALTER TABLE Transfer_money
DROP CONSTRAINT FK_Transfer_money_walletID1;
ALTER TABLE Transfer_money
DROP CONSTRAINT FK_Transfer_money_walletID2;

ALTER TABLE Benefits
DROP CONSTRAINT FK_Benefits_mobileNo;

ALTER TABLE Points_Group
DROP CONSTRAINT FK_Points_Group_benefitID;
ALTER TABLE Points_Group
DROP CONSTRAINT FK_Points_Group_paymentID;

ALTER TABLE Exclusive_Offer
DROP CONSTRAINT FK_Exclusive_Offer_benefitID;

ALTER TABLE Cashback
DROP CONSTRAINT FK_Cashback_benefitID;
ALTER TABLE Cashback
DROP CONSTRAINT FK_Cashback_walletID;

ALTER TABLE Plan_Provides_Benefits
DROP CONSTRAINT FK_Plan_Provides_Benefits_benefitID;
ALTER TABLE Plan_Provides_Benefits
DROP CONSTRAINT FK_Plan_Provides_Benefits_planID;

ALTER TABLE Physical_Shop
DROP CONSTRAINT FK_Physical_Shop_shopID;

ALTER TABLE E_shop
DROP CONSTRAINT FK_E_shop_shopID;

ALTER TABLE Voucher
DROP CONSTRAINT FK_Voucher_mobileNo;
ALTER TABLE Voucher
DROP CONSTRAINT FK_Voucher_shopID;

ALTER TABLE Technical_Support_Ticket
DROP CONSTRAINT FK_Technical_Support_Ticket_mobileNo;

-- Truncate tables
TRUNCATE TABLE Customer_profile;
TRUNCATE TABLE Customer_Account;
TRUNCATE TABLE Service_Plan;
TRUNCATE TABLE Subscription;
TRUNCATE TABLE Plan_Usage;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Process_Payment;
TRUNCATE TABLE Wallet;
TRUNCATE TABLE Transfer_money;
TRUNCATE TABLE Benefits;
TRUNCATE TABLE Points_Group;
TRUNCATE TABLE Exclusive_Offer;
TRUNCATE TABLE Cashback;
TRUNCATE TABLE Plan_Provides_Benefits;
TRUNCATE TABLE Shop;
TRUNCATE TABLE Physical_Shop;
TRUNCATE TABLE E_shop;
TRUNCATE TABLE Voucher;
TRUNCATE TABLE Technical_Support_Ticket;

-- Re-add foreign key constraints
ALTER TABLE Customer_Account
ADD CONSTRAINT FK_Customer_Account_nationalID FOREIGN KEY (nationalID) REFERENCES Customer_profile(nationalID);

ALTER TABLE Subscription
ADD CONSTRAINT FK_Subscription_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo);
ALTER TABLE Subscription
ADD CONSTRAINT FK_Subscription_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID);

ALTER TABLE Plan_Usage
ADD CONSTRAINT FK_Plan_Usage_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo);
ALTER TABLE Plan_Usage
ADD CONSTRAINT FK_Plan_Usage_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID);

ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo);

ALTER TABLE Process_Payment
ADD CONSTRAINT FK_Process_Payment_paymentID FOREIGN KEY (paymentID) REFERENCES Payment(paymentID);
ALTER TABLE Process_Payment
ADD CONSTRAINT FK_Process_Payment_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID);

ALTER TABLE Wallet
ADD CONSTRAINT FK_Wallet_nationalID FOREIGN KEY (nationalID) REFERENCES Customer_profile(nationalID);

ALTER TABLE Transfer_money
ADD CONSTRAINT FK_Transfer_money_walletID1 FOREIGN KEY (walletID1) REFERENCES Wallet(walletID);
ALTER TABLE Transfer_money
ADD CONSTRAINT FK_Transfer_money_walletID2 FOREIGN KEY (walletID2) REFERENCES Wallet(walletID);

ALTER TABLE Benefits
ADD CONSTRAINT FK_Benefits_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo);

ALTER TABLE Points_Group
ADD CONSTRAINT FK_Points_Group_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID);
ALTER TABLE Points_Group
ADD CONSTRAINT FK_Points_Group_paymentID FOREIGN KEY (paymentID) REFERENCES Payment(paymentID);

ALTER TABLE Exclusive_Offer
ADD CONSTRAINT FK_Exclusive_Offer_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID);

ALTER TABLE Cashback
ADD CONSTRAINT FK_Cashback_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID);
ALTER TABLE Cashback
ADD CONSTRAINT FK_Cashback_walletID FOREIGN KEY (walletID) REFERENCES Wallet(walletID);

ALTER TABLE Plan_Provides_Benefits
ADD CONSTRAINT FK_Plan_Provides_Benefits_benefitID FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID);
ALTER TABLE Plan_Provides_Benefits
ADD CONSTRAINT FK_Plan_Provides_Benefits_planID FOREIGN KEY (planID) REFERENCES Service_Plan(planID);

ALTER TABLE Physical_Shop
ADD CONSTRAINT FK_Physical_Shop_shopID FOREIGN KEY (shopID) REFERENCES Shop(shopID);

ALTER TABLE E_shop
ADD CONSTRAINT FK_E_shop_shopID FOREIGN KEY (shopID) REFERENCES Shop(shopID);

ALTER TABLE Voucher
ADD CONSTRAINT FK_Voucher_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo);
ALTER TABLE Voucher
ADD CONSTRAINT FK_Voucher_shopID FOREIGN KEY (shopID) REFERENCES Shop(shopID);

ALTER TABLE Technical_Support_Ticket
ADD CONSTRAINT FK_Technical_Support_Ticket_mobileNo FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo);

GO

CREATE VIEW allCustomerAccounts AS
SELECT cp.*,ca.mobileNo, ca.pass, ca.balance, ca.account_type, ca.start_date,
        ca.status, ca.point 
FROM Customer_profile cp
INNER JOIN Customer_Account ca ON cp.nationalID = ca.nationalID
WHERE ca.status = 'active';

GO

CREATE VIEW allServicePlans AS
SELECT *
FROM Service_Plan;


GO

CREATE VIEW allBenefits AS
SELECT *
FROM Benefits
WHERE status = 'active';

GO

CREATE VIEW AccountPayments AS
SELECT 
    c.mobileNo,
    c.pass,
    c.balance,
    c.account_type,
    c.start_date,
    c.status AS account_status,  -- Alias for Customer_Account status
    c.point,
    c.nationalID,
    p.paymentID,
    p.amount,
    p.date_of_payment,
    p.payment_method,
    p.status AS payment_status  -- Alias for Payment status
FROM 
    Customer_Account c
INNER JOIN 
    Payment p ON c.mobileNo = p.mobileNo;

GO

CREATE VIEW allShops AS
SELECT * 
FROM Shop

GO

CREATE VIEW allResolvedTickets AS
SELECT *
FROM Technical_Support_Ticket
WHERE status = 'Resolved'

GO

CREATE VIEW CustomerWallet AS
SELECT w.*, c.first_name, c.last_name
FROM Wallet w
INNER JOIN Customer_profile c ON w.nationalID = c.nationalID

GO

CREATE VIEW E_shopVouchers AS
SELECT e.*, v.voucherID, v.value
FROM E_shop e
INNER JOIN Voucher v ON e.shopID = v.shopID
WHERE v.redeem_date IS NOT NULL

GO

CREATE VIEW PhysicalStoreVouchers AS
SELECT ps.*, v.voucherID, v.value
FROM Physical_Shop ps INNER JOIN Voucher v ON v.shopID = ps.shopID
WHERE v.redeem_date IS NOT NULL

GO

CREATE VIEW Num_of_cashback AS
SELECT walletID, count(CashbackID) AS number_Of_Cashback_Transactions
FROM Cashback
WHERE walletID IS NOT NULL
GROUP BY walletID;

GO

CREATE ROLE admin;

GO

CREATE PROCEDURE Account_Plan
AS
SELECT C.*, SP.*
FROM Subscription S
JOIN Customer_Account C ON (S.mobileNo = C.mobileNo)
JOIN Service_Plan SP ON (S.planID = SP.planID)

GO

GRANT EXECUTE ON Account_Plan TO admin

GO

CREATE FUNCTION Account_Plan_Date (@Subscription_Date DATE, @Plan_id INT)

RETURNS TABLE

AS
RETURN (
    SELECT C.mobileNo, SP.planID, SP.name
    FROM Subscription S
    JOIN Customer_Account C
    ON (S.subscription_date = @Subscription_Date
        AND S.mobileNo = C.mobileNo)
    JOIN Service_Plan SP ON (S.planID = @Plan_id AND S.planID = SP.planID)
)

GO

GRANT SELECT ON Account_Plan_Date TO admin

GO

CREATE FUNCTION Account_Usage_Plan (@MobileNo CHAR(11), @from_date DATE)
RETURNS TABLE
AS
RETURN (
    SELECT S.planID, SUM(data_consumption) AS 'total data consumed', SUM(minutes_used) AS 'total minutes used', SUM(SMS_sent) AS 'total SMS'
    FROM Subscription S
    JOIN Plan_Usage P ON (S.mobileNo = P.mobileNo)
    JOIN Service_Plan SP ON (S.planID = SP.planID)
    WHERE P.start_date >= @from_date
    AND S.mobileNo = @MobileNo
    GROUP BY S.planID
)

GO

GRANT SELECT ON Account_Usage_Plan TO admin

GO

CREATE PROCEDURE Benefits_Account
    @MobileNo CHAR(11), 
    @plan_ID INT
AS
    -- Delete from tables referencing Benefits
    DELETE FROM Points_Group 
    WHERE benefitID IN (
        SELECT B.benefitID
        FROM Benefits B
        INNER JOIN Plan_Provides_Benefits PPB ON B.benefitID = PPB.benefitID
        WHERE B.mobileNo = @MobileNo AND PPB.planID = @plan_ID
    );

    DELETE FROM Exclusive_Offer 
    WHERE benefitID IN (
        SELECT B.benefitID
        FROM Benefits B
        INNER JOIN Plan_Provides_Benefits PPB ON B.benefitID = PPB.benefitID
        WHERE B.mobileNo = @MobileNo AND PPB.planID = @plan_ID
    );

    DELETE FROM Cashback 
    WHERE benefitID IN (
        SELECT B.benefitID
        FROM Benefits B
        INNER JOIN Plan_Provides_Benefits PPB ON B.benefitID = PPB.benefitID
        WHERE B.mobileNo = @MobileNo AND PPB.planID = @plan_ID
    );

    DECLARE @t TABLE(bid INT)

    INSERT INTO @t
    SELECT B.benefitID
    FROM Plan_Provides_Benefits PPB
    INNER JOIN Benefits B ON (PPB.benefitID = B.benefitID)
    WHERE PPB.planID = @plan_ID

    -- Delete from Plan_Provides_Benefits to remove the plan-benefit relationship
    DELETE FROM Plan_Provides_Benefits
    WHERE benefitID IN (
        SELECT B.benefitID
        FROM Benefits B
        INNER JOIN Plan_Provides_Benefits PPB ON B.benefitID = PPB.benefitID
        WHERE B.mobileNo = @MobileNo AND PPB.planID = @plan_ID
    );

    -- Delete from Benefits
    DELETE FROM Benefits 
    WHERE benefitID IN (
        SELECT B.benefitID
        FROM Benefits B
        WHERE B.mobileNo = @MobileNo AND benefitID IN (SELECT * FROM @t)
    );

GO

GRANT EXECUTE ON Benefits_Account TO admin

GO

CREATE FUNCTION Account_SMS_Offers (@MobileNo CHAR(11))
RETURNS TABLE
AS
RETURN (
    SELECT 
        B.benefitID,
        B.description,
        B.validity_date,
        B.status,
        B.mobileNo,
        EO.offerID,
        EO.internet_offered,
        EO.SMS_offered,
        EO.minutes_offered
    FROM Exclusive_Offer EO
    JOIN Benefits B ON EO.benefitID = B.benefitID
    WHERE B.mobileNo = @MobileNo
        AND EO.SMS_offered > 0
)

GO

GRANT SELECT ON Account_SMS_Offers TO admin

GO

CREATE PROCEDURE Account_Payment_Points
@MobileNo CHAR(11),
@TotalNumberOftransactions INT OUTPUT, 
@TotalAmountOfPoints INT OUTPUT
AS
BEGIN
DECLARE @tp1 INT, @tp2 INT

SELECT @tp1 = COUNT(*)
FROM Payment
WHERE mobileNo = @MobileNo AND status = 'successful'
AND date_of_payment >= DATEADD(YEAR, -1, CURRENT_TIMESTAMP);

SELECT @tp2 = SUM(pg.pointsAmount)
FROM Payment p
INNER JOIN Points_Group pg ON p.PaymentID = pg.PaymentID
WHERE p.mobileNo = @MobileNo
    AND p.date_of_payment >= DATEADD(YEAR, -1, CURRENT_TIMESTAMP)
    AND p.status = 'successful';
END;

IF @tp1 IS NULL
SET @TotalNumberOftransactions = 0    
ELSE SET @TotalNumberOftransactions = @tp1
IF @tp2 IS NULL
SET @TotalAmountOfPoints = 0    
ELSE SET @TotalAmountOfPoints = @tp2

GO

CREATE FUNCTION Wallet_Cashback_Amount
(@WalletId INT, @planId INT)
RETURNS INT
AS
BEGIN
DECLARE @AmountOfCashback INT, @tp INT
SELECT @tp = SUM(cb.amount)
FROM Cashback cb
INNER JOIN Plan_Provides_Benefits ppb ON cb.benefitID = ppb.benefitID
WHERE @WalletId = cb.walletID AND @planId = ppb.planID

IF @tp IS NULL
SET @AmountOfCashback = 0
ELSE
SET @AmountOfCashback = @tp

RETURN @AmountOfCashback
END;

GO

GRANT EXECUTE ON Wallet_Cashback_Amount TO admin

GO

CREATE FUNCTION Wallet_Transfer_Amount
(@Wallet_id INT, @start_date DATE, @end_date DATE)
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @TransactionAmountAverage DECIMAL(10,2)
SELECT @TransactionAmountAverage = AVG(tm.amount)
FROM Wallet w
INNER JOIN Transfer_money tm ON W.walletID = tm.walletID1
WHERE @Wallet_id = tm.walletID1 AND tm.transfer_date BETWEEN @start_date AND @end_date
RETURN @TransactionAmountAverage
END;

GO

GRANT EXECUTE ON Wallet_Transfer_Amount TO admin

GO

CREATE FUNCTION Wallet_MobileNo
(@MobileNo char(11))
RETURNS BIT
AS
BEGIN
DECLARE @outBit BIT
IF(EXISTS(SELECT w.mobileNo
FROM Wallet w
WHERE @MobileNo = w.mobileNo))
SET @outBit = 1
ELSE
SET @outBit = 0
RETURN @outBit
END;

GO

GRANT EXECUTE  ON Wallet_MobileNo TO admin

GO

CREATE PROCEDURE Total_Points_Account
@MobileNo char(11),
@TotalPoints INT OUTPUT
AS
BEGIN
DECLARE @tp INT
SELECT @tp = SUM(pg.pointsAmount)
FROM Points_Group pg
INNER JOIN Payment p ON pg.PaymentID = p.PaymentID
INNER JOIN Benefits B ON pg.benefitID = B.benefitID
WHERE @MobileNo = P.mobileNo AND @MobileNo = B.mobileNo AND B.validity_date >= CURRENT_TIMESTAMP AND B.status = 'active'

IF @tp IS NULL
    SET @TotalPoints = 0
ELSE
    SET @TotalPoints = @tp

UPDATE Customer_Account
SET point = @TotalPoints
WHERE @MobileNo = mobileNo


END;

GO

GRANT EXECUTE ON Total_Points_Account TO admin

GO

CREATE ROLE customer

GO
CREATE FUNCTION AccountLoginValidation
(@MobileNo CHAR(11), @password VARCHAR(50))

RETURNS BIT
AS
BEGIN
DECLARE @result BIT;

IF EXISTS (SELECT * from Customer_Account C where C.mobileNo=@MobileNo AND C.pass=@password)
	Set @result= 1
ELSE
	Set @result= 0


RETURN @result
END

GO 

GRANT EXECUTE ON AccountLoginValidation TO customer

GO

CREATE FUNCTION Consumption
(@Plan_name VARCHAR(50) ,@start_date DATE ,@end_date DATE)

RETURNS TABLE

AS

RETURN (
    SELECT ISNULL(SUM(P.data_consumption), 0) AS 'Data consumption',
        ISNULL(SUM(P.minutes_used), 0) AS 'Minutes used',
        ISNULL(SUM(P.SMS_sent), 0) AS 'SMS sent'
    FROM Plan_Usage P
    INNER JOIN Service_Plan S ON P.planID = S.planID
    WHERE S.name = @Plan_name
        AND P.start_date >= @start_date
        AND P.end_date <= @end_date
)

GO

GRANT SELECT ON Consumption TO customer

GO

CREATE PROC Unsubscribed_Plans
@MobileNo char(11)
AS
SELECT DISTINCT P.* from Service_Plan P
where P.planID NOT IN (
        select S.planID
        FROM Subscription S
        where S.planID = P.planID
            AND S.mobileNo=@MobileNo)

GO

GRANT EXECUTE ON Unsubscribed_Plans TO customer

GO

CREATE FUNCTION Usage_Plan_CurrentMonth
(@MobileNo char(11))

RETURNS TABLE

AS

RETURN (
    SELECT P.data_consumption AS 'Data consumption',
        P.minutes_used AS 'Minutes used',
        P.SMS_sent AS 'SMS sent'
    from Plan_Usage P
    INNER JOIN Subscription S ON P.mobileNo = S.mobileNo AND P.planID = S.planID
    WHERE P.mobileNo = @MobileNo
    AND MONTH(CURRENT_TIMESTAMP) = MONTH(P.start_date)
    AND YEAR(CURRENT_TIMESTAMP) = YEAR(P.start_date)
    AND S.status = 'active'
)

GO

GRANT SELECT ON Usage_Plan_CurrentMonth TO customer

GO

CREATE FUNCTION Cashback_Wallet_Customer
(@NationalID int)
RETURNS TABLE

AS

RETURN ( SELECT C.* from Cashback C INNER JOIN Wallet W on C.walletID = W.walletID where W.nationalID=@NationalID)

GO

GRANT SELECT ON Cashback_Wallet_Customer TO customer

GO

CREATE PROC Ticket_Account_Customer
@NationalID INT
AS
SELECT COUNT(*) AS 'Number of technical support tickets'
FROM (SELECT A.mobileNo
	  FROM Customer_Account A
	  WHERE A.nationalID = @NationalID
	  ) AS AM INNER JOIN Technical_Support_Ticket T ON AM.mobileNo = T.mobileNo
WHERE T.status <> 'Resolved'
GO

GRANT EXECUTE ON Ticket_Account_Customer TO customer

GO

CREATE PROC Account_Highest_Voucher
@MobileNo CHAR(11),
@Voucher_id INT OUTPUT
AS
SELECT TOP 1 @Voucher_id = ISNULL(V.voucherID, 0)
FROM Voucher V
WHERE V.mobileNo = @MobileNo
ORDER BY V.value DESC
GO

GRANT EXECUTE ON Account_Highest_Voucher TO customer

GO

CREATE FUNCTION Remaining_plan_amount
(@MobileNo CHAR(11), @plan_name VARCHAR(50))
RETURNS decimal(10,1)
AS 
BEGIN
DECLARE @result decimal(10,1) = 0

SELECT TOP 1 @result = PP.remaining_balance
FROM Payment P
INNER JOIN Process_Payment PP ON P.paymentID = PP.paymentID
INNER JOIN Service_Plan SP ON PP.planID = SP.planID
WHERE P.mobileNo = @MobileNo AND SP.name = @plan_name
ORDER BY P.date_of_payment DESC

RETURN @result
END

GO

GRANT EXECUTE ON Remaining_plan_amount TO customer

GO

CREATE FUNCTION Extra_plan_amount
(@MobileNo char(11), @plan_name varchar(50))
RETURNS decimal(10,1)
AS 
BEGIN
DECLARE @result decimal(10,1) = 0

SELECT TOP 1 @result = PP.extra_amount
FROM Payment P INNER JOIN Process_Payment PP ON P.paymentID = PP.paymentID
INNER JOIN Service_Plan SP ON PP.planID = SP.planID
WHERE P.mobileNo = @MobileNo AND SP.name = @plan_name
ORDER BY P.date_of_payment DESC

RETURN @result
END

GO

GRANT EXECUTE ON Extra_plan_amount TO customer

GO

CREATE PROC Top_Successful_Payments
@MobileNo char(11)
AS
SELECT TOP 10 *
FROM Payment P
WHERE P.mobileNo = @MobileNo AND P.status = 'successful'
ORDER BY P.amount DESC
GO

GRANT EXECUTE ON Top_Successful_Payments TO customer

GO

CREATE FUNCTION Subscribed_plans_5_Months (
    @MobileNo CHAR(11)
)
RETURNS TABLE
AS
RETURN
(
    SELECT sp.*
    FROM Service_Plan sp INNER JOIN Subscription s ON sp.planID = s.planID
    INNER JOIN Customer_Account c ON s.mobileNo = c.mobileNo
    WHERE c.mobileNo = @MobileNo AND s.subscription_date >= DATEADD(MONTH, -5, GETDATE())
)

GO

GRANT SELECT ON Subscribed_plans_5_Months TO customer

GO

CREATE PROCEDURE Initiate_plan_payment
    @MobileNo CHAR(11),
    @amount DECIMAL(10, 1),
    @payment_method VARCHAR(50),
    @plan_id INT
AS
    DECLARE @success BIT, @payID INT, @Rem DECIMAL(10,1)
    
    -- Insert the payment record
    INSERT INTO Payment (amount, date_of_payment, payment_method, status, mobileNo)
    VALUES (@amount, CURRENT_TIMESTAMP, @payment_method, 'successful', @MobileNo);

    SELECT TOP 1 @payID = paymentID
    FROM Payment
    WHERE mobileNo = @MobileNo
    ORDER BY paymentID DESC

    INSERT INTO Process_Payment
    VALUES (@payID, @plan_id)

    SELECT @Rem = remaining_balance
    FROM Process_Payment
    WHERE paymentID = @payID

    IF @Rem = 0
        BEGIN
            -- Updating subscription status to 'active'
            UPDATE Subscription
            SET status = 'active'
            WHERE mobileNo = @MobileNo AND planID = @plan_id;
        END
    ELSE
        BEGIN
            -- Updating subscription status to 'active'
            UPDATE Subscription
            SET status = 'onhold'
            WHERE mobileNo = @MobileNo AND planID = @plan_id;
        END

GO

GRANT EXECUTE ON Initiate_plan_payment TO customer


GO

CREATE PROCEDURE Payment_wallet_cashback
    @MobileNo CHAR(11),
    @payment_id INT,
    @benefit_id INT
AS
    DECLARE @walletID INT;
    DECLARE @cashbackAmount DECIMAL(10, 2);

    -- Retrieve the walletID associated with the given mobile number
    SELECT @walletID = walletID
    FROM Wallet
    WHERE nationalID IN (
        SELECT nationalID 
        FROM Customer_Account
        WHERE mobileNo = @MobileNo
    );

    -- Calculate 10% of the payment amount
    SET @cashbackAmount = (SELECT amount * 0.1 FROM Payment WHERE paymentID = @payment_id);

    -- Insert the cashback record with the calculated amount
    INSERT INTO Cashback (benefitID, walletID, amount, credit_date)
    VALUES (@benefit_id, @walletID, @cashbackAmount, CURRENT_TIMESTAMP);

    -- Update the wallet's balance with the cashback amount
    UPDATE Wallet
    SET current_balance = current_balance + @cashbackAmount
    WHERE walletID = @walletID;

GO

GRANT EXECUTE ON Payment_wallet_cashback TO customer

GO

CREATE PROCEDURE Initiate_balance_payment
    @MobileNo CHAR(11),
    @amount DECIMAL(10,1),
    @payment_method VARCHAR(50)
AS
    -- Insert the payment record
    INSERT INTO Payment (amount, date_of_payment, payment_method, status, mobileNo)
    VALUES (@amount, CURRENT_TIMESTAMP, @payment_method, 'successful', @MobileNo);

    -- Updating balance for account for balance recharge
    UPDATE Customer_Account
    SET balance = balance + @amount
    WHERE mobileNo = @MobileNo

GO

GRANT EXECUTE ON Initiate_balance_payment TO customer

GO

CREATE PROCEDURE Redeem_voucher_points
    @MobileNo CHAR(11),
    @voucher_id INT
AS
    -- Declare variables for points deduction and validation
    DECLARE @points_to_deduct INT;
    DECLARE @points INT;
    DECLARE @expiry_date DATE;
    DECLARE @redeem_date DATE;

    -- Check if the voucher exists for the mobile number and retrieve points, expiry date and redeem_date
    SELECT @points_to_deduct = points, @expiry_date = expiry_date, @redeem_date = redeem_date
    FROM Voucher
    WHERE voucherID = @voucher_id AND mobileNo = @MobileNo;

    SELECT @points = point
    FROM Customer_Account
    WHERE mobileNo = @MobileNo

    -- Verify if the voucher exists and is not expired and not redeemed
    IF @points_to_deduct <= @points AND @expiry_date >= CURRENT_TIMESTAMP AND @redeem_date IS NULL
    BEGIN
        -- Update the voucher's redeem date to mark it as redeemed
        UPDATE Voucher
        SET redeem_date = CURRENT_TIMESTAMP
        WHERE voucherID = @voucher_id AND mobileNo = @MobileNo;

        -- Deduct points from the customer's account
        UPDATE Customer_Account
        SET point = point - @points_to_deduct
        WHERE mobileNo = @MobileNo;
    END
GO

GRANT EXECUTE ON Redeem_voucher_points TO customer

GO
