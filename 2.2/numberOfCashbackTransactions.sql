CREATE VIEW Num_of_cashback AS
SELECT walletID, count(CashbackID) AS NumberOfCashbackTransactions
FROM Cashback
WHERE walletID IS NOT NULL
GROUP BY walletID;