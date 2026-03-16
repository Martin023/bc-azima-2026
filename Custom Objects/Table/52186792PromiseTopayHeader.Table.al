table 52186792 "Promise Topay Header"
{
    LookupPageId = "Promise Topay Header";
    DrillDownPageId = "Promise Topay Header";
    fields
    {

        field(1; "No."; Code[50])
        {
            Editable = false;
        }
        field(2; "Member No."; Code[50])
        {
            TableRelation = Members;
            trigger OnValidate()
            var
                Members: Record Members;
                Loans: Record Loans;
            begin
                if "No." = '' then begin
                    SeriesSetup.Get;
                    SeriesSetup.TestField(SeriesSetup."Promise To Pay");
                    "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Promise To Pay");
                    // NoSeriesMgt.InitSeries(SeriesSetup."Promise To Pay", xRec."No. Series", 0D, "No.", "No. Series");

                    "Created At" := CurrentDateTime;
                    "Created By" := UserId;

                    GlobalFunctions.InsertUserTasks(DepartMent::DMU, SubDepartmentS::"Promise Topay", Rec."No.", UserID);
                end;

                TopayHeader.Reset();
                TopayHeader.SetRange("Member No.",Rec."Member No.");
                TopayHeader.SetFilter("Promise Status",'<>%1',TopayHeader."Promise Status"::Closed);
                TopayHeader.SetFilter("No.",'<>%1',"No.");
                if TopayHeader.FindFirst() then 
                Error('Kindly proceed and use header no %1, Status %2',TopayHeader."No.",TopayHeader."Promise Status");

                if Members.Get("Member No.") then
                    "Member Name" := Members.Name;

                Loans.Reset();
                Loans.SetRange("Member No.", Rec."Member No.");
                Loans.SetFilter("Outstanding Balance", '>0');
                if not Loans.FindFirst() then Error("Member Name" + ' - ' + "Member No." + ' does not have an active loan.');
            end;
        }
        field(3; "Member Name"; Text[200])
        {
            Editable = false;
        }
        field(4; "Created By"; Code[100])
        {
            Editable = false;
        }
        field(5; "Created At"; DateTime)
        {
            Editable = false;
        }
        field(6; "Write an SMS"; Text[1000])
        {
            trigger OnValidate()
            begin
                "Loan Reference" := '';
            end;
        }
        field(7; "Loan Reference"; Code[100])
        {
            TableRelation = Loans."Loan No." where("Member No." = field("Member No."), "Outstanding Balance" = filter(> 0));
            trigger OnValidate()
            var
                Members: Record Members;
            begin
                if Members.Get("Member No.") then begin
                    "Phone Number" := Members."Phone No.";
                    if "Phone Number" = '' then
                        "Phone Number" := Members."Transactional Mobile Number";
                end;
            end;
        }
        field(8; "Promise Status"; Option)
        {
            Editable = false;
            OptionMembers = New,Active,Closed;
        }
        field(9; "Closed By"; Code[100])
        {
            Editable = false;
        }
        field(10; "Closed At"; DateTime)
        {
            Editable = false;
        }
        field(11; "No. Series"; Code[50])
        {
            Editable = false;
        }
        field(12; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(13; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(14; "Phone Number"; Text[20])
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

    trigger OnInsert()
    begin
        SeriesSetup.Get;
        SeriesSetup.TestField(SeriesSetup."Promise To Pay");
        "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Promise To Pay");
        // NoSeriesMgt.InitSeries(SeriesSetup."Promise To Pay", xRec."No. Series", 0D, "No.", "No. Series");

        "Created At" := CurrentDateTime;
        "Created By" := UserId;

        GlobalFunctions.InsertUserTasks(DepartMent::DMU, SubDepartmentS::"Promise Topay", Rec."No.", UserID);
    end;

    var
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SeriesSetup: Record "Credit Nos. Series";
        GlobalFunctions: Codeunit "Global Functions";
        SubDepartments: Enum "Sub Module";
        TopayHeader: Record "Promise Topay Header";
        DepartMent: Enum "Responsibility Center Enum";


}

