INSERT Customer_profile
VALUES
(1, jay, hay, jayhay, a, '2000/01/01'),
(2, clay, bay, claybay, b, '1999/01/01'),
(3, bob, jack, bobjack, c, '2001/01/01'),

INSERT Customer_Account
VALUES
('00000000000', 'abc', 0, 'Post Paid', '2010/01/01', 'active', 0, 1),
('00000000001', 'def', 0,  'Prepaid', '2011/01/01', 'active', 0, 2),
('00000000002', 'ghi', 0,  'Post Paid', '2012/01/01', 'active', 0, 3),

INSERT Service_Plan
VALUES
(10, 10, 10, 'plan1', 10),
(20, 20, 20, 'plan2', 20),
(30, 30, 30, 'plan3', 30),

INSERT Subscription
VALUES
('00000000000', 1, '2015/01/01', 'active',),
('00000000000', 3, '2015/01/01', 'active',),
('00000000001', 2,  '2015/01/01', 'active'),
('00000000002', 3,   '2015/01/01', 'active'),
('00000000002', 2,   '2015/01/01', 'active'),

INSERT Plan_Usage
VALUES
('2015/01/01', '2015/02/01', 7, 7, 7, '00000000000', 1,),
('2015/01/01', '2015/02/01', 15, 15, 15, '00000000000', 3,),
('2015/01/01', '2015/02/01', 10, 10, 10, '00000000001', 2,),
('2015/01/01', '2015/02/01', 9, 9, 9, '00000000002', 2,),
('2015/01/01', '2015/02/01', 8, 8, 8, '00000000002', 3,),

INSERT Payment
VALUES
(20, '2014/02/01', 'cash', 'successful', '00000000000'),
(5, '2014/02/01', 'cash', 'successful', '00000000000'),
(7, '2014/01/01', 'credit', 'successful', '00000000001'),
(50, '2014/01/01', 'credit', 'successful','00000000002'),
(2, '2014/01/01', 'credit', 'successful', '00000000002'),

INSERT Process_Payment
VALUES
(1, 1,),
(2, 3,),
(3, 2,),
(4, 2,),
(5, 3,),

INSERT Wallet
VALUES
(10, 'egp', '2013/01/01', 1),
(10, 'usd', '2013/01/01', 3),


INSERT Transfer_money 
VALUES
(2, 1, 1, 1, '2013/01/02')

INSERT Benefits
VALUES
('desc', '2014/01/01', 'active', '00000000000')

INSERT Points_Group
VALUES
(1, 1, 10, 1);

INSERT Points_Group
VALUES
(1, 1, 10, 1);

INSERT Shop
VALUES
(1, 'za3bola', 'cat');

INSERT Physical_Shop
VALUES
(1, 'abc', '9:00-9:00');

INSERT Voucher
VALUES
(1, 20, '2015/02/01', 20, '00000000000', 1, '2015/01/01');

INSERT Technical_Support_Ticket 
VALUES
(1, '00000000001', 'hmm', 1, 'Open');
