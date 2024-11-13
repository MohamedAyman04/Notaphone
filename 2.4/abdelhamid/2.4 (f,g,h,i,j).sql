GO
CREATE PROC Ticket_Account_Customer
@NationalID int
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
@MobileNo char(11),
@Voucher_id int OUTPUT
AS
SELECT TOP 1 @Voucher_id = V.voucherID
FROM Voucher V
WHERE V.mobileNo = @MobileNo
ORDER BY V.value DESC
GO

GRANT EXECUTE ON Account_Highest_Voucher TO customer

GO
CREATE FUNCTION Remaining_plan_amount
(@MobileNo char(11), @plan_name varchar(50))
RETURNS decimal(10,1)
AS 
BEGIN
DECLARE @result decimal(10,1) = 0

SELECT TOP 1 @result = PP.remaining_balance
FROM Payment P INNER JOIN Process_Payment PP ON P.paymentID = PP.paymentID
INNER JOIN Service_Plan SP ON PP.planID = SP.planID
WHERE P.mobileNo = @MobileNo AND SP.name = @plan_name AND P.status = 'successful'
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
WHERE P.mobileNo = @MobileNo AND SP.name = @plan_name AND P.status = 'successful'
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



