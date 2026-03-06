
SELECT 
    tl.EntryID,
    tl.WalletID,
    tl.ProductID,
    tl.Amount,
    tl.ExternalReference,
    tl.ProcessingStatus
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv
    ON tl.EntryID = dv.EntryID
WHERE dv.EntryID IS NULL
AND tl.ProcessingStatus = 'Completed';
