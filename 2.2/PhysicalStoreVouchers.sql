CREATE VIEW PhysicalStoreVouchers AS
SELECT ps.*, v.voucherID, v.value
FROM Physical_Shop ps INNER JOIN Voucher v ON v.shopID = ps.shopID
WHERE v.redeem_date IS NOT NULL
