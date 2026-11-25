# FreshBasket report build specification

Canvas: 16:9, 1280 x 720. Theme: deep navy, teal, warm amber, white / light gray.
Use the supplied `FreshBasket_Theme.json` via View → Themes → Browse for themes.

## Page 1 — Executive Overview
**Purpose:** answer how the supermarket chain is performing.
- KPI cards: Net Sales, Gross Profit, Gross Margin %, Total Orders, Average Order Value, Units Sold.
- Line chart: Net Sales by Date[Month Year], sort by Year Month Sort.
- Clustered bar: Net Sales by Stores[StoreName].
- Bar/treemap: Net Sales by Products[Category].
- Donut: Net Sales by Sales[SalesChannel].
- Slicers: Date[Date], Stores[Region], Stores[StoreName], Products[Category], Sales[SalesChannel].
- Tooltip: Net Sales, Gross Profit, Gross Margin %, Total Orders.

## Page 2 — Product & Store Performance
- Top N bar chart: Products[ProductName] by Net Sales; visual filter Show Product In Top N = 1; add Top N Selector[Value] slicer.
- Matrix: Category → ProductName, with Net Sales, Units Sold, Gross Profit, Gross Margin %.
- Store ranking bar chart: StoreName by Net Sales.
- Scatter: Sales per Sq Ft vs Gross Margin %, bubble size Net Sales, details StoreName.
- Drill-through page: Store detail using Stores[StoreName] as drill-through field.
- Add field parameter to switch chart value among Net Sales, Gross Profit and Units Sold.

## Page 3 — Customer, Promotion & Returns
- Cards: Customers, Average Order Value, Refund Amount, Return Rate %.
- Bar: Net Sales by Customers[LoyaltyTier].
- Bar: Net Sales by Customers[City] (Unknown is retained).
- Promotion table: PromotionName, PromotionType, DiscountPct, Net Sales, Gross Profit; explain that campaign dates do not prove a sale was caused by a campaign.
- Return reason bar: Returns[ReturnReason] by Refund Amount.
- Return channel split: Returns[ReturnChannel] by Returned Units.
- Use Refunds by Original Sale Date for transaction-cohort return analysis; do not divide refund totals by unrelated sales-period totals without explaining date basis.

## Page 4 — Inventory & Operations
- Cards: Latest Inventory Value, Low Stock Store-Product Pairs, Latest Inventory Snapshot.
- Matrix: StoreName × ProductName with UnitsOnHand, ReorderLevel, UnitsOnOrder.
- Conditional formatting: UnitsOnHand below ReorderLevel in warning color.
- Bar: low-stock pairs by store.
- Trend: inventory value by SnapshotDate.
- Use only the latest snapshot for current-state cards; use snapshot-date trends for historical stock views.

## Interactions / advanced features
- Sync Date, Region and Category slicers where appropriate.
- Edit interactions so unrelated charts do not cross-filter the wrong metrics.
- Add drill-through on Store and Product detail pages.
- Add a report-page tooltip for product and store summaries.
- Create a bookmark for an “Executive View” with slicers cleared.
- Add a decomposition tree for Net Sales using Region → Store → Category → Brand.
- Use conditional formatting on Gross Margin % and target attainment.
- Add a what-if target parameter and a discount scenario slider.

## Field parameter
In Power BI Desktop: Modeling → New parameter → Fields. Add Net Sales, Gross Profit and Units Sold. Use the generated field parameter as a slicer and visual value.
