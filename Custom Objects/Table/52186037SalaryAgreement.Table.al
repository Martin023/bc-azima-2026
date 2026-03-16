table 52186037 "Salary Agreement"
{

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Salary Agreement No");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "No.Series"; Code[10])
        {
        }
        field(3; "Member No"; Code[20])
        {
            TableRelation = Members WHERE(Status = FILTER(New | Active), Subflag = const(Defaulter));

            trigger OnValidate()
            begin
                Members.Reset;
                Members.SetRange("No.", "Member No");
                if Members.Find('-') then begin
                    "Member Name" := Members.Name;
                    "Payroll No" := Members."Payroll/Staff No.";
                    "ID No" := Members."Primary Identification";
                    "Activity Code" := Members."Global Dimension 1 Code";
                    Department := Members."Employer Code";
                    Telephone := Members."Phone No.";
                    Ministry := Members."Employer Name";
                    "Member Status" := Members.Status;
                end;
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Member No.", Rec."Member No");
                SavingsAccounts.SetRange("Product Type", '505');
                if SavingsAccounts.Find('-') then
                    "Fosa Account No" := SavingsAccounts."No.";
            end;
        }
        field(4; "Member Name"; Text[100])
        {
        }
        field(5; "ID No"; Code[10])
        {
        }
        field(6; "Payroll No"; Code[20])
        {
        }
        field(7; Department; Text[30])
        {
        }
        field(8; "P.O Box"; Code[50])
        {
        }
        field(9; Ministry; Text[100])
        {
        }
        field(10; Telephone; Code[20])
        {
        }
        field(11; "Fosa Account No"; Code[20])
        {
        }
        field(12; "With Effect From"; Date)
        {
            TableRelation = "Interest Due Period";

            trigger OnValidate()
            begin
                if (Date2DMY("With Effect From", 2) < Date2DMY("Date Captured", 2)) and (Date2DMY("With Effect From", 3) <= Date2DMY("Date Captured", 3)) then
                    Error(Txt001);
                //Prevent 2 salary forms within same month
                SalaryAgreement.Reset;
                SalaryAgreement.SetRange(SalaryAgreement."Member No", Rec."Member No");
                SalaryAgreement.SetRange(SalaryAgreement."With Effect From", Rec."With Effect From");
                if SalaryAgreement.FindFirst then
                    Error(Txt002);
            end;
        }
        field(13; "Activity Code"; Code[20])
        {
        }
        field(14; User; Code[30])
        {
            Editable = false;
        }
        field(15; Category; Option)
        {
            Editable = true;
            OptionCaption = ' ,Salary Agreement Form,Variation';
            OptionMembers = " ","Salary Agreement Form",Variation;

            trigger OnValidate()
            begin
                Amount := 0;
            end;
        }
        field(16; "Date Captured"; Date)
        {
        }
        field(17; Comment; Code[250])
        {
        }
        field(18; "Member Status"; Enum "Member Status")
        {
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Applicant,Withdrawn,Deceased,Defaulter,Closed,Withdrawn Shareholder';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Applicant",Withdrawn,Deceased,Defaulter,Closed,"Withdrawn Shareholder";
        }
        field(19; "Recruited By"; Code[10])
        {
            TableRelation = IF ("Recruited by Type" = FILTER(Staff)) "HR Employees"."No."
            ELSE
            IF ("Recruited by Type" = CONST(Others)) Members."No." WHERE(Status = FILTER(<> Deceased & <> Closed))
            ELSE
            IF ("Recruited by Type" = CONST(Delegates)) "Delegate Members"."Delegate MNO." WHERE(Status = CONST(Approved),
                                                                                                                      Retired = CONST(false));

            trigger OnValidate()
            begin
                "Recruited By Name" := '';
                if "Recruited by Type" = "Recruited by Type"::Others then begin
                    Members.Reset;
                    Members.SetRange("No.", "Recruited By");
                    if Members.Find('-') then begin
                        "Recruited By Name" := Members.Name;
                    end;
                end else begin
                    HREmployees.Reset;
                    HREmployees.SetRange("No.", "Recruited By");
                    if HREmployees.Find('-') then begin
                        "Recruited By Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";

                    end;
                end;
                if "Recruited by Type" = "Recruited by Type"::Delegates then begin
                    DelegateMemberss.Reset;
                    DelegateMemberss.SetRange("Delegate MNO.", "Recruited By");
                    if DelegateMemberss.Find('-') then
                        "Recruited By Name" := DelegateMemberss."Delegate Name";
                end;
            end;
        }
        field(20; "Recruited by Type"; Option)
        {
            OptionCaption = 'Staff,Others,Self,Delegates';
            OptionMembers = Staff,Others,Self,Delegates;

            trigger OnValidate()
            begin
                "Recruited By Name" := '';
                "Recruited By" := '';
            end;
        }
        field(21; "Recruited By Name"; Text[100])
        {
            Editable = false;
        }
        field(22; Amount; Decimal)
        {
        }
        field(23; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(24; "Branch Code"; Code[30])
        {
        }
        field(25; Region; Option)
        {
            OptionCaption = 'National,County';
            OptionMembers = National,County;
        }
        field(26; "Responsibility Center"; Code[50])
        {
        }
        field(27; "Rejection Reason"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        // SeriesSetup."Salary Agreement No"
        // if No = '' then begin
        //     SalesSetup.Get();
        //     SalesSetup.TestField(SalesSetup."Freight G/L Acc. No.");
        //     NoSeriesMgt.InitSeries(SalesSetup."Freight G/L Acc. No.", xRec."No.Series", 0D, No, "No.Series");
        // end;

        if No = '' then begin
            SeriesSetup.Get();
            SeriesSetup.TestField(SeriesSetup."Salary Agreement No");
            No := NoSeriesMgt.GetNextNo(SeriesSetup."Salary Agreement No");
            // NoSeriesMgt.InitSeries(SeriesSetup."Salary Agreement No", xRec."No.Series", 0D, No, "No.Series");
        end;

        "Date Captured" := Today;
        //"Date Captured":=231221D;
        User := UserId;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            "Branch Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
        Category := Category::"Salary Agreement Form";
    end;

    trigger OnModify()
    begin
        "Date Captured" := Today;
        User := UserId;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            "Branch Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
            Modify;
        end;
        Category := Category::"Salary Agreement Form";
        Modify
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";

        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        Txt001: Label 'With Effect Date Cannot be less than Capture date';
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        HREmployees: Record "HR Employees";
        UserSetup: Record "User Setup";
        SalaryAgreement: Record "Salary Agreement";
        Txt002: Label 'You can not have two Salary forms within the same period';
        DelegateMemberss: Record "Delegate Members";
}

