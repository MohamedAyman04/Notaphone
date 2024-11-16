-- this is yehia's file dummy

--2.3 f)
GO
CREATE PROCEDURE Account_Payment_Points
@MobileNo char(11),
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
WHERE p.mobileNo = @MobileNo;
END;

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

--2.3 h)
GO
CREATE FUNCTION Wallet_Transfer_Amount
(@Wallet_id int, @start_date date, @end_date date)
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @TransactionAmountAverage DECIMAL(10,2)
SELECT @TransactionAmountAverage = AVG(tm.amount)
FROM Wallet w
INNER JOIN Transfer_money tm On W.walletID = tm.walletID1
WHERE @Wallet_id = tm.walletID1 AND tm.transfer_date BETWEEN @start_date AND @end_date
RETURN @TransactionAmountAverage
END;

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

--2.3 j)
GO
CREATE PROCEDURE Total_Points_Account
@MobileNo char(11),
@TotalPoints INT OUTPUT
AS
BEGIN
SELECT @TotalPoints = SUM(pointsAmount)
FROM Points_Group pg
INNER JOIN Payment p ON pg.PaymentID = p.PaymentID
WHERE @MobileNo = mobileNo

UPDATE Customer_Account
SET point = @TotalPoints
WHERE @MobileNo = mobileNo
END;