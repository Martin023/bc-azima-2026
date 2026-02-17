table 52187022 "DMU Case Forwarding"
{
    Caption = 'DMU Case Forwarding';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            Editable = false;
        }

        field(4; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(5; "Open Issues"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("DMU Case Forwarding Lines" where("Header No." = field("No."), Closed = const(false)));
        }
        field(6; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(7; "Current Departmrnt"; Code[50])
        {
            Editable = false;
        }
        field(8; "Originating Status"; Option)
        {
            Editable = false;
            OptionMembers = New,Sent,Returned,"Sent & Ongoing Action","Sent & Actioned";
        }
        field(9; "Recepient Status"; Option)
        {
            Editable = false;
            OptionMembers = New,Returned,Forwarded,"Received & Ongoing Action","Received & Actioned";
        }
        field(10; "Viewed By Recepient"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("CF Tracker"."Viewed By Recepient" where("Header No." = field("No."), "Current Department" = const(true)));
        }
        field(11; "Case Closed"; Boolean)
        {

        }
        field(12; "Total Issues"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("DMU Case Forwarding Lines" where("Header No." = field("No.")));
        }
        field(24; "Employer Code"; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if xRec."Employer Code" <> '' then begin
                    DMUCFLines.Reset();
                    DMUCFLines.SetRange("Header No.", "No.");
                    if DMUCFLines.Find('-') then begin
                        if Confirm('Changing the employer code will clear the lines, do you wish to continue?') then begin
                            ClearLines();
                        end else begin
                            "Employer Code" := xRec."Employer Code";
                        end;
                    end;
                end;
            end;
        }
        field(25; Period; date)
        {
            TableRelation = "Interest Due Period"."Interest Due Date";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if xRec.Period <> 0D then begin
                    DMUCFLines.Reset();
                    DMUCFLines.SetRange("Header No.", "No.");
                    if DMUCFLines.Find('-') then begin
                        if Confirm('Changing the period will clear the lines, do you wish to continue?') then begin
                            ClearLines();
                        end else begin
                            Period := xRec.Period;
                        end;
                    end;
                end;
                CalcFields("Period Name");
            end;
        }
        field(26; "Period Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Interest Due Period".Name where("Interest Due Date" = field(Period)));
        }
        field(27; "Case Intructions"; Option)
        {
            OptionMembers = " ","Fall Off","Reversals","Others";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if xRec."Case Intructions" <> "Case Intructions"::" " then begin
                    DMUCFLines.Reset();
                    DMUCFLines.SetRange("Header No.", "No.");
                    if DMUCFLines.Find('-') then begin
                        if Confirm('Changing Case Intructions will clear the lines, do you wish to continue?') then begin
                            Period := 0D;
                            "Employer Code" := '';
                            ClearLines();
                        end else begin
                            "Case Intructions" := xRec."Case Intructions";
                        end;
                    end;
                end;
                CalcFields("Period Name");
                if Rec."Case Intructions" = Rec."Case Intructions"::Reversals then begin
                    Rec."Employer Code" := '';
                    Period := 0D;
                    CalcFields("Period Name");
                end;
            end;
        }
        field(28; "Case Closed By"; Code[50])
        {
            Editable = false;
        }
        field(29; "Case Closed At"; DateTime)
        {
            Editable = false;
        }
        field(30; "Sent At"; DateTime)
        {

        }
        field(31; "Description"; Text[1000])
        {

        }
        field(32;"Fall Off Has Run"; Boolean)
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
        CreditNosSeries: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            CreditNosSeries.Get;
            CreditNosSeries.TestField(CreditNosSeries."DMU Case Forwarding");
            "No." := NoSeriesMgt.GetNextNo(CreditNosSeries."DMU Case Forwarding");
            // NoSeriesMgt.InitSeries(CreditNosSeries."DMU Case Forwarding", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Departmrnt" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end else
            Error('You must be set up in user setup');
    end;

    procedure ClearLines()
    begin
        DMUCFLines.Reset();
        DMUCFLines.SetRange("Header No.", "No.");
        if DMUCFLines.Find('-') then DMUCFLines.DeleteAll();
    end;

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        Text001: Label 'You cannot use system table %1 in the package.';
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SystemEditsCodeunit: Codeunit "System Editss";
        CreditNoSeries: Record "Credit Nos. Series";
        CFPage: Page "DMU CF Page";
        DMUCFLines: Record "DMU Case Forwarding Lines";
}
