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
    WHERE SP.name = @plan

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
    WHERE SP.name = @plan

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
        FOREIGN KEY (nationalID) REFERENCES Customer_profile(nationalID)
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
        FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
        FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
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
        FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
        FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
    );

    CREATE TABLE Payment (
        paymentID INT PRIMARY KEY IDENTITY(1, 1),
        amount DECIMAL(10, 1),
        date_of_payment DATE,
        payment_method VARCHAR(50) CHECK (payment_method in ('cash', 'credit')),
        status VARCHAR(50) CHECK (status in ('successful', 'pending', 'rejected')),
        mobileNo CHAR(11),
        FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
    );

    CREATE TABLE Process_Payment (
        paymentID INT PRIMARY KEY,
        planID INT,
        remaining_balance AS dbo.calculate_remaining_balance(planID, paymentID),
        extra_amount AS dbo.calculate_amount(planID, paymentID),
        FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
        FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
    );

    CREATE TABLE Wallet (
        walletID INT PRIMARY KEY IDENTITY(1, 1),
        current_balance DECIMAL(10, 1),
        currency VARCHAR(50),
        last_modified_date DATE,
        nationalID INT,
        FOREIGN KEY (nationalID) REFERENCES Customer_profile(nationalID)
    );

    CREATE TABLE Transfer_money (
        walletID1 INT,
        walletID2 INT,
        transfer_id INT,
        amount DECIMAL(10, 1),
        transfer_date DATE,
        PRIMARY KEY (walletID1, walletID2, transfer_id),
        FOREIGN KEY (walletID1) REFERENCES Wallet(walletID),
        FOREIGN KEY (walletID2) REFERENCES Wallet(walletID)
    );


    CREATE TABLE Benefits (
        benefitID INT PRIMARY KEY IDENTITY(1, 1),
        description VARCHAR(50),
        validity_date DATE,
        status VARCHAR(50) CHECK (status in ('active', 'expired')),
        mobileNo CHAR(11),
        FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
    );

    CREATE TABLE Points_Group (
        pointID INT IDENTITY (1,1),
        benefitID INT,
        pointsAmount DECIMAL(10, 1),
        PaymentID INT,
        PRIMARY KEY (pointID, benefitID),
        FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
        FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
    )

    CREATE TABLE Exclusive_Offer (
        offerID INT IDENTITY (1,1),
        benefitID INT,
        internet_offered INT,
        SMS_offered INT,
        minutes_offered INT,
        PRIMARY KEY (offerID, benefitID),
        FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
    )

    CREATE TABLE Cashback (
        CashbackID INT IDENTITY (1,1),
        benefitID INT,
        walletID INT,
        amount DECIMAL(10, 1),
        credit_date DATE,
        PRIMARY KEY (CashbackID, benefitID),
        FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
        FOREIGN KEY (walletID) REFERENCES Wallet(walletID)
    )

    CREATE TABLE Plan_Provides_Benefits (
        benefitID INT,
        planID INT,
        PRIMARY KEY (benefitID, planID),
        FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
        FOREIGN KEY (planID) REFERENCES Service_Plan(planID)
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
        FOREIGN KEY (shopID) REFERENCES Shop(shopID)
    )

    CREATE TABLE E_shop (
        shopID INT,
        URL VARCHAR(50),
        rating INT,
        PRIMARY KEY (shopID),
        FOREIGN KEY (shopID) REFERENCES Shop(shopID)
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
        FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo),
        FOREIGN KEY (shopID) REFERENCES Shop(shopID)
    )

    CREATE TABLE Technical_Support_Ticket (
        ticketID INT IDENTITY (1,1),
        mobileNo CHAR(11),
        Issue_description VARCHAR(50),
        priority_level INT,
        status VARCHAR(50) CHECK (status in ('Open', 'In Progress', 'Resolved')),
        PRIMARY KEY (ticketID, mobileNo),
        FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
    )

GO

EXECUTE createAllTables;

GO

INSERT INTO Customer_profile
VALUES
(1, 'jay', 'hay', 'jayhay', 'a', '2000/01/01'),
(2, 'clay', 'bay', 'claybay', 'b', '1999/01/01'),
(3, 'bob', 'jack', 'bobjack', 'c', '2001/01/01')

INSERT INTO Customer_Account
VALUES
('00000000000', 'abc', 0, 'Post Paid', '2010/01/01', 'active', 0, 1),
('00000000001', 'def', 0,  'Prepaid', '2011/01/01', 'active', 0, 2),
('00000000002', 'ghi', 0,  'Post Paid', '2012/01/01', 'active', 0, 3),
('00000000003', 'abc', 0, 'Prepaid', '2011/02/03', 'active', 0, 1),
('00000000004', 'ghi', 0,  'Post Paid', '2014/01/01', 'onhold', 0, 3)

INSERT INTO Service_Plan
VALUES
(10, 10, 10, 'plan1', 10, null),
(20, 20, 20, 'plan2', 20, null),
(30, 30, 30, 'plan3', 30, null)

INSERT INTO Subscription
VALUES
('00000000000', 1, '2015/01/01', 'active'),
('00000000000', 3, '2015/01/01', 'active'),
('00000000001', 2,  '2015/01/01', 'active'),
('00000000002', 3,   '2015/01/01', 'active'),
('00000000002', 2,   '2015/01/01', 'active')

INSERT INTO Plan_Usage
VALUES
('2015/01/01', '2015/02/01', 7, 7, 7, '00000000000', 1),
('2015/01/01', '2015/02/01', 15, 15, 15, '00000000000', 3),
('2015/01/01', '2015/02/01', 10, 10, 10, '00000000001', 2),
('2015/01/01', '2015/02/01', 9, 9, 9, '00000000002', 2),
('2015/01/01', '2015/02/01', 8, 8, 8, '00000000002', 3)

INSERT INTO Payment
VALUES
(20, '2014/02/01', 'cash', 'successful', '00000000000'),
(5, '2014/02/01', 'cash', 'successful', '00000000000'),
(7, '2014/01/01', 'credit', 'successful', '00000000001'),
(50, '2014/01/01', 'credit', 'successful','00000000002'),
(2, '2014/01/01', 'credit', 'successful', '00000000002')

INSERT INTO Process_Payment
VALUES
(1, 1),
(2, 3),
(3, 2),
(4, 2),
(5, 3)

INSERT INTO Wallet
VALUES
(10, 'egp', '2013/01/01', 1),
(10, 'usd', '2013/01/01', 3)

INSERT INTO Transfer_money 
VALUES
(2, 1, 1, 1, '2013/01/02')

INSERT INTO Benefits
VALUES
('desc', '2014/01/01', 'active', '00000000000')

INSERT INTO Points_Group
VALUES
(1, 10, 1);

INSERT INTO Shop
VALUES
('za3bola', 'cat');

INSERT INTO Physical_Shop
VALUES
(1, 'abc', '9:00-9:00');

INSERT INTO Voucher
VALUES
(20, '2015/02/01', 20, '00000000000', 1, '2015/01/01');

INSERT INTO Technical_Support_Ticket 
VALUES
('00000000001', 'hmm', 1, 'Open');

GO

CREATE PROCEDURE dropAllTables
AS
DROP TABLE Customer_profile;
DROP TABLE Customer_Account;
DROP TABLE Service_Plan;
DROP TABLE Subscription;
DROP TABLE Plan_Usage;
DROP TABLE Payment;
DROP TABLE Process_Payment;
DROP TABLE Wallet;
DROP TABLE Transfer_money;
DROP TABLE Benefits;
DROP TABLE Points_Group;
DROP TABLE Exclusive_Offer;
DROP TABLE Cashback;
DROP TABLE Plan_Provides_Benefits;
DROP TABLE Shop;
DROP TABLE Physical_Shop;
DROP TABLE E_shop;
DROP TABLE Voucher;
DROP TABLE Technical_Support_Ticket;

GO

-- EXECUTE dropAllTables;

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
DROP FUNCTION calculate_remaining_balance
DROP FUNCTION calculate_amount

GO

-- EXECUTE dropAllProceduresFunctionsViews

GO

CREATE PROC clearAllTables
AS
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

GO

-- EXECUTE clearAllTables


GO

CREATE VIEW allCustomerAccounts AS
SELECT cp.*,ca.mobileNo, ca.pass, ca.balance, ca.account_type, ca.start_date,
        ca.status, ca.point 
FROM Customer_profile cp
INNER JOIN Customer_Account ca ON cp.nationalID = ca.nationalID
WHERE ca.status = 'active';

GO

/*
SELECT *
FROM allCustomerAccounts
*/


