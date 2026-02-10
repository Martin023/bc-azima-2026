table 52186157 "HR Company Activities"
{
    LookupPageId="HR Company Activities List1";
    DrillDownPageId="HR Company Activities List1";

    fields
    {
        field(1; "Code"; Code[10])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Company Activities");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Acitivity Description"; Text[50])
        {
        }
        field(3; Date; DateTime)
        {
        }
        field(4; Venue; Text[200])
        {
        }

        field(5; "Employee Responsible"; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "Employee Responsible");
                if HREmp.Find('-') then begin
                    EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    "Employee Name" := EmpName;
                    "Responsibility Center" := HREmp."Responsibility Center";
                    
                    
                end;
            end;
        }
        field(6; Costs; Decimal)
        {
        
        
            CalcFormula = Sum("Recruitment Costs".Cost WHERE("Training ID" = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        
        }
        field(7; "G/L Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAccts.Reset;
                GLAccts.SetRange(GLAccts."No.", "G/L Account No");
                if GLAccts.FindSet() then begin
                    "G/L Account Name" := GLAccts.Name;
                end;
            end;
        }
        field(8; "Bal. Account Type"; Enum "Gen. Journal Account Type")
        {
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";

            trigger OnValidate()
            begin
                //{
                //IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
                //GLAccts.GET(GLAccts."No.")
                //ELSE
                //Banks.GET(Banks."No.");
                //}
            end;
        }
        field(9; "Bal. Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(11; Posted; Boolean)
        {
            Editable = false;
        }
        field(16; "Email Message"; Text[250])
        {
        }
        field(17; "No. Series"; Code[10])
        {
        }
        field(18; Closed; Boolean)
        {
            Editable = false;
        }
        field(19; "Contribution Amount (If Any)"; Decimal)
        {
        }
        field(20; "Activity Status"; Option)
        {
            Editable=false;
            OptionCaption = 'Planning,On going,Complete';
            OptionMembers = Planning,"On going",Complete;
        }
        field(21; "G/L Account Name"; Text[50])
        {
        }
        field(22; "Employee Name"; Text[50])
        {
        }
        field(23; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(24; Status; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected,Deferred;
        }
        field(25; "Start Date"; Date)
        {
        }
        field(26; "End Date"; Date)
        {
            trigger OnValidate()
            var
               
            begin
                if rec."Activity Status"=rec."Activity Status"::Complete then 
                rec."End Date":=today;
                
            end;
        }
        field(27;"type of cost";code[50])
        {
            TableRelation="HR Lookup Values".Type WHERE(Type = CONST("Recruitment Cost"));
        }
          field(28; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(29; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(30;Jobs;code[40])
        {
            TableRelation="HR Jobs"."Job ID";
        trigger OnValidate()
        var
            HrJobs: record "HR Jobs";
        begin
            HrJobs.Reset();
            HrJobs.SetRange("Job ID",Jobs);
            If HrJobs.FindFirst THEN 
            "Job Description":=HrJobs."Job Description";
        end;
        }
        FIELD(31;"Job Description";text[100])

        {}
         FIELD(32;"Comments";text[100])

        {}
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        // key(Key2;'')
        // {
        //     Enabled = false;
        // }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if Code = '' then begin
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Company Activities");
            NoSeriesMgt.InitSeries(HRSetup."Company Activities", xRec."No. Series", 0D, Code, "No. Series");
        end;
        if UserSetup.get(UserId) then begin
            "Global Dimension 1 Code":=UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code":=UserSetup."Global Dimension 2 Code";
        end;
    end;

    var
        GLAccts: Record "G/L Account";
        Banks: Record "Bank Account";
        UserSetup:record "User Setup";
        Text000: Label 'You have canceled the create process.';
        Text001: Label 'Replace existing attachment?';
        Text002: Label 'You have canceled the import process.';
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HREmp: Record "HR Employees";
        EmpName: Text;
}

