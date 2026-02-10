page 52185819 "Over Draft Authorisation List"
{
    CardPageID = "Over Draft Authorisation";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Over Draft Authorisation";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Expired; Rec.Expired)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        IF Posted=TRUE THEN
                        ERROR('This Overdraft has already been issued');
                        
                        IF Status <> Status::Approved THEN
                        ERROR('You cannot post an application being processed.');
                        
                        TESTFIELD("Account No.");
                        TESTFIELD("Effective/Start Date");
                        TESTFIELD(Duration);
                        TESTFIELD("Expiry Date");
                        TESTFIELD("Requested Amount");
                        TESTFIELD("Approved Amount");
                        TESTFIELD("Overdraft Interest %");
                        
                        
                        IF CONFIRM('Are you sure you want to authorise this overdraft? This will charge overdraft issue fee.',FALSE) = FALSE THEN
                        EXIT;
                        
                        //Overdraft Issue Fee
                        AccountTypes.RESET;
                        AccountTypes.SETRANGE(AccountTypes.Code,"Account Type");
                        IF AccountTypes.FIND('-') THEN  BEGIN
                        
                        {
                        CalcAvailableBal;
                        
                        IF AvailableBalance < "Overdraft Fee" THEN
                        ERROR('Available balance not sufficient to cover the overdraft issue charge.');
                        }
                        
                        UsersID.RESET;
                        UsersID.SETRANGE(UsersID."User Name",UPPERCASE(USERID));
                        IF UsersID.FIND('-') THEN BEGIN
                        DBranch:=UsersID.Branch;
                        DActivity:='FOSA';
                        //MESSAGE('%1,%2',Branch,Activity);
                        END;
                        
                        
                        IF "Overdraft Fee" > 0 THEN BEGIN
                        AccountTypes.TESTFIELD("Over Draft Issue Charge A/C");
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN
                        GenJournalLine.DELETEALL;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="No.";
                        GenJournalLine."Posting Date":=TODAY;
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No.":="Account No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine.Description:='Overdraft Issue Charges';
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:="Overdraft Fee";
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="No.";
                        GenJournalLine."Posting Date":=TODAY;
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        GenJournalLine."Account No.":=AccountTypes."Over Draft Issue Charge A/C";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine.Description:="Account Name";
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Overdraft Fee";
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        
                        
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                        END;
                        
                        //Post New
                        
                        END;
                        END;
                        //Overdraft Fee
                        
                        Posted:=TRUE;
                        MODIFY;
                        
                        MESSAGE('Overdraft authorised and charges posted successfully.');
                        */

                    end;
                }
                action(Account)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                action(Liquidate)
                {
                    ApplicationArea = Basic, Suite;
                    Image = PutawayLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        TESTFIELD(Expired,FALSE);
                        TESTFIELD(Liquidated,FALSE);
                        
                        CalcAvailableBal;
                        
                        AvailableBalance:=AvailableBalance-"Approved Amount";
                        
                        
                        IF CONFIRM('Are you sure you want to liquidate this overdraft?',FALSE) = FALSE THEN
                        EXIT;
                        
                        
                        IF NOT GenBatch.GET('PURCHASES','OVER DRAFT') THEN
                        BEGIN
                        GenBatch.INIT;
                        GenBatch."Journal Template Name":='PURCHASES';
                        GenBatch.Name:='OVER DRAFT';
                        GenBatch.INSERT;
                        END;
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'OVER DRAFT');
                        GenJournalLine.DELETEALL;
                        
                        DocNo := 'OVER DRAFT';
                        IF PDate = 0D THEN
                        PDate := TODAY;
                        
                        
                        EndMonth:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY(PDate,2),DATE2DMY(PDate,3))));
                        
                        StartDate:=CALCDATE('-1M',CALCDATE('1D',EndMonth));
                        IntDays:=(PDate-StartDate)+1;
                        
                        
                        
                        
                        ODRate:="Overdraft Interest %";
                        
                        AccruedInt:=0;
                        RIntDays:=IntDays;
                        AsAt:=StartDate;
                        OverDraftAmount:=0;
                        
                        IF Vendor.GET("Account No.") THEN BEGIN
                        IF AccountType.GET(Vendor."Account Type") THEN BEGIN
                        IF AccountType."Allow Over Draft" =  TRUE THEN BEGIN
                        //Loop thru days of the month
                        REPEAT
                        AccountType.TESTFIELD(AccountType."Over Draft Interest Account");
                        ODAccount:=AccountType."Over Draft Interest Account";
                        
                        RIntDays:=RIntDays-1;
                        
                        DFilter:='01/01/05..'+FORMAT(AsAt);
                        
                        Account.RESET;
                        Account.SETRANGE(Account."No.",Vendor."No.");
                        Account.SETFILTER(Account."Date Filter",DFilter);
                        IF Account.FIND('-') THEN BEGIN
                        Account.CALCFIELDS(Account."Balance (LCY)");
                        IF Account."Balance (LCY)" < 0 THEN BEGIN
                        OverDraftAmount:=(((ODRate*12)/36500)*ABS(Account."Balance (LCY)"));
                        
                        
                        AccruedInt:=AccruedInt+OverDraftAmount;
                        
                        END;
                        
                        END;
                        
                        AsAt:=CALCDATE('1D',AsAt);
                        UNTIL RIntDays = 0;
                        
                        AccruedInt:=ROUND(AccruedInt,0.01,'>');
                        
                        IF (AvailableBalance - AccruedInt) < 0 THEN
                        ERROR('Available balance not sufficient to cover the overdraft plus accrued interest on overdraft of %1.',AccruedInt);
                        
                        
                        IF AccruedInt > 0 THEN BEGIN
                        IF Vendor.Blocked = Vendor.Blocked::All THEN BEGIN
                        Vendor.Blocked := Vendor.Blocked::Payment;
                        Vendor.MODIFY;
                        END;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.INIT;
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='OVER DRAFT';
                        GenJournalLine."Document No.":=DocNo;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=PDate;
                        GenJournalLine.Description:='Over Draft Charges';
                        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=AccruedInt;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=ODAccount;
                        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        
                        
                        END;
                        END;
                        END;
                        END;
                        
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'OVER DRAFT');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                        END;
                        //Post New
                        */
                        Rec.Liquidated := true;
                        Rec.Expired := true;
                        Rec."Date Liquidated" := Today;
                        Rec."Liquidated By" := UserId;
                        Rec.Modify;

                        Message('Overdraft liquidation posted successfully.');

                    end;
                }
            }
        }
    }

    //[Scope('OnPrem')]
    procedure CalcAvailableBal()
    begin
        /*AvailableBalance:=0;
        MinAccBal:=0;
        
        IF Account.GET("Account No.") THEN BEGIN
        Account.CALCFIELDS(Account.Balance,Account."Uncleared Cheques",Account."ATM Transactions",
                           Account."Authorised Over Draft");
        
        AccountTypes.RESET;
        AccountTypes.SETRANGE(AccountTypes.Code,"Account Type");
        IF AccountTypes.FIND('-') THEN BEGIN
        MinAccBal:=AccountTypes."Minimum Balance";
        
        AvailableBalance:=(Account.Balance+Account."Authorised Over Draft") - MinAccBal - Account."Uncleared Cheques" -
                          Account."EFT Transactions"-Account."ATM Transactions";
        
        
        END;
        END;
        */

    end;
}

