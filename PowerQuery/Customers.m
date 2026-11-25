let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\Customers.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanText = Table.TransformColumns(Headers, {
        {"CustomerID", each if _ = null then null else Text.Upper(Text.Trim(Text.From(_))), type text},
        {"CustomerName", each if _ = null then null else Text.Trim(Text.Clean(Text.From(_))), type text},
        {"City", each if _ = null or Text.Trim(Text.From(_)) = "" then "Unknown" else Text.Trim(Text.From(_)), type text},
        {"LoyaltyTier", each if _ = null or Text.Trim(Text.From(_)) = "" then "Unknown" else Text.Proper(Text.Trim(Text.From(_))), type text}
    }),
    Result = Table.TransformColumnTypes(CleanText, {{"Age", Int64.Type}, {"SignupDate", type date}}, "en-US")
in
    Result
