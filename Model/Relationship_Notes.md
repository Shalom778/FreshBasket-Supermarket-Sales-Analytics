# Relationship setup

Create these as active, one-to-many relationships with single-direction filtering from dimension to fact:
- Products[ProductID] → Sales[ProductID], Returns[ProductID], InventorySnapshots[ProductID]
- Stores[StoreID] → Sales[StoreID], Returns[StoreID], InventorySnapshots[StoreID]
- Customers[CustomerID] → Sales[CustomerID]
- Employees[EmployeeID] → Sales[EmployeeID]
- Promotions[PromotionID] → Sales[PromotionID]
- Date[Date] → Sales[TransactionDate], Returns[ReturnDate], InventorySnapshots[SnapshotDate]

Mark Date as the date table using Date[Date]. Sort Date[Month] by Date[Month Number] and Date[Month Year] by Date[Year Month Sort].

Do not directly join Returns or InventorySnapshots to Sales. They are separate fact tables sharing conformed dimensions. The optional measure `Refunds by Original Sale Date` uses TREATAS to match returns to sales IDs for cohort-style reporting.

All foreign keys were checked after cleanup; see QA/Data_Quality_Report.md.
