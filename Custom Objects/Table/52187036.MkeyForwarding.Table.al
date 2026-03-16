table 52187036 "MKey Forwarding"
{
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
        field(3; Instructions; Text[1000])
        {

        }

        field(4; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(5; "Sent Date"; date)
        {

        }
        field(6; "Sent By"; Code[50])
        {

        }
        field(7; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(8; "Current Departmrnt"; Code[50])
        {
            Editable = false;
        }
        field(9; "Originating Status"; Option)
        {
            Editable = false;
            OptionMembers = New,Sent,Returned,"Sent & Ongoing Action","Sent & Actioned";
        }
        field(10; "Recepient Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Pending,Returned,Forwarded,Received & Ongoing Action,Received & Actioned';
            OptionMembers = New,Returned,Forwarded,"Received & Ongoing Action","Received & Actioned";
        }
        field(11; "Viewed By Recepient"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("CF Tracker"."Viewed By Recepient" where("Header No." = field("No."), "Current Department" = const(true)));
        }
        field(12; "Case Closed"; Boolean)
        {

        }
        field(13; "Total Issues"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("DMU Case Forwarding Lines" where("Header No." = field("No.")));
        }

        field(14; "Case Closed By"; Code[50])
        {
            Editable = false;
        }
        field(15; "Case Closed At"; DateTime)
        {
            Editable = false;
        }
        field(16; "Sent At"; DateTime)
        {

        }
        field(17; "CheckOff Header No."; Code[50])
        {

        }
        field(18; Status; enum "Workflow Status Main Flags")
        {
            Editable = false;

            trigger OnValidate()
            var
                Members: Record Members;
                MKeyLines: Record "MKey Lines";
                GeneralSetup: Record "General Set-Up";
            begin
                GeneralSetup.Get();
                if (Rec.Status = Rec.Status::Approved) and (GeneralSetup."AutoCompletion on approval") then begin
                    MKeyLines.Reset();
                    MKeyLines.SetRange("Header No.", Rec."No.");
                    if MKeyLines.Find('-') then begin
                        repeat
                            if Members.Get(MKeyLines."Member No. ") then begin
                                Members."Payroll/Staff No." := MKeyLines."New Payroll Number";
                                Members."Employer Code" := MKeyLines."New Employer Code";
                                Members.Modify();
                            end;
                        until MKeyLines.Next() = 0;
                    end;
                    Rec."Case Closed" := true;
                    rec."Case Closed At" := CurrentDateTime;
                    Rec."Case Closed By" := UserId;
                    Rec."Originating Status" := Rec."Originating Status"::"Sent & Actioned";
                    Rec.Modify();
                    Message('Chages Posted successfully');
                end;
            end;
        }
        field(19; "Inserted At"; DateTime)
        {

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
            CreditNosSeries.TestField(CreditNosSeries."MKey Case Forwarding");
            "No." := NoSeriesMgt.GetNextNo(CreditNosSeries."MKey Case Forwarding");
            // NoSeriesMgt.InitSeries(CreditNosSeries."MKey Case Forwarding", xRec."No. Series", 0D, "No.", "No. Series");
        end;


        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Departmrnt" := UserSetup."Responsibility Centre";
            "Originating Status" := Rec."Originating Status"::New;
            "Inserted At" := CurrentDateTime;
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
