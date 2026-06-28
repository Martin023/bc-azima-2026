table 52186014 "Files Table"
{
    Caption = 'File Movement Files';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Files List";
    LookupPageId = "Files List";

    fields
    {
        field(1; "No."; Code[100])
        {
            Caption = 'File No.';
            // AutoIncrement = true;
            // Editable = false;
        }
        field(2; "File Type"; Enum "File Types")
        {
            Caption = 'File Type';
            // OptionMembers = " ","Member File","Business Loans File","Policy Files","HR Files",Departmental,Other;
            // OptionCaption = ' , Member File, Business Loans File, Policy Files, HR Files, Departmental, Other';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Business Loan Types" := ' ';
                "Policy Files Types" := ' ';
                "File/Member No." := '';
                "File Name/Descrption" := '';
                "Staff PF No." := '';
                "File Custodian" := '';

                if Rec."File Type" = Rec."File Type"::"HR Files" then begin
                    HRTable.RESET;
                    HRTable.SetRange("No.", Rec."Staff PF No.");
                    if HRTable.Find('-') then begin
                        Rec."File Name/Descrption" := HRTable.FullName();
                        Rec."File/Member No." := HRTable."Member No.";
                        Rec."No." := HRTable."No." + '-HR';
                    end;

                end
            end;
        }
        field(3; "File/Member No."; Code[100])
        {
            //Caption = 'File/Member No.';
            Caption = 'Member No.';
            TableRelation = IF ("File Type" = FILTER("Member File" | "Business Loans File")) "Members"."No.";

            trigger OnValidate()
            begin
                if Members.Get("File/Member No.") then begin
                    if rec."File Type" = rec."File Type"::"Member File" then begin
                        Rec."No." := Members."No.";
                        rec."File Name/Descrption" := Members.Name;
                        Rec."Staff PF No." := Members."Payroll/Staff No.";
                        Rec."Member Name" := Members.Name;
                    end;
                    if rec."File Type" = rec."File Type"::"Business Loans File" then begin
                        Rec."No." := Members."No." + '-BSL';
                        rec."File Name/Descrption" := Members.Name;
                        Rec."Staff PF No." := Members."Payroll/Staff No.";
                        Rec."Member Name" := Members.Name;
                    end;
                end;

            end;
        }
        field(4; "File Name/Descrption"; Text[250])
        {
            Caption = 'File Name/Descrption';
        }
        field(5; "File Custodian"; Code[100])
        {
            Caption = 'File Custodian';
            TableRelation = "Responsibility CenterBR";
        }
        field(6; "File Status"; Option)
        {
            Caption = 'File Status';
            OptionMembers = "In Store","In Movement","Archived";
        }
        field(7; "File Volume No."; Code[100])
        {
            Caption = 'File Volume No.';
            TableRelation = "File Volumes"."File Volume No.";
        }
        field(8; "Entry No."; Code[100])
        {
            Caption = 'Entry No.';
            //AutoIncrement = true;
            trigger OnValidate()
            begin
                if "Entry No." <> xRec."Entry No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."File Entry No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(9; "No. Series"; Code[100])
        {
        }
        field(10; "Staff PF No."; Code[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(11; "Member Name"; Code[200])
        {
        }
        field(12; "Business Loan Types"; Option)
        {
            OptionMembers = " ",Individual,Groups;
            OptionCaption = ' , Individual, Groups';
        }
        field(13; "Policy Files Types"; Option)
        {
            OptionMembers = " ",Administrative,Finance;
            OptionCaption = ' , Administrative, Finance';
        }
        field(14; "File Sub Type"; Code[100])
        {
            TableRelation = IF ("File Type" = Const("Business Loans File")) "File Sub Types"."Business Loans"
            else IF ("File Type" = Const("Policy Files")) "File Sub Types"."Policy Files";
        }
        field(15; "Member Status"; Enum "Member Status")
        {
        }
        field(16; "ID No."; Code[100])
        {
        }
        field(17; "File Batch No."; integer)
        {
            TableRelation = "Batch No Table";
        }
        field(18; Archived; Boolean)
        {
            Caption = 'Archived';

            trigger OnValidate()
            begin
                if Archived then begin
                    rec."Archived By" := UserId;
                    rec."Date Archived" := Today;
                end;
            end;
        }
        field(19; "Date Archived"; Date)
        {
            Caption = 'Date Archived';
        }
        field(20; "Archived By"; Code[100])
        {
            Caption = 'Archived By';
            TableRelation = "User Setup"."User Id";
            editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; "No.", "File Type", "File Name/Descrption")
        {
        }
    }
    trigger OnInsert()

    Var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "Entry No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."File Entry No.");
            "Entry No." := NoSeriesMgt.GetNextNo(SeriesSetup."File Entry No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."File Entry No.", xRec."No. Series", 0D, "Entry No.", "No. Series");
        end;
    end;


    var
        Members: Record "Members";
        Loans: Record Loans;
        FileMovemementFiles: Record "Files Table";
        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        HRTable: Record "HR Employees";
}
