table 52185957 Legal
{
    DrillDownPageID = "Legal List";
    LookupPageID = "Legal List";

    fields
    {
        field(31; "No."; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Case Nos.");
                    "No. Series" := '';
                end;
            end;

        }
        field(1; "Case Number"; Code[20])
        {
            Editable = false;
        }
        field(3; "Date of Filing the suit"; Date)
        {
            trigger OnValidate()
            begin
                if "Date of Filing the suit" > Today then
                    Error('The Complaint date cannot be in future');

                "Action Duration Start Date" := "Date of Filing the suit";
                //"Action Duration End  Date":="Date of Complaint";
            end;
        }
        field(4; "Type of Complainant"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Type of Complainant" = CONST('MEMBER')) Members."No."
            ELSE
            IF ("Type of Complainant" = CONST('SUPPLIER')) Vendor."No."
            ELSE
            IF ("Type of Complainant" = CONST('STAFF')) "HR Employees"."No."
            ELSE
            IF ("Type of Complainant" = CONST('TENANT')) Customer."No.";
        }
        field(5; "Recommended Action"; Code[250])
        {
        }
        field(6; "Description of Complaint"; Text[250])
        {
        }
        field(7; Reporter; Code[10])
        {
            TableRelation = IF ("Reporter Type" = CONST(Member)) Members."No."
            ELSE
            IF ("Reporter Type" = CONST(Supplier)) Vendor."No."
            ELSE
            IF ("Reporter Type" = CONST(Tenant)) Customer."No."
            ELSE
            IF ("Reporter Type" = CONST(Staff)) "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", Reporter);
                if Emp.Find('-') then
                    "Reporter Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                Cust.Reset;
                Cust.SetRange(Cust."No.", Reporter);
                if Cust.Find('-') then
                    "Reporter Name" := Cust.Name;


                Vend.Reset;
                Vend.SetRange(Vend."No.", Reporter);
                if Vend.Find('-') then
                    "Reporter Name" := Vend.Name;


                Memb.Reset;
                Memb.SetRange(Memb."No.", Reporter);
                if Memb.Find('-') then
                    "Reporter Name" := Memb.Name;
            end;
        }
        field(8; Witness; Code[20])
        {
            TableRelation = Witnesses.No;

            trigger OnValidate()
            begin
                Witn.Reset;
                Witn.SetRange(Witn.No, Witness);
                if Witn.Find('-') then
                    "Witness #1 Name" := Witn.Name;
            end;
        }
        field(9; "Witness #2"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(10; "Action Taken"; Code[20])
        {
            TableRelation = Advocate.No;
        }
        field(11; "Date To Discuss Case"; Date)
        {
        }
        field(13; "Disciplinary Remarks"; Text[30])
        {
        }
        field(14; Comments; Text[250])
        {
        }
        field(15; "Case Discussion"; Boolean)
        {
        }
        field(16; "Body Handling The Complaint"; Code[100])
        {
            TableRelation = "HR Committees".Code;

            trigger OnValidate()
            begin
                HRCommittees.Reset;
                HRCommittees.SetRange(HRCommittees.Code, "Body Handling The Complaint");
                if HRCommittees.Find('-') then
                    "Body Name" := HRCommittees.Description;
            end;
        }
        field(17; Recomendations; Code[10])
        {
        }
        field(23; "No. Series"; Code[20])
        {
        }
        field(24; "Accused Employee"; Code[30])
        {
            TableRelation = IF ("Accused Type" = CONST(Member)) Members."No."
            ELSE
            IF ("Accused Type" = CONST(Supplier)) Vendor."No."
            ELSE
            IF ("Accused Type" = CONST(Tenant)) Customer."No."
            ELSE
            IF ("Accused Type" = CONST(Staff)) "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Accused Employee");
                if Emp.Find('-') then
                    "Accused Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                Cust.Reset;
                Cust.SetRange(Cust."No.", "Accused Employee");
                if Cust.Find('-') then
                    "Accused Name" := Cust.Name;


                Vend.Reset;
                Vend.SetRange(Vend."No.", "Accused Employee");
                if Vend.Find('-') then
                    "Accused Name" := Vend.Name;


                Memb.Reset;
                Memb.SetRange(Memb."No.", "Accused Employee");
                if Memb.Find('-') then
                    "Accused Name" := Memb.Name;
            end;
        }
        field(28; "Policy Description"; Text[50])
        {
        }
        field(29; "Taken Action Description"; Text[50])
        {
        }
        field(3963; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility CenterBR".Code;
        }
        field(3964; "Reporter Name"; Text[40])
        {
            Editable = false;
        }
        field(3965; "Witness #1 Name"; Text[50])
        {
        }
        field(3966; "Witness #2  Name"; Text[50])
        {
        }
        field(3968; "Legal Type"; Option)
        {
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(3969; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(3970; "Accused Name"; Text[100])
        {
            Editable = false;
        }
        field(3971; "Type of Court"; Option)
        {
            OptionMembers = "High Court","Tribunal","Employment Court";
        }
        field(50003; "Action Duration Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "Case Duration" := "Action Duration End  Date" - "Action Duration Start Date";
            end;
        }
        field(50004; "Action Duration End  Date"; Date)
        {

            trigger OnValidate()
            begin
                "Case Duration" := "Action Duration End  Date" - "Action Duration Start Date";
            end;
        }
        field(50005; Status; Enum "Workflow Status Main Flags")
        {
            // Editable = true;
            // OptionCaption = 'Open,"Pending Approval",Approved,Rejected,Closed';
            // OptionMembers = Open,"Pending Approval",Approved,Rejected,Closed;
        }
        field(50006; "Plaintiff Type"; Option)
        {
            OptionMembers = " ",Member,Supplier,Tenant,Staff,Others;
        }
        field(50007; Plaintiff; Code[20])
        {
            TableRelation = IF ("Plaintiff Type" = CONST(Member)) Members."No."
            ELSE
            IF ("Plaintiff Type" = CONST(Supplier)) Vendor."No."
            ELSE
            IF ("Plaintiff Type" = CONST(Tenant)) Customer."No."
            ELSE
            IF ("Plaintiff Type" = CONST(Staff)) "HR Employees"."No.";

            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", Plaintiff);
                if Emp.Find('-') then
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                Cust.Reset;
                Cust.SetRange(Cust."No.", Plaintiff);
                if Cust.Find('-') then
                    Name := Cust.Name;


                Vend.Reset;
                Vend.SetRange(Vend."No.", Plaintiff);
                if Vend.Find('-') then
                    Name := Vend.Name;


                Memb.Reset;
                Memb.SetRange(Memb."No.", Plaintiff);
                if Memb.Find('-') then
                    Name := Memb.Name;
            end;
        }
        field(50008; Name; Text[100])
        {
            Editable = false;
        }
        field(50009; "Accused Type"; Option)
        {
            OptionMembers = " ",Member,Supplier,Tenant,Staff;
        }
        field(50010; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("Case Cost List".Cost WHERE(Code = FIELD("Case Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Case Status"; Option)
        {
            OptionMembers = Open,Ongoing,ADR,Closed,Appealed;
        }
        field(50012; Appealed; Boolean)
        {
            trigger OnValidate()
            begin
                Legal.RESET;
                if Legal."Old Case Number" <> '' then
                    Appealed := true;
            end;
        }
        // field(50013; "Case Verdict"; Text[250])
        // {
        // }
        field(50014; "Reporter Type"; Option)
        {
            OptionMembers = " ",Member,Supplier,Tenant,Staff;
        }
        field(50015; "Body Name"; Text[100])
        {
            Editable = false;
        }
        field(50016; "Case Duration"; Integer)
        {

            trigger OnValidate()
            begin
                "Case Duration" := "Action Duration End  Date" - "Action Duration Start Date";
            end;
        }
        field(50017; "Matter Code"; Code[20])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Matter Code"));
            trigger OnValidate()
            begin
                Casetype.Reset;
                Casetype.SetRange(Casetype.Code, "Matter Code");
                if Casetype.Find('-') then
                    "Case Description" := Casetype.Description;
            end;
        }
        field(50018; "Case Description"; Text[100])
        {
        }
        field(50019; Others; Text[100])
        {
        }
        field(50020; "Pleadings in Summary"; Text[2024]) { }
        field(50021; "Legal Fees"; Decimal) { }
        field(50022; "Contigent Liabilities"; Text[250]) { }
        field(50023; "Law Firm"; Text[50])
        {
            TableRelation = IF ("Case Category" = const(Internal)) "HR Employees"."No."
            ELSE
            IF ("Case Category" = CONST(External)) Vendor."No.";
            trigger OnValidate()
            begin
                Emp.Reset;
                Emp.SetRange(Emp."No.", "Law Firm");
                if Emp.Find('-') then
                    "Lawyer" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                Vend.Reset;
                Vend.SetRange(Vend."No.", "Law Firm");
                if Vend.Find('-') then
                    "Lawyer" := Vend.Name;
                "Advocate E-Mail" := Vend."E-Mail";

            end;
            // TableRelation = Vendor."No.";
            // trigger OnValidate()
            // begin
            //     Vend.Reset;
            //     Vend.SetRange(Vend."No.", "Law Firm");
            //     if Vend.Find('-') then
            //         "Lawyer" := Vend.Name;
            // end;
        }
        field(50033; Address; Text[250]) { }
        field(50034; City; Text[30]) { }
        field(50024; "Lawyer"; Text[50]) { }
        field(50025; "Case Summary"; Text[2048]) { }
        field(50026; "Created at"; DateTime) { }
        field(50027; "Created By"; Code[50]) { }
        field(50028; "Name of Case"; Text[100]) { }
        field(50029; "ADR"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Type of ADR" := ' ';
            end;
        }
        field(50030; "Old No."; Code[50])
        {
        }
        field(50031; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50032; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50036; "Old Case Number"; Code[20])
        {
        }
        field(50035; "Summary of advisory"; Text[2048])
        {
        }
        field(50037; "Case Category"; Option)
        {
            OptionMembers = External,Internal;
        }
        field(50038; Advisory; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Summary of advisory" := ' ';
            end;

        }
        field(500038; "Type of ADR"; CODE[20])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Type of ADR"));
            trigger OnValidate()
            begin
                Casetype.Reset;
                Casetype.SetRange(Casetype.Code, "Type of ADR");
                if Casetype.Find('-') then
                    "Type of ADR" := Casetype.Description;
            end;
        }
        field(500039; "Predicted Outcome"; Option)
        {
            OptionMembers = " ","Win","Loss";
        }
        field(500040; "Case Outcome"; Option)
        {
            OptionMembers = " ","Win","Loss";
        }
        field(500041; "Budgeted Amount"; Decimal)
        {
        }
        field(500042; Signatory; Option)
        {
            OptionCaption = 'Company Secretary, C.E.O, Legal Manager';
            OptionMembers = "Company Secretary","C.E.O","Legal Manager";
        }
        field(500043; "Advocate E-Mail"; Code[50])
        {
        }
        field(500044; "Law Firm E-Mail Sent"; Boolean)
        {
        }
        field(50045; "Fees Saved"; Decimal)
        {
            
        }
    }

    keys
    {
        Key(PK; "No.")
        {
            Clustered = true;
        }
        // key(Key1; "Case Number")
        // {
        // }
    }

    fieldgroups
    {
        fieldgroup(Dropdown; "No.", "Case Number", "Case Description", "Name of Case")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            MembNoSeries.Get;
            NoSeriesMgt.TestManual(MembNoSeries."Case Nos.");
            // NoSeriesMgt.InitSeries(MembNoSeries."Case Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            // GenLedgerSetup.Get;
            // NoSeriesMgt.InitSeries(GenLedgerSetup."Case Number", xRec."No. Series", 0D, "Case Number", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;
        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;

    end;

    var
        Emp: Record "HR Employees";
        GenLedgerSetup: Record "Cash Office Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Vend: Record Vendor;
        Cust: Record Customer;
        Memb: Record Members;
        Witn: Record Witnesses;
        HRCommittees: Record "HR Committees";
        Casetype: Record "Segment/County/Dividend/Signat";
        MembNoSeries: Record "Credit Nos. Series";
        Legal: Record Legal;
        UserSetup: Record "User Setup";
}

