table 52187413 "Refund,Account Transfer Header"
{
    DrillDownPageID = "Refund $ Account Trans List";
    LookupPageID = "Refund $ Account Trans List";
    Caption = 'Refund And Account Transfer';

    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                // if No <> xRec.No then begin
                //     NoSetup.Get();
                //     NoSeriesMgt.TestManual(NoSetup."Refunds No.");
                //     "No. Series" := '';
                // end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[50])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }

        field(21; "Posting date"; Date)
        {
            Editable = true;
        }

        field(22; "Description"; Text[50])
        {
        }

        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {
            Caption = 'Total debits';
            CalcFormula = Sum("Refund,Account Transfer lines".Amount WHERE("Refund Header No." = FIELD(No), Amount = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }


        field(26; "Scheduled Amount"; Decimal)
        {


            Caption = 'Scheduled Amount';
            CalcFormula = Sum("Refund,Account Transfer lines".Amount WHERE("Refund Header No." = FIELD(No)));
            Editable = false;
            FieldClass = FlowField;


        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = Count("Refund,Account Transfer lines" WHERE("Refund Header No." = FIELD(No)));
            FieldClass = FlowField;
        }


        field(30; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
            trigger OnValidate()
            var
                myInt: Integer;
                GlobalFunctions: Codeunit "Global Functions";
            begin
                if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Approved) then
                    GlobalFunctions.CommentsManagement(Rec.No);

            end;
        }

        field(32; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code; //WHERE(Type = CONST("Salary Processing"))

            trigger OnValidate()
            begin
                "Document No" := No;
            end;
        }
        field(33; Validated; Boolean)
        {
        }
        field(34; "Upload Option"; Option)
        {
            OptionMembers = "MultiLine","Single Line";
        }
        field(46; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(47; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(42; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(43; "Originating Unit"; Option)
        {
            OptionMembers = General,"Business Loans";
        }
        field(44; "Refund Type"; Option)
        {
            OptionMembers = " ",Refund,"Loan Clearance";
            OptionCaption = ' ,Refunds & Transfer between Accts.,Loan Clearance';
            trigger Onvalidate()
            begin
                if xRec."Refund Type" <> "Refund Type"::" " then begin
                    dialog.Error('You cannot change a refund type once selected. Please use a different document to proceed');
                end;
            end;
        }
        field(45; "Comments/Remartks"; Text[250])
        {
        }
        field(56; "Time Posted"; Time)
        {
        }
        field(57; "Send SMS"; Boolean)
        {
            Caption = 'Send SMS Notification';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //  if Rec."Refund Type" = "Refund Type"::" " then
        //      dialog.Error('Please select a refund type before proceeding');

        // RefundAccTranHeader.reset;
        // RefundAccTranHeader.SetRange(Status, rec.Status::Open);
        // RefundAccTranHeader.SetRange(Posted, false);
        // RefundAccTranHeader.SetRange("Entered By", UserId);
        // RefundAccTranHeader.SetRange("Refund Type", Rec."Refund Type");
        // RefundAccTranHeader.SetRange("Originating Unit", Rec."Originating Unit");
        // RefundAccTranHeader.SetFilter("Refund Type", '<>%1', RefundAccTranHeader."Refund Type"::" ");
        // if RefundAccTranHeader.findfirst() then begin
        //     Error('You have an open transaction card that has not been posted: %1 kindly utilize that card.', RefundAccTranHeader.No);
        // end;

        if No = '' then begin
            NoSetup.Get();
            if Rec."Refund Type" = "Refund Type"::"Loan Clearance" then begin
                NoSetup.TestField(NoSetup."Loan Refund No.");
               No := NoSeriesMgt.GetNextNo(NoSetup."Loan Refund No.");
                // NoSeriesMgt.InitSeries(NoSetup."Loan Refund No.", xRec."No. Series", 0D, No, "No. Series");
            end
            else begin
                NoSetup.TestField(NoSetup."Refunds No.");
               No := NoSeriesMgt.GetNextNo(NoSetup."Refunds No.");
                // NoSeriesMgt.InitSeries(NoSetup."Refunds No.", xRec."No. Series", 0D, No, "No. Series");
            end;
        end;

        i := 0;
        CashierTrans.RESET;
        CashierTrans.SETRANGE("Entered By", USERID);
        CashierTrans.SETFILTER(Status, '%1', Status::Open);
        CashierTrans.SetRange(Posted, false);
        CashierTrans.SetRange("Refund Type", Rec."Refund Type");
        CashierTrans.SetRange("Originating Unit", Rec."Originating Unit");
        CashierTrans.SetFilter("Refund Type", '<>%1', CashierTrans."Refund Type"::" ");
        IF CashierTrans.FIND('-') THEN BEGIN
            REPEAT
                i += 1;
                OPenrecords := CashierTrans.No;
            UNTIL CashierTrans.NEXT = 0;
        END;

        IF i > 3 THEN ERROR('You are not allowed to open multiple applications.Complete %1 first.', OPenrecords);


        "Entered By" := UpperCase(UserId);
        "Date Entered" := Today;
        "Time Entered" := Time;
        "Posting date" := Today;
        "Document No" := No;
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");


            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        NoSetup: Record "Banking No Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        cust: Record Customer;
        RefundLines: Record "Refund,Account Transfer lines";
        UserSetup: Record "User Setup";
        i: Integer;
        CashierTrans: Record "Refund,Account Transfer Header";
        OPenrecords: Code[20];
        RefundAccTranHeader: Record "Refund,Account Transfer Header";
}

