table 52186039 "Permission Requisition"
{

    DrillDownPageID = "Permission Requisition List";
    LookupPageID = "Permission Requisition List";
    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            //begin

            //if No <> xRec.No then begin
            //CashOfficeSetup.Get;
            //NoSeriesMgt.TestManual(CashOfficeSetup."Permission Requisition Nos");
            //"No.Series" := '';
            //end;
            //end;
            begin

                if No <> xRec.No then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Permission Requisitions Nos");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "No.Series"; Code[10])
        {
        }
        field(4; "Full Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Staff No"; Code[20])
        {
            Editable = true;
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange("No.", "Staff No");
                if HREmployees.Find('-') then begin
                    Department := HREmployees."Global Dimension 1 Code";
                    "Phone No" := HREmployees."Cell Phone Number";
                    "Full Name" := HREmployees."Full Name";
                    "Employment Type" := HREmployees."Contract Type";
                end;
            end;
        }
        field(7; Department; Text[30])
        {
            Editable = false;
        }
        field(10; "Phone No"; Text[30])
        {
            Editable = false;
        }
        field(23; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(24; User; Code[50])
        {
            Editable = false;
        }
        field(25; "Employment Type"; Code[30])
        {
            Editable = false;
        }
        field(26; "Request Type"; Option)
        {
            OptionCaption = ' ,New,Amendment';
            OptionMembers = " ",New,Amendment;
        }
        field(27; "Date Captured"; Date)
        {
            Editable = false;
        }
        field(28; "Date Approved"; Date)
        {
            Editable = false;
        }
        field(29; "Time Approved"; Time)
        {
            Editable = false;
        }
        field(30; "Approved By"; Code[50])
        {
            Editable = true;
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(71; "Granted By"; code[50])
        {
            Editable = false;
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
        if No = '' then begin

            SeriesSetup.Get();
            SeriesSetup.TestField(SeriesSetup."Permission Requisitions Nos");
            No := NoSeriesMgt.GetNextNo(SeriesSetup."Permission Requisitions Nos");
            // NoSeriesMgt.InitSeries(SeriesSetup."Permission Requisitions Nos", xRec."No.Series", 0D, No, "No.Series");
        end;

        "Date Captured" := Today;

        User := UserId;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

        end;
        HREmployees.Reset;
        HREmployees.SetRange("User ID", UserId);
        if HREmployees.FindFirst then begin
            "Staff No" := HREmployees."No.";
            Validate("Staff No");
            "Full Name" := HREmployees."Full Name";
            "Phone No" := Format(HREmployees."Cellular Phone Number");
            "Employment Type" := HREmployees."Contract Type";
        end;
    end;

    trigger OnModify()
    begin
        "Date Captured" := Today;
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin
            //"Branch Code" := UserSetup."Global Dimension 2 Code";
            //"Responsibility Center":=UserSetup."Responsibility Centre";
            Modify;
        end;

    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Members: Record Members;
        SavingsAccounts: Record "Savings Accounts";
        Txt001: Label 'With Effect Date Cannot be less than Capture date';
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        HREmployees: Record "HR Employees";
        UserSetup: Record "User Setup";
        SalaryAgreement: Record "Salary Agreement";
        Txt002: Label 'You cann not have two Salary forms witin the same period';
        DelegateMemberss: Record "Delegate Members";
        CashOfficeSetup: Record "Cash Office Setup";
        SeriesSetup: Record "Credit Nos. Series";
}

