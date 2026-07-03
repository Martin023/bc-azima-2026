table 52185559 "HR Training Need Request"
{
    DataCaptionFields = "Request No.", Description;
    DrillDownPageID = "HR Training Need Request List";
    LookupPageID = "HR Training Need Request List";

    fields
    {
        field(1; "Request No."; Code[20])
        {
            Editable = false;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Training Description';
        }
        field(3; "Training Category"; Option)
        {
            OptionMembers = " ",Individual,Department,Groups,Organization,Staff,Interns,Attachees;
        }
        field(4; "Training Type"; Option)
        {
            OptionMembers = " ","Local",Regional,International,Conference,Seminar,Workshop,"Study Tour","Self Sponsored",Other,"Company Sponsorship";
            
            trigger OnValidate()
            begin
                if Rec."Training Type" = Rec."Training Type"::Other then
                    Rec.TestField(Other);
            end;
        }
        field(5; Other; Text[50])
        {
            Caption = 'Other Training Type';
        }
        field(6; "No. of Employees"; Integer)
        {
            Caption = 'Number of Employees';
            MinValue = 1;
        }
        field(7; Justification; Text[250])
        {
            Caption = 'Justification/Reason';
        }
        field(8; Priority; Option)
        {
            OptionMembers = " ",Low,Medium,High,Critical;
        }
        field(9; "Proposed Start Date"; Date)
        {
            Caption = 'Proposed Start Date';
        }
        field(10; "Proposed End Date"; Date)
        {
            Caption = 'Proposed End Date';
            
            trigger OnValidate()
            begin
                if ("Proposed End Date" <> 0D) and ("Proposed Start Date" <> 0D) then
                    if "Proposed End Date" < "Proposed Start Date" then
                        Error('Proposed End Date cannot be earlier than Proposed Start Date');
            end;
        }
        field(11; "Estimated Cost"; Decimal)
        {
            Caption = 'Estimated Cost (if known)';
        }
        field(12; "Requested By Employee No."; Code[20])
        {
            Caption = 'Requested By';
            Editable = false;
            TableRelation = "HR Employees"."No.";
        }
        field(13; "Requested By Name"; Text[100])
        {
            Caption = 'Requested By Name';
            Editable = false;
        }
        field(14; "Request Date"; Date)
        {
            Caption = 'Request Date';
            Editable = false;
        }
        field(15; "Department Code"; Code[10])
        {
            Caption = 'Department';
            Editable = false;
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(16; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(20; "Need Source"; Option)
        {
            OptionCaption = '  ,Appraisal,Succesion,Training,Employee,Employee Skill Plan,Competency Profiling,Market Demand';
            OptionMembers = "  ",Appraisal,Succesion,Training,Employee,"Employee Skill Plan","Competency Profiling","Market Demand";
        }
        field(21; "Preferred Provider"; Text[100])
        {
            Caption = 'Preferred Training Provider (if any)';
        }
        field(22; "Preferred Location"; Text[100])
        {
            Caption = 'Preferred Location';
        }
        field(23; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(24; Status; Option)
        {
            OptionMembers = New,"Under Review","Converted to Official Need",Rejected;
            Editable = false;
        }
        field(25; "Official Training Need No."; Code[20])
        {
            Caption = 'Converted to Official Need No.';
            Editable = false;
            TableRelation = "HR Training Needs".Code;
        }
    }

    keys
    {
        key(Key1; "Request No.")
        {
            Clustered = true;
        }
        key(Key2; "Department Code", "Request Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Request No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Training Need Request Nos.");
            "Request No." := NoSeriesMgt.GetNextNo(HRSetup."Training Need Request Nos.");
        end;

        "User ID" := UserId;
        "Request Date" := Today;

        GetEmployeeInfo;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Employee: Record "HR Employees";
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility CenterBR";

    local procedure GetEmployeeInfo()
    begin
        Employee.Reset;
        Employee.SetRange("User ID", UserId);
        if Employee.FindFirst then begin
            "Requested By Employee No." := Employee."No.";
            "Requested By Name" := Employee.FullName;
            "Department Code" := Employee."Department Code";
            "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
            "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";

            if "Department Code" <> '' then begin
                ResponsibilityCenter.Reset;
                if ResponsibilityCenter.Get("Department Code") then
                    "Department Name" := ResponsibilityCenter.Name;
            end;
        end else begin
            UserSetup.Reset;
            UserSetup.SetRange("User ID", UserId);
            if UserSetup.FindFirst then begin
                "Department Code" := UserSetup."Responsibility Centre";
                "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";

                if "Department Code" <> '' then begin
                    ResponsibilityCenter.Reset;
                    if ResponsibilityCenter.Get("Department Code") then
                        "Department Name" := ResponsibilityCenter.Name;
                end;
            end;
        end;
    end;
}
