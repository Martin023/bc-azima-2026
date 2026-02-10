table 52185807 "Investment Header"
{
    DrillDownPageID = "Investment List";
    LookupPageID = "Investment List";

    fields
    {
        field(1; "Investment No"; Code[20])
        {
            //TableRelation = Customer."No.";
            Editable = false;

            trigger OnValidate()
            begin
                if "Investment No" <> xRec."Investment No" then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Investment Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Investment Type Code"; Code[50])
        {
            TableRelation = "Investment Type" WHERE(Type = FIELD("Asset Type"));

            trigger OnValidate()
            begin

                if InvestType.Get("Investment Type Code") then begin
                    "Investment Type Description" := InvestType.Description;
                    "Deposit Type" := InvestType."Deposit Type";
                    "Accrued Interest G/L Acc" := InvestType."Accrued Interest G/L Acc";
                    "Interest Income G/L Acc" := InvestType."Interest Income G/L Acc";
                    Validate("Deposit Type");
                end;
            end;
        }
        field(3; "Investment Type Description"; Text[50])
        {
            Editable = false;
        }
        field(4; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Fulfilled,Partially Lifted,Matured';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Fulfilled,"Partially Lifted",Matured;

            trigger OnValidate()
            var
                RegistrationMngt: Codeunit "Registration Process";
                GlobalFunctions: Codeunit "Global Functions";
            begin
                if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Approved) then begin
                    GlobalFunctions.CommentsManagement(Rec."Investment No");
                    Comments.Reset();
                    Comments.SetRange("Commented By", UserId);
                    Comments.SetRange("Viewd By Somebody Else", false);
                    Comments.SetRange("Header No.", rec."Investment No");
                    if not Comments.FindFirst() then
                        Error('Please add a comment before performing this action');
                end;
            end;
        }
        field(6; "No. Series"; Code[10])
        {
        }
        field(7; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(8; "Asset Type"; Option)
        {
            OptionCaption = 'Money Market,Bond';
            OptionMembers = "Money Market",Bond;
            ValuesAllowed = "Money Market", Bond;
        }
        field(9; "Total Investment"; Decimal)
        {
            CalcFormula = Sum("Investment Lines"."Investment Amount" WHERE("Investment No" = FIELD("Investment No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Transaction Date"; Date)
        {
        }
        field(11; "Compliance Checked"; Boolean)
        {
        }
        field(12; "Trade Type"; Option)
        {
            OptionCaption = ' ,Held To Maturity,Available For Sale,Trading';
            OptionMembers = " ","Held To Maturity","Available For Sale",Trading;
        }
        field(13; Institution; Code[20])
        {
            TableRelation = Customer WHERE("Account Type" = CONST(Investment));

            trigger OnValidate()
            begin
                if Customer.Get(Institution) then begin
                    Customer.CalcFields(Customer."Balance (LCY)");
                    "Institution Name" := Customer.Name;
                    "Vendor Credit Limit(LCY)" := Customer."Credit Limit (LCY)";
                    "Available Amount" := "Vendor Credit Limit(LCY)" - (Customer."Balance (LCY)");
                end;
            end;

        }
        field(14; "Institution Name"; Text[100])
        {
            Editable = false;
        }
        field(15; "Investment Date"; Date)
        {

            trigger OnValidate()
            var
                NextIntDate: Date;
                PreviousIntDate: Date;
            begin
                CompInfo.Get;

                // NonWorkingDay := CalenderMgt.CheckDateStatus(CompInfo."Base Calendar Code", "Investment Date", DateDesc);
                if NonWorkingDay = true then
                    Message('Expected payment date is falling on a non working day');
            end;
        }
        field(16; "Interest Rate"; Decimal)
        {
        }
        field(17; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(18; "Total Investment (LCY)"; Decimal)
        {
            CalcFormula = Sum("Investment Lines"."Investment Amount (LCY)" WHERE("Investment No" = FIELD("Investment No")));
            FieldClass = FlowField;
        }
        field(19; Tenor; DateFormula)
        {

            trigger OnValidate()
            begin
                "Maturity Date" := CalcDate(Tenor, "Investment Date") - 1;
                CompInfo.Get;

                "Expected Payment Date" := "Maturity Date" + 1;

                rec."No Of Days" := Abs(Rec."Investment Date" - Rec."Maturity Date") + 1;


                // NonWorkingDay := CalenderMgt.CheckDateStatus(CompInfo."Base Calendar Code", "Expected Payment Date", DateDesc);
                if NonWorkingDay = true then
                    Message('Expected payment date is falling on a non working day');
            end;
        }
        field(20; "Expected Payment Date"; Date)
        {
        }
        field(21; "Interest Mode"; Option)
        {
            OptionCaption = ' ,Arrears,Advance';
            OptionMembers = " ",Arrears,Advance;
        }
        field(22; Years; Decimal)
        {
        }
        field(23; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "Tariff Code s".Code WHERE(Type = CONST("W/Tax"));

            trigger OnValidate()
            var
                InvLines: Record "Investment Lines";
            begin
                InvLines.Reset();
                InvLines.SetRange("Investment No", rec."Investment No");
                if InvLines.FindFirst() then
                    InvLines.DeleteAll();
            end;
        }
        field(24; Remarks; Text[250])
        {
        }
        field(25; "Maturity Date"; Date)
        {
        }
        field(26; "Deposit Type"; Option)
        {
            OptionCaption = ' ,Fixed,Call,Treasury Bills,Shares,Bonds';
            OptionMembers = " ","Fixed",Call,"Treasury Bills",Shares,Bonds;

        }
        field(27; "Period Type"; Option)
        {
            OptionCaption = ' ,Days,Weeks,Months,Quaters,Years';
            OptionMembers = " ",Days,Weeks,Months,Quaters,Years;
        }
        field(28; "Frequency Period"; Integer)
        {

            trigger OnValidate()
            var
                Datefom: DateFormula;
            begin

                if "Period Type" = "Period Type"::Days then
                    Evaluate(Datefom, Format("Frequency Period") + 'D');
                if "Period Type" = "Period Type"::Weeks then
                    Evaluate(Datefom, Format("Frequency Period") + 'W');
                if "Period Type" = "Period Type"::Months then
                    Evaluate(Datefom, Format("Frequency Period") + 'M');
                if "Period Type" = "Period Type"::Quaters then
                    Evaluate(Datefom, Format("Frequency Period") + 'Q');
                if "Period Type" = "Period Type"::Years then
                    Evaluate(Datefom, Format("Frequency Period") + 'Y');

                Tenor := Datefom;
                Validate(Tenor);
            end;
        }
        field(29; "Available Amount"; Decimal)
        {
        }
        field(30; "Vendor Credit Limit(LCY)"; Decimal)
        {
        }
        field(31; "Document Date"; Date)
        {
        }
        field(32; "Date Posted"; Date)
        {
        }
        field(33; "Time Posted"; Time)
        {
        }
        field(34; "Posted By"; Code[50])
        {
        }
        field(35; Posted; Boolean)
        {
        }
        field(36; "Accrued Interest G/L Acc"; Code[50])
        {
            TableRelation = "Investment Type"."Accrued Interest G/L Acc";
        }
        field(37; "Interest Income G/L Acc"; Code[50])
        {
            TableRelation = "Investment Type"."Interest Income G/L Acc";
        }
        field(38; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(39; "No Of Days"; Integer)
        {

        }
    }

    keys
    {
        key(Key1; "Investment No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Investment No" = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Investment Nos");
            NoSeriesMgt.InitSeries(NoSetup."Investment Nos", xRec."No. Series", 0D, "Investment No", "No. Series");
        end;

        "Transaction Date" := Today;
        "Document Date" := Today;
    end;

    var
        NoSetup: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvestType: Record "Investment Type";
        Customer: Record Customer;
        CompInfo: Record "Company Information";
        CalenderMgt: Codeunit "Calendar Management";
        NonWorkingDay: Boolean;
        DateDesc: Text[30];
        paySetup: Record "Receipts and Payment Types";
        Comments: Record Comments;

    // [Scope('OnPrem')]
    procedure CreatePaymentDoc()
    var
        PaymentsHeader: Record "Payments Header";
        PaymentsLine: Record "Payment Line";
        InvestLines: Record "Investment Lines";
        PaymentHeaderNo: Code[50];
    begin
        // PaymentsHeader.Reset();
        // PaymentsHeader.SetRange("Creation Doc No.", Rec."Investment No");
        // PaymentsHeader.SetRange(Posted, false);
        // PaymentsHeader.SetRange(Cashier, UserId);
        // if PaymentsHeader.FindFirst() then begin
        //     PAGE.Run(Page::"Payment Header", PaymentsHeader);
        //     exit;
        // end;
        PaymentHeaderNo := CreatePaymentHeader();
        //Message(PaymentHeaderNo);

        InvestLines.Reset;
        InvestLines.SetRange(InvestLines."Investment No", Rec."Investment No");
        if InvestLines.Find('-') then begin
            repeat
                paySetup.Reset;
                paySetup.SetRange(paySetup."Payment Reference", paySetup."Payment Reference"::Investment);
                paySetup.SetRange(paySetup.Type, paySetup.Type::Payment);
                if paySetup.Find('-') then begin
                    repeat
                        PaymentsLine.Init;
                        PaymentsLine."Line No." := 0;
                        PaymentsLine.No := PaymentHeaderNo;
                        PaymentsLine."Account Type" := PaymentsLine."Account Type"::Customer;
                        PaymentsLine."Account No." := Institution;
                        PaymentsLine."Account Name" := "Institution Name";
                        PaymentsLine.Type := paySetup.Code;
                        PaymentsLine.Amount := InvestLines."Investment Amount";
                        PaymentsLine.Validate(Amount);
                        PaymentsLine."Withholding Tax Code" := "Withholding Tax Code";
                        PaymentsLine."Withholding Tax Amount" := InvestLines."Wht Tax Amount";
                        PaymentsLine.Insert(true);
                        PaymentsLine.Validate(PaymentsLine.Amount);
                        PaymentsLine.VALIDATE(PaymentsLine."Account No.");
                        PaymentsLine.Modify;
                    until paySetup.Next() = 0;
                end else begin
                    PaymentsLine.Init;
                    PaymentsLine."Line No." := 0;
                    PaymentsLine.No := PaymentHeaderNo;
                    PaymentsLine."Account Type" := PaymentsLine."Account Type"::Customer;
                    PaymentsLine."Account No." := Institution;
                    PaymentsLine."Account Name" := "Institution Name";
                    // PaymentsLine.Type := paySetup.Code;
                    PaymentsLine.Amount := InvestLines."Investment Amount";
                    PaymentsLine."Withholding Tax Code" := "Withholding Tax Code";
                    PaymentsLine."Withholding Tax Amount" := InvestLines."Wht Tax Amount";
                    PaymentsLine.Insert(true);
                    PaymentsLine.Validate(PaymentsLine.Amount);
                    PaymentsLine.VALIDATE(PaymentsLine."Account No.");
                    PaymentsLine.Modify;
                end;
            until InvestLines.Next() = 0;

        end;

        if PaymentsHeader.get(PaymentHeaderNo) then
            PAGE.Run(Page::"Payment Header", PaymentsHeader);
    end;

    procedure CreatePaymentHeader(): Code[50]
    var
        PaymentsHeader: Record "Payments Header";
        CashOffficeSetup: Record "Cash Office Setup";
        PaymentHeaderNo: code[50];
    begin
        CashOffficeSetup.Get();
        CashOffficeSetup.TestField(CashOffficeSetup."Normal Payments No");
        NoSeriesMgt.InitSeries(CashOffficeSetup."Normal Payments No", xRec."No. Series", 0D, PaymentHeaderNo, "No. Series");
        PaymentsHeader.Init;
        PaymentsHeader."No." := PaymentHeaderNo;
        PaymentsHeader.Date := Today;
        PaymentsHeader."Pay Mode" := PaymentsHeader."Pay Mode"::Cheque;
        PaymentsHeader."Currency Code" := "Currency Code";
        PaymentsHeader.Payee := "Institution Name";
        PaymentsHeader."Payment Narration" := "Institution Name"; //Investment header Remarks
        PaymentsHeader."Responsibility Center" := "Responsibility Center";
        PaymentsHeader."Creation Doc No." := "Investment No";
        PaymentsHeader."Creation Doc Type" := PaymentsHeader."Creation Doc Type"::Investment;
        PaymentsHeader.Insert(true);

        exit(PaymentsHeader."No.")
    end;

    procedure CreateReceiptDoc()
    var
        ReceiptHeader: Record "Receipts Header";
        ReceiptLine: Record "Receipt Line";
        InvestLines: Record "Investment Lines";
    begin




        ReceiptHeader.Init;
        ReceiptHeader.Date := Today;
        // PaymentsHeader."Pay Mode" := PaymentsHeader."Pay Mode"::Cheque;
        ReceiptHeader."Currency Code" := "Currency Code";
        ReceiptHeader."Received From" := "Institution Name";
        ReceiptHeader."Responsibility Center" := "Responsibility Center";
        ReceiptHeader."Creation Doc No." := "Investment No";
        ReceiptHeader."Creation Doc Type" := ReceiptHeader."Creation Doc Type"::Investment;
        ReceiptHeader.Insert(true);


        InvestLines.Reset;
        InvestLines.SetRange(InvestLines."Investment No", "Investment No");
        if InvestLines.Find('-') then begin
            repeat
                ReceiptLine.Init;
                ReceiptLine."Line No." := 0;
                ReceiptLine.No := ReceiptHeader."No.";
                ReceiptLine."Account Type" := ReceiptLine."Account Type"::Customer;
                ReceiptLine."Account No." := Institution;
                ReceiptLine."Account Name" := "Institution Name";
                paySetup.Reset;
                paySetup.SetRange(paySetup."Payment Reference", paySetup."Payment Reference"::Investment);
                if paySetup.Find('-') then begin
                    ReceiptLine.Type := paySetup.Code;
                end;

                ReceiptLine.Insert(true);

                ReceiptLine.Modify;
            until InvestLines.Next = 0;
        end;


        PAGE.Run(Page::"Receipt Header", ReceiptHeader);
    end;
}

