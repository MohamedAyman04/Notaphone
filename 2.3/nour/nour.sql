CREATE ROLE Admin;

GO

CREATE PROCEDURE Account_Plan
AS
SELECT C.*, SP.*
FROM Subscription S
JOIN Customer_Account C ON (S.mobileNo = C.mobileNo)
JOIN Sevice_Plan SP ON (S.planID = SP.planID)

GO

GRANT EXECUTE ON Account_Plan TO Admin

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
    JOIN Sevice_Plan SP ON (S.planID = @Plan_id AND S.planID = SP.planID)
)

GO

GRANT SELECT ON Account_Plan_Date TO Admin

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

GRANT SELECT ON Account_Usage_Plan TO Admin

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

GRANT EXECUTE ON Benefits_Account TO Admin

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

GRANT SELECT ON Account_SMS_Offers TO Admin

GO
