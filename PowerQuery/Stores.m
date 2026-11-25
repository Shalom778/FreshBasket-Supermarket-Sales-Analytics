let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\Stores.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanText = Table.TransformColumns(Headers, {
        {"StoreID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"StoreName", each Text.Trim(Text.From(_)), type text},
        {"City", each Text.Trim(Text.From(_)), type text},
        {"State", each Text.Trim(Text.From(_)), type text},
        {"Region", each Text.Trim(Text.From(_)), type text}
    }),
    Result = Table.TransformColumnTypes(CleanText, {{"OpenDate", type date}, {"SquareFeet", Int64.Type}}, "en-US")
in
    Result
