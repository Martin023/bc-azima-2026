table 52186134 "Promise Topay Lines"
{

    fields
    {
        field(1; "Header No."; Code[20])
        {
        }
        field(2; "Member No."; Code[50])
        {
            trigger OnValidate()
            var
                Members: Record Members;
            begin
                if Members.Get("Member No.") then
                    "Member Name" := Members.Name;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Loan No."; Code[20])
        {
            TableRelation = Loans WHERE("Outstanding Balance" = FILTER(> 0), "Member No." = field("Member No."));

            trigger OnValidate()
            var
                Members: Record Members;

            begin
                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields("Outstanding Balance");
                    "Loan Account No." := Loans."Loan Account";
                    "Member Name" := Loans."Member Name";
                    "Outstanding Balance" := Loans."Outstanding Balance";
                end else begin
                    "Loan Account No." := '';
                    "Member Name" := '';
                    "Outstanding Balance" := 0;
                end;


                if Members.Get("Member No.") then
                    "Member Name" := Members.Name;
            end;
        }
        field(5; "Amount to Pay"; Decimal)
        {
            MinValue = 1;
            trigger OnValidate()
            begin
                TestField("Loan No.");
                if Loans.Get("Loan No.") then begin
                    if "Outstanding Balance" > Loans.Repayment then begin
                        if "Amount to Pay" < Loans.Repayment then
                            Message('BE ADVISED!\1. Monthly Repayment - %1\2. Promised Payment - %2\3. Difference  - %3', Loans.Repayment, "Amount to Pay", (Loans.Repayment - "Amount to Pay"));
                    end;
                end;
                if "Amount to Pay" > "Outstanding Balance" then
                    Error(Err001);
            end;
        }
        field(6; "Loan Account No."; Code[20])
        {
        }
        field(7; "Topay Date"; Date)
        {
            trigger OnValidate()
            begin
                TestField("Loan No.");
                if "Topay Date" < Today then Error('Topay date can not be earlier than today');
            end;
        }
        field(8; "Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(9; "Entered By"; Code[100])
        {
            Editable = false;
        }
        field(10; "Entered At"; DateTime)
        {
            Editable = false;
        }
        field(11; Comment; Text[1000])
        {

        }
        field(12; "Close Promise"; Boolean)
        {
            trigger OnValidate()
            var
                TopayLlines: Record "Promise Topay Lines";
                TopayHeader: Record "Promise Topay Header";
                LinesCount: Integer;
            begin

                TestField("Loan No.");
                TestField("Amount to Pay");
                TestField("Topay Date");

                if Rec."Close Promise" then begin
                    if "Amount Paid" < "Amount to Pay" then
                        if Comment = '' then begin
                            "Close Promise" := false;
                            Message('Comment must have a value');
                            exit;
                        end;

                    if "Entered By" <> UserId then
                        Error('This case can only be closed by %1', GlobalFunctions.FormatUserName("Entered By"));

                    TopayLlines.Reset();
                    TopayLlines.SetRange("Header No.", Rec."Header No.");
                    TopayLlines.SetRange("Close Promise", false);
                    if TopayLlines.Find('-') then
                        LinesCount := TopayLlines.Count;
                    if LinesCount = 1 then
                        if Confirm('This is the last remaining promise line, Do you wish to close the entire promise header?') then begin
                            if TopayHeader.Get(Rec."Header No.") then begin
                                TopayHeader."Promise Status" := TopayHeader."Promise Status"::Closed;
                                TopayHeader."Closed At" := CurrentDateTime;
                                TopayHeader."Closed By" := UserId;
                                TopayHeader.Modify();
                            end;
                        end else begin
                            if Confirm('Do you wish to continue with closing this line?') then exit;
                            "Close Promise" := false;
                        end;
                end;
            end;
        }
        field(13; "Amount Paid"; Decimal)
        {
            trigger OnValidate()
            begin
                TestField("Loan No.");
                TestField("Topay Date");
            end;
        }
        field(14; "Last Date Paid"; DateTime)
        {
            trigger OnValidate()
            begin
                TestField("Loan No.");
                TestField("Topay Date");
            end;
        }


    }

    keys
    {
        key(Key1; "Header No.", "Member No.", "Loan No.", "Topay Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Entered By" := UserId;
        "Entered At" := CurrentDateTime;
    end;

    var
        Loans: Record Loans;
        Err001: Label 'Amount cannot be greater than outstanding balance';
        GlobalFunctions: Codeunit "Global Functions";
}

