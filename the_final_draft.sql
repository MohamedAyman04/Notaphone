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
DROP TABLE Payment;
DROP TABLE Process_Payment;
DROP TABLE Benefits;
DROP TABLE Wallet;

-- Drop tables referenced by others now that dependencies are removed
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
DROP FUNCTION calculate_remaining_balance
DROP FUNCTION calculate_amount

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
FROM Wallet w INNER JOIN Customer_profile c ON w.nationalID = c.nationalID

GO

CREATE VIEW E_shopVouchers AS
SELECT e.*, v.voucherID, v.value
FROM E_shop eINNER JOIN Voucher v ON e.shopID = v.shopID
WHERE v.redeem_date IS NOT NULL

GO

CREATE VIEW PhysicalStoreVouchers AS
SELECT ps.*, v.voucherID, v.value
FROM Physical_Shop ps INNER JOIN Voucher v ON v.shopID = ps.shopID
WHERE v.redeem_date IS NOT NULL

GO

CREATE VIEW Num_of_cashback AS
SELECT walletID, count(CashbackID) AS NumberOfCashbackTransactions
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
JOIN Sevice_Plan SP ON (S.planID = SP.planID)

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
@MobileNo CHAR(11), @plan_ID INT
AS
    DELETE B
    FROM Benefits B
    WHERE EXISTS (
        SELECT *
        FROM Plan_Provides_Benefits PPB
        WHERE B.benefitID = PPB.benefitID
            AND B.mobileNo = @MobileNo
            AND PPB.planID = @plan_ID
   )

GO

GRANT EXECUTE ON Benefits_Account TO admin

GO

CREATE FUNCTION Account_SMS_Offers (@MobileNo CHAR(11))
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM Exclusive_Offer EO
    JOIN Benefits B ON (EO.benefitID = B.benefitID)
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
SELECT @TotalNumberOftransactions = COUNT(*)
FROM Payment
WHERE mobileNo = @MobileNo AND status = 'successful'
AND date_of_payment >= DATEADD(YEAR, -1, CURRENT_TIMESTAMP);

SELECT @TotalAmountOfPoints = SUM(pg.pointsAmount)
FROM Payment p
INNER JOIN Points_Group pg ON p.PaymentID = pg.PaymentID
WHERE p.mobileNo = @MobileNo AND p.date_of_payment >= DATEADD(YEAR, -1, CURRENT_TIMESTAMP);
END;

GO

GRANT EXECUTE ON Account_Payment_Points TO admin

--2.3 g)
GO
CREATE FUNCTION Wallet_Cashback_Amount
(@WalletId INT, @planId INT)
RETURNS INT
AS
BEGIN
DECLARE @AmountOfCashback INT
SELECT @AmountOfCashback = SUM(cb.amount)
FROM Cashback cb
INNER JOIN Plan_Provides_Benefits ppb ON cb.benefitID = ppb.benefitID
WHERE @WalletId = cb.walletID AND @planId = ppb.planID

RETURN @AmountOfCashback
END;

GO

GRANT EXECUTE ON Wallet_Cashback_Amount TO admin

--2.3 h)
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

--2.3 i)
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

--2.3 j)
GO
CREATE PROCEDURE Total_Points_Account
@MobileNo char(11),
@TotalPoints INT OUTPUT
AS
BEGIN
SELECT @TotalPoints = SUM(pg.pointsAmount)
FROM Points_Group pg
INNER JOIN Payment p ON pg.PaymentID = p.PaymentID
INNER JOIN Benefits B ON pg.benefitID = B.benefitID
WHERE @MobileNo = P.mobileNo AND @MobileNo = B.mobileNo AND B.validity_date >= CURRENT_TIMESTAMP AND B.status = 'active'

UPDATE Customer_Account
SET point = @TotalPoints
WHERE @MobileNo = mobileNo
END;

GO

GRANT EXECUTE ON Total_Points_Account TO admin

GO

-- ahmed's part
-- part a

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


-- part b

GO
CREATE FUNCTION Consumption
(@Plan_name VARCHAR(50) ,@start_date DATE ,@end_date DATE)

RETURNS TABLE

AS

RETURN ( SELECT P.data_consumption, P.minutes_used, P.SMS_sent FROM Plan_Usage P INNER JOIN Service_Plan S ON P.planID = S.planID
WHERE S.name = @Plan_name AND P.start_date >= @start_date AND P.end_date <= @end_date )

GO

GRANT SELECT ON Consumption TO customer

-- part c

GO
CREATE PROC Unsubscribed_Plans
@MobileNo char(11)
AS
SELECT S.* from Service_Plan P, Subscription S  where S.planID NOT IN (select S.planID from S where S.mobileNo=@MobileNo)
GO

GRANT EXECUTE ON Unsubscribed_Plans TO customer

-- part d
 
GO
CREATE FUNCTION Usage_Plan_CurrentMonth
(@MobileNo char(11))

RETURNS TABLE

AS

RETURN ( SELECT P.data_consumption, P.minutes_used, P.SMS_sent from Plan_Usage P INNER JOIN Subscription S
ON P.mobileNo = S.mobileNo AND P.planID = S.planID
WHERE P.mobileNo = @MobileNo AND MONTH(CURRENT_TIMESTAMP) = MONTH(P.start_date) AND YEAR(CURRENT_TIMESTAMP) = YEAR(P.start_date)
AND S.status = 'active'
)

GO

GRANT SELECT ON Usage_Plan_CurrentMonth TO customer

GO

-- part e

CREATE FUNCTION Cashback_Wallet_Customer
(@NationalID int)
RETURNS TABLE

AS

RETURN ( SELECT C.* from Cashback C INNER JOIN Wallet W on C.walletID = W.walletID where W.nationalID=@NationalID)

GO

GRANT SELECT ON Cashback_Wallet_Customer TO customer

-- abdelhamid's part

GO

CREATE PROC Ticket_Account_Customer
@NationalID INT
AS
SELECT COUNT(*)
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
SELECT TOP 1 @Voucher_id = V.voucherID
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
FROM Payment P INNER JOIN Process_Payment PP ON P.paymentID = PP.paymentID
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

-- mohamed's part
-- part k
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

-- part l
GO

CREATE PROCEDURE Initiate_plan_payment
    @MobileNo CHAR(11),
    @amount DECIMAL(10, 1),
    @payment_method VARCHAR(50),
    @plan_id INT
AS
    -- Insert the payment record
    INSERT INTO Payment (amount, date_of_payment, payment_method, status, mobileNo)
    VALUES (@amount, CURRENT_TIMESTAMP, @payment_method, 'successful', @MobileNo);
    
    -- Updating subscription status to 'active'
    UPDATE Subscription
    SET status = 'active'
    WHERE mobileNo = @MobileNo AND planID = @plan_id;

GO

GRANT EXECUTE ON Initiate_plan_payment TO customer

-- part m
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

-- part n
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

-- part o
GO

CREATE PROCEDURE Redeem_voucher_points
    @MobileNo CHAR(11),
    @voucher_id INT
AS
    -- Declare variables for points deduction and validation
    DECLARE @points_to_deduct INT;
    DECLARE @expiry_date DATE;
    DECLARE @redeem_date DATE;

    -- Check if the voucher exists for the mobile number and retrieve points, expiry date and redeem_date
    SELECT @points_to_deduct = points, @expiry_date = expiry_date, @redeem_date = redeem_date
    FROM Voucher
    WHERE voucherID = @voucher_id AND mobileNo = @MobileNo;

    -- Verify if the voucher exists and is not expired and not redeemed
    IF @points_to_deduct IS NOT NULL AND @expiry_date >= CURRENT_TIMESTAMP AND @redeem_date IS NULL
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
