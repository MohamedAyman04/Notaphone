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
SELECT S.* from Service_Plan P  where S.planID NOT IN (select S.planID from Subscription S where S.mobileNo=@MobileNo)
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

GO

