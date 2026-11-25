# Data Quality & Validation Report

## Source and cleaned row counts
| Table | Raw rows | Clean rows | Change |
|---|---:|---:|---:|
| Sales | 7,008 | 7,000 | -8 |
| Products | 46 | 46 | +0 |
| Customers | 600 | 600 | +0 |
| Stores | 8 | 8 | +0 |
| Employees | 40 | 40 | +0 |
| Promotions | 25 | 25 | +0 |
| Returns | 180 | 180 | +0 |
| InventorySnapshots | 1,120 | 1,120 | +0 |

## Issues detected and actions
| Issue | Raw finding | Treatment |
|---|---:|---|
| Mixed Sales date formats | 25 slash-formatted values | Parsed slash values as `dd/MM/yyyy`; ISO values as `yyyy-MM-dd`; output standardized to ISO date |
| Duplicate transaction IDs | 8 repeated IDs | De-duplicated Sales by `TransactionID`, keeping the first occurrence; this is valid for this dataset because each generated transaction ID represents one line |
| Missing Sales quantity | 10 rows | Kept null; do not invent quantity. Unit-based and cost-based measures should ignore or explicitly exclude these rows |
| Missing Sales customer ID | 231 rows | Kept null; these sales remain valid but are unattributed to a known customer |
| Missing customer city | 29 customers | Replaced with `Unknown` for grouping/reporting |
| Missing loyalty tier | 9 customers | Replaced with `Unknown` |
| Inconsistent StoreID casing/spacing | observed in Sales | Trimmed and uppercased keys before relationships |
| Inconsistent text case/whitespace | selected product/payment/category fields | Trimmed and standardized casing |

## Referential integrity after cleanup
- **Sales.ProductID not in Products:** 0
- **Sales.StoreID not in Stores:** 0
- **Sales.EmployeeID not in Employees:** 0
- **Sales.CustomerID not in Customers (excluding blank):** 0
- **Returns.TransactionID not in Sales:** 0
- **Returns.ProductID not in Products:** 0
- **Returns.StoreID not in Stores:** 0

## Sales date coverage
- Minimum transaction date: **2023-01-01**
- Maximum transaction date: **2025-12-30**

## Order status after de-duplication
- Completed: 6,601
- Cancelled: 260
- Pending: 139

## Business rules to keep explicit
1. Primary sales KPIs include `Completed` orders only; Pending and Cancelled are excluded.
2. Gross Sales is before discounts; Net Sales is Gross Sales minus Discount Amount. Tax is reported separately.
3. Gross Profit is estimated as `(UnitPrice - UnitCost) * Quantity - DiscountAmount`; it excludes tax and requires a nonblank quantity.
4. Missing quantity is not the same as zero quantity. Retain the blank and exclude it from unit and profit calculations.
5. Return rate by period date is a simple returned-units / sold-units ratio and may not be a matched cohort rate. For cohort analysis, match Returns to original TransactionID and use the original sale date.
6. InventorySnapshots is a periodic snapshot fact. Use the latest snapshot for current stock KPIs, and use snapshot date for trends; do not sum inventory across snapshots.
7. PromotionID is blank for transactions without an applied promotion. Do not replace it with a fabricated campaign.
8. The data is entirely synthetic and must not be represented as real business performance.
