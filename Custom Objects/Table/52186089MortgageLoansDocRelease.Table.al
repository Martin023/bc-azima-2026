table 52186089 "Mortgage Loans Doc Release"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            TableRelation = "Mortgage Loans Doc Register"."Loan No." WHERE("Member No" = FIELD("Member No."),
                                                                            "Document Withheld" = CONST(true));

            trigger OnValidate()
            begin
                if "Loan No." <> '' then begin
                    Loans.Reset;
                    Loans.SetRange("Loan No.", "Loan No.");
                    if Loans.Find('-') then begin
                        Loans.CalcFields("Total Loan Balance");
                        if Loans."Total Loan Balance" > 0 then Error('Loan not yet cleared');
                    end else
                        Error('Loan Does not exist');

                    MortRegister.Reset;
                    MortRegister.SetRange("Loan No.", "Loan No.");
                    if MortRegister.Find('-') then begin
                        "Member Name" := MortRegister."Member Name";
                        "Date Withheld" := MortRegister."Date Withheld";
                        "User Registered" := MortRegister."User Registered";
                        "Document Type" := MortRegister."Document Type";
                        "WithHeld Document No." := MortRegister."Withheld Document No";
                    end;
                end;

                MortDocRelease.Reset;
                MortDocRelease.SetRange("Loan No.", "Loan No.");
                MortDocRelease.SetFilter(Status, '<>%1', MortDocRelease.Status::Rejected);
                if MortDocRelease.Find('-') then
                    Error('Application for this document Already exist with No %1 of status %2', MortDocRelease."No.", MortDocRelease.Status);
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members;
        }
        field(3; "Member Name"; Text[70])
        {
        }
        field(4; "Loan Type"; Code[10])
        {
        }
        field(5; "Document Type"; Option)
        {
            OptionCaption = ' ,Lease/Title';
            OptionMembers = " ","Lease/Title";
        }
        field(6; "No."; Code[10])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Mortage Doc Release");
                    "No. Series" := '';
                end
            end;
        }
        field(7; "Date Withheld"; Date)
        {
        }
        field(8; "User Registered"; Text[50])
        {
        }
        field(9; "Date Released"; Date)
        {
        }
        field(10; "User Relased"; Text[50])
        {
        }
        field(11; Status; Option)
        {
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(12; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(13; "Captured By"; Text[50])
        {
        }
        field(14; "Date Captured"; Date)
        {
        }
        field(15; "WithHeld Document No."; Code[15])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Mortage Doc Release");
            "No." := NoSeriesMgt.GetNextNo(MembNoSeries."Mortage Doc Release");
            // NoSeriesMgt.InitSeries(MembNoSeries."Mortage Doc Release", xRec."No. Series", 0D, "No.", "No. Series");
            "Captured By" := UserId;
            "Date Captured" := Today;
        end;
    end;

    var
        MembNoSeries: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Loans: Record Loans;
        MortRegister: Record "Mortgage Loans Doc Register";
        MortDocRelease: Record "Mortgage Loans Doc Release";

    [Scope('OnPrem')]
    procedure ReleaseDocument(LoanNo: Code[15])
    begin
        MortRegister.Reset;
        MortRegister.SetRange("Loan No.", LoanNo);
        if MortRegister.Find('-') then begin
            MortRegister."Date Released" := Today;
            MortRegister."User Relased" := UserId;
            MortRegister."Document Withheld" := false;
        end;
    end;
}

