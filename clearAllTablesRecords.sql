﻿GO
CREATE PROC clearAllTablesRecords
AS
TRUNCATE TABLE Customer_profile;
TRUNCATE TABLE Customer_Account;
TRUNCATE TABLE Service_Plan;
TRUNCATE TABLE Subscription;
TRUNCATE TABLE Plan_Usage;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Process_Payment;
TRUNCATE TABLE Wallet;
TRUNCATE TABLE Transfer_money;
TRUNCATE TABLE Benefits;
TRUNCATE TABLE Points_Group;
TRUNCATE TABLE Exclusive_Offer;
TRUNCATE TABLE Cashback;
TRUNCATE TABLE Plan_Provides_Benefits;
TRUNCATE TABLE Shop;
TRUNCATE TABLE Physical_Shop;
TRUNCATE TABLE E_shop;
TRUNCATE TABLE Voucher;
TRUNCATE TABLE Technical_Support_Ticket;

GO
