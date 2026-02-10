table 52186210 "AGM Delegate Payment Line"
{
    DrillDownPageID = "Delegates Payment List";
    LookupPageID = "Delegates Payment List";

    fields
    {
        field(1; "Code"; Code[50])
        {
            Description = 'Lookup to 52018556';
            TableRelation="AGM Delegates Payment".Code;
            trigger OnValidate() begin
                
            end;
        }
        field(2; "Delegate MNO."; Code[50])
        {
            Description = 'Lookup to Member table';
            TableRelation = "Delegate Members"."Delegate MNO." WHERE(Code = FIELD("Delegate Region"),
                                                                       Retired = FILTER(false));

            trigger OnValidate()
            begin
                ProdFac.Get('124');
                DelegateMemberss.Reset;
                DelegateMemberss.SetRange(Code, "Delegate Region");
                DelegateMemberss.SetRange(DelegateMemberss."Delegate MNO.", "Delegate MNO.");
                if DelegateMemberss.Find('-') then begin
                    "Delegate Name" := DelegateMemberss."Delegate Name";
                    if DelegateMemberss.Type = DelegateMemberss.Type::ADM then
                        "Delegate Code" := DelegateMemberss."Delegate Code"
                    else
                        "Delegate Code" := DelegateMemberss.Code;

                    DelegatesPayment.Reset;
                    DelegatesPayment.SetRange(DelegatesPayment.Code, Code);
                    if DelegatesPayment.Find('-') then begin
                        //MESSAGE('%1 and %2 and %3',DelegatesPayment."Payment Frequency",DelegatesPayment."Transaction Type","Delegate Code");
                        "Payment Frequency" := DelegatesPayment."Payment Frequency";
                        "Transaction Type" := DelegatesPayment."Transaction Type";
                    end;

                    EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                    SalProc.Reset;
                    SalProc.SetRange("Member No.", "Delegate MNO.");
                    SalProc.SetRange("Posting Date", EndDateSalo, Today);
                    SalProc.SetRange(Posted, true);
                    if SalProc.Find('-') then begin
                        if SalProc.Count < ProdFac."No. of Salary Times" then begin
                            Error(Text009);
                        end;
                    end;
                end;

                // if DelegateMemberss.Type = DelegateMemberss.Type::ADM then
                //     GenerateLines(DelegateMemberss."Delegate Code");
            end;
        }
        field(3; "Delegate Name"; Text[100])
        {
            Editable = false;
        }
        field(4; Position; Code[50])
        {
            Description = 'Lookup 39004358 filter type tittle';
            Editable = false;
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Position));
        }
        field(5; "Job Tittle"; Code[50])
        {
            Description = '39004358';
            Editable = false;
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
        }
        field(6; "Service Period"; Text[30])
        {
            Editable = false;
        }
        field(7; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "Tariff Code"; Code[10])
        {
            Description = '52018549';
            TableRelation = "Region Delegates Tariff".Code WHERE("Payment Frequency" = FIELD("Payment Frequency"),
                                                                  "Region Code" = FIELD("Delegate Region"),
                                                                  "Transaction Type" = FIELD("Transaction Type"));

            trigger OnValidate()
            begin

                MyCount := 1;

                DelegatePaymentLine.Reset;
                DelegatePaymentLine.SetRange(Code, Code);
                DelegatePaymentLine.SetRange(DelegatePaymentLine."Tariff Code", "Tariff Code");
                DelegatePaymentLine.SetRange(Posted, false);
                if DelegatePaymentLine.Find('-') then begin
                    repeat
                        MyCount += 1;
                    until DelegatePaymentLine.Next = 0;
                end;

                if DelegatePaymentLine."Payment Frequency" = DelegatePaymentLine."Payment Frequency"::Annual then
                    MyCount := 0;
                //MESSAGE('%1',MyCount);
                Tariffs.Reset;
                Tariffs.SetRange(Tariffs.Code, "Tariff Code");
                if Tariffs.Find('-') then begin
                    if MyCount > Tariffs."Maximum No Paid" then
                        Error('Maximum payement of %1 exceeds maximum allowable of %2', Tariffs.Description, Tariffs."Maximum No Paid");
                end;
                if DelegatesPayment.Get(Code, "Payment Frequency") then begin
                    //MESSAGE('%1',DelegatesPayment."Delegate Code");
                    DelegatesTariff.Reset;
                    DelegatesTariff.SetRange(DelegatesTariff.Code, "Tariff Code");
                    DelegatesTariff.SetRange("Region Code", "Delegate Code");
                    if DelegatesTariff.Find('-') then begin
                        if DelegatesTariff.CalculationMethod = DelegatesTariff.CalculationMethod::Milleage then begin
                            DimensionValue.Reset;
                            DimensionValue.SetRange(Code, "Electoral Zone");
                            if DimensionValue.Find('-') then begin
                                "Amount Payable" := DimensionValue."Mileage (KMs)" * DelegatesTariff."Rate Per KM";
                            end;
                        end else
                            "Amount Payable" := DelegatesTariff.Amount;
                    end;
                end;
                DelegatesPayment.Reset;
                DelegatesPayment.SetRange(Code, Code);
                if DelegatesPayment.Find('-') then begin
                    "Electoral Zone" := DelegatesPayment."Electoral Zone";
                    "Electoral Zone Name" := DelegatesPayment."Electoral Zone Name";
                end;
                DelegatePaymentLines.Reset;
                DelegatePaymentLines.SetRange(Code, Code);
                DelegatePaymentLines.SetRange("Delegate MNO.", "Delegate MNO.");
                DelegatePaymentLines.SetRange("Tariff Code", "Tariff Code");
                if DelegatePaymentLines.Find('-') then begin
                    Error('This Member has already been assigned this allowance');
                end;
            end;
        }
        field(9; "Amount Payable"; Decimal)
        {
        }
        field(10; Posted; Boolean)
        {
            Editable = false;
        }
        field(11; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(12; "Delegate Region"; Code[50])
        {
            Description = 'Lookup to 52018551';
            Editable = false;
            TableRelation = "Delegate Region".Code;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Payment Frequency"; Option)
        {
            OptionCaption = ',Weekly,Monthly,Quartely,Semi Annual,Annual';
            OptionMembers = ,Weekly,Monthly,Quartely,"Semi Annual",Annual;
        }
        field(16; "Electoral Zone"; Code[50])
        {
            Description = 'lookup Electrol Zones/Area Svr Center (52018626) (Type=FILTER(Electral Zone))';
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = FILTER("Electral Zone"));

            trigger OnValidate()
            begin
                // ElectrolZonesAreaSvrCenter.Reset;
                // ElectrolZonesAreaSvrCenter.SetRange(Code, "Electoral Zone");
                // ElectrolZonesAreaSvrCenter.SetRange(Type, ElectrolZonesAreaSvrCenter.Type::"Electral Zone");
                // if ElectrolZonesAreaSvrCenter.Find('-') then begin
                //     "Electoral Zone Name" := ElectrolZonesAreaSvrCenter.Description;
                // end;
            end;
        }
        field(17; "Electoral Zone Name"; Text[100])
        {
            Editable = false;
        }
        field(18; "Period Ending Date"; Date)
        {
            Editable = false;
        }
        field(19; "Transaction Type"; Code[20])
        {
            TableRelation = "Delegates Payment"."Transaction Type" WHERE(Code = FIELD(Code));
        }
        field(20; "Delegate Code"; Code[20])
        {
        }
        field(21; "Payment No"; Code[20])
        {
        }
         field(22; "Account No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
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
        DelegatesPayment: Record "AGM Delegates Payment";
        Tariffs: Record "Region Delegates Tariff";
        DelegatePaymentLine: Record "AGM Delegate Payment Line";
        MyCount: Integer;
        DelegatePaymentLines: Record "AGM Delegate Payment Line";
        ProdFac: Record "Product Factory";
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        Text009: Label 'Salary Must be through the SACCO.';

    }

