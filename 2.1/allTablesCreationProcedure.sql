﻿GO

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
        paymentID INT PRIMARY KEY IDENTITY(1, 1),
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
        pointID INT,
        benefitID INT,
        pointsAmount DECIMAL(10, 1),
        PaymentID INT,
        PRIMARY KEY (pointID, benefitID),
        FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID),
        FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
    )

    CREATE TABLE Exclusive_Offer (
        offerID INT,
        benefitID INT,
        internet_offered INT,
        SMS_offered INT,
        minutes_offered INT,
        PRIMARY KEY (offerID, benefitID),
        FOREIGN KEY (benefitID) REFERENCES Benefits(benefitID)
    )

    CREATE TABLE Cashback (
        CashbackID INT,
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
        shopID INT,
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
        voucherID INT,
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
        ticketID INT,
        mobileNo CHAR(11),
        Issue_description VARCHAR(50),
        priority_level INT,
        status VARCHAR(50) CHECK (status in ('Open', 'In Progress', 'Resolved')),
        PRIMARY KEY (ticketID, mobileNo),
        FOREIGN KEY (mobileNo) REFERENCES Customer_Account(mobileNo)
    )

GO
