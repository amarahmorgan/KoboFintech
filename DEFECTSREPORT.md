<p align="center">
  <img src="https://img.shields.io/badge/KOBO_FINTECH-Defect_Report-DC143C?style=for-the-badge&labelColor=8B0000" alt="Kobo Fintech Defect Report" />
</p>

<h1 align="center">Defect Report</h1>

<p align="center">
  <em>Kobo Fintech Digital Distribution Platform</em>
</p>

---

## Defect Summary

| Field | Detail |
|:---|:---|
| **Defect ID** | DEF-002 |
| **Title** | Transactions Allowed With Insufficient Wallet Balance |
| **Component** | Stored Procedure · `usp_IssueDigitalVoucher` |
| **Severity** | High |
| **Status** | Open |
| **Environment** | KoboFintech Database |

---

## Description

The `usp_IssueDigitalVoucher` stored procedure deducts the product value from a wallet without first verifying whether the wallet has sufficient balance. As a result, transactions can succeed even when the wallet balance is lower than the product price.

---

## Steps to Reproduce

1. Identify a wallet with low balance (WalletID 10).
2. Wallet 10 balance = **R5**.
3. Attempt to purchase a product costing **R100**.
4. Execute the purchase request via the API.

---

## Expected vs Actual

### Expected

The transaction should fail with an error indicating **insufficient wallet balance**.

### Actual

The transaction succeeds and the wallet balance becomes negative.

---

## Business Impact

| Dimension | Detail |
|:---|:---|
| **Financial** | Users may purchase products without funds |
| **Fraud Risk** | System could be exploited for free vouchers |
| **Data Integrity** | Wallet balances may become negative |

---

## Recommended Fix

Add balance validation before deducting funds.

```sql
IF (SELECT Balance FROM Wallets WHERE WalletID = @WalletID) 
   < (SELECT FaceValue FROM Products WHERE ProductID = @ProductID)
BEGIN
   RAISERROR ('Insufficient funds', 16, 1);
   RETURN;
END
