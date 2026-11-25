let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\Sales.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanIDs = Table.TransformColumns(Headers, {
        {"TransactionID", each Text.Trim(Text.From(_)), type text},
        {"StoreID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"ProductID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"CustomerID", each if _ = null then null else Text.Upper(Text.Trim(Text.From(_))), type text},
        {"EmployeeID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"PromotionID", each if _ = null then null else Text.Upper(Text.Trim(Text.From(_))), type text},
        {"PaymentMethod", each Text.Proper(Text.Trim(Text.From(_))), type text},
        {"SalesChannel", each Text.Proper(Text.Trim(Text.From(_))), type text},
        {"OrderStatus", each Text.Proper(Text.Trim(Text.From(_))), type text}
    }),
    ParseDates = Table.TransformColumns(CleanIDs, {{"TransactionDate", each try if Text.Contains(Text.From(_), "/") then Date.FromText(Text.From(_), [Culture="en-GB"]) else Date.FromText(Text.From(_), [Culture="en-US"]) otherwise null, type date}}),
    DeDuplicated = Table.Distinct(ParseDates, {"TransactionID"}),
    Result = Table.TransformColumnTypes(DeDuplicated, {
        {"Quantity", Int64.Type}, {"UnitPrice", Currency.Type}, {"DiscountPct", Percentage.Type},
        {"GrossSales", Currency.Type}, {"DiscountAmount", Currency.Type}, {"TaxAmount", Currency.Type}, {"NetSales", Currency.Type}
    }, "en-US")
in
    Result
