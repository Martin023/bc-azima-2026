#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186403 tableextension52186403 extends Customer
{
    fields
    {
        field(50000; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Travel Advance",Partner,Investment,"Staff Imprest",Others,"Training Advance",Employer,"Cashier Excess","Cashier Shortage",Tenant,"Parking Customer",SinkFund,"Conference Room Customer";
            ValuesAllowed = " ", "Staff Imprest", Employer, "Cashier Excess", "Cashier Shortage", "Training Advance";


            trigger Onvalidate()
            begin
                // if rec."Account Type" = rec."Account Type"::Employer then begin
                //     rec.TestField("Employer Code");
                //     //rec.TestField("Employer Code Name");
                // end;
            end;
        }
        field(50001; "Employee Job Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Statistics Group".Code;
        }
        field(50002; "Document Limit"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Advice Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Changes,Everything';
            OptionMembers = " ",Changes,Everything;
        }
        field(50004; "Internal Staff Employer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Member No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members."No.";
        }
        field(50006; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Approved, Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(50007; "Dont Charge Transactions"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Loan Qualification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Basic Pay,Gross Pay,Standing Order';
            OptionMembers = "Basic Pay","Gross Pay","Standing Order";
        }
        field(50009; "Old No."; Code[20])
        {
            Caption = 'Old No.';
            DataClassification = ToBeClassified;
        }
        field(50010; "Loans Cleared"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full Clearance,Leave One Intallment';
            OptionMembers = " ","Full Clearance","Leave One Intallment";
        }
        field(50011; "Employee No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No." where(Status = const(Active));

            trigger OnValidate()
            begin
                Rec.Reset;
                Rec.SetRange(Rec."Employee No.", Rec."Employee No.");
                if Rec.Find('-') then begin
                    if Rec."Employee No." <> '' then
                        Error('The Customer already exists');
                end;

                // Emp.Get(Rec."Employee No.");
                // Rec.Validate(Rec.Name,Emp."Full Name");
                //Name:=Emp."Full Name";
                Rec."Customer Posting Group" := 'IMPREST';
                Rec."Gen. Bus. Posting Group" := 'EXCEMPT';
                Rec."VAT Bus. Posting Group" := 'EXCEMPT';
                Rec."Allow Line Disc." := true;
                Rec."Account Type" := Rec."account type"::"Staff Imprest";
                Rec."Loan Qualification" := Rec."loan qualification"::"Basic Pay";
            end;
        }
        field(50012; "Self Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Non-Common Board Employer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Introduced By"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Board,Staff,Self,Member,Current Tenant,Former Tenant,Media';
            OptionMembers = Board,Staff,Self,Member,"Current Tenant","Former Tenant","Media";
        }
        field(50016; "KRA PIN"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Type of Business"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Business Types".code;
        }
        field(50018; "Primary Contact Number"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Created Date"; Date)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50020; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Rent Rate"; Option)
        {
            OptionMembers = " ","Monthly","Quarterly","Yearly";
        }
        field(50023; "Lease Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Tenant Referees"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Tenant Referees Phone"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Size in Sq. Ft."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Contact Person"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Company Profile"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Physical Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Escalation For Leases"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Escalation Frequency"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Checkoff Cuttoff Day"; Integer)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Checkoff Cuttoff Day" > 28 then Error('Checkoff cuttoff date cannot be greater than 28');
            end;
        }
        field(50033; "Lease Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(50035; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(50036; "Current Departmrnt"; Code[50])
        {
            Editable = false;
        }
        field(50037; "Last Transaction Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."), "Posting Date" = field("Date Filter")));
        }
        field(50039; "Digit Order"; Integer)
        {
            Description = 'Introduced to assist in running bulk jobs in batches';
            Editable = false;
        }
        field(50040; "Created By"; Code[100])
        {
            Editable = false;
        }
        field(50041; "Created At"; DateTime)
        {
            Editable = false;
        }
        field(50042; "Member Class Account Type"; Option)
        {
            OptionMembers = " ","Child Hope",Nominee;
        }
        field(50043; "Graduation To Class"; Code[10])
        {
            TableRelation = "Member Classes"."No.";
        }
        field(50044; "Signatory Specimen"; Blob)
        {
            Subtype = Bitmap;
        }
        field(50045; "Responsible Employee"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            // ValidateTableRelation = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                UserSetup.Reset;
                UserSetup.SetRange("User ID", Rec."Responsible Employee");
                if UserSetup.FindFirst then begin
                    Rec."Responsible Employee Name" := UserSetup."Full Name";
                    Rec."Responsible Employee Extension" := UserSetup."Employee Extension No.";
                end;
            end;
        }
        field(50046; "Responsible Employee Name"; Text[250])
        {
            Editable = false;
        }
        field(50047; "Responsible Employee Extension"; Code[50])
        {
            Editable = false;
        }
        field(50048; "No of Memmbers (Employer)"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count(Members where("Employer Code" = field("No.")));
        }
        field(50049; "No of Accounts (Employer)"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Savings Accounts" where("Employer Code" = field("No.")));
        }
        field(50050; "No of Loans (Employer)"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count("Loans" where("Employer Code" = field("No."), Posted = filter(true)));
        }
        field(50051; "Digit Custodian"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Digit Custodian" then begin
                    Rec."Responsible Employee Name" := '';
                    Rec."Responsible Employee Extension" := '';
                    rec.Modify();
                end;
            end;
        }
        field(50052; "Loan TPAY SMS Notification"; Boolean)
        {
        }
        field(50053; "Employer Code"; code[20])
        {
            TableRelation = Customer."No." where("Account Type" = filter(Employer));
        }
        field(50054; "Employer Code Name"; Text[250])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Employer Code")));
        }
        field(50056; "Retiree Employer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify("Name")
        {
            trigger OnAfterValidate()
            begin
                if (rec."No." <> '') then begin
                    Cust.Reset();
                    Cust.SetRange(Name, Rec.Name);
                    if Cust.FindFirst() then begin
                        if Cust."No." <> Rec."No." then
                            Error('%1 already exist with No. %2.', Rec.Name, Cust."No.");
                    end;
                end;
            end;
        }


    }

    trigger OnBeforeInsert()
    var
    begin

    end;


    trigger OnInsert()
    begin

        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then begin

            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Departmrnt" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end else
            Error('User must exist in user setup table');

        "Created By" := UserId;
        "Created At" := CurrentDateTime;
        "Created Date" := Today;
    end;


    var
        Emp: Record "HR Employees";
        UserSetup: Record "User Setup";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        Cust: Record Customer;
}
