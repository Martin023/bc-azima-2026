table 52185797 "Account Transfer Header"
{
    DrillDownPageID = "Account Transfer List";
    LookupPageID = "Account Transfer List";

    fields
    {
        field(1; No; Code[10])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Account Transfer Nos");
                    "No. Series" := '';
                    Remarks := '';
                end;
            end;
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Transaction Type"; Code[20])
        {
            TableRelation = "Transaction Types".Code WHERE(Type = CONST(Transfers));
        }
        field(4; Posted; Boolean)
        {
            Editable = true;
        }
        field(5; "No. Series"; Code[20])
        {
        }
        field(6; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(7; Remarks; Code[50])
        {
        }
        field(8; Status; Option)
        {

            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;

            trigger OnValidate()
            var
                RegistrationMngt: Codeunit "Registration Process";
                GlobalFunctions: Codeunit "Global Functions";
            begin
                if (Rec.Status = Status::Rejected) then
                    GlobalFunctions.CommentsManagement(Rec.No);
            end;
        }
        field(9; "Created By"; Code[80])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(10; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
                //  if "Global Dimension 2 Code" = 'BOSA' then                    
            end;
        }
        field(13; "Total Debits"; Decimal)
        {
            CalcFormula = Sum("Account Transfer Source"."Source Amount" WHERE("No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(14; "Total Credits"; Decimal)
        {
            CalcFormula = Sum("Account Transfer Destination"."Destination Amount" WHERE("No." = FIELD(No)));
            FieldClass = FlowField;
        }
        field(15; "Member No"; Code[20])
        {
            TableRelation = Members;

            trigger OnValidate()
            begin
                AccountTransferHeader.Reset;
                AccountTransferHeader.SetRange("Member No", "Member No");
                AccountTransferHeader.SetRange(Posted, false);
                //AccountTransferHeader.SetRange("Transfer Type", rec."Transfer Type");
                AccountTransferHeader.setfilter(No, '<>%1', rec.No);
                if AccountTransferHeader.Find('-') then
                    Error(ExistingDoc, AccountTransferHeader.No);

                TransSource.Reset;
                TransSource.SetRange(TransSource."No.", No);
                if TransSource.Find('-') then
                    TransSource.DeleteAll;

                TransDestin.Reset;
                TransDestin.SetRange(TransDestin."No.", No);
                if TransDestin.Find('-') then
                    TransDestin.DeleteAll;

                if "Transfer Type" = "Transfer Type"::Other then begin
                    TransDestin.Reset;
                    TransDestin.SetRange(TransDestin."No.", No);
                    if TransDestin.Find('-') then
                        TransDestin.DeleteAll;

                    SavingsREC.Reset;
                    SavingsREC.SetRange(SavingsREC."Member No.", "Member No");
                    SavingsREC.setfilter("Product Category", '%1|%2|%3', SavingsREC."Product Category"::"FOSA Account", SavingsREC."Product Category"::Kesasa, SavingsREC."Product Category"::"Junior Account");
                    if SavingsREC.Find('-') then begin
                        repeat
                            TransSource.Init;
                            TransSource."Entry No." := TransSource."Entry No." + 1;
                            TransSource."No." := No;
                            TransSource."Source Account Type" := TransSource."Source Account Type"::Savings;
                            TransSource."Source Account No." := SavingsREC."No.";
                            TransSource."Source Account Name" := SavingsREC.Name;
                            TransSource."Product Name" := SavingsREC."Product Name";
                            TransSource."Product Code" := SavingsREC."Product Type";
                            TransSource."Transfer Type" := "Transfer Type";
                            TransSource."Member No." := SavingsREC."Member No.";
                            TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::" ";
                            TransSource.Insert(true);
                            TransSource.Validate(TransSource."Source Account No.");
                            TransSource.Modify;
                        until SavingsREC.Next = 0;
                    end;

                    //Credit
                    // CreditREC.Reset;
                    // CreditREC.SetRange(CreditREC."Member No.", "Member No");
                    // if CreditREC.Find('-') then begin
                    //     repeat
                    //         CreditREC.CalcFields(CreditREC."Total Balance");
                    //         if CreditREC."Total Balance" > 0 then begin
                    //             TransSource.Init;
                    //             TransSource."Entry No." := TransSource."Entry No." + 1;
                    //             TransSource."No." := No;
                    //             TransSource."Source Account Type" := TransSource."Source Account Type"::Credit;
                    //             TransSource."Source Account No." := CreditREC."Loan Account";
                    //             TransSource."Source Account Name" := CreditREC."Member No.";
                    //             TransSource."Product Name" := CreditREC."Loan Product Type Name";
                    //             TransSource."Product Code" := CreditREC."Loan Product Type";
                    //             TransSource."Transfer Type" := "Transfer Type";
                    //             TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::Loan;
                    //             TransSource."Member No." := CreditREC."Member No.";
                    //             TransSource.Insert(true);
                    //             TransSource.Validate(TransSource."Source Loan No.");
                    //             TransSource.Modify;
                    //         end;

                    //     until CreditREC.Next = 0;
                    // end;
                end else begin
                    SavingsREC.Reset;
                    SavingsREC.SetRange(SavingsREC."Member No.", "Member No");
                    SavingsREC.setfilter("Product Category", '%1|%2', SavingsREC."Product Category"::"FOSA Account", SavingsREC."Product Category"::Kesasa);
                    if SavingsREC.Find('-') then begin
                        repeat
                            TransSource.Init;
                            TransSource."Entry No." := TransSource."Entry No." + 1;
                            TransSource."No." := No;
                            TransSource."Source Account Type" := TransSource."Source Account Type"::Savings;
                            TransSource."Source Account No." := SavingsREC."No.";
                            TransSource."Source Account Name" := SavingsREC.Name;
                            TransSource."Product Name" := SavingsREC."Product Name";
                            TransSource."Product Code" := SavingsREC."Product Type";
                            TransSource."Transfer Type" := "Transfer Type";
                            TransSource."Member No." := SavingsREC."Member No.";
                            TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::" ";
                            TransSource.Insert(true);
                            TransSource.Validate(TransSource."Source Account No.");
                            TransSource.Modify;
                        until SavingsREC.Next = 0;
                    end;

                    //Credit
                    // CreditREC.Reset;
                    // CreditREC.SetRange(CreditREC."Member No.", "Member No");
                    // if CreditREC.Find('-') then begin
                    //     repeat
                    //         CreditREC.CalcFields(CreditREC."Total Balance");
                    //         if CreditREC."Total Balance" > 0 then begin
                    //             TransSource.Init;
                    //             TransSource."Entry No." := TransSource."Entry No." + 1;
                    //             TransSource."No." := No;
                    //             TransSource."Source Account Type" := TransSource."Source Account Type"::Credit;
                    //             TransSource."Source Account No." := CreditREC."Loan Account";
                    //             TransSource."Source Account Name" := CreditREC."Member No.";
                    //             TransSource."Product Name" := CreditREC."Loan Product Type Name";
                    //             TransSource."Product Code" := CreditREC."Loan Product Type";
                    //             TransSource."Transfer Type" := "Transfer Type";
                    //             TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::Loan;
                    //             TransSource."Member No." := CreditREC."Member No.";
                    //             TransSource.Insert(true);
                    //             TransSource.Validate(TransSource."Source Loan No.");
                    //             TransSource.Modify;
                    //         end;

                    //     until CreditREC.Next = 0;
                    // end;

                    // Trans destination

                    SavingsREC.Reset;
                    SavingsREC.SetRange(SavingsREC."Member No.", "Member No");
                    SavingsREC.setfilter("Product Category", '<>%1&<>%2', SavingsREC."Product Category"::"Unallocated Fund", SavingsREC."Product Category"::"Entrance Fee");
                    if SavingsREC.Find('-') then begin
                        repeat
                            TransDestin.Init;
                            TransDestin."Entry No." := TransDestin."Entry No." + 1;
                            TransDestin."No." := No;
                            TransDestin."Destination Account Type" := TransDestin."Destination Account Type"::Savings;
                            TransDestin."Destination Account No." := SavingsREC."No.";
                            TransDestin."Destination Account Name" := SavingsREC.Name;
                            TransDestin."Product Name" := SavingsREC."Product Name";
                            TransDestin."Product Code" := SavingsREC."Product Type";
                            TransDestin."Transfer Type" := "Transfer Type";
                            TransDestin."Member No." := SavingsREC."Member No.";
                            TransDestin.Insert(true);
                            TransDestin.Validate(TransDestin."Destination Account No.");
                            TransDestin.Modify;
                        until SavingsREC.Next = 0;
                    end;

                    //Credit
                    CreditREC.Reset;
                    CreditREC.SetRange(CreditREC."Member No.", "Member No");
                    if CreditREC.Find('-') then begin
                        repeat
                            CreditREC.CalcFields(CreditREC."Total Balance");
                            if CreditREC."Total Balance" > 0 then begin
                                TransDestin.Init;
                                TransDestin."Entry No." := TransDestin."Entry No." + 1;
                                TransDestin."No." := No;
                                TransDestin."Destination Account Type" := TransDestin."Destination Account Type"::Credit;
                                TransDestin."Destination Account No." := CreditREC."Loan Account";
                                TransDestin."Destination Account Name" := CreditREC."Member No.";
                                TransDestin."Product Name" := CreditREC."Loan Product Type Name";
                                TransDestin."Product Code" := CreditREC."Loan Product Type";
                                TransDestin."Transfer Type" := "Transfer Type";
                                TransDestin."Destination Transaction Type" := TransDestin."Destination Transaction Type"::Armotised;
                                TransDestin."Member No." := CreditREC."Member No.";
                                TransDestin.Insert(true);
                                TransDestin.Validate(TransDestin."Destination Loan No.", Creditrec."Loan No.");
                                TransDestin.Modify;
                            end;

                        until CreditREC.Next = 0;
                    end;

                end;
            end;
        }
        field(16; "Transfer Type"; Option)
        {
            OptionCaption = 'Self,Other,Share Transfer';
            OptionMembers = Self,Other,"Share Transfer";
            ValuesAllowed = Self, Other;
            InitValue = other;
            trigger OnValidate()
            begin
                AccountTransferHeader.Reset;
                AccountTransferHeader.SetRange("Member No", "Member No");
                AccountTransferHeader.SetRange(Posted, false);
                //AccountTransferHeader.SetRange("Transfer Type", rec."Transfer Type");
                AccountTransferHeader.setfilter(No, '<>%1', rec.No);
                //AccountTransferHeader.SetFilter(Status, '<>%1', AccountTransferHeader.Status::Rejected);
                if AccountTransferHeader.Find('-') then
                    Error(ExistingDoc, AccountTransferHeader.No);

                TransSource.Reset;
                TransSource.SetRange(TransSource."No.", No);
                if TransSource.Find('-') then
                    TransSource.DeleteAll;

                TransDestin.Reset;
                TransDestin.SetRange(TransDestin."No.", No);
                if TransDestin.Find('-') then
                    TransDestin.DeleteAll;

                if "Transfer Type" = "Transfer Type"::Other then begin
                    TransDestin.Reset;
                    TransDestin.SetRange(TransDestin."No.", No);
                    if TransDestin.Find('-') then
                        TransDestin.DeleteAll;

                    SavingsREC.Reset;
                    SavingsREC.SetRange(SavingsREC."Member No.", "Member No");
                    SavingsREC.setfilter("Product Category", '%1|%2', SavingsREC."Product Category"::"FOSA Account", SavingsREC."Product Category"::Kesasa);
                    if SavingsREC.Find('-') then begin
                        repeat
                            TransSource.Init;
                            TransSource."Entry No." := TransSource."Entry No." + 1;
                            TransSource."No." := No;
                            TransSource."Source Account Type" := TransSource."Source Account Type"::Savings;
                            TransSource."Source Account No." := SavingsREC."No.";
                            TransSource."Source Account Name" := SavingsREC.Name;
                            TransSource."Product Name" := SavingsREC."Product Name";
                            TransSource."Product Code" := SavingsREC."Product Type";
                            TransSource."Transfer Type" := "Transfer Type";
                            TransSource."Member No." := SavingsREC."Member No.";
                            TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::" ";
                            TransSource.Insert(true);
                            TransSource.Validate(TransSource."Source Account No.");
                            TransSource.Modify;
                        until SavingsREC.Next = 0;
                    end;

                    //Credit
                    // CreditREC.Reset;
                    // CreditREC.SetRange(CreditREC."Member No.", "Member No");
                    // if CreditREC.Find('-') then begin
                    //     repeat
                    //         CreditREC.CalcFields(CreditREC."Total Balance");
                    //         if CreditREC."Total Balance" > 0 then begin
                    //             TransSource.Init;
                    //             TransSource."Entry No." := TransSource."Entry No." + 1;
                    //             TransSource."No." := No;
                    //             TransSource."Source Account Type" := TransSource."Source Account Type"::Credit;
                    //             TransSource."Source Account No." := CreditREC."Loan Account";
                    //             TransSource."Source Account Name" := CreditREC."Member No.";
                    //             TransSource."Product Name" := CreditREC."Loan Product Type Name";
                    //             TransSource."Product Code" := CreditREC."Loan Product Type";
                    //             TransSource."Transfer Type" := "Transfer Type";
                    //             TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::Loan;
                    //             TransSource."Member No." := CreditREC."Member No.";
                    //             TransSource.Insert(true);
                    //             TransSource.Validate(TransSource."Source Loan No.");
                    //             TransSource.Modify;
                    //         end;

                    //     until CreditREC.Next = 0;
                    // end;
                end else begin
                    TransSource.Reset;
                    TransSource.SetRange(TransSource."No.", No);
                    if TransSource.findset() then
                        TransSource.DeleteAll;

                    SavingsREC.Reset;
                    SavingsREC.SetRange(SavingsREC."Member No.", "Member No");
                    SavingsREC.setfilter("Product Category", '%1|%2', SavingsREC."Product Category"::"FOSA Account", SavingsREC."Product Category"::Kesasa);
                    if SavingsREC.Find('-') then begin
                        repeat
                            TransSource.Init;
                            TransSource."Entry No." := TransSource."Entry No." + 1;
                            TransSource."No." := No;
                            TransSource."Source Account Type" := TransSource."Source Account Type"::Savings;
                            TransSource."Source Account No." := SavingsREC."No.";
                            TransSource."Source Account Name" := SavingsREC.Name;
                            TransSource."Product Name" := SavingsREC."Product Name";
                            TransSource."Product Code" := SavingsREC."Product Type";
                            TransSource."Transfer Type" := "Transfer Type";
                            TransSource."Member No." := SavingsREC."Member No.";
                            TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::" ";
                            TransSource.Insert(true);
                            TransSource.Validate(TransSource."Source Account No.");
                            TransSource.Modify;
                        until SavingsREC.Next = 0;
                    end;

                    //Credit
                    // CreditREC.Reset;
                    // CreditREC.SetRange(CreditREC."Member No.", "Member No");
                    // if CreditREC.Find('-') then begin
                    //     repeat
                    //         CreditREC.CalcFields(CreditREC."Total Balance");
                    //         if CreditREC."Total Balance" > 0 then begin
                    //             TransSource.Init;
                    //             TransSource."Entry No." := TransSource."Entry No." + 1;
                    //             TransSource."No." := No;
                    //             TransSource."Source Account Type" := TransSource."Source Account Type"::Credit;
                    //             TransSource."Source Account No." := CreditREC."Loan Account";
                    //             TransSource."Source Account Name" := CreditREC."Member No.";
                    //             TransSource."Product Name" := CreditREC."Loan Product Type Name";
                    //             TransSource."Product Code" := CreditREC."Loan Product Type";
                    //             TransSource."Transfer Type" := "Transfer Type";
                    //             TransSource."Source Transaction Type" := TransSource."Source Transaction Type"::Loan;
                    //             TransSource."Member No." := CreditREC."Member No.";
                    //             TransSource.Insert(true);
                    //             TransSource.Validate(TransSource."Source Loan No.");
                    //             TransSource.Modify;
                    //         end;

                    //     until CreditREC.Next = 0;
                    // end;

                    // Trans destination
                    TransDestin.Reset;
                    TransDestin.SetRange(TransDestin."No.", No);
                    if TransDestin.FindSet() then
                        TransDestin.DeleteAll;

                    SavingsREC.Reset;
                    SavingsREC.SetRange(SavingsREC."Member No.", "Member No");
                    SavingsREC.setfilter("Product Category", '<>%1&<>%2', SavingsREC."Product Category"::"Unallocated Fund", SavingsREC."Product Category"::"Entrance Fee");
                    if SavingsREC.Find('-') then begin
                        repeat
                            TransDestin.Init;
                            TransDestin."Entry No." := TransDestin."Entry No." + 1;
                            TransDestin."No." := No;
                            TransDestin."Destination Account Type" := TransDestin."Destination Account Type"::Savings;
                            TransDestin."Destination Account No." := SavingsREC."No.";
                            TransDestin."Destination Account Name" := SavingsREC.Name;
                            TransDestin."Product Name" := SavingsREC."Product Name";
                            TransDestin."Product Code" := SavingsREC."Product Type";
                            TransDestin."Transfer Type" := "Transfer Type";
                            TransDestin."Member No." := SavingsREC."Member No.";
                            TransDestin.Insert(true);
                            TransDestin.Validate(TransDestin."Destination Account No.");
                        //TransDestin.Modify(true);
                        until SavingsREC.Next = 0;
                    end;

                    //Credit
                    CreditREC.Reset;
                    CreditREC.SetRange(CreditREC."Member No.", "Member No");
                    if CreditREC.Find('-') then begin
                        repeat
                            CreditREC.CalcFields(CreditREC."Total Balance");
                            if CreditREC."Total Balance" > 0 then begin
                                TransDestin.Init;
                                TransDestin."Entry No." := TransDestin."Entry No." + 1;
                                TransDestin."No." := No;
                                TransDestin."Destination Account Type" := TransDestin."Destination Account Type"::Credit;
                                TransDestin."Destination Account No." := CreditREC."Loan Account";
                                TransDestin."Destination Account Name" := CreditREC."Member No.";
                                TransDestin."Product Name" := CreditREC."Loan Product Type Name";
                                TransDestin."Product Code" := CreditREC."Loan Product Type";
                                TransDestin."Transfer Type" := "Transfer Type";
                                TransDestin."Destination Transaction Type" := TransDestin."Destination Transaction Type"::Armotised;
                                TransDestin."Member No." := CreditREC."Member No.";
                                TransDestin."Destination Loan No." := CreditREC."Loan No.";
                                TransDestin.Insert(true);
                                TransDestin.Validate(TransDestin."Destination Loan No.", CreditREC."Loan No.");
                                //TransDestin.Modify(true);
                            end;
                        until CreditREC.Next = 0;
                    end;
                end;
            end;
        }
        field(17; "Account Transfer Type"; Option)
        {
            OptionCaption = ' ,SinkFund';
            OptionMembers = " ",SinkFund;
        }
        field(18; "Rejection Reason"; Text[50])
        {
        }
        field(19; "Upload Response"; Integer)
        {
            Editable = false;
        }
        field(20; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(21; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(22; "Recover Arrears"; Boolean)
        {

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

    trigger OnDelete()
    begin
        if Posted then
            Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
        AccountTransferHeader.Reset;
        AccountTransferHeader.SetRange(Status, Status::Open);
        AccountTransferHeader.SetRange("Created By", UserId);
        if AccountTransferHeader.count > 1 then
            Error('You cannot open a new card because you have an open card No: ' + AccountTransferHeader.No);
        // AccountTransferHeader.FindLast then
        //     Error('You cannot open a new card because you have an open card No: ' + AccountTransferHeader.No);

        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."Account Transfer Nos");
            NoSeriesMgt.InitSeries(NoSetup."Account Transfer Nos", xRec.Remarks, 0D, No, Remarks);
        end;
        "Transaction Date" := Today;
        "Transaction Time" := Time;
        "Created By" := UserId;



        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            UserSetup.TestField(UserSetup."Responsibility Centre");

            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    trigger OnModify()
    begin
        //IF Posted THEN
        //ERROR('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then
            Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Banking No Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        SavingsREC: Record "Savings Accounts";
        TransSource: Record "Account Transfer Source";
        TransDestin: Record "Account Transfer Destination";
        CreditREC: Record Loans;
        AccountTransferHeader: Record "Account Transfer Header";
        ExistingDoc: Label 'Member has an existing application No %1 which is not posted';

    procedure GetAccountTrCharges(Account: Record "Savings Accounts"; AcctTransfer: Record "Account Transfer Header"): Decimal
    begin

    end;
}

