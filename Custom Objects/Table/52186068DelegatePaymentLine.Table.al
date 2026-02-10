table 52186068 "Delegate Payment Line"
{
    DrillDownPageId = "Delegates Payment Line List";
    LookupPageId = "Delegates Payment Line List";
    fields
    {
        field(1; "Code"; Code[50])
        {
            Description = 'Lookup to 52018556';
        }
        field(2; "Delegate MNO."; Code[50])
        {
            Description = 'Lookup to Member table';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields(Position);
            end;

        }
        field(3; "Allowance Code"; Code[50])
        {
            TableRelation = "Allowed Allowances";
        }
        field(4; "Delegate Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Delegate MNO.")));
        }
        field(5; Position; Code[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Delegate Officials".Position where("Member Number" = field("Delegate MNO.")));
        }


        field(6; "Amount Payable"; Decimal)
        {

        }

        field(7; "Electoral Zone"; Code[50])
        {

        }
        field(8; "Electoral Zone Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Electoral Zones"."Electoral Zone Name" where(Code = field("Electoral Zone")));
        }
        field(9; Amount; Decimal)
        {
            Editable = false;
            trigger
            OnValidate()
            begin
                Validate("No. of Meetings");

                Allowances.Reset();
                Allowances.SetRange("Allowance Code", Rec."Allowance Code");
                if Allowances.FindFirst() then begin
                    TransactionCharges.Reset();
                    TransactionCharges.SetRange("Transaction Type", Allowances."Charge Code");
                    if TransactionCharges.Findfirst() then begin
                        repeat
                            ChargeAmount := 0;
                            ChargeGL := '';
                            ExciseDuty := 0;
                            ExciseGL := '';
                            GlobalFunctions.GetTransactionCharge(Amount, Allowances."Charge Code", TransactionCharges.Description, ChargeAmount,
                                                                ChargeGL, ExciseDuty, ExciseGL);
                            if TransactionCharges."Withholding Tax" then
                                "Withholding Tax" := ChargeAmount
                            else begin
                                "Processing Fee" := ChargeAmount;
                                "Excise Duty" := ExciseDuty;
                            end;
                        until TransactionCharges.Next() = 0;
                    end;
                end;
                "Line Amount" := Amount;
                "Amount Payable" := Amount - ("Excise Duty" + "Withholding Tax" + "Processing Fee");

                "Withholding G\L Acc" := ChargeGL;
            end;
        }
        field(10; "Withholding Tax"; Decimal)
        {

        }
        field(11; "Processing Fee"; Decimal)
        {

        }
        field(12; "Excise Duty"; Decimal)
        {

        }
        field(14; "Line Amount"; Decimal)
        {

        }

        field(13; "No. of Meetings"; Decimal)
        {
            trigger
            OnValidate()

            begin
                Amount := "No. of Meetings" * "Original Amount";
                PaymentHeader.Get(Rec.Code);
                MeetingHeader.Get(PaymentHeader."Minute No.");


                Allowances.Reset();
                Allowances.SetRange("Meeting Type Code", MeetingHeader."Meeting Type");
                Allowances.SetRange("Allowance Code", Rec."Allowance Code");
                Allowances.SetRange(Position, Rec.Position);
                if Allowances.FindFirst() then begin
                    Allowances.CalcFields("Charge Code");
                    TransactionCharges.Reset();
                    TransactionCharges.SetRange("Transaction Type", Allowances."Charge Code");
                    if TransactionCharges.Findfirst() then begin
                        repeat
                            ChargeAmount := 0;
                            ChargeGL := '';
                            ExciseDuty := 0;
                            ExciseGL := '';
                            GlobalFunctions.GetTransactionCharge(Amount, Allowances."Charge Code", TransactionCharges.Description, ChargeAmount,
                                                                ChargeGL, ExciseDuty, ExciseGL);
                            if TransactionCharges."Withholding Tax" then
                                "Withholding Tax" := ChargeAmount
                            else begin
                                "Processing Fee" := ChargeAmount;
                                "Excise Duty" := ExciseDuty;
                            end;
                        until TransactionCharges.Next() = 0;
                    end;
                end;

                "Line Amount" := Amount;
                "Amount Payable" := Amount - ("Excise Duty" + "Withholding Tax" + "Processing Fee");

                "Withholding G\L Acc" := ChargeGL;
            end;

        }
        field(15; "Withholding G\L Acc"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(16; "Original Amount"; Decimal)
        {
            Editable = false;
        }
        field(17; "Allowances G/L"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Value ID" = CONST(1));
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Value ID" = CONST(2));
        }
        field(20; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
        }
        field(21; Committed; Boolean)
        {
            Caption = 'Committed';
        }
    }

    keys
    {
        key(Key1; "Code", "Delegate MNO.", "Allowance Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Members: Record Members;
        // DelegateMembers: Record "Delegate Members Applicationss";
        ErrPosition: Label 'You cannot have the same position of %1 within the same group';
        GeneralSetUp: Record "General Set-Up";
        ErrMemb: Label 'This member has not met minimum membership period of %1';
        DelegatesTariff: Record "Region Delegates Tariff";
        DimensionValue: Record "Electrol Zones/Area Svr Center";
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        ElectrolZonesAreaSvrCenters: Record "Electrol Zones/Area Svr Center";
        DelegateMemberss: Record "Delegate Members";
        DelegatesPayment: Record "Delegates Payment";
        Tariffs: Record "Region Delegates Tariff";
        DelegatePaymentLine: Record "Delegate Payment Line";
        MyCount: Integer;
        DelegatePaymentLines: Record "Delegate Payment Line";
        ProdFac: Record "Product Factory";
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        Text009: Label 'Salary Must be through the SACCO.';
        TransactionCharges: Record "Transaction Charges";
        MeetingNos: Record "Delegates Minutes Header";
        meetingTypes: Record "Meeting Types";
        Allowances: Record "Allowed Allowances";
        ChargeAmount: Decimal;
        ChargeGL: Code[20];
        ExciseDuty: Decimal;
        ExciseGL: Code[20];
        GlobalFunctions: Codeunit "Global Functions";
        MeetingHeader: Record "Delegates Minutes Header";
        PaymentHeader: Record "Delegates Payment";
}

