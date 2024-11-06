CREATE VIEW AccountPayments AS
SELECT c.*, p.*
FROM Customer_Account c
INNER JOIN Payment p ON c.mobileNo = p.mobileNo;
