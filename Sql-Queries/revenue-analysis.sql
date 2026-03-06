
SELECT 
    u.AccountTier,
    COUNT(tl.EntryID) AS TotalTransactions,
    SUM(tl.Amount) AS TotalRevenue
FROM TransactionLedger tl
JOIN Wallets w 
    ON tl.WalletID = w.WalletID
JOIN Users u
    ON w.UserID = u.UserID
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY u.AccountTier
ORDER BY TotalRevenue DESC;