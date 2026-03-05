page 52186342 "Loan Application Card Dummy"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Loan File,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Loans;
    SourceTableView = WHERE(Posted = CONST(false),
                            "Dummy Appraisal" = FILTER(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("CRM Application No."; Rec."CRM Application No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff No';
                    Editable = ApplicationDetailsEdit;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member';
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Appraisal Parameter Type"; Rec."Appraisal Parameter Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Retirement/Expiry Date"; Rec."Retirement/Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Cost Value of House"; Rec."Cost Value of House")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Property Cost Value';
                    Editable = Morgage;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Amount Applied';
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'System Recommended Amount';
                    Editable = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Amount';
                    Editable = ApplicationDetailsEdit;
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Comment for Exemptions"; Rec."Comment for Exemptions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Visible = true;
                }
                field("CRB Rating"; Rec."CRB Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Purpose of Loan"; Rec."Purpose of Loan")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("BDE Type"; Rec."BDE Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                    Visible = false;
                }
                field("Relation Officer"; Rec."Relation Officer")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                    Visible = false;
                }
                field("Loan Appraised By"; Rec."Loan Appraised By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Loans - Deposit Purchase"; Rec."Loans - Deposit Purchase")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Share Boosting- Purchase';
                    Editable = ApplicationDetailsEdit;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Disbursement Account No"; Rec."Disbursement Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApprovedEdit;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Discounted Amount"; Rec."Discounted Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Disbursement Destination"; Rec."Disbursement Destination")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Disbursement Date"; Rec."Disbursement Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = true;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Rejection Reason"; Rec."Loan Rejection Reason")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DisbursementEdit;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Mortgage Insurance Amount"; Rec."Mortgage Insurance Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Create New")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            separator(Action72)
            {
            }
            action("Loan Payment Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ReturnCustomerBill;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Loan Payment Schedule";
                RunPageLink = "Loan No." = FIELD("Loan No.");
                Visible = false;
            }
            separator(Action18)
            {
            }
            action("Create Loan Account")
            {
                ApplicationArea = Basic, Suite;
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec."Loan Account" := LoanProcess.CreateLoanAccount(Rec."Member No.", Rec."Loan Product Type");
                    Rec.Modify;
                end;
            }
            separator(Action44)
            {
            }
            action("Partial Loan Disbursement Schedule")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Partial Loan Disbursement Schedule';
                Image = PutAwayWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Partial Disbursement Schedule";
                RunPageLink = "Loan No." = FIELD("Loan No.");
                Visible = false;
            }
            separator(Action21)
            {
            }
            action("Guarantors & Security")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Guarantors& Security';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Guarantors and Security";
                RunPageLink = "Loan No" = FIELD("Loan No.");
            }
            separator(Action24)
            {
            }
            action("Loan Top Ups")
            {
                ApplicationArea = Basic, Suite;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Top Up";
                RunPageLink = "Loan No." = FIELD("Loan No."),
                              "Client Code" = FIELD("Member No.");
            }
            separator(Action56)
            {
            }
            action("Repayment Method")
            {
                ApplicationArea = Basic, Suite;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Payment Method";
                RunPageLink = "Loan No." = FIELD("Loan No."),
                              "Member No." = FIELD("Member No.");

                trigger OnAction()
                begin

                    if Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Check Off" then begin
                        RepMethods.Reset;
                        RepMethods.SetRange("Loan No.", Rec."Loan No.");
                        if not RepMethods.Find('-') then begin
                            RepMethods."Loan No." := Rec."Loan No.";
                            RepMethods.Amount := Rec.Repayment;
                            RepMethods."Member No." := Rec."Member No.";
                            RepMethods."Payment Method" := RepMethods."Payment Method"::Checkoff;
                            RepMethods.Insert;
                        end;
                    end;
                end;
            }
            separator(Action25)
            {
            }
            action("Other Commitments Clearance")
            {
                ApplicationArea = Basic, Suite;
                Image = Cost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan No." = FIELD("Loan No.");
            }
            separator(Action27)
            {
            }
            action("Salary Details")
            {
                ApplicationArea = Basic, Suite;
                Image = StatisticsGroup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Appraisal Salary Details";
                RunPageLink = "Loan No" = FIELD("Loan No."),
                              "Client Code" = FIELD("Member No.");

                trigger OnAction()
                begin
                    //Load defaults
                    AppraisalDetailsSetup.Reset;
                    if AppraisalDetailsSetup.Find('-') then begin
                        repeat
                            AppraisalSalDetails.Reset;
                            AppraisalSalDetails.SetRange(AppraisalSalDetails."Loan No", Rec."Loan No.");
                            AppraisalSalDetails.SetRange(AppraisalSalDetails.Type, AppraisalDetailsSetup.Type);
                            AppraisalSalDetails.SetRange(Code, AppraisalDetailsSetup.Code);

                            if AppraisalSalDetails.Find('-') then
                                exit;
                            AppraisalSalDetails.Init;
                            AppraisalSalDetails."Loan No" := Rec."Loan No.";
                            AppraisalSalDetails."Client Code" := Rec."Member No.";
                            AppraisalSalDetails.Code := AppraisalDetailsSetup.Code;
                            AppraisalSalDetails.Description := AppraisalDetailsSetup.Description;
                            AppraisalSalDetails.Type := AppraisalDetailsSetup.Type;
                            AppraisalSalDetails.Insert;
                        until AppraisalDetailsSetup.Next = 0;
                    end;
                end;
            }
            separator(Action33)
            {
            }
            action("Loan Collateral")
            {
                ApplicationArea = Basic, Suite;
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Collaterals1";
                RunPageLink = "Loan No." = FIELD("Loan No."),
                              "Client Code" = FIELD("Member No.");
                Visible = false;
            }
            action("Generate Repayment  Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Posted then
                        Error('The loan is already posted thus cannot generate the schedule');

                    //Delete schedule
                    RSchedule.Reset;
                    RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan No.");
                    RSchedule.DeleteAll;

                    QCounter := 0;
                    QCounter := 3;




                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Loan No.", Rec."Loan No.");
                    if LoansR.Find('-') then begin

                        Rec.TestField("Disbursement Date");
                        Rec.TestField("Repayment Start Date");


                        LoanAmount := LoansR."Approved Amount";
                        InterestRate := LoansR.Interest;
                        RepayPeriod := LoansR.Installments;
                        InitialInstal := LoansR.Installments;
                        LBalance := LoansR."Approved Amount";
                        RunDate := Rec."Repayment Start Date";

                        InstalNo := 0;



                        //Repayment Frequency


                        repeat
                            InstalNo := InstalNo + 1;




                            //kma
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then begin
                                Rec.TestField(Interest);
                                Rec.TestField(Installments);
                                TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                                LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                                LPrincipal := TotalMRepay - LInterest;
                            end;

                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Straight Line" then begin
                                Rec.TestField(Interest);
                                Rec.TestField(Installments);
                                LPrincipal := LoanAmount / RepayPeriod;
                                LInterest := (InterestRate / 12 / 100) * LoanAmount;
                                //Grace Period Interest
                                //LInterest:=(LInterest*InitialInstal)/(InitialInstal-InitialGraceInt);
                            end;

                            if (Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance") or
                              (Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Flat") then begin
                                Rec.TestField(Interest);
                                Rec.TestField(Installments);
                                LPrincipal := LoanAmount / RepayPeriod;
                                LInterest := Round((InterestRate / 12 / 100) * LBalance, 1.0, '>');
                            end;
                            /*
                            IF "Interest Calculation Method"="Interest Calculation Method"::"Straight Line" THEN BEGIN
                            TESTFIELD(Repayment);
                            IF LBalance < Repayment THEN
                            LPrincipal:=LBalance
                            ELSE
                            LPrincipal:=Repayment;
                            LInterest:=Interest;
                            END;
                            */
                            //kma



                            //Grace Period
                            if GrPrinciple > 0 then begin
                                LPrincipal := 0
                            end else begin
                                //IF "Instalment Period" <> InPeriod THEN
                                LBalance := LBalance - LPrincipal;

                            end;

                            if GrInterest > 0 then
                                LInterest := 0;

                            GrPrinciple := GrPrinciple - 1;
                            GrInterest := GrInterest - 1;

                            Evaluate(RepayCode, Format(InstalNo));

                            RSchedule.Init;
                            RSchedule."Repayment Code" := RepayCode;
                            RSchedule."Loan No." := Rec."Loan No.";
                            RSchedule."Loan Amount" := LoanAmount;
                            RSchedule."Instalment No" := InstalNo;
                            RSchedule."Repayment Date" := RunDate;
                            RSchedule."Member No." := Rec."Member No.";
                            RSchedule."Loan Category" := Rec."Loan Product Type";
                            RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                            RSchedule."Monthly Interest" := LInterest;
                            RSchedule."Principal Repayment" := LPrincipal;
                            RSchedule.Insert;


                            //Repayment Frequency
                            if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Daily then
                                RunDate := CalcDate('1D', RunDate)
                            else
                                if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Weekly then
                                    RunDate := CalcDate('1W', RunDate)
                                else
                                    if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Monthly then
                                        RunDate := CalcDate('1M', RunDate)
                                    else
                                        if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Quarterly then
                                            RunDate := CalcDate('1Q', RunDate)
                                        else
                                            if Rec."Repayment Frequency" = Rec."Repayment Frequency"::"Bi-Annual" then
                                                RunDate := CalcDate('6M', RunDate)
                                            else
                                                if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Yearly then
                                                    RunDate := CalcDate('1Y', RunDate);

                        until LBalance < 1

                    end;

                    Commit;



                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    //if LoanApp.Find('-') then
                    //REPORT.Run(52185725, true, false, LoanApp);

                end;
            }
            separator(Action42)
            {
            }
            action("Mandatory Requirements")
            {
                ApplicationArea = Basic, Suite;
                Image = RegisteredDocs;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "Loan Required Documents";
                RunPageLink = "Loan No." = FIELD("Loan No.");
            }
            separator(Action47)
            {
            }
            separator(Action51)
            {
            }
            action("Loan History")
            {
                ApplicationArea = Basic, Suite;
                Image = History;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Loan History";
                RunPageLink = "Loan Application No." = FIELD("Loan No.");
            }
            separator(Action48)
            {
            }
            action("Business Income")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "Business Incomes";
                RunPageLink = "Loan No." = FIELD("Loan No.");

                trigger OnAction()
                begin
                    //here//LoanProcess.BusinessLoan(Rec);
                end;
            }
            separator(Action34)
            {
            }
            action("Clear Dummy")
            {
                ApplicationArea = Basic, Suite;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //LoansR.RESET;
                    //LoansR.SETRANGE("Loan No.",USERID);
                    //IF LoansR.FIND('-') THEN BEGIN
                    //LoansR."Loan No.":='';
                    /*LoansR."Member No.":='';
                    LoansR."Loan Product Type":='';
                    LoansR."Requested Amount":=0;
                    LoansR."Staff No":='';
                    LoansR."Loan Product Type Name":='';
                    LoansR."Member Name":='';
                    {LoansR."Loan Account":='';
                    LoansR."Disbursement Account No":='';}
                    LoansR.Status:=LoansR.Status::Open;
                    */
                    // LoansR.VALIDATE("Requested Amount");
                    //LoansR.
                    //  LoansR.MODIFY;

                    //LoansR.SETRANGE("Loan No.",USERID);
                    //IF LoansR.FIND('-') THEN BEGIN
                    //LoansR."Loan No.":='';
                    Rec."Member No." := '';
                    Rec."Loan Product Type" := '';
                    Rec."Requested Amount" := 0;
                    Rec."Approved Amount" := 0;
                    Rec."Application Date" := 0D;
                    Rec."Disbursement Date" := 0D;
                    Rec."Loan Product Type Name" := '';
                    Rec."Share Boosted Amount" := 0;
                    Rec.Installments := 0;
                    Rec.Interest := 0;
                    Rec."Staff No" := '';
                    Rec."Loan Product Type Name" := '';
                    Rec."Member Name" := '';
                    /*LoansR."Loan Account":='';
                    LoansR."Disbursement Account No":='';*/
                    Rec.Status := Rec.Status::Open;

                    // LoansR.VALIDATE("Requested Amount");
                    //LoansR.
                    Rec.Modify;
                    //END;

                    AppraisalSalDetails.Reset;
                    AppraisalSalDetails.SetRange("Loan No", Rec."Loan No.");
                    if AppraisalSalDetails.Find('-') then begin
                        AppraisalSalDetails.DeleteAll;
                    end;

                    ExternalComm.Reset;
                    ExternalComm.SetRange("Loan No.", Rec."Loan No.");
                    if ExternalComm.Find('-') then
                        ExternalComm.DeleteAll;

                    LoansTopup.Reset;
                    LoansTopup.SetRange("Loan No.", Rec."Loan No.");
                    if LoansTopup.Find('-') then
                        LoansTopup.DeleteAll;

                end;
            }
            separator(Action32)
            {
            }
            action("Financial Business Appraisal")
            {
                ApplicationArea = Basic, Suite;
                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "Business Appraisals";
                RunPageLink = "Loan No." = FIELD("Loan No.");
                Visible = true;

                trigger OnAction()
                begin
                    //Load defaults

                    if Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Corporate or Business" then begin

                        BusAppr.Reset;
                        if BusAppr.Find('-') then begin
                            repeat
                                BusApprDet.Reset;
                                BusApprDet.SetRange("Loan No.", Rec."Loan No.");
                                BusApprDet.SetRange(Position, BusAppr.Position);
                                if BusApprDet.Find('-') then
                                    exit;
                                TotalLoans := 0;
                                BusApprDet.Init;
                                BusApprDet.Code := BusAppr."Classifiaction Code";
                                BusApprDet.Position := BusAppr.Position;
                                BusApprDet.Description := BusAppr.Description;
                                if BusApprDet.Code = 'LONG TERM LOANS' then begin
                                    LoanApp.Reset;
                                    LoanApp.SetRange("Member No.", Rec."Member No.");
                                    if LoanApp.Find('-') then begin
                                        repeat
                                            LoanApp.CalcFields("Outstanding Balance");
                                            TotalLoans := TotalLoans + LoanApp."Outstanding Balance";
                                        until LoanApp.Next = 0;
                                    end;
                                end;
                                BusApprDet."Loan With Sacco" := TotalLoans;
                                BusApprDet."Financial Classification Code" := BusAppr."Financial Classifiaction";
                                BusApprDet."Loan No." := Rec."Loan No.";
                                BusApprDet.Insert;
                            until BusAppr.Next = 0;
                        end;
                    end;
                end;
            }
            separator(Action35)
            {
            }
            action("Business Evaluation Report")
            {
                ApplicationArea = Basic, Suite;
                Image = Report;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    //if LoanApp.Find('-') then
                    //REPORT.Run(52185655, true, false, LoanApp)
                end;
            }
            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ProdFac.Get(Rec."Loan Product Type");

                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    // if LoanApp.Find('-') then begin
                    //     if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Check Off" then begin
                    //         //if ProdFac."Mortgage Loan" = false then
                    //         //REPORT.Run(52185745, true, false, LoanApp)
                    //         //else
                    //         if ProdFac."Mortgage Loan" = true then begin
                    //             //if "Mortgage Insurance Amount" <= 0 then Error('Kindly specify Mortgage Insurance amount');
                    //             //REPORT.Run(52186957, true, false, LoanApp)
                    //         end;
                    //     end else
                    //         //if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::Salary then
                    //             //REPORT.Run(52185640, true, false, LoanApp)
                    //             //else
                    //             //if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Corporate or Business" then
                    //                 //REPORT.Run(52185655, true, false, LoanApp);
                    //     //OLD ONE 39004267
                    //end;
                end;
            }
            separator(Action37)
            {
            }
            action(Approve)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                var
                // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                end;
            }
            separator(Action28)
            {
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = false;

                trigger OnAction()
                var
                // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //Check minimum requirements
                    ValidateReq;
                    TotalOffset := 0;

                    //salaried loans
                    //Get if salary based loan and the frequency in that period
                    ProdFac.Get(Rec."Loan Product Type");

                    if ProdFac."Repay Mode" = ProdFac."Repay Mode"::Salary then begin
                        EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                        SalProc.Reset;
                        SalProc.SetRange("Account No.", Rec."Disbursement Account No");
                        SalProc.SetRange("Posting Date", EndDateSalo, Today);
                        SalProc.SetRange(Posted, true);
                        if SalProc.Find('-') then begin
                            if SalProc.Count < ProdFac."No. of Salary Times" then
                                Error(Text010);

                        end else
                            Error(Text010);
                    end;

                    //Check if checkoff product and ensure salary details captured
                    //Check if company code expects salary
                    if Cust.Get(Members."Employer Code") then begin
                        if (Cust."Loan Qualification" = Cust."Loan Qualification"::"Basic Pay") or (Cust."Loan Qualification" = Cust."Loan Qualification"::"Gross Pay") then
                            if (Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Check Off") or (Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::Salary) then begin
                                AppraisalSalDetails.Reset;
                                AppraisalSalDetails.SetRange("Loan No", Rec."Loan No.");
                                if not AppraisalSalDetails.Find('-') then
                                    Error(Text009);
                                if (AppraisalSalDetails.Type = AppraisalSalDetails.Type::Basic) and (AppraisalSalDetails.Amount = 0) then
                                    Error('Kindly capture Basic Salary information');
                            end else begin
                                RepMethods.Reset;
                                RepMethods.SetRange("Loan No.", Rec."Loan No.");
                                if RepMethods.Find('-') then begin
                                    if (RepMethods."Payment Method" <> RepMethods."Payment Method"::"Standing Order(External)") and
                                      (RepMethods."Payment Method" <> RepMethods."Payment Method"::"Standing Order(Internal)") then
                                        Error(Text013);
                                end;
                            end else
                            Error(Text012);

                    end;

                    //Check costs
                    PartialSched.Reset;
                    PartialSched.SetRange(PartialSched."Loan No.", Rec."Loan No.");
                    if PartialSched.Find('-') then begin
                        PartialSched.CalcSums(PartialSched.Amount);
                        if Rec."Amount To Disburse" + PartialSched.Amount <> Rec."Approved Amount" then
                            Error(AmtErr);
                    end;
                    Rec.TestField("Loan Account");
                    Rec.TestField("Disbursement Account No");
                    Rec.TestField("Disbursement Date");
                    Rec.TestField("Loan Product Type");
                    Rec.TestField("Amount To Disburse");
                    Rec.TestField("Global Dimension 1 Code");
                    //TESTFIELD("Global Dimension 2 Code");
                    Rec.TestField("Approved Amount");
                    Rec.TestField("Disbursement Account No");

                    //Repayment schedule
                    //RSchedule.RESET;
                    //RSchedule.SETRANGE(RSchedule."Loan No.","Loan No.");
                    //IF NOT RSchedule.FIND('-') THEN
                    //ERROR('Loan schedule must be generated first');

                    //
                    //Check if product allows multiple loans and if offset
                    LoanApp.Reset;
                    LoanApp.SetRange("Member No.", Rec."Member No.");
                    LoanApp.SetRange(Posted, true);
                    LoanApp.SetRange("Loan Product Type", Rec."Loan Product Type");
                    LoanApp.SetFilter("Outstanding Balance", '>0');
                    if LoanApp.Find('-') then begin
                        repeat
                            if ProdFac.Get(Rec."Loan Product Type") then begin
                                if ProdFac."Allow Multiple Running Loans" = false then begin
                                    LoansTopup.Reset;
                                    LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                                    LoansTopup.SetRange("Loan No.", Rec."Loan No.");
                                    if not LoansTopup.Find('-') then
                                        Error('Member already has an existing Loan %1 of same product', LoanApp."Loan No.");
                                end;
                            end;
                        until LoanApp.Next = 0;
                    end;
                    

                    //Confirm amounts
                    LoansTopup.Reset;
                    LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                    if LoansTopup.Find('-') then begin
                        LoansTopup.CalcSums(LoansTopup."Total Top Up");
                        TotalOffset := LoansTopup."Total Top Up";
                    end;

                    ExternalComm.Reset;
                    ExternalComm.SetRange(ExternalComm."Loan No.", Rec."Loan No.");
                    if ExternalComm.Find('-') then begin
                        ExternalComm.CalcSums(ExternalComm.Amount);
                        TotalOffset := TotalOffset + ExternalComm.Amount;
                    end;

                    if TotalOffset >= Rec."Approved Amount" then
                        Error(Text002, TotalOffset, Rec."Approved Amount");
                    //ConfirmReyments
                    LoanRepay := 0;
                    PaymentMethods.Reset;
                    PaymentMethods.SetRange(PaymentMethods."Loan No.", Rec."Loan No.");
                    PaymentMethods.SetRange(PaymentMethods."Member No.", Rec."Member No.");
                    if PaymentMethods.Find('-') then begin
                        repeat
                            LoanRepay := LoanRepay + PaymentMethods.Amount;
                        until PaymentMethods.Next = 0;
                    end;
                    if LoanRepay <> 0 then begin
                        if LoanRepay <> Rec.Repayment then
                            Error(ErrMssage);
                    end;
                    //

                    Members.Get(Rec."Member No.");
                    if Members.Status <> Members.Status::Active then
                        Error("InactiveErr:");


                    LoanGua.Reset;
                    LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
                    if LoanGua.Find('-') then begin
                        repeat
                            if Members.Get(LoanGua."Member No") then begin
                                if ProdFac.Get(Rec."Loan Product Type") then begin
                                    if (ProdFac."Max Amt on Guarantors" <> 0) and (ProdFac."Minimum Guarantors on Max Amt" = 0) then
                                        Error(Text007);
                                    if (ProdFac."Max Amt on Guarantors" = 0) and (ProdFac."Minimum Guarantors on Max Amt" <> 0) then
                                        Error(Text007);
                                    if (Rec."Approved Amount" > ProdFac."Max Amt on Guarantors") and (LoanGua.Count < (ProdFac."Minimum Guarantors on Max Amt")) then
                                        Error(Text008, ProdFac."Minimum Guarantors on Max Amt", ProdFac."Max Amt on Guarantors");
                                    if LoanGua.Count < ProdFac."Minimum Guarantors" then
                                        Error(Text006, ProdFac."Minimum Guarantors");
                                    //******************************Policies states any loan above 2M should have minimum of 10 guarantors
                                    if Rec."Approved Amount" > 2000000 then begin
                                        if LoanGua.Count < 10 then
                                            Error(Text006, 10);
                                    end;
                                    //*******************************************End of policies.....               
                                end;
                                LoanGua.CalcSums("Amount Guaranteed");
                                GenSetup.Get;
                                if GenSetup."Self Deposits(As Guarantor)" = true then begin
                                    SavAcc.Reset;
                                    SavAcc.SetRange(SavAcc."Member No.", Rec."Member No.");
                                    SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                                    if SavAcc.Find('-') then
                                        SavAcc.CalcFields(SavAcc."Balance (LCY)");
                                    if LoanGua."Amount Guaranteed" + SavAcc."Balance (LCY)" < Rec."Approved Amount" then
                                        Error(Text005);

                                end else
                                    if LoanGua."Amount Guaranteed" < Rec."Approved Amount" then
                                        Error(Text005);

                                //SendSMS.SendSms(SourceType::"Loan Guarantors",Members."Phone No.",'Your have guaranteed  '+"Member Name"+''+"Loan Product Type Name"+' Loan of ' +FORMAT("Approved Amount")+
                                //'. If in dispute call'+' '+CompInfo."Phone No.","Loan No.","Disbursement Account No",FALSE);
                            end;
                        until LoanGua.Next = 0;
                    end;

                    CompInfo.Get;
                    VarVariant := Rec;
                    // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                    // CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = false;

                trigger OnAction()
                var
                // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    VarVariant := Rec;
                    // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Re-Open Rejected Loan")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Rejected then begin
                        if Confirm('Are you sure you want to re-open the loan?', false) = true then begin
                            Rec.Status := Rec.Status::Open;
                            Rec.Modify;
                        end;
                    end;
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Visible = false;

                trigger OnAction()
                var
                // // //ApprovalEntries: Page "Approval Entries";
                // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    // // ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                end;
            }
            action("Loan [File]")
            {
                ApplicationArea = Basic, Suite;
                Image = Document;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DMS: Record EDMS;
                begin
                    DMS.Reset;
                    DMS.SetRange(DMS.Key, DMS.Key::"Loan File");
                    if DMS.Find('-') then begin
                        HyperLink(DMS."url path" + Rec."Loan No.");
                    end;
                end;
            }
            separator(Action67)
            {
            }
            action(Statement)
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    CustMembr.Reset;
                    CustMembr.SetRange(CustMembr."No.", Rec."Member No.");
                    //if CustMembr.Find('-') then
                    //REPORT.Run(52185621, true, false, CustMembr);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        StatusControl;
    end;

    trigger OnAfterGetRecord()
    begin
        /*SetControlAppearance;
        StatusControl;
        RESET;
        SETRANGE("Loan No.",USERID);
        "Dummy Appraisal":=TRUE;
        */
        //MODIFY;
        /*
        RESET;
        SETRANGE("Loan No.",USERID);
        IF NOT LoansR.GET(USERID) THEN BEGIN
          LoansR.INIT;
          LoansR."Loan No.":=USERID;
          "Dummy Appraisal":=TRUE;
          LoansR.INSERT(TRUE);
        END ELSE BEGIN
        LoansR.VALIDATE("Loan No.");
        "Dummy Appraisal":=TRUE;
        LoansR.MODIFY(TRUE);
        END;
        */

    end;

    trigger OnClosePage()
    begin
        Rec."Discounted Amount" := 0;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Dummy Appraisal" := true;
        Rec.Modify;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        StatusControl;
        Rec."Dummy Appraisal" := true;
        Rec.Modify;
    end;

    trigger OnOpenPage()
    begin
        StatusControl;
        if UserSetup.Get(UserId) then begin
            if UserSetup.Admin = false then begin
                Rec.Reset;
                Rec.SetRange("Loan No.", UserId);
                if not LoansR.Get(UserId) then begin
                    LoansR.Init;
                    LoansR."Loan No." := UserId;
                    Rec."Dummy Appraisal" := true;
                    LoansR.Insert(true);
                end else begin
                    LoansR.Validate("Loan No.");
                    Rec."Dummy Appraisal" := true;
                    LoansR.Modify(true);
                end;
            end;
        end;
    end;

    var
        Text001: Label 'Status Must Be Open';
        CustMembr: Record Members;
        LoanProcess: Codeunit "Loans Process";
        UpdateMember: Codeunit "DCS Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GetScore: Codeunit "DCS Management";
        LoansR: Record Loans;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        RSchedule: Record "Ideal Repayment Schedule";
        LoanApp: Record Loans;
        PartialSched: Record "Partial Disbursement Schedule";
        AmtErr: Label 'Amount for partial disbursement and amount to disburse must be equal to approved amount';
        AppraisalDetailsSetup: Record "Appraisal Salary Set-up";
        AppraisalSalDetails: Record "Appraisal Salary Details";
        LReq: Record "Loan Mandatory Requirements";
        LoanGua: Record "Loan Guarantors and Security";
        Coll: Record "Loan Collateral";
        Found: Boolean;
        SecErr: Label 'You have not provided neither collateral nor guarantors';
        SavAcc: Record "Savings Accounts";
        DepErr: Label 'This member does not have a deposit account';
        SalErr: Label 'Salary information is expected';
        ApplDocs: Record "Product Documents";
        LoanReqDocs: Record "Loan Required Documents";
        BusinessIncome: Record "Business Income";
        SendSMS: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        Members: Record Members;
        LoansTopup: Record "Loans Top up";
        ExternalComm: Record "Other Commitements Clearance";
        TotalOffset: Decimal;
        Text002: Label 'Total offset of %1 is more than approved amount of %2';
        ProdFac: Record "Product Factory";
        Text003: Label 'Loan Account is invalid';
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        Text004: Label 'The fund is already exhausted';
        PaymentMethods: Record "Payment Methods";
        LoanRepay: Decimal;
        ErrMssage: Label 'Repayment distribution is not equal to the loan repayment amount';
        Text005: Label 'Amount guaranteed is less than approved amount';
        Text006: Label 'Minimum number of guarantors not provided. They should be at least %1';
        Text007: Label 'Both Minimum Guarantors on Max Amt and Max Amt on Guarantors must be defined';
        Text008: Label 'The number of guarantors expected is less than the expected number of %1 where amount is more than %2';
        "InactiveErr:": Label 'This member is not active thus cannot qualify for a loan';
        RepMethods: Record "Payment Methods";
        CompInfo: Record "Company Information";
        Text009: Label 'This product requires salary details';
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        Text010: Label 'This member does not receive salary through the sacco';
        Text011: Label 'There are documents to be provided : %1';
        BusAppr: Record "Financial Appraisal setup";
        BusApprDet: Record "Business Loan Appraisal";
        TotalLoans: Decimal;
        GenSetup: Record "General Set-Up";
        Cust: Record Customer;
        Text012: Label 'The employer code is missing';
        Text013: Label 'Standing order must be provided for this loan';
        "******************************************************Controls": Integer;
        ApplicationDetailsEdit: Boolean;
        DisbursementEdit: Boolean;
        ApprovedEdit: Boolean;
        UserSetup: Record "User Setup";
        Morgage: Boolean;

    local procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;

    local procedure ValidateReq()
    begin
        if ProdFac.Get(Rec."Loan Product Type") then begin
            if CopyStr(ProdFac."Account No. Prefix", 1, 2) <> CopyStr(Rec."Loan Account", 1, 2) then
                Error(Text003);
        end;


        //Required documents
        LoanReqDocs.Reset;
        LoanReqDocs.SetRange("Loan No.", Rec."Loan No.");
        if LoanReqDocs.Find('-') then begin
            repeat
                if (LoanReqDocs."Provided ?" = LoanReqDocs."Provided ?"::" ") or (LoanReqDocs."Provided ?" = LoanReqDocs."Provided ?"::No) then
                    Error(Text011, LoanReqDocs.Description);
            until LoanReqDocs.Next = 0;
        end;

        //Check if external funds and confirm if funds are available
        if ProdFac."Source of Funds" = ProdFac."Source of Funds"::"External Fund" then begin
            ProdFac.TestField("Source Of Funds No.");
            if Vend.Get(ProdFac."Source Of Funds No.") then begin
                Vend.CalcFields("Balance (LCY)");
                if GLAcc.Get(ProdFac."Loan  Account [G/L]") then begin
                    GLAcc.CalcFields(Balance);
                end;

                if (GLAcc.Balance + Rec."Approved Amount") > Vend."Balance (LCY)" then
                    Error(Text004);

            end;
        end;
        LReq.Reset;
        LReq.SetRange(LReq."Loan No.", Rec."Loan No.");
        if LReq.Find('-') then begin
            case LReq."Mandatory Requirement" of

                LReq."Mandatory Requirement"::"Business Income":
                    begin

                    end;
                LReq."Mandatory Requirement"::"Collateral or Guarantors":
                    begin
                        Found := false;
                        LoanGua.Reset;
                        LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
                        if LoanGua.Find('-') then
                            Found := true;

                        Coll.Reset;
                        Coll.SetRange(Coll."Loan No.", Rec."Loan No.");
                        if Coll.Find('-') then
                            Found := true;

                        if Found = false then
                            Error(SecErr);

                    end;
                LReq."Mandatory Requirement"::"Member Deposits":
                    begin
                        SavAcc.Reset;
                        SavAcc.SetRange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                        SavAcc.SetRange(SavAcc."Member No.", Rec."Member No.");
                        if not SavAcc.Find('-') then begin
                            Error(DepErr);
                        end;

                    end;
                LReq."Mandatory Requirement"::Salary:
                    begin
                        AppraisalSalDetails.Reset;
                        AppraisalSalDetails.SetRange(AppraisalSalDetails."Client Code", Rec."Member No.");
                        if AppraisalSalDetails.Find('-') then begin
                            AppraisalSalDetails.CalcSums(AppraisalSalDetails.Amount);
                            if AppraisalSalDetails.Amount = 0 then
                                Error(SalErr);
                        end else
                            Error(SalErr);

                    end;
            end;
        end;
    end;

    //[Scope('OnPrem')]
    procedure StatusControl()
    begin
        case Rec.Status of
            Rec.Status::Open:
                begin
                    ApplicationDetailsEdit := true;
                    DisbursementEdit := true;
                    ApprovedEdit := false;
                end;

            Rec.Status::Pending, Rec.Status::Rejected:
                begin
                    ApplicationDetailsEdit := false;
                    DisbursementEdit := false;
                end;
            Rec.Status::Approved:
                begin
                    ApprovedEdit := true;
                    ApplicationDetailsEdit := false;
                    DisbursementEdit := false;
                end;

        end;

        //Controls
        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Mortgage Loan" = true then begin
                Morgage := true;
            end else begin
                Morgage := false;
            end;

        end;
    end;
}

