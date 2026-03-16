table 52187063 "Office Keys"
{
    Caption = 'Office Keys';
    DataClassification = ToBeClassified;
    //LookupPageId = "Key Dispatch List";
    //drilldownpageid = "Key Dispatch List";

    fields
    {
        field(1; "No."; CODE[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Keys Dispatch Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(11;"Key Request No.";Code[50])
        {
            Caption = 'Key Request No.';
            TableRelation = "Key Request Table"."No." WHERE (Status = CONST(Approved), "Key Status" = CONST (Open));
            trigger OnValidate()
            begin

                if KeyRequest.GET("Key Request No.") then
                //if KeyRequest."Key No." <> '' then
                    begin 
                        begin
                        "Staff Number" := KeyRequest."Staff Number";
                         Name := KeyRequest.Name;
                         "Purpose of Key Request" := KeyRequest."Purpose of Request";
                         "Key Request Date" := KeyRequest."Date of Request";
                         "Key Number" := KeyRequest."Key No.";
                         "Key Room Name" := KeyRequest."Key Room Name";
                         "Department" := KeyRequest."Department Name";
                         //"Originating Branch" := KeyRequest."Originating Branch";
                         //"Key Request Date" := KeyRequest."Created at";
                        end

                    end;
            end;
        }
        field(2; "Staff Number"; Code[20])
        {
            Caption = 'Staff Number';
        }
        field(3; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        // field(4; "Second Name"; Text[20])
        // {
        //     Caption = 'Second Name';
        // }
        // field(5; "Last Name"; Text[20])
        // {
        //     Caption = 'Last Name';
        // }
        field(6; "Purpose of Key Request"; Text[100])
        {
            Caption = 'Purpose of Key Request';
        }
        field(7; "Proof of Sign-Off"; Blob)
        {
            Caption = 'Proof of Sign-Off';
            Subtype = Bitmap;
        }
        field(8; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            // trigger OnValidate()
            // begin
            //     if "No. Series" <> xRec."No. Series" then begin
            //         SeriesSetup.Get;
            //         NoSeriesMgt.TestManual(SeriesSetup."Office Keys Nos.");
            //         "No." := '';
            //     end;
            // end;
        }
        field(9; Dispatched; Boolean)
        {
            Caption = 'Dispatched';
        }
        field(10; "Key Dispatch Date"; DateTime)
        {
            Caption = 'Dispatch Date';
        }
        field(12; "Dispatched By"; Code[20])
        {
            Caption = 'Dispatched By';
        }
        field(13; "Dispatched To"; Code[20])
        {
            Caption = 'Dispatched To';
        }
        field(14; "Key Request Date"; Date)
        {
            Caption = 'Key Request Date';
        }
        field(15; "Received"; Boolean)
        {
            Caption = 'Received';
        }
        field(16; "Returned"; Boolean)
        {
            Caption = 'Returned';
        }  
        field(17; "Key Number"; Code[20])
        {
            Caption = 'Key Number';
        }
        field(18; "Key Room Name"; Code[20])
        {
            Caption = 'Key Room Name';
        }
        field(19; "Key Status"; Option)
        {
            Caption = 'Key Status';
            OptionMembers = Open, Dispatched, Received, Returned;
        }
        field(21; "Created by"; Code[50])
        {
            Caption = 'Created by';
        }
        field(22; "Created at"; DateTime)
        {
            Caption = 'Created at';
        }
        field(23; "Originating Branch"; Code[20])
        {
            Caption = 'Originating Brach';
        }
        field(24; "Department"; Code[20])
        {
            Caption = 'Originating Department';
        }
        field(25; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(26; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(27; "Dispatched at"; DateTime)
        {
            Caption = 'Dispatched at';
        }
        field(28; "Received by"; Code[50])
        {
            Caption = 'Dispatched by';
        }
        field(29; "Received at"; DateTime)
        {
            Caption = 'Received at';
        }
        field(30; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility CenterBR".Code;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

    }
    Trigger OnInsert()
    var
        SeriesSetup: Record "Credit Nos. Series";
    //NoSeriesMgt: Codeunit NoSeriesManagement;
    begin

        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Keys Dispatch Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Keys Dispatch Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Keys Dispatch Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;
        Rec."Dispatched at" := CURRENTDATETIME;
        Rec."Dispatched By" := UserId;
        Rec."Received at" := CURRENTDATETIME;
        Rec."Received by" := UserId;

            if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        seriessetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        KeyRequest: Record "Key Request Table";
        UserSetup: Record "User Setup";
}
