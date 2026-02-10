tableextension 52187341 Insurance extends Insurance
{
    fields
    {
        field(50100; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";

            // trigger OnValidate()
            // begin
            //     FA.RESET;
            //     if FA.Get("No.") then
            //     //if "Vehicle No." <> '' then
            //     begin
            //         "Fixed Asset No." := FA."Asset No.";
            //         "FA Location Code" := FA."FA Location Code";
            //         "FA Subclass Code" := FA."FA Subclass Code";
            //         "FA Class Code" := FA."FA Class Code";
            //     end;
            // end;

        }
        field(50101; "Vehicle Registration No."; Code[20])
        {
            Caption = 'Vehicle Registration No.';
            DataClassification = ToBeClassified;
        }
        field(50102; "Fixed Asset No."; Code[20])
        {
            Caption = 'Fixed Asset No.';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            begin
                "FA Class Code" := '';
                "FA Subclass Code" := '';
                "FA Location Code" := '';
                Description := '';
                "Book Value" := 0;

                FA.RESET;
                FA.SetRange("No.", rec."Fixed Asset No.");
                If FA.Find('-') then begin
                    "FA Location Code" := FA."FA Location Code";
                    "FA Subclass Code" := FA."FA Subclass Code";
                    "FA Class Code" := FA."FA Class Code";
                    Description := FA.Description;
                end;
                FADepreciationBook.RESET;
                FADepreciationBook.SetRange(FADepreciationBook."FA No.", Rec."Fixed Asset No.");
                if FADepreciationBook.FindFirst() then begin
                    FADepreciationBook.CALCFIELDS(FADepreciationBook."Book Value");
                    Rec."Book Value" := FADepreciationBook."Book Value"
                end;
            end;
        }
        field(50103; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(50104; Insurer; Code[100])
        {
            Caption = 'Insurer';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            trigger OnValidate()
            begin
                if "Insurer" <> '' then begin
                    Vendor.RESET;
                    Vendor.SetRange("No.", "Insurer");
                    IF Vendor.Find('-') then begin
                        "Insurer Name" := Vendor.Name;
                    end;
                end;
            end;
        }
        field(50105; "Responsibility Centre"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
        }
        field(50106; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = ToBeClassified;
        }
        field(50107; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
        }
        field(50108; "User ID"; Code[50])
        {
        }
        field(50109; "Renewal Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ((Rec."Renewal Date" < Rec."Effective Date") AND (Rec."Renewal Date" < "Expiration Date")) then
                    Error('Renewal Date cannot be less than Insurance Start Date');

            end;
        }
        field(50110; "Insurance Cover"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Insurance Covers"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                InsuranceCover.RESET;
                InsuranceCover.SetRange(InsuranceCover."Code", "Insurance Cover");
                if InsuranceCover.Find('-') then
                    "Insurance Cover" := InsuranceCover.Description;
            end;
        }
        field(50112; "Insurer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Reminder Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Book Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Insurance Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New,Active,Expired;
        }
        field(500116; "Asset Insurance"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Single Asset","Multiple Assets","Non Assets";
        }
        modify("FA Class Code")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                FA.RESET;
                FA.Setrange("FA Class Code", Rec."FA Class Code");
                if FA.Find('-') then begin
                    repeat
                        CollectiveAssets.DeleteAll();
                        CollectiveAssets.Init();
                        CollectiveAssets."Insurance No." := Rec."No.";
                        CollectiveAssets."Asset No." := FA."No.";
                        CollectiveAssets.Description := FA.Description;
                        CollectiveAssets."FA Class Code" := FA."FA Class Code";
                        CollectiveAssets."FA Subclass Code" := FA."FA Subclass Code";
                        CollectiveAssets."FA Location Code" := FA."FA Location Code";
                        FADepBook.RESET;
                        FADepBook.SetRange("FA No.", FA."No.");
                        if FADepBook.FindFirst() then begin
                            FADepBook.CALCFIELDS(FADepBook."Book Value");
                            CollectiveAssets."Book Value" := FADepBook."Book Value";
                        end;
                    until FA.Next() = 0;
                end;
            end;
        }
    }
    trigger OnInsert()
    begin
        Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        Rec."Responsibility Centre" := UserSetup."Responsibility Centre";
        "Created By" := USERID;
        "Created Date" := CURRENTDATETIME;

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
        CompanyVehicles: Record "Company Vehicles";
        UserSetup: Record "User Setup";
        FA: Record "Fixed Asset";
        Vendor: Record Vendor;
        InsuranceCover: Record "Segment/County/Dividend/Signat";
        FADepreciationBook: Record "FA Depreciation Book";
        CollectiveAssets: Record "Collective Asset Insurance";
        FADepBook: Record "FA Depreciation Book";
}
