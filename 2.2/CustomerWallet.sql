CREATE VIEW CustomerWallet
AS
SELECT W.walletID, W.current_balance, W.currency, W.last_modified_date, W.nationalID, W.mobileNo, C.first_name, C.last_name
FROM Wallet W INNER JOIN Customer_profile C ON W.nationalID = C.nationalID;






