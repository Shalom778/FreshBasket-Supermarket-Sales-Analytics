let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\Promotions.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanText = Table.TransformColumns(Headers, {
        {"PromotionID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"PromotionName", each Text.Trim(Text.From(_)), type text},
        {"PromotionType", each Text.Trim(Text.From(_)), type text},
        {"CampaignChannel", each Text.Trim(Text.From(_)), type text}
    }),
    Result = Table.TransformColumnTypes(CleanText, {{"DiscountPct", Int64.Type}, {"StartDate", type date}, {"EndDate", type date}}, "en-US")
in
    Result
