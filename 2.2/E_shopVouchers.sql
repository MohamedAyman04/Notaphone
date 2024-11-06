CREATE VIEW E_shopVouchers
AS
SELECT S.name,V.voucherID,V.value
FROM (Shop S INNER JOIN Voucher V ON S.shopID = V.shopID) INNER JOIN E_shop E ON S.shopID=E.shopID;
