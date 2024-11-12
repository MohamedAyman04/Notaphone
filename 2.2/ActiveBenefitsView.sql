CREATE VIEW allBenefits AS
SELECT *
FROM Benefits
WHERE status = 'active';
