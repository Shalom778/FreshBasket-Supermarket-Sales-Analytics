let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\Returns.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanText = Table.TransformColumns(Headers, {
        {"ReturnID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"TransactionID", each Text.Trim(Text.From(_)), type text},
        {"ProductID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"StoreID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"ReturnReason", each Text.Trim(Text.From(_)), type text},
        {"ReturnChannel", each Text.Proper(Text.Trim(Text.From(_))), type text}
    }),
    Result = Table.TransformColumnTypes(CleanText, {{"ReturnDate", type date}, {"ReturnQuantity", Int64.Type}, {"RefundAmount", Currency.Type}}, "en-US")
in
    Result
