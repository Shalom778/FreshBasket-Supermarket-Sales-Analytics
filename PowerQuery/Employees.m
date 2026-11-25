let
    Source = Csv.Document(
        File.Contents(DataFolderPath & "\Employees.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    CleanText = Table.TransformColumns(Headers, {
        {"EmployeeID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"StoreID", each Text.Upper(Text.Trim(Text.From(_))), type text},
        {"EmployeeName", each Text.Trim(Text.From(_)), type text},
        {"Role", each Text.Trim(Text.From(_)), type text},
        {"EmploymentStatus", each Text.Proper(Text.Trim(Text.From(_))), type text}
    }),
    Result = Table.TransformColumnTypes(CleanText, {{"HireDate", type date}}, "en-US")
in
    Result
