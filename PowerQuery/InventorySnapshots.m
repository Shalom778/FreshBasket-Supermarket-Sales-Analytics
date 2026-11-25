let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\InventorySnapshots.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanText = Table.TransformColumns(Headers, {
        {"StoreID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"ProductID", each Text.Upper(Text.Trim(Text.From(_))), type text}
    }),
    Result = Table.TransformColumnTypes(CleanText, {{"SnapshotDate", type date}, {"UnitsOnHand", Int64.Type}, {"ReorderLevel", Int64.Type}, {"UnitsOnOrder", Int64.Type}, {"InventoryCostValue", Currency.Type}}, "en-US")
in
    Result
