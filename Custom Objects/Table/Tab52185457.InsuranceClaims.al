table 52185457 "Insurance Claims"
{
    Caption = 'Insurance Claims';
    DataClassification = ToBeClassified;
    LookupPageId = "Insurance Claims - List";
    DrillDownPageId = "Insurance Claims - List";

    fields
    {
        field(1; "Claim No."; Code[20])
        {
            Caption = 'Claim No.';
        }
        field(2; "Asset No."; Code[20])
        {
            Caption = 'Asset No.';
            TableRelation = "Fixed Asset";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FA.RESET;
                if FA.GET("Asset No.") then begin
                    if FA."Status" = FA."Status"::"Disposed" then begin
                        ERROR('Asset is Disposed');
                    end
                    else begin
                        Rec."Asset Description" := FA.Description;
                    end;
                end;

            end;
        }
        field(3; "Asset Description"; Text[100])
        {
            Caption = 'Asset Description';
        }
        field(4; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(5; "Responsibility Centre"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility Center";
        }
        field(6; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin

            end;
        }
        field(7; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin

            end;
        }
        field(8; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(9; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
        }
        field(10; "User ID"; Code[200])
        {
            Caption = 'User ID';
        }
        field(11; "No. Series"; Code[200])
        {
            Caption = 'No Series';
        }
        field(12; "Date of Incident"; Date)
        {
            Caption = 'Date of Incident';
        }
        field(13; "Date of Claim"; Date)
        {
            Caption = 'Date of Claim';
        }
        field(14; "Date of Reporting"; Date)
        {
            Caption = 'Date of Reporting';
        }
        field(15; "Date of Closure"; Date)
        {
            Caption = 'Date of Closing the Claim';
        }
        field(16; "Staff Responsible PF. No."; Code[200])
        {
            Caption = 'Staff PF. No.';
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Employees.RESET;
                Employees.Setrange("No.", Rec."Staff Responsible PF. No.");
                //Employees.GET("Staff Responsible PF. No.");
                if Employees.Find('-') then
                    Rec."Staff Responsible Name" := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name";
                ;
            end;
        }
        field(18; "Staff Responsible Name"; Code[200])
        {
            Caption = 'Staff Responsible';
        }
        field(19; "Policy Amount"; Decimal)
        {
            Caption = 'Policy Amount';
        }
        field(20; "Nature of the Claim"; Text[2000])
        {
            Caption = 'Nature of the Claim';
        }
        field(21; "Insurance No."; Code[100])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance."No." where("Fixed Asset No." = FIELD("Asset No."));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Rec."Policy No." := '';
                Rec."Policy Amount" := 0;
                Rec."Insurance Cover" := '';

                Insurance.RESET;
                Insurance.Setrange(Insurance."No.", "Insurance No.");
                if Insurance.Find('-') then begin
                    Rec."Policy No." := Insurance."Policy No.";
                    Rec."Policy Amount" := Insurance."Policy Coverage";
                    Rec."Insurance Cover" := Insurance."Insurance Cover";
                end;
            end;
        }
        field(22; "Policy No."; Code[100])
        {
            Caption = 'Policy No.';
        }
        field(23; "Amount in Claims"; Decimal)
        {
            Caption = 'Amount in Claims';
        }
        field(24; "Amount in Compensation"; Decimal)
        {
            Caption = 'Amount in Compensation';
        }
        field(25; "Closed By"; Code[200])
        {
            Caption = 'Closed By';
        }
        field(26; "Closed"; Boolean)
        {
            Caption = 'Closed';
        }
        field(27; "Insurance Claims"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Single Asset","Multiple Assets", "Non Assets";
        }
        field(28; "Insurance Cover"; Text[2000])
        {
            Caption = 'Insurance Cover';
        }
    }
    keys
    {
        key(PK; "Claim No.")
        {
            Clustered = true;
        }
    }
    Trigger OnInsert()
    var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";

    begin
        if "Claim No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Insurance Claim No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Insurance Claim No.", xRec."No. Series", 0D, "Claim No.", "No. Series");
        end;
        Rec."Created Date" := CURRENTDATETIME;
        Rec."Created By" := UserId;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Centre" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FA: Record "Fixed Asset";
        Employees: Record "HR Employees";
        Insurance: Record "Insurance";
        VisibleSingleAsset: Boolean;
        VisibleCollectiveAsset: Boolean;
}
