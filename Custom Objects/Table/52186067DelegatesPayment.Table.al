table 52186067 "Delegates Payment"
{
    DrillDownPageID = "Delegates Payment List";
    LookupPageID = "Delegates Payment List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; "Minute No."; Code[30])
        {
            Caption = 'Meeting No';
            TableRelation = "Delegates Minutes Header".Code where("Meeting Paid" = const(false), Status = const(Approved));
            trigger OnValidate()
            var
            begin
                if Code = '' then begin
                    MembNoSeries.Get;
                    MembNoSeries.TestField(MembNoSeries."Delegate Payment Nos.");
                    NoSeriesMgt.InitSeries(MembNoSeries."Delegate Payment Nos.", xRec."No. Series", 0D, Code, "No. Series");
                    "Created By" := UserId;
                    "Creation Date" := Today;
                end;

                DelegatesPayments.Reset();
                DelegatesPayments.SetRange("Minute No.", Rec."Minute No.");
                DelegatesPayments.SetFilter(Code, '<>%1', Rec.Code);
                DelegatesPayments.SetFilter(Status, '%1|%2|%3', Status::Open, Status::Pending, Status::Approved);
                if DelegatesPayments.FindFirst() then
                    if not Confirm('Meeting code also in header no %1 Do you wish to continue?', false, DelegatesPayments.Code) then
                        Error('Meeting code cannot be used in more than one payment header');

                MinutesHeader.Get("Minute No.");
                "Electoral Zone" := MinutesHeader."Electoral Region";
                CalcFields("Electoral Zone Name");
                if ElectrolZones.Get("Electoral Zone") then
                    County := ElectrolZones.County;
                "Sub-County" := ElectrolZones."Sub County Name";
                CalcFields("County Name", "Sub-County Name");
                "Payment Narration" := Format(MinutesHeader."Electoral Name") + ' ' + Format(MinutesHeader.Quarter) + ' ' + Format(MinutesHeader.Year);

                GenerateDelegatePaymentLines(Code, "Minute No.");
            end;
        }

        field(3; "Electoral Zone"; Code[50])
        {
            Editable = false;
        }
        field(4; "Electoral Zone Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Electoral Zones"."Electoral Zone Name" where(Code = field("Electoral Zone")));
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(7; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(8; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(9; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(10; County; Code[50])
        {
            Editable = false;
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));
        }
        field(11; "Sub-County"; Code[50])
        {
            Editable = false;
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Sub-County"));
        }
        field(12; "County Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Segment/County/Dividend/Signat".Description where(Code = field(County)));
        }
        field(13; "Sub-County Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Segment/County/Dividend/Signat".Description where(Code = field("Sub-County")));
        }
        field(14; Status; Enum "Workflow Status Main Flags")
        {
            Editable = false;
            trigger OnValidate()
            var
                Comments: Record Comments;
            begin
                //if (xRec.Status = Status::Pending) and (Rec.Status = Status::Approved) then
                if Rec.Status = Status::Approved then begin
                    Comments.Reset();
                    Comments.SetRange("Commented By", UserId);
                    Comments.SetRange("Viewd By Somebody Else", false);
                    Comments.SetRange("Header No.", code);
                    if not Comments.FindFirst() then
                        Error('Please reopen the document add an approval comment before performing this action');
                    Rec."Approved By" := UserId;
                end;
            end;
        }
        field(15; Posted; Boolean)
        {
            Editable = false;
        }
        field(16; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(17; "Posted By"; Code[50])
        {
            Editable = false;
        }

        field(18; "Total Payment"; Decimal)
        {
            CalcFormula = Sum("Delegate Payment Line"."Amount Payable" WHERE(Code = FIELD(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = FILTER("Delegates Payment" | "Delegates Special"));
        }
        field(20; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(21; "Document Date"; Date)
        {
        }
        field(22; "Approved By"; CODE[50])
        {
            Editable = false;
        }
        field(23; "Payment Narration"; text[250])
        {
        }

    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            MembNoSeries.Get;
            MembNoSeries.TestField(MembNoSeries."Delegate Payment Nos.");
            NoSeriesMgt.InitSeries(MembNoSeries."Delegate Payment Nos.", xRec."No. Series", 0D, Code, "No. Series");
            "Created By" := UserId;
            "Creation Date" := Today;
            "Document Date" := Today;
            UserSetUp.Reset();
            UserSetUp.SetRange("User ID", UserId);
            if UserSetUp.FindFirst() then begin
                "Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
                "Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
                if "Global Dimension 1 Code" = '' then Error('Please set up Global Dimension 1 Code in user setup');
                if "Global Dimension 2 Code" = '' then Error('Please set up Global Dimension 2 Code in user setup');
            end else
                Error('You are not set up in user setup');
        end;
    end;

    procedure GenerateDelegatePaymentLines(PaymentHeader: Code[50]; MeetingCode: Code[50])
    var
        MinutesHeader: Record "Delegates Minutes Header";
        MeetingAttendees: Record "Delegates Meeting Attendees";
        PaymentLine: Record "Delegate Payment Line";
        MeetingTypes: Record "Meeting Types";
        Allowances: Record "Allowed Allowances";
        TransactionCharges: Record "Transaction Charges";
        WithHoldingTax: Decimal;
        GlobalFunctions: Codeunit "Global Functions";
        ChargeAmount: Decimal;
        ChargeGL: Code[50];
        ExciseDuty: Decimal;
        ExciseGL: Code[50];
    begin
        PaymentLine.Reset();
        PaymentLine.SetRange(Code, PaymentHeader);
        if PaymentLine.Findfirst() then PaymentLine.DeleteAll();

        MinutesHeader.Get(MeetingCode);

        MeetingAttendees.Reset();
        MeetingAttendees.SetRange("Header No", MinutesHeader.Code);
        if MeetingAttendees.Findfirst() then begin
            repeat
                MeetingTypes.Get(MinutesHeader."Meeting Type");

                Allowances.Reset();
                Allowances.SetRange("Meeting Type Code", MeetingTypes.Code);
                Allowances.SetRange(Position, MeetingAttendees."Delegate Position");
                if Allowances.Find('-') then begin
                    repeat
                        Allowances.CalcFields("Charge Code", "G/L Account");

                        PaymentLine.Init();
                        PaymentLine.Code := PaymentHeader;
                        PaymentLine."Delegate MNO." := MeetingAttendees."Delegate No.";
                        PaymentLine.CalcFields("Delegate Name", Position);
                        PaymentLine."Electoral Zone" := MinutesHeader."Electoral Region";
                        PaymentLine.CalcFields("Electoral Zone Name");
                        PaymentLine."Allowance Code" := Allowances."Allowance Code";
                        PaymentLine."No. of Meetings" := 1;
                        PaymentLine.Amount := Allowances.Amount;
                        PaymentLine."Allowances G/L" := Allowances."G/L Account";
                        PaymentLine."Original Amount" := Allowances.Amount;
                        TransactionCharges.Reset();
                        TransactionCharges.SetRange("Transaction Type", Allowances."Charge Code");
                        if TransactionCharges.Findfirst() then begin
                            repeat
                                ChargeAmount := 0;
                                ChargeGL := '';
                                ExciseDuty := 0;
                                ExciseGL := '';
                                GlobalFunctions.GetTransactionCharge(Allowances.Amount, Allowances."Charge Code", TransactionCharges.Description, ChargeAmount,
                                                                    ChargeGL, ExciseDuty, ExciseGL);
                                if TransactionCharges."Withholding Tax" then
                                    PaymentLine."Withholding Tax" := ChargeAmount
                                else begin
                                    PaymentLine."Processing Fee" := ChargeAmount;
                                    PaymentLine."Excise Duty" := ExciseDuty;
                                end;
                                PaymentLine."Withholding G\L Acc" := ChargeGL;
                            until TransactionCharges.Next() = 0;
                        end;
                        PaymentLine."Line Amount" := PaymentLine.Amount;
                        PaymentLine."Amount Payable" := PaymentLine.Amount - (PaymentLine."Excise Duty" + PaymentLine."Withholding Tax" + PaymentLine."Processing Fee");
                        PaymentLine.Insert();
                    until Allowances.Next() = 0;
                end;
            until MeetingAttendees.Next() = 0;
        end;
    end;

    var
        ElectrolZones: Record "Electoral Zones";
        MembNoSeries: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        DelegateGroupss: Record "Delegate Region";
        DelegateMemberss: Record "Delegate Members";
        DelegatePaymentLine: Record "Delegate Payment Line";
        DelegatePaymentLines: Record "Delegate Payment Line";
        MyRec2: Record "Delegate Payment Line";
        LineNo: Integer;
        DelegateGroups: Record "Delegate Region";
        DelegatesPayments: Record "Delegates Payment";
        DelegateGroup: Record "Delegate Region";
        MinutesHeader: Record "Delegates Minutes Header";
        UserSetUp: Record "User Setup";
}

