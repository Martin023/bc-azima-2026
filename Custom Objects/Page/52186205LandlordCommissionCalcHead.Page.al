page 52186205 "Landlord Commission Calc Head"
{
    PageType = Card;
    SourceTable = "Landlord Commission Calc";
    SourceTableView = WHERE(Processed = CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                        FrmCalendar.SetDate("From Date");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "From Date" := D;
                        */

                    end;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                        //is obsolete in 2015
                        FrmCalendar.SetDate("To Date");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "To Date" := D;
                         */

                    end;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Landlord No."; Rec."Landlord No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Commission Fee"; Rec."Commission Fee")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1102756012; "Landlord Commission Calc  Line")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Control1102755033; "Landlord Commision Calc LEXP")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                SubPageLink = "No." = FIELD("No.");
            }
            group(Calculations)
            {
                Caption = 'Calculations';
                // field(TOTALINFLOW; Rec.TOTALINFLOW)
                // {
                //     Caption = 'Total Inflow';
                // }
                field(Outflows; Rec.Outflows)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Commission Rate"; Rec."Commission Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Commission Amount"; Rec."Commission Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT on Commission"; Rec."VAT on Commission")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Letting Fee Amount"; Rec."Letting Fee Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Reletting Fee Amount"; Rec."Reletting Fee Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payable To Landlord"; Rec."Payable To Landlord")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Letting Flat Amount"; Rec."Letting Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Reletting Flat Amount"; Rec."Reletting Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Commssion Flat Amount"; Rec."Commssion Flat Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Letting Rate"; Rec."Letting Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Reletting Rate"; Rec."Reletting Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group("Payment details")
            {
                Caption = 'Payment details';
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            label(Control1102755036)
            {
                ApplicationArea = Basic, Suite;
                CaptionClass = Text19022245;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            label(Control1102755035)
            {
                ApplicationArea = Basic, Suite;
                CaptionClass = Text19042409;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
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
                action("Process Dues")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Process Dues';

                    trigger OnAction()
                    begin
                        /*
                         IF  CONFIRM('Are You Sure You want to process Management Fee?',FALSE)=FALSE THEN BEGIN EXIT END;
                        MGT:=0;
                        T:=0;
                        VATonCom:=0;
                        MGTexclVAT:=0;
                        Expense:=0;
                        TOTALINFLOW:=0;
                        CommAmount:=0;
                       TESTFIELD("Commission Fee");
                       TESTFIELD("Posting Date");
                       //CLEAR ALL BEFORE PROCESSING ONCE AGAIN
                       LC.RESET;
                       LC.SETRANGE(LC."No.","No.");
                       IF LC.FIND('-')THEN BEGIN
                       LC.DELETEALL;
                       END;
                       LCExp.RESET;
                       LCExp.SETRANGE(LCExp."No.","No.");
                       IF LCExp.FIND('-')THEN BEGIN
                       LCExp.DELETEALL;
                       END;

                        RecptLine.RESET;
                        RecptLine.SETRANGE(RecptLine.Date,"From Date","To Date");
                        RecptLine.SETRANGE(RecptLine.Posted,TRUE);
                        RecptLine.SETRANGE(RecptLine."Property Code","Property No.");
                        //RecptLine.SETFILTER(RecptLine.Remmitted,FORMAT(FALSE)); TO BE CONSIDERED
                        IF RecptLine.FIND('-')THEN BEGIN

                       LC.RESET;
                       IntC:=0;
                       IF LC.FINDLAST THEN
                       BEGIN
                       IntC:=LC."Line No.";
                       END;
                       IntC:=IntC +1;
                       //deletes ant existing record
                       LC.RESET;
                       LC.SETRANGE(LC."No.","No.");
                       LC.SETRANGE(LC."Posting Date","From Date","To Date");
                       IF LC.FINDFIRST THEN BEGIN
                       LC.DELETEALL;
                       END;
                       //end of deletes any existing record

                        LC.RESET;
                        //reset the values
                         Inflows:=0;
                         Outflows:=0;
                         "Commission Amount":=0;
                         "Payable To Landlord":=0;
                       REPEAT
                       //inserts all incomes in LC Table
                       LC.INIT;
                       LC."No.":="No.";
                       LC."Line No.":=IntC;
                       LC."Posting Date":=RecptLine."Date Posted";
                       LC.Description:=RecptLine."Charge Name";
                       LC."Lease No.":=RecptLine."Lease No";
                       //LC."Tenant No.":=RecptLine."Tenant Name";
                       IF LC."Lease No."<>'' THEN
                       BEGIN
                       L.RESET;
                       L.GET(LC."Lease No.");
                       LC."Tenant No.":=L."Tenant No.";
                       END;
                       LC.Amount:=(RecptLine."Amount Paid Excl. VAT"+RecptLine."VAT Amount Paid");
                       TOTALINFLOW:=TOTALINFLOW+(RecptLine."Amount Paid Excl. VAT"+RecptLine."VAT Amount Paid");
                       LC.INSERT;
                       IntC:=IntC +1;
                       //end of insertion LC Table
                       Charges.RESET;
                       Charges.SETRANGE(Charges."Property Code","Property No.");
                       Charges.SETRANGE(Charges.Code,RecptLine."Transaction Code");
                       Charges.SETRANGE(Charges."Charge Management Fee",TRUE);
                       IF Charges.FIND('-') THEN  BEGIN
                       REPEAT
                       //charge management fee on Rent excluding VAT
                       IF (RecptLine."Transaction Code"=Charges.Code) AND  (Charges."Mgt on Rent Only"=TRUE) THEN BEGIN
                       CommAmount:=CommAmount+(RecptLine."Amount Paid Excl. VAT");
                       END ELSE
                       CommAmount:=CommAmount+(RecptLine."Amount Paid Excl. VAT"+RecptLine."VAT Amount Paid");
                       UNTIL Charges.NEXT=0;
                       END;
                       UNTIL RecptLine.NEXT=0;
                       END;
                       Inflows:=CommAmount;

                       //Process All Expenses
                         GL.RESET;
                         GL.SETRANGE(GL."Property Code","Property No.");
                         GL.SETRANGE(GL."Posting Date","From Date","To Date");
                         GL.SETFILTER(GL."G/L Account No.",'8401|8200');
                         IF GL.FIND('-')THEN BEGIN
                       IF (GL."Document Type"=GL."Document Type"::Invoice) OR
                       (GL."Document Type"=GL."Document Type"::"Credit Memo")THEN  BEGIN
                       LCExp.RESET;
                           IntExp:=0;
                           IF LCExp.FINDLAST THEN
                             BEGIN
                               IntExp:=LCExp."Line No.";
                             END;
                               IntExp:=IntExp +1;
                           LCExp.RESET;
                           LCExp.SETRANGE(LCExp."No.","No.");
                           LCExp.SETRANGE(LCExp."Posting Date","From Date","To Date");
                           IF LCExp.FINDFIRST THEN
                             BEGIN
                               LCExp.DELETEALL;
                             END;
                            LCExp.RESET;
                            //reset the values
                           REPEAT
                            IF  GL."Expense Code"<>'' THEN BEGIN
                             LCExp.INIT;
                               LCExp."No.":="No.";
                               LCExp."Line No.":=IntExp;
                               LCExp."Posting Date":=GL."Posting Date";
                               LCExp.Description:=GL.Description;
                               LCExp."Lease No.":=GL."Lease No.";
                               LCExp."Tenant No.":= GL."Tenant No";
                               LCExp.Supplier:=GL."Source No.";
                               IF LCExp."Lease No."<>'' THEN
                                 BEGIN
                                   L.RESET;
                                   L.GET(LC."Lease No.");
                                   LCExp."Tenant No.":=L."Tenant No.";
                                 END;

                                 LCExp.Amount:=(GL.Amount);

                         Expense:=Expense+GL.Amount;

                         Outflows:=Expense;
                       LCExp.INSERT;
                       END;
                       IntExp:=IntExp +1;
                       UNTIL GL.NEXT=0;

                       END;
                       END;

                        IF "Commission Rate"<>0 THEN BEGIN
                        //CHARGE VAT ON COMMISSION (REGENT MGT FEE ATTRACTS VAT)
                        Charges.RESET;
                        Charges.SETRANGE(Charges."Property Code","Property No.");
                        Charges.SETRANGE(Charges.Code,RecptLine."Transaction Code");
                         Charges.SETRANGE(Charges."Charge Management Fee",TRUE);
                        Charges.SETRANGE(Charges."Charge Management Incl. VAT",TRUE);
                        IF Charges.FIND('-')THEN BEGIN
                        MGTexclVAT:=CommAmount *("Commission Rate"/100);

                        VATonCom:=MGTexclVAT*0.16;
                        MGT:=MGTexclVAT+VATonCom;
                        END ELSE
                        //NO VAT ON COMMISSION
                        MGT:=Inflows*("Commission Rate"/100);

                       END ELSE BEGIN

                       //charge commission on flat Amount
                        LeaseLine.RESET;
                        LeaseLine.SETRANGE(LeaseLine."Property No","Property No.");
                        LeaseLine.SETRANGE(LeaseLine."Charge Once",FALSE);
                         IF LeaseLine.FIND('-')THEN BEGIN
                         //Monthly
                         REPEAT
                        T:=T+LeaseLine."Total Amount Inclusive VAT";
                       UNTIL LeaseLine.NEXT=0;
                       END;
                         IF LeaseLine.Quantity=1 THEN BEGIN
                         "Commission Amount":=("Commssion Flat Amount"/T)*Inflows;
                         MESSAGE(FORMAT(T));
                         MGT:="Commission Amount";
                          //Quarterly
                         END ELSE IF LeaseLine.Quantity=3 THEN BEGIN
                          "Commission Amount":=("Commssion Flat Amount"/(T/3))*Inflows;
                          MGT:="Commission Amount";
                          //Annually
                          END ELSE IF LeaseLine.Quantity=12 THEN BEGIN
                           "Commission Amount":=("Commssion Flat Amount"/(T/12))*Inflows;
                          MGT:="Commission Amount";
                          END;
                         MODIFY;
                        END;


                        PropertyDet.RESET;
                        PropertyDet.SETRANGE(PropertyDet."No.","Property No.");
                        IF PropertyDet.FIND('-')THEN BEGIN
                        IF PropertyDet."Charge letting once"=FALSE THEN BEGIN
                         //charge letting fee
                          Charges.RESET;
                          Charges.SETRANGE(Charges."Property Code",RecptLine."Property Code");
                          Charges.SETRANGE(Charges."Charge Letting Fee",TRUE);
                         IF  Charges.FIND('-')THEN BEGIN
                         LeaseLine.RESET;
                         LeaseLine.SETRANGE(LeaseLine."Property No","Property No.");
                         LeaseLine.SETRANGE(LeaseLine."Charge Letting Fee",TRUE);
                         IF LeaseLine.FIND('-')THEN BEGIN

                        IF "Letting Rate"<>0 THEN BEGIN
                         "Letting Fee Amount":=LeaseLine."Total Amount Inclusive VAT"*("Letting Rate"/100);
                        END ELSE
                         "Letting Fee Amount":="Letting Flat Amount";
                          MODIFY;
                       END
                       END;
                        //charge reletting fee
                          Charges.RESET;
                          Charges.SETRANGE(Charges."Property Code",RecptLine."Property Code");
                          Charges.SETRANGE(Charges."Charge Reletting Fee",TRUE);
                         IF  Charges.FIND('-')THEN BEGIN
                         LeaseLine.RESET;
                         LeaseLine.SETRANGE(LeaseLine."Property No","Property No.");
                         LeaseLine.SETRANGE(LeaseLine."Charge Reletting Fee",TRUE);
                         IF LeaseLine.FIND('-')THEN BEGIN

                        IF "Reletting Rate"<>0 THEN BEGIN
                        "Reletting Fee Amount":=LeaseLine."Total Amount Inclusive VAT"*("Reletting Rate"/100);
                        END ELSE
                        "Reletting Fee Amount":="Reletting Flat Amount";
                       MODIFY;
                       END
                       END;

                       END
                       END;
                       "Commission Amount":=MGT;
                       "VAT on Commission":=VATonCom;
                       "Payable To Landlord":=(CommAmount-ABS(Outflows))-"Commission Amount"-"Letting Fee Amount"-"Reletting Fee Amount";

                        MODIFY;

                       CurrPage.UPDATE();
                        RecptLine.RESET;
                        RecptLine.SETRANGE(RecptLine."Date Posted","From Date","To Date");
                        RecptLine.SETRANGE(RecptLine."Property Code","Property No.");
                        RecptLine.SETRANGE(RecptLine.Remmitted,TRUE);
                        RecptLine.SETFILTER(RecptLine.Remmitted,FORMAT(TRUE));
                        IF RecptLine.FIND('-')THEN BEGIN
                         ERROR('Landlord Remmitence has Already been processes for the period %1 %2',"From Date","To Date");
                         END;
                         */

                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        SalCard.Reset;
                        SalCard.SetRange(SalCard."No.", Rec."No.");
                        //REPORT.Run(52185948, true, false, SalCard);


                        //39005581
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*
                         IF  CONFIRM('Are You Sure You want to Post the Dues?',FALSE)=FALSE THEN BEGIN EXIT END;
                        
                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",'GENERAL');
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",'DUES');
                        GenJnlLine.DELETEALL;
                        
                        GSetup.RESET;
                        GSetup.GET();
                        IF GSetup."Landlord Dues G/L"='' THEN
                          BEGIN
                            ERROR('You must specify the Commission GL Account');
                          END;
                        IF GSetup."Commission Template"='' THEN
                          BEGIN
                            ERROR('You must specify the Commission Template');
                          END;
                        IF GSetup."Commission Batch"='' THEN
                          BEGIN
                            ERROR('You must specify the Commission Batch');
                          END;
                        TESTFIELD("Cheque No");
                        TESTFIELD("Paying Bank Account");
                        {IF GenJnlLine.FINDLAST THEN
                          BEGIN
                            IntC:=GenJnlLine."Line No.";
                          END;}
                          IntC:=IntC +10000;
                               //Landlord Dues
                            GenJnlLine.INIT;
                                GenJnlLine."Line No.":=IntC;
                                GenJnlLine."Source Code":='GENJNL';
                                GenJnlLine."Journal Template Name":='GENERAL';
                                GenJnlLine."Journal Batch Name":='DUES';
                                GenJnlLine."Posting Date":="Posting Date";
                                GenJnlLine."Document No.":='[' + FORMAT("No.") + ']' + "Property No.";
                                GenJnlLine."Account Type":=GenJnlLine."Account Type"::Vendor;
                                GenJnlLine."Account No.":="Landlord No.";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                GenJnlLine.Description:=COPYSTR('Landlord Dues: ' + FORMAT("From Date") + '..' + FORMAT("To Date"),1,50);
                                GenJnlLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine."Currency Code":=Currency;
                                GenJnlLine."Expense code":="Commission Fee";
                                GenJnlLine."Property Code":="Property No.";
                                GenJnlLine.ExpenseCommission:=TRUE;
                        
                                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                GenJnlLine.Amount:=("Commission Amount");
                                //GenJnlLine."Management Fee[Commission]":=-"Commission Amount";
                                 // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                //GenJnlLine."Bal. Account No.":=GSetup."Commission GL";
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        
                            GenJnlLine.INSERT;
                        
                        
                             //Management Fees
                          IntC:=IntC +10000;
                        
                            GenJnlLine.INIT;
                                GenJnlLine."Line No.":=IntC;
                                GenJnlLine."Source Code":='GENJNL';
                                GenJnlLine."Journal Template Name":='GENERAL';
                                GenJnlLine."Journal Batch Name":='DUES';
                                GenJnlLine."Posting Date":="Posting Date";
                                GenJnlLine."Document No.":= '[' + FORMAT("No.") + ']' + "Property No.";
                                GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No.":=GSetup."Management Account";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                GenJnlLine.Description:=COPYSTR('Management Fees: ' + FORMAT("From Date") + '..' + FORMAT("To Date"),1,50);
                                GenJnlLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine."Currency Code":=Currency;
                                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                GenJnlLine."Property Code":="Property No.";
                                 GenJnlLine."Expense code":="Commission Fee";
                        
                                GenJnlLine.Amount:=-"Commission Amount";
                                //GenJnlLine."Bal. Account Type":=GenJnlLine."Account Type"::Vendor;
                                //GenJnlLine."Bal. Account No.":="Landlord No.";
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                                //GenJnlLine."Applies-to Doc. No.":='[' + FORMAT("No.") + ']' + "Property No.";
                        
                            GenJnlLine.INSERT;
                        
                        //Post Net Payble
                          {IntC:=IntC +10000;
                        
                            GenJnlLine.INIT;
                                GenJnlLine."Line No.":=IntC;
                                GenJnlLine."Source Code":='GENJNL';
                                GenJnlLine."Journal Template Name":='GENERAL';
                                GenJnlLine."Journal Batch Name":='DUES';
                                GenJnlLine."Posting Date":="Posting Date";
                                GenJnlLine."External Document No.":="Cheque No";
                                GenJnlLine."Document No.":= '[' + FORMAT("No.") + ']' + "Property No.";
                                GenJnlLine."Account Type":=GenJnlLine."Account Type"::"Bank Account";
                                GenJnlLine."Account No.":="Paying Bank Account";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                GenJnlLine.Description:=COPYSTR('Net Payable: ' + FORMAT("From Date") + '..' + FORMAT("To Date"),1,50);
                                GenJnlLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine."Currency Code":=Currency;
                                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                GenJnlLine.Amount:=-"Payable To Landlord";
                                //GenJnlLine."Bal. Account Type":=GenJnlLine."Account Type"::Vendor;
                                //GenJnlLine."Bal. Account No.":="Landlord No.";
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                                //GenJnlLine."Applies-to Doc. No.":='[' + FORMAT("No.") + ']' + "Property No.";
                        
                            GenJnlLine.INSERT;
                        }
                        
                        
                        
                             //Letting Fees(mkirema)
                        //Check letting once transactions]
                         PropertyDet.RESET;
                         PropertyDet.SETRANGE(PropertyDet."No.","Property No.");
                         IF PropertyDet.FIND('-')THEN BEGIN
                        IF PropertyDet."Charge letting once"=FALSE THEN BEGIN
                           PropertyDet."Charge letting once":=TRUE;
                           PropertyDet.MODIFY;
                        
                          IntC:=IntC +10000;
                            GenJnlLine.INIT;
                                GenJnlLine."Line No.":=IntC;
                                GenJnlLine."Source Code":='GENJNL';
                                GenJnlLine."Journal Template Name":='GENERAL';
                                GenJnlLine."Journal Batch Name":='DUES';
                                GenJnlLine."Posting Date":="Posting Date";
                                GenJnlLine."Document No.":= '[' + FORMAT("No.") + ']' + "Property No.";
                                GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No.":=GSetup."Management Account";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                GenJnlLine.Description:=COPYSTR('Letting Fees: ' + FORMAT("From Date") + '..' + FORMAT("To Date"),1,50);
                                GenJnlLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine."Currency Code":=Currency;
                                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                GenJnlLine."Expense code":="Commission Fee";
                                GenJnlLine.Amount:=-"Letting Fee Amount";
                                GenJnlLine."Bal. Account Type":=GenJnlLine."Account Type"::Vendor;
                                GenJnlLine."Bal. Account No.":="Landlord No.";
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                                //GenJnlLine."Applies-to Doc. No.":='[' + FORMAT("No.") + ']' + "Property No.";
                        
                            GenJnlLine.INSERT;
                             //Reletting Fees(mkirema)
                          IntC:=IntC +10000;
                        
                            GenJnlLine.INIT;
                                GenJnlLine."Line No.":=IntC;
                                GenJnlLine."Source Code":='GENJNL';
                                GenJnlLine."Journal Template Name":='GENERAL';
                                GenJnlLine."Journal Batch Name":='DUES';
                                GenJnlLine."Posting Date":="Posting Date";
                                GenJnlLine."Document No.":= '[' + FORMAT("No.") + ']' + "Property No.";
                                GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No.":=GSetup."Management Account";
                                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                                GenJnlLine.Description:=COPYSTR('Reletting Fees: ' + FORMAT("From Date") + '..' + FORMAT("To Date"),1,50);
                                GenJnlLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                                GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine."Currency Code":=Currency;
                                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                                GenJnlLine."Expense code":="Commission Fee";
                                GenJnlLine.Amount:=-"Reletting Fee Amount";
                                GenJnlLine."Bal. Account Type":=GenJnlLine."Account Type"::Vendor;
                                GenJnlLine."Bal. Account No.":="Landlord No.";
                                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                                //GenJnlLine."Applies-to Doc. No.":='[' + FORMAT("No.") + ']' + "Property No.";
                            GenJnlLine.INSERT;
                           END;
                           END;
                        //SELECTS ALL RECIEPTS AS REMITTED
                         RecptLine.RESET;
                         RecptLine.SETRANGE(RecptLine."Date Posted","From Date","To Date");
                         RecptLine.SETRANGE(RecptLine."Property Code","Property No.");
                         IF RecptLine.FIND('-')THEN BEGIN
                         REPEAT
                          //RecptLine.Remmitted:=TRUE;
                          RecptLine.MODIFY;
                          UNTIL RecptLine.NEXT=0;
                        
                        END;
                        //SELECTS ALL EXPENSES AS REMITTED
                        {
                         GL.RESET;
                         GL.SETRANGE(GL."Posting Date","From Date","To Date");
                        GL.SETRANGE(GL."Property Code","Property No.");
                         IF GL.FIND('-')THEN BEGIN
                         REPEAT
                          GL."Expense Remmitted":=TRUE;
                          GL.MODIFY;
                          UNTIL GL.NEXT=0;
                        
                        END;
                        }
                        {
                           GenJnlLine.RESET;
                            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",GSetup."Commission Template");
                            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",GSetup."Commission Batch");
                            IF GenJnlLine.FIND('-') THEN BEGIN
                            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnlLine);
                            Processed:=TRUE;
                        
                            "Processed Date":=TODAY;
                            "Processed Time":=TIME;
                            "Processed By":=USERID;
                            MODIFY;
                            END;
                         }
                         *///mki to opened

                    end;
                }
            }
        }
        area(processing)
        {
            action("&Process")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Process';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    /*
                    BLedg.RESET;
                    BLedg.SETRANGE(BLedg."Posting Date","From Date","To Date");
                    BLedg.SETRANGE(BLedg."Property Code","Property No.");
                    BLedg.SETRANGE(BLedg.Reversed,FALSE);
                    
                    IF BLedg.FINDFIRST THEN
                      BEGIN
                    
                        LC.RESET;
                        IntC:=0;
                        IF LC.FINDLAST THEN
                          BEGIN
                            IntC:=LC."Line No.";
                          END;
                            IntC:=IntC +1;
                        LC.RESET;
                        LC.SETRANGE(LC."No.","No.");
                        IF LC.FINDFIRST THEN
                          BEGIN
                            LC.DELETEALL;
                          END;
                         LC.RESET;
                         //reset the values
                          Inflows:=0;
                          Outflows:=0;
                          "Commission Amount":=0;
                          "Payable To Landlord":=0;
                        REPEAT
                          LC.INIT;
                            LC."No.":="No.";
                            LC."Line No.":=IntC;
                            LC."Posting Date":=BLedg."Posting Date";
                            LC.Description:=BLedg.Description;
                            LC."Lease No.":=BLedg."Lease No.";
                           LC."Tenant No.":= BLedg."Tenant No";
                            IF LC."Lease No."<>'' THEN
                              BEGIN
                                L.RESET;
                                L.GET(LC."Lease No.");
                                LC."Tenant No.":=L."Tenant No.";
                              END;
                            LC.Amount:=BLedg.Amount;
                            IF BLedg.Amount <0 THEN
                              BEGIN
                                Outflows:=Outflows + BLedg.Amount;
                              END
                            ELSE
                              BEGIN
                                Inflows:=Inflows + BLedg.Amount;
                              END;
                          LC.INSERT;
                            IntC:=IntC +1;
                        UNTIL BLedg.NEXT=0;
                      END;
                      "Commission Amount":=(Inflows) ;
                      IF "Commission Rate"<>0 THEN
                      "Commission Amount":="Commission Amount" *("Commission Rate"/100)
                      ELSE
                      "Commission Amount":="Commssion Flat Amount";
                      "Payable To Landlord":=(Inflows-ABS(Outflows))-"Commission Amount";
                      MODIFY;
                    CurrPage.UPDATE();
                     */

                end;
            }
            action("&Post")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    GSetup.Reset;
                    GSetup.Get();
                    if GSetup."Landlord Dues G/L" = '' then begin
                        Error('You must specify the Commission GL Account');
                    end;
                    if GSetup."Commission Template" = '' then begin
                        Error('You must specify the Commission Template');
                    end;
                    if GSetup."Commission Batch" = '' then begin
                        Error('You must specify the Commission Batch');
                    end;
                    Rec.TestField("Cheque No");
                    Rec.TestField("Paying Bank Account");
                    /*IF GenJnlLine.FINDLAST THEN
                      BEGIN
                        IntC:=GenJnlLine."Line No.";
                      END;*/
                    IntC := IntC + 10000;
                    //Landlord Dues
                    GenJnlLine.Init;
                    GenJnlLine."Line No." := IntC;
                    GenJnlLine."Source Code" := 'GENJNL';
                    GenJnlLine."Journal Template Name" := 'GENERAL';
                    GenJnlLine."Journal Batch Name" := 'DUES';
                    GenJnlLine."Posting Date" := Today;
                    GenJnlLine."Document No." := '[' + Format(Rec."No.") + ']' + Rec."Property No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                    GenJnlLine."Account No." := Rec."Landlord No.";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine.Description := CopyStr('Landlord Dues: ' + Format(Rec."From Date") + '..' + Format(Rec."To Date"), 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine."Currency Code" := Rec.Currency;
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    GenJnlLine.Amount := (Rec."Payable To Landlord" + Rec."Commission Amount");
                    //GenJnlLine."Management Fee[Commission]":=-"Commission Amount";
                    // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                    //GenJnlLine."Bal. Account No.":=GSetup."Commission GL";
                    GenJnlLine.Validate(GenJnlLine.Amount);

                    GenJnlLine.Insert;


                    //Management Fees
                    IntC := IntC + 10000;

                    GenJnlLine.Init;
                    GenJnlLine."Line No." := IntC;
                    GenJnlLine."Source Code" := 'GENJNL';
                    GenJnlLine."Journal Template Name" := 'GENERAL';
                    GenJnlLine."Journal Batch Name" := 'DUES';
                    GenJnlLine."Posting Date" := Today;
                    GenJnlLine."Document No." := '[' + Format(Rec."No.") + ']' + Rec."Property No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                    GenJnlLine."Account No." := GSetup."Management Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine.Description := CopyStr('Management Fees: ' + Format(Rec."From Date") + '..' + Format(Rec."To Date"), 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine."Currency Code" := Rec.Currency;
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    GenJnlLine.Amount := -Rec."Commission Amount";
                    //GenJnlLine."Bal. Account Type":=GenJnlLine."Account Type"::Vendor;
                    //GenJnlLine."Bal. Account No.":="Landlord No.";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Applies-to Doc. No." := '[' + Format(Rec."No.") + ']' + Rec."Property No.";

                    GenJnlLine.Insert;

                    //Post Net Payble
                    IntC := IntC + 10000;

                    GenJnlLine.Init;
                    GenJnlLine."Line No." := IntC;
                    GenJnlLine."Source Code" := 'GENJNL';
                    GenJnlLine."Journal Template Name" := 'GENERAL';
                    GenJnlLine."Journal Batch Name" := 'DUES';
                    GenJnlLine."Posting Date" := Today;
                    GenJnlLine."External Document No." := Rec."Cheque No";
                    GenJnlLine."Document No." := '[' + Format(Rec."No.") + ']' + Rec."Property No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                    GenJnlLine."Account No." := Rec."Paying Bank Account";
                    GenJnlLine.Validate(GenJnlLine."Account No.");
                    GenJnlLine.Description := CopyStr('Net Payable: ' + Format(Rec."From Date") + '..' + Format(Rec."To Date"), 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine."Currency Code" := Rec.Currency;
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    GenJnlLine.Amount := -Rec."Payable To Landlord";
                    //GenJnlLine."Bal. Account Type":=GenJnlLine."Account Type"::Vendor;
                    //GenJnlLine."Bal. Account No.":="Landlord No.";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine."Applies-to Doc. No." := '[' + Format(Rec."No.") + ']' + Rec."Property No.";

                    GenJnlLine.Insert;






                    GenJnlLine.Reset;
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GSetup."Commission Template");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", GSetup."Commission Batch");
                    if GenJnlLine.Find('-') then begin
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                        Rec.Processed := true;
                        Rec."Processed Date" := Today;
                        Rec."Processed Time" := Time;
                        Rec."Processed By" := UserId;
                        Rec.Modify;
                    end;

                end;
            }
        }
    }

    var
        BLedg: Record "Bank Account Ledger Entry";
        IntC: Integer;
        LC: Record "Landlord Commision Calc Lines";
        L: Record Lease;
        GenJnlLine: Record "Gen. Journal Line";
        GSetup: Record "General Setup";
        SalCard: Record "Landlord Commission Calc";
        Month: Integer;
        D: Date;
        RecptLine: Record "Receipt Line";
        Charges: Record "Property Charges";
        CommAmount: Decimal;
        LeaseLine: Record "Lease Line";
        PropertyDet: Record "Property Details";
        GL: Record "G/L Entry";
        Expense: Decimal;
        LCExp: Record "Landlord Commision Calc LEXP";
        IntExp: Integer;
        MGT: Decimal;
        VATonCom: Decimal;
        MGTexclVAT: Decimal;
        T: Decimal;
        TOTALINFLOW: Decimal;
        Text19042409: Label 'Incomes';
        Text19022245: Label 'Expenses';
        FrmCalendar: Code[10];
}

