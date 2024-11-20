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