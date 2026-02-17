table 52186042 "Computer Asset Register"
{

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    CashOfficeSetup.Get;
                    NoSeriesMgt.TestManual(CashOfficeSetup."Computer Asset Requisition");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "No.Series"; Code[10])
        {
        }
        field(3; Location; Option)
        {
            OptionCaption = ' ,Head Office,Branch';
            OptionMembers = " ","Head Office",Branch;
        }
        field(4; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(5; "Asset Description"; Text[100])
        {
        }
        field(6; Manufacturer; Text[30])
        {
            TableRelation = "Asset Register Setup".Description WHERE(Type = FILTER(Manufacturer));
        }
        field(7; "Allocated User"; Text[100])
        {
        }
        field(8; "System Software"; Text[50])
        {
            TableRelation = "Asset Register Setup".Description WHERE(Type = FILTER("System Software"));
        }
        field(9; Applications; Text[50])
        {
            TableRelation = "Asset Register Setup".Description WHERE(Type = FILTER(Applications));
        }
        field(10; "Processor Type"; Text[30])
        {
            TableRelation = "Asset Register Setup".Description WHERE(Type = FILTER("Processor Type"));
        }
        field(11; "Memory Size"; Code[20])
        {
            TableRelation = "Asset Register Setup".Description WHERE(Type = FILTER("Memory Size"));
        }
        field(12; "Asset Serial No"; Code[20])
        {
        }
        field(13; "Year of Purchase"; Integer)
        {

            trigger OnValidate()
            begin
                if ("Year of Purchase" + 5) <= Date2DMY(Today, 3) then
                    Status := Status::"End of life";
            end;
        }
        field(14; "Purchase Amount"; Decimal)
        {
        }
        field(15; Status; Option)
        {
            OptionCaption = ' ,Active,Approching end of life,End of life';
            OptionMembers = " ",Active,"Approching end of life","End of life";
        }
        field(16; "Year of Service Left"; Integer)
        {
        }
        field(17; "Expected Value at end of Life"; Decimal)
        {
        }
        field(18; "Staff No"; Code[20])
        {
            TableRelation = "HR Employees";

            trigger OnValidate()
            begin
                HREmployees.Reset;
                HREmployees.SetRange("No.", "Staff No");
                if HREmployees.FindFirst then
                    "Allocated User" := HREmployees."Full Name";
            end;
        }
        field(19; Disposed; Boolean)
        {
        }
        field(20; "Date Disposed"; Date)
        {
        }
        field(21; Center; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(22; "Created By"; Code[50])
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
        if No = '' then begin

            CashOfficeSetup.Get();
            CashOfficeSetup.TestField(CashOfficeSetup."Computer Asset Requisition");
            No := NoSeriesMgt.GetNextNo(CashOfficeSetup."Computer Asset Requisition");
            // NoSeriesMgt.InitSeries(CashOfficeSetup."Computer Asset Requisition", xRec."No.Series", 0D, No, "No.Series");
        end;
        "Created By" := UserId;
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
}

