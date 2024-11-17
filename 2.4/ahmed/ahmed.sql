-- part a

GO
CREATE FUNCTION AccountLoginValidation
(@MobileNo char(11), @password varchar(50))

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



-- part b

GO
CREATE FUNCTION Consumption
(@Plan_name varchar(50) ,@start_date date ,@end_date date)

RETURNS TABLE

AS

RETURN ( SELECT P.data_consumption, P.minutes_used, P.SMS_sent from Plan_Usage P INNER JOIN Service_Plan S ON P.planID= S.planID
where S.name =@Plan_name AND P.start_date <=@start_date AND P.end_date >=@end_date )

GO

-- part c

GO
CREATE PROC Unsubscribed_Plans
@MobileNo char(11)
AS
SELECT S.* from Service_Plan P  where S.planID not in (select S.planID from Subscription S where S.mobileNo=@MobileNo)
GO

-- part d
 
GO
CREATE FUNCTION Usage_Plan_CurrentMonth
(@MobileNo char(11))

RETURNS TABLE

AS

RETURN ( SELECT P.data_consumption, P.minutes_used, P.SMS_sent from Plan_Usage P where P.mobileNo=@MobileNo)

GO

-- part e

CREATE FUNCTION Cashback_Wallet_Customer
(@NationalID int)
RETURNS TABLE

AS

RETURN ( SELECT C.* from Cashback C INNER JOIN Wallet W on C.walletID= W.walletID where W.nationalID=@NationalID)

GO

