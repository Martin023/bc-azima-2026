table 52187079 "Staff Welfare"
{
    Caption = 'Staff Welfare';
    DataClassification = ToBeClassified;
    DrillDownPageId="Staff Welfare ";
    LookupPageId="Staff Welfare ";

    fields
    {
        field(1; No; Code[40])
        {
            Caption = 'No';
            Editable=False;
            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HrSetup.Get();
                    NoSeriesMgt.TestManual(HrSetup."Welfare No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employee Code"; Code[40])
        { }
        field(4; "Payroll No"; Code[40])
        {
            TableRelation = "HR Employees"."No." WHERE(Status = filter(Active));
            Caption = 'Employee Code';
            trigger OnValidate()
            begin
                Employee.reset();
                Employee.setrange("No.", rec."Payroll No");
                if employee.Find('-') then begin
                    "Employee Name" := Employee.FullName;
                    "Pin No" := Employee."PIN No.";

                end;
            end;

        }
        field(10; "No. Series"; Code[40])
        {

        }
        field(3; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            editable = false;
        }

        field(5; "Pin No"; Code[40])
        {
            Caption = 'Pin No';
            editable = false;
        }

        field(6; Beneficiary; code[40])
        {
            TableRelation = "HR Employee Kin" where("Employee Code"=field("Payroll No"));
            Caption = 'Beneficiary';
            trigger OnValidate()
            begin
                Employee.reset();
                Employee.SetRange("No.", "Payroll No");
                if Employee.find('-') then begin
                    Beneficiary.reset();
                    Beneficiary.SetRange("Employee Code","Payroll No");
                    if beneficiary.find('-')then begin
                        Relationship := Beneficiary.Relationship;
                         RelationshipTypes.reset();
                         RelationshipTypes.setrange(relation,Relationship);
                         if RelationshipTypes.Find('-') then begin
                             "Claim Amount" := RelationshipTypes."Welfare Claim Amount";
                         end;
                    end;
                end
            end;
              


        }
        field(7; Relationship; code[40])
        {
            Caption = 'Relationship';
            Editable = false;
        }
        field(8; "Claim reason"; Option)
         
        {
            Caption = 'Claim reason';
            OptionMembers=Medical,Death,"Child Birth";
            OptionCaption='Medical,Death,Child Birth';
        }

        field(9; "Date"; Date)
        {
            Caption = 'Date';
            Editable = False;
        }
        field(11; "Entered By"; Text[20])
        {
            Caption = 'Date';
        }
        field(12; "Claim Amount"; decimal)
        {
        Editable=false;
        }
        field(13; "Status"; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Deferred;
            Editable = False;
        }
        field(14; "Member No"; code[40])
        {
            TableRelation = Members."No." where("Payroll/Staff No." = field("Payroll No"));
            trigger OnValidate()

            begin
                Member.reset();
                Member.SetRange("No.", "Member No");
                if Member.find('-') then begin
                    "Member No" := member."No.";
                end;


            end;
        }
        field(15;Comments;Text[100])
        {

        }
        field(16;Posted;boolean)
        {
            
        }
        

    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            HrSetup.Get();
            HrSetup.TestField(HrSetup."Welfare No");
            No := NoSeriesMgt.GetNextNo(HrSetup."Welfare No");
            // NoSeriesMgt.InitSeries(HrSetup."Welfare No", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Entered By" := UpperCase(UserId);
        Date := Today;

    end;

    var
        HrSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Employee: record "HR Employees";
        Beneficiary: record  "HR Employee Kin";
        Member: Record Members;
        RelationshipTypes: Record "Relationship Types";
}
