CREATE VIEW CustomerWallet
AS
SELECT w.*, c.first_name, c.last_name
FROM Wallet w INNER JOIN Customer_profile c ON w.nationalID = c.nationalID;
