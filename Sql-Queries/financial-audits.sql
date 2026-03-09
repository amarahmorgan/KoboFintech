
SELECT 
    tl.EntryID,
    tl.WalletID,
    p.Description,
    tl.Amount,
    p.FaceValue
FROM TransactionLedger tl
JOIN Products p
    ON tl.ProductID = p.ProductID
WHERE tl.Amount <> p.FaceValue;