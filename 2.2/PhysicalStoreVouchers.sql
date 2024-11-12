CREATE VIEW PhysicalStoreVouchers
AS
SELECT s.name, v.voucherID, v.value
FROM Physical_Shop ps
INNER JOIN Shop s ON ps.shopID = s.shopID
INNER JOIN Voucher v ON s.shopID = v.shopID
