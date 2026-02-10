codeunit 52187200 DataTransfer
{
    var
        DataToPass: Code[50];

    procedure SetData(Data: Code[50])
    begin
        DataToPass := Data;
    end;

    procedure GetData(): Code[50]
    begin
        exit(DataToPass);
    end;
}
