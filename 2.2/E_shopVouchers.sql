CREATE VIEW E_shopVouchers AS
SELECT e.name, v.voucherID, v.value
FROM E_shop e INNER JOIN Voucher v ON e.shopID = v.shopID;
WHERE v.redeem_date IS NOT NULL
