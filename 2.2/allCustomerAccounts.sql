CREATE VIEW allcustomerAccounts AS
SELECT *
FROM Customer_profile, Customer_Account
WHERE Customer_profile.nationalID = Customer_Account.nationalID;