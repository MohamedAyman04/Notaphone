-- Run this to be able to test the website
USE Milestone2DB_24

GO

INSERT INTO Customer_profile
VALUES
(1, 'jay', 'hay', 'jayhay', 'a', '2000/01/01'),
(2, 'clay', 'bay', 'claybay', 'b', '1999/01/01'),
(3, 'bob', 'jack', 'bobjack', 'c', '2001/01/01')
INSERT INTO Customer_Account
VALUES
('00000000000', 'abc', 0, 'postpaid', '2010/01/01', 'active', 0, 1),
('00000000001', 'def', 0,  'prepaid', '2011/01/01', 'active', 0, 2),
('00000000002', 'ghi', 0,  'postpaid', '2012/01/01', 'active', 0, 3),
('00000000003', 'abc', 0, 'prepaid', '2011/02/03', 'active', 100, 1),
('00000000004', 'ghi', 0,  'postpaid', '2014/01/01', 'onhold', 0, 3)
INSERT INTO Service_Plan
VALUES
('plan1', 10, 10, 1, 10, 'desc'),
('plan2', 20, 20, 2, 20, null),
('plan3', 30, 30, 3, 30, null)
INSERT INTO Subscription
VALUES
('00000000000', 1, '2015/01/01', 'active'),
('00000000000', 3, '2024/09/01', 'active'),
('00000000001', 2,  '2015/01/01', 'active'),
('00000000002', 3,   '2015/01/01', 'active'),
('00000000002', 2,   '2015/01/01', 'active'),
('00000000001', 1,  '2024/09/01', 'active')
INSERT INTO Plan_Usage
VALUES
('2015/01/01', '2015/02/01', 7, 7, 7, '00000000000', 1),
('2024/11/11', '2025/01/11', 7, 7, 7, '00000000000', 1),
('2024/11/29', '2024/12/29', 15, 15, 15, '00000000000', 3),
('2015/01/01', '2015/02/01', 10, 10, 10, '00000000001', 2),
('2015/01/01', '2015/02/01', 9, 9, 9, '00000000002', 2),
('2015/01/01', '2015/02/01', 8, 8, 8, '00000000002', 3)
INSERT INTO Payment
VALUES
(20, '2014/02/01', 'cash', 'successful', '00000000000'),
(5, '2014/02/01', 'cash', 'successful', '00000000000'),
(7, '2014/01/01', 'credit', 'successful', '00000000001'),
(50, '2014/01/01', 'credit', 'successful','00000000002'),
(2, '2014/01/01', 'credit', 'successful', '00000000002'),
(11, '2023/12/20', 'credit', 'successful', '00000000000'),
(14, '2023/12/21', 'credit', 'successful', '00000000000'),
(20, '2024/02/02', 'credit', 'rejected', '00000000000')
INSERT INTO Process_Payment
VALUES
(1, 1),
(2, 3),
(3, 2),
(4, 2),
(5, 3),
(6, 1),
(7, 3),
(8, 2)
INSERT INTO Wallet
VALUES
(10, 'egp', '2013/01/01', 1, '00000000000'),
(10, 'usd', '2013/01/01', 3, '00000000002')
INSERT INTO Transfer_money 
VALUES
(2, 1, 10, '2013/01/02'),
(2, 1, 20, '2015/01/02')
INSERT INTO Benefits
VALUES
('desc', '2025/01/01', 'active', '00000000000'),
('desc', '2014/01/01', 'active', '00000000004'),
('desc', '2014/01/01', 'expired', '00000000001'),
('desc', '2025/01/01', 'active', '00000000000'),
('desc', '2022/01/01', 'active', '00000000000'),
('desc', '2022/01/01', 'expired', '00000000000')
INSERT INTO Plan_Provides_Benefits
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 2)
INSERT INTO Points_Group
VALUES
(1, 10, 1),
(4, 10, 6),
(5, 10, 7),
(6, 20, 8)
INSERT INTO Cashback
VALUES
(2, 2, 10, '2000/01/01'),
(3, 2, 20, '2000/01/01');
INSERT INTO Exclusive_Offer
VALUES
(1, 10, 12, 14)
INSERT INTO Shop
VALUES
('za3bola', 'cat'),
('egbg', 'catcat');
INSERT INTO Physical_Shop
VALUES
(1, 'abc', '9:00-9:00');
INSERT INTO E_shop
VALUES
(2, 'frong.gov', 9);
INSERT INTO Voucher
VALUES
(20, '2015/02/01', 20, '00000000000', '2014/01/01', 2),
(50, '2016/02/01', 60, '00000000003', '2015/01/01', 1),
(30, '2030/02/01', 30, '00000000003', null, 1);
INSERT INTO Technical_Support_Ticket 
VALUES
('00000000001', 'hmm', 1, 'Open'),
('00000000002', 'hmmmm', 1, 'Resolved');