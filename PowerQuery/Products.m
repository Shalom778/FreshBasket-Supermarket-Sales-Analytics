let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\Products.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanText = Table.TransformColumns(Headers, {
        {"ProductID", each Text.Upper(Text.Trim(Text.Clean(Text.From(_)))), type text},
        {"ProductName", each Text.Trim(Text.Clean(Text.From(_))), type text},
        {"Category", each Text.Proper(Text.Lower(Text.Trim(Text.From(_)))), type text},
        {"Subcategory", each Text.Proper(Text.Lower(Text.Trim(Text.From(_)))), type text},
        {"SupplierID", each Text.Upper(Text.Trim(Text.From(_))), type text}
    }),
    Result = Table.TransformColumnTypes(CleanText, {{"UnitCost", Currency.Type}, {"UnitPrice", Currency.Type}})
in
    Result
