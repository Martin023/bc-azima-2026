table 52186264 "Monthly Contrib Logs"
{
    Caption = 'Monthly Contrib Logs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            Caption = 'No';
            AutoIncrement = true;
        }
        field(2; "Product ID"; Code[50])
        {
            tablerelation = "Product Factory"."Product ID" where("Product Class Type" = filter(Savings), Status = filter(Active));
            Caption = 'Product ID';
        }
        field(4; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            trigger OnValidate()
            begin
                "Effective Date" := CalcDate('<-CM>', "Effective Date");
            end;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End date';
        }
        field(5; "Currently Active"; Boolean)
        {
            Caption = 'Currently Active';

            trigger OnValidate()
            begin
                if "Currently Active" then begin
                    MonthlyLogs.reset;
                    MonthlyLogs.setrange("Product ID", "Product ID");
                    MonthlyLogs.setfilter(No, '<>%1', Rec.No);
                    MonthlyLogs.setrange("Currently Active", true);
                    if monthlyLogs.findfirst then begin
                        repeat
                            MonthlyLogs."Currently Active" := false;
                            MonthlyLogs.modify;
                        until MonthlyLogs.Next = 0;
                    end;
                end;
            end;
        }
        field(10; "Monthly Contribution"; Decimal)
        {
            Caption = 'New Contribution';
        }
        field(7; "Effected By"; code[50])
        {
            Caption = 'Effected By';
        }

    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    var
        MonthlyLogs: Record "Monthly Contrib Logs";

    trigger OnInsert()
    begin
        Rec."Effected By" := USERID;
    end;

}
