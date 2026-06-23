page 52185753 "Loan Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,History,Loan File,Cancellation,Category7_caption,Reopen Document,Approval request,EDMS,CRB - Metropol';
    SourceTable = Loans;
    SourceTableView = WHERE(Posted = CONST(false));
    DeleteAllowed = false;
    // InsertAllowed = false;
    Editable = true;
    //Ensure STOs are created for hybrid loans
    Permissions = TableData "Standing Order Header" = rim,
                    TableData "Standing Order Lines" = rim;
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
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member';
                    Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        SADVisible := false;
                        if Members.Get(Rec."Member No.") then
                            if Members."Employer Code" = '05' then
                                SADVisible := true;


                        if ProdFac.Get(Rec."Loan Product Type") then begin
                            if ProdFac."Mortgage Loan" = true then begin
                                Members.Get(Rec."Member No.");
                                if Members."Employer Code" = '99' then
                                    CheckRetirementDate := true
                                else
                                    CheckRetirementDate := false
                            end;
                        end;
                        if Members.Get(Rec."Member No.") then begin
                            if Members."Phone No." = '' then
                                MEssage('Member must have phone number in the system');

                            if StrLen(Members."Phone No.") < 10 then
                                Message('Member phone number is not valid');
                        end;


                    end;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff No';
                    Editable = ApplicationDetailsEdit;
                }
                field("Work Station"; Rec."Work Station")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Work Station';
                }
                field("Work Station Name"; Rec."Work Station Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Work Station Name';
                    Editable = false;
                }
                field("Member Class"; Rec."Member Class")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member Class';
                    Editable = false;
                }

                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Application Time"; Rec."Application Time")
                {
                    Editable = false;

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
                        ProdFac.Get(Rec."Loan Product Type");
                        //Commented for No salary
                        Members.Get(Rec."Member No.");
                        if (ProdFac."Requires Salary Processing" = true) then begin
                            //if ProdFac."Repay Mode" = ProdFac."Repay Mode"::Salary then begin
                            //IF NOT (Members."Member Class"='CONTRACT')AND (Members."Employer Code"='00') THEN BEGIN//To cater for BDE To receive salary advance

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
                            //END;
                        end;
                        ProdFac.Get(Rec."Loan Product Type");

                        if (ProdFac."Requires Salary Processing" = true) then begin
                            //IF NOT (Members."Member Class"='CONTRACT') AND (Members."Employer Code"='00')THEN BEGIN//To cater for BDE To receive salary advance
                            EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                            SalProc.Reset;
                            SalProc.SetRange("Account No.", Rec."Disbursement Account No");
                            SalProc.SetRange("Posting Date", EndDateSalo, Today);
                            //SalProc.SETRANGE(Posted,TRUE);
                            if SalProc.Find('-') then begin
                                if SalProc.Count < ProdFac."No. of Salary Times" then
                                    Error(Text010);

                            end else
                                Error(Text010);
                            //END;
                        end;

                        if ProdFac.Get(Rec."Loan Product Type") then begin
                            if ProdFac."Mortgage Loan" = true then
                                IfMortgage := true
                            else
                                IfMortgage := false;
                        end;

                        if ProdFac.Get(Rec."Loan Product Type") then begin
                            if ProdFac."Mortgage Loan" = true then begin
                                Members.Get(Rec."Member No.");
                                if Members."Employer Code" = '99' then
                                    CheckRetirementDate := true
                                else
                                    CheckRetirementDate := false
                            end;
                        end;

                        if ProdFac.Get(Rec."Loan Product Type") then begin
                            if ProdFac."Mortgage Loan" = true then
                                IsMortgageLoan := true
                            else
                                IsMortgageLoan := false;

                            if Rec."Loan Product Type" = '138' then
                                IfJenga := true
                            else
                                IfJenga := false;

                        end;
                        if ProdFac.Get(Rec."Loan Product Type") then begin
                            if ProdFac."Shamba Loan" = true then
                                IsShambaLoan := true
                            else
                                IsShambaLoan := false;

                            if ProdFac."Loan Security" = ProdFac."Loan Security"::" " then begin
                                isRequireSecurity := false;

                            end else begin
                                isRequireSecurity := true;
                            end;
                        end;

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
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                    trigger OnValidate()
                    begin
                        Rec.TestField("Member No.");
                        // if Rec."Recovery Mode" = Rec."Recovery Mode"::"Internal STO" then begin
                        //     SavingsAccounts.Reset;
                        //     SavingsAccounts.SetRange("Product Type", '505');
                        //     SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                        //     SavingsAccounts.SetRange("Salary Through FOSA", true);
                        //     if not SavingsAccounts.FindFirst then Error('Member''s salary does not pass through FOSA');
                        // end;
                        if (Rec."Recovery Mode" = Rec."Recovery Mode"::Hybrid) or (Rec."Recovery Mode" = Rec."Recovery Mode"::"Internal STO") or (Rec."Recovery Mode" = Rec."Recovery Mode"::Salary) then begin
                            // SavingsAccounts.Reset;
                            // SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"FOSA Account");
                            // SavingsAccounts.SetRange("Member No.", Rec."Member No.");
                            // SavingsAccounts.SetFilter("Salary Received", '>0');
                            // //SavingsAccounts.SetRange("Salary Through FOSA", true);
                            // if not SavingsAccounts.FindFirst then
                            //     Error('Member''s salary does not pass through FOSA');

                            // //check salary lines
                            //EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);
                            // //  EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"l), Today);
                            SalProc.Reset;
                            SalProc.SetRange("Account No.", Rec."Disbursement Account No");
                            //SalProc.SetRange("Posting Date", EndDateSalo, Today);
                            SalProc.SetRange(Posted, true);
                            if not SalProc.Find('-') then begin
                                if not confirm('Salary does not through FOSA. Do you wish to continue?', false) then
                                    error('Member Salary does not pass through FOSA.');
                            end;

                        end;

                        Rec.TestField("Loan Product Type");
                        if Rec."Loan Product Type" = '142' then begin
                            if (Rec."Recovery Mode" <> Rec."Recovery Mode"::Checkoff) and (Rec."Recovery Mode" <> Rec."Recovery Mode"::"Internal STO") then
                                Error('Recovery mode must be either Checkoff or internal STO');
                        end;
                    end;
                }

                field("Appraisal Parameter Type"; Rec."Appraisal Parameter Type")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = ApplicationDetailsEdit;
                }
                field("Member Age"; Rec."Member Age")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Retirement/Expiry Date"; Rec."Retirement/Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = CheckRetirementDate;
                }
                field("Months to Retire"; Rec."Months to Retire")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin
                        if (ProdFac."Requires Salary Processing" = true) then begin
                            //IF NOT (Members."Member Class"='CONTRACT') AND (Members."Employer Code"='00')THEN BEGIN//To cater for BDE To receive salary advance
                            EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                            SalProc.Reset;
                            SalProc.SetRange("Account No.", Rec."Disbursement Account No");
                            SalProc.SetRange("Posting Date", EndDateSalo, Today);
                            //SalProc.SETRANGE(Posted,TRUE);
                            if SalProc.Find('-') then begin
                                if SalProc.Count < ProdFac."No. of Salary Times" then
                                    Error(Text010);

                            end else
                                if (Rec."Loan Product Type" = '140') and (Rec.Installments > 72) then begin
                                    Rec.Installments := 72;
                                    Message('Installments must less than or equal to 72');
                                end;
                            //END;
                        end;
                    end;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Cost Value of House"; Rec."Cost Value of House")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = IfMortgage;
                    Visible = false;
                }
                field("Property Cost Value"; Rec."Property Cost Value")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Property Cost Value';
                    Editable = IsShambaLoan;
                    Visible = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEdit;

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
                    // Editable = ApplicationDetailsEdit;
                    Editable = false;// wonder why?kenpipe requested thats why
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin
                        if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::"Partial Disbursement" then
                            UseBatch := true
                    end;
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
                // field("Purpose of Loan"; Rec."Purpose of Loan")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = ApplicationDetailsEdit;
                //     // Visible = false;
                // }
                field("Share Boosted Amount"; Rec."Share Boosted Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("BDE Type"; Rec."BDE Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Relation Officer"; Rec."Relation Officer")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Loan Appraised By"; Rec."Loan Appraised By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Source Unit';
                    Editable = false;
                }
                field("Loans - Deposit Purchase"; Rec."Loans - Deposit Purchase")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposit Boosting';
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin
                        if Rec."Loans - Deposit Purchase" > Rec."Approved Amount" then
                            Error('you cannot share boost more than the approved amount');
                        // if Members.Get(Rec."Member No.") then begin
                        //     if Cust.Get(Members."Employer Code") then begin
                        //         if Cust."Self Employed" then begin
                        //             Error(ShareBoostError);
                        //             Rec."Loans - Deposit Purchase" := 0.0;
                        //             Rec.Modify;
                        //         end;
                        //     end;
                        // end;
                    end;
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
                    Editable = false;
                }
                field("Disbursement Account No"; Rec."Disbursement Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApprovedEdit;
                    //ditable = true;
                    // trigger OnValidate()
                    // begin
                    //     if (Rec.Status = Rec.Status::Approved) AND (Rec.Posted = Rec.Posted = false) then
                    //         UseBatch := true;
                    // end;
                }

                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Variated Amount"; Rec."Variated Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Discounted Amount"; Rec."Discounted Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApprovedEdit;
                }
                field("Amount In Arreas SACCO"; Rec."Amount In Arreas SACCO")
                {
                    ApplicationArea = all;
                }
                field("Amount In Arreas SASRA"; Rec."Amount In Arreas SASRA")
                {
                    ApplicationArea = all;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    ApplicationArea = all;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ApplicationDetailsEdit;

                    trigger OnValidate()
                    begin

                        if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::"Partial Disbursement" then
                            UseBatch := true else
                            UseBatch := false;
                    end;
                }
                field("Disbursement Destination"; Rec."Disbursement Destination")
                {
                    ApplicationArea = Basic, Suite;

                    Editable = false;//ApplicationDetailsEdit;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Details Verified By"; Rec."Details Verified By")
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
                    Editable = false;
                }
                field("disbursement time"; Rec."disbursement time")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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

                field("Loan Defferal Reason"; Rec."Loan Defferal Reason")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Sector Level2"; Rec."Sub Sector Level2")
                {
                    ApplicationArea = Basic, Suite;

                    //Editable = ApplicationDetailsEdit;
                    //Visible = false;
                }
                field("Hold Installment(s)"; Rec."Hold Installment(s)")
                {

                }
                field("Number Of Installment(s)"; Rec."Number Of Installment(s)")
                {

                }
                field("Moratorium Loan"; Rec."Moratorium Loan")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }

            }

            group("Sectoral Classification")
            {
                Caption = 'Sectoral Classification';
                Editable = true;
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Main Sector Description"; Rec."Main Sector Description")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Sub Sector Level1"; Rec."Sub Sector Level1")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                }
                field("Sub Sector Level1 Description"; Rec."Sub Sector Level1 Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(SubSectorLevel2; Rec."Sub Sector Level2")
                {
                    Caption = 'Sub Sector Level2';
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Sub Sector Level2 Description"; Rec."Sub Sector Level2 Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
            }
            group("External STO Details")
            {
                Caption = 'External STO Details';
                Editable = (Rec."Recovery Mode" = Rec."Recovery Mode"::"External STO");
                field("Client Bank Code"; Rec."Client Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Client Bank Name"; Rec."Client Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Client Account No"; Rec."Client Account No")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("External STO  Amount"; Rec."External STO  Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("External STO Effective Date"; Rec."External STO Effective Date")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
            }
            group("Hybrid Details")
            {
                Caption = 'Hybrid Details';
                Editable = Rec."Recovery Mode" = Rec."Recovery Mode"::Hybrid;


                field("Salary Amount"; Rec."Salary Amount")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = ApplicationDetailsEdit;
                    ShowMandatory = true;
                }
                field("Checkoff Amount"; Rec."Checkoff Amount")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = ApplicationDetailsEdit;
                    Editable = false;
                }
            }

        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                Caption = 'Member Images';
                SubPageLink = "Member No" = FIELD("Member No.");
            }
            // part("Member FactBox"; "Member FactBox")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Member FactBox';
            //     SubPageLink = "Member No." = field("Member No.");
            // }
            part("Loans Factbox"; "Loans Factbox")
            {
                ApplicationArea = Basic;
                Caption = 'Loan FactBox';
                SubPageLink = "Member No." = field("Member No.");
            }

        }
    }

    actions
    {
        area(creation)
        {
            // action("Loan Payment Schedule")
            // {
            //     Visible = false;
            //     ApplicationArea = Basic, Suite;
            //     Image = ReturnCustomerBill;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "Loan Payment Schedule";
            //     RunPageLink = "Loan No." = FIELD("Loan No.");
            // }
            // action(AssinedUser)
            // {
            //     ApplicationArea = all;
            //     Image = Task;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "User Tasks";
            //     RunPageLink = "Record ID" = FIELD("Loan No.");
            //     Caption = 'User Assigned';
            // }
            action("Create Loan Account")
            {
                ApplicationArea = Basic, Suite;
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if ProdFac.Get(Rec."Loan Product Type") then
                        if Credit.Get(ProdFac."Account No. Prefix" + Rec."Member No." + ProdFac."Account No. Suffix") then
                            Rec."Loan Account" := ProdFac."Account No. Prefix" + Rec."Member No." + ProdFac."Account No. Suffix"
                        else begin
                            Rec."Loan Account" := LoanProcess.CreateLoanAccount(Rec."Member No.", Rec."Loan Product Type");

                        end;
                    Rec.Modify;
                    Message('Loan account created successfully');
                end;
            }
            action("Update Disbursement Account")
            {
                ApplicationArea = Basic, Suite;
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Loan: record Loans;
                    SavAcc: record "Savings Accounts";
                begin
                    if loan.get(rec."Loan No.") then begin
                        if loan.Posted then error('Loan already posted');
                        if Loan."Member No." = '' then error('Kindly Enter member number before performing this action');
                        SavAcc.Reset;
                        SavAcc.SetRange(SavAcc."Member No.", loan."Member No.");
                        //SavAcc.SetRange(SavAcc."Loan Disbursement Account", true);
                        SavAcc.SetRange("Product Type", '191');
                        if SavAcc.Find('-') then begin
                            loan."Disbursement Account No" := SavAcc."No.";
                            Loan.modify;
                            Message('Loan disbursement account updated successfully');
                        end
                        else
                            Error('Member does not have a ordinary account');
                    end;
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
                Enabled = isRequireSecurity;
                PromotedIsBig = true;
                RunObject = Page "Loan Guarantors and Security";
                RunPageLink = "Loan No" = FIELD("Loan No.");
            }
            separator(Action24)
            {
            }
            action("Loan Top Ups")
            {
                Caption = 'Loan Refinancing';
                ApplicationArea = Basic, Suite;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Loan Top Up";
                RunPageLink = "Loan No." = FIELD("Loan No."),
                  "Client Code" = FIELD("Member No.");
            }
            // action("Loan Appraisal Summary")
            // {
            //     Image = Document;
            //     ApplicationArea = Basic, Suite;
            //     Promoted = true;
            //     Visible = true;
            //     PromotedCategory = Process;
            //     Caption = 'Loan Appraisal Summary';
            //     PromotedIsBig = true;
            //     RunObject = Page "Loan Appraisals";
            //     RunPageLink = "Loan No." = FIELD("Loan No.");

            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //         GloabalFunc: Codeunit "Global Functions";
            //     begin
            //         GloabalFunc.InsertAppraisalSummary(Rec."Loan No.");

            //     end;

            // }

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
                    if Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::Salary then begin
                        RepMethods.Reset;
                        RepMethods.SetRange("Loan No.", Rec."Loan No.");
                        if not RepMethods.Find('-') then begin
                            RepMethods."Loan No." := Rec."Loan No.";
                            RepMethods.Amount := Rec.Repayment;
                            RepMethods."Member No." := Rec."Member No.";
                            RepMethods."Payment Method" := RepMethods."Payment Method"::Salary;
                            RepMethods.Insert;
                        end;
                    end;
                end;
            }

            action("Other Commitments Clearance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Other Commitments/Loan Takeoff.';
                Image = Cost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Other Commitments Clearance";
                RunPageLink = "Loan No." = FIELD("Loan No.");
            }
            // action("Asset Finance Deduction")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = BarCode;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     RunObject = Page "Asset Finance Loans";
            //     RunPageLink = "Loan No." = FIELD("Loan No.");
            // }
            action("Loan Appraisal Comments")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageLink = "Loan No." = FIELD("Loan No.");
                RunObject = Page "52187231Loan Appr. Comments";
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
                        if Rec."Source Unit" = Rec."Source Unit"::FOSA then
                            AppraisalDetailsSetup.Setfilter("Source Unit", '=%1|%2', appraisalDetailsSetup."Source Unit"::" ", appraisalDetailsSetup."Source Unit"::FOSA)
                        else if Rec."Source Unit" = Rec."Source Unit"::BOSA then
                            AppraisalDetailsSetup.Setfilter("Source Unit", '=%1|%2', appraisalDetailsSetup."Source Unit"::" ", appraisalDetailsSetup."Source Unit"::BOSA);
                        repeat
                            AppraisalSalDetails.Reset;
                            AppraisalSalDetails.SetRange(AppraisalSalDetails."Loan No", Rec."Loan No.");
                            AppraisalSalDetails.SetRange(AppraisalSalDetails."Client Code", Rec."Member No.");
                            AppraisalSalDetails.SetRange(AppraisalSalDetails.Type, AppraisalDetailsSetup.Type);
                            AppraisalSalDetails.SetRange(Code, AppraisalDetailsSetup.Code);

                            if AppraisalSalDetails.Find('-') then
                                exit;
                            if Rec."Loan No." <> '' then begin
                                AppraisalSalDetails.Init;
                                AppraisalSalDetails."Loan No" := Rec."Loan No.";
                                AppraisalSalDetails."Client Code" := Rec."Member No.";
                                AppraisalSalDetails.Code := AppraisalDetailsSetup.Code;
                                AppraisalSalDetails.Description := AppraisalDetailsSetup.Description;
                                AppraisalSalDetails.Type := AppraisalDetailsSetup.Type;
                                AppraisalSalDetails.Rate := AppraisalDetailsSetup."Base Rate";
                                AppraisalSalDetails.Hours := AppraisalDetailsSetup."Base Hours";
                                AppraisalSalDetails.Insert;
                            end;
                        until AppraisalDetailsSetup.Next = 0;
                    end;
                end;
            }
            action("Loan Exceptions")
            {
                ApplicationArea = Basic, Suite;
                Image = StatisticsGroup;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Exceptions/ Rejection Reason";
                RunPageLink = Code = FIELD("Loan No.");
            }

            // action("Loan Collateral")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = SocialSecurity;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     RunObject = Page "Loan Collaterals1";
            //     RunPageLink = "Loan No." = FIELD("Loan No."),
            //                   "Client Code" = FIELD("Member No.");
            //     Visible = false;
            // }
            action("Generate Repayment  Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ProdFac: record "Product Factory";
                    LRepaymentSchedule: record "Ideal Repayment Schedule";
                begin

                    LRepaymentSchedule.Reset;
                    LRepaymentSchedule.SetRange(LRepaymentSchedule."Loan No.", Rec."Loan No.");
                    LRepaymentSchedule.DeleteAll();
                    LoanProcess.GenerateSchedule(Rec, True);

                    Commit;
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then
                        REPORT.Run(Report::"Ideal Repayment Schedule", true, false, LoanApp);

                end;
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
            action("Member Statistics")
            {
                ApplicationArea = Basic, Suite;
                Image = StatisticsGroup;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member Statistics";
                RunPageLink = "No." = FIELD("Member No.");

                trigger OnAction()
                begin
                    Rec.TestField(Rec."Member No.");

                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Show Hidden" = false then
                            Error('You do not have permissions to view this account information.');
                    end;

                end;
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

            // action("Business Income")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedIsBig = true;
            //     RunObject = Page "Business Incomes";
            //     RunPageLink = "Loan No." = FIELD("Loan No.");

            //     trigger OnAction()
            //     begin
            //         //LoanProcess.BusinessLoan(Rec);
            //     end;
            // }

            // action("Financial Business Appraisal")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = BankAccountStatement;
            //     Promoted = true;
            //     PromotedCategory = "Report";
            //     PromotedIsBig = true;
            //     RunObject = Page "Business Appraisals";
            //     RunPageLink = "Loan No." = FIELD("Loan No.");
            //     Visible = true;

            //     trigger OnAction()
            //     begin
            //         //Load defaults

            //         if Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Corporate or Business" then begin
            //             BusApprDet.Reset;
            //             BusApprDet.SetRange("Loan No.", Rec."Loan No.");
            //             BusApprDet.SetRange(Position, BusAppr.Position);
            //             if BusApprDet.Find('-') then
            //                 BusApprDet.DeleteAll;
            //             BusAppr.Reset;
            //             if BusAppr.Find('-') then begin
            //                 repeat
            //                     /*BusApprDet.RESET;
            //                     BusApprDet.SETRANGE("Loan No.","Loan No.");
            //                     BusApprDet.SETRANGE(Position,BusAppr.Position);
            //                     IF BusApprDet.FIND('-') THEN
            //                       EXIT;*/
            //                     TotalLoans := 0;
            //                     BusApprDet.Init;
            //                     BusApprDet.Code := BusAppr."Classifiaction Code";
            //                     BusApprDet.Position := BusAppr.Position;
            //                     BusApprDet.Description := BusAppr.Description;
            //                     if BusApprDet.Code = 'LONG TERM LOANS' then begin
            //                         LoanApp.Reset;
            //                         LoanApp.SetRange("Member No.", Rec."Member No.");
            //                         if LoanApp.Find('-') then begin
            //                             repeat
            //                                 LoanApp.CalcFields("Outstanding Balance");
            //                                 TotalLoans := TotalLoans + LoanApp."Outstanding Balance";
            //                             until LoanApp.Next = 0;
            //                         end;
            //                     end;
            //                     BusApprDet."Loan With Sacco" := TotalLoans;
            //                     BusApprDet."Financial Classification Code" := BusAppr."Financial Classifiaction";
            //                     BusApprDet."Loan No." := Rec."Loan No.";
            //                     BusApprDet.Insert;
            //                 until BusAppr.Next = 0;
            //             end;
            //         end;

            //     end;
            // }
            separator(Action35)
            {
            }

            action("Loan Appraisal Report")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ProdFac.Get(Rec."Loan Product Type");
                    Rec.TestField("Recovery Mode");


                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
                    LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
                    LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
                    if LoanApp.Find('-') then begin
                        LoansTopup.Reset;
                        LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                        LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                        if not LoansTopup.Find('-') then
                            Error('Member has an existing %1 Loan No. %2, Kindly TopUp', Rec."Loan Product Type", LoanApp."Loan No.");
                    end;

                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then begin
                        if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Check Off" then begin
                            if (ProdFac."Mortgage Loan" = false) then begin
                                REPORT.Run(Report::"Loan Appraisal Checkoff", true, false, LoanApp);
                                LoansR.reset;
                                LoansR.SetRange("Loan No.", Rec."Loan No.");
                                LoansR.SetRange(status, LoansR.status::Open);
                                if LoansR.Find('-') then begin
                                    LoansR."Loan Appraised By" := UserId;
                                    LoansR.Modify;
                                end;
                                CreateAppraisalBackup(LoanApp."Loan No.", 52185745);
                            end else
                                if ProdFac."Mortgage Loan" = true then begin
                                    IF rec."Mortgage Insurance Amount" <= 0 THEN ERROR('Kindly specify Mortgage Insurance amount');
                                    REPORT.Run(Report::"Loan Appraisal Haramb-Mortgage", true, false, LoanApp);
                                    LoansR.reset;
                                    LoansR.SetRange("Loan No.", Rec."Loan No.");
                                    LoansR.SetRange(status, LoansR.status::Open);
                                    if LoansR.Find('-') then begin
                                        LoansR."Loan Appraised By" := UserId;
                                        LoansR.Modify;
                                    end;
                                    CreateAppraisalBackup(LoanApp."Loan No.", 52185957);
                                end;
                        end;
                        if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::Salary then begin
                            REPORT.Run(Report::"Loan Appraisal Report-Salaried", true, false, LoanApp);
                            LoansR.reset;
                            LoansR.SetRange("Loan No.", Rec."Loan No.");
                            LoansR.SetRange(status, LoansR.status::Open);
                            if LoansR.Find('-') then begin
                                LoansR."Loan Appraised By" := UserId;
                                LoansR.Modify;
                            end;
                            CreateAppraisalBackup(LoanApp."Loan No.", 52185640);
                        end;
                        if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Corporate or Business" then begin
                            REPORT.Run(Report::"Loan Appraisal Bus-Special", true, false, LoanApp);
                            LoansR.reset;
                            LoansR.SetRange("Loan No.", Rec."Loan No.");
                            LoansR.SetRange(status, LoansR.status::Open);
                            if LoansR.Find('-') then begin
                                LoansR."Loan Appraised By" := UserId;
                                LoansR.Modify;
                            end;
                            CreateAppraisalBackup(LoanApp."Loan No.", 52185747);
                        end;
                        if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Staff Loans" then begin
                            REPORT.Run(Report::"Loan Appraisal Staff", true, false, LoanApp);
                            LoansR.reset;
                            LoansR.SetRange("Loan No.", Rec."Loan No.");
                            LoansR.SetRange(status, LoansR.status::Open);
                            if LoansR.Find('-') then begin
                                LoansR."Loan Appraised By" := UserId;
                                LoansR.Modify;
                            end;
                            CreateAppraisalBackup(LoanApp."Loan No.", 52186719);
                        end;
                        if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::Hybrid then begin
                            REPORT.Run(Report::"Loan Appraisal Hybrid", true, false, LoanApp);
                            LoansR.reset;
                            LoansR.SetRange("Loan No.", Rec."Loan No.");
                            LoansR.SetRange(status, LoansR.status::Open);
                            if LoansR.Find('-') then begin
                                LoansR."Loan Appraised By" := UserId;
                                LoansR.Modify;
                            end;
                            CreateAppraisalBackup(LoanApp."Loan No.", 52186204);
                        end;
                    end;

                end;
            }
            separator(Action53)
            {
            }
            action("Loan Appraisal Breakdown")
            {
                ApplicationArea = Basic, Suite;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ProdFac.Get(Rec."Loan Product Type");
                    Rec.TestField("Recovery Mode");
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
                    LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
                    LoanApp.SetFilter(LoanApp."Total Loan Balance", '>0');
                    if LoanApp.Find('-') then begin
                        LoanApp.CalcFields("Total Loan Balance");
                        if LoanApp."Total Loan Balance" > LoanApp.Repayment then begin
                            LoansTopup.Reset;
                            LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                            LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                            if not LoansTopup.Find('-') then
                                Error('Member has an existing %1 Loan No. %2, Kindly TopUp', Rec."Loan Product Type Name", LoanApp."Loan No.");
                        end;
                    end;
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
                    LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
                    LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
                    if LoanApp.Find('-') then begin
                        LoansTopup.Reset;
                        LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                        LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                        if not LoansTopup.Find('-') then
                            Error('Member has an existing %1 Loan No. %2, Kindly TopUp', Rec."Loan Product Type", LoanApp."Loan No.");
                    end;

                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then begin
                        // if LoanApp."Appraisal Parameter Type" = LoanApp."Appraisal Parameter Type"::"Check Off" then begin
                        if (ProdFac."Mortgage Loan" = false) then begin
                            REPORT.Run(Report::"Eligibilty Check", true, false, LoanApp);
                            LoansR.reset;
                            LoansR.SetRange("Loan No.", Rec."Loan No.");
                            if LoansR.Find('-') then begin
                                LoansR."Loan Appraised By" := UserId;
                                LoansR.Modify;
                            end;
                            // CreateAppraisalBackup(LoanApp."Loan No.", 52185745);
                            // end
                        end;

                    end;

                end;
            }
            // action("Post Advance")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = PostDocument;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = false;

            //     trigger OnAction()
            //     begin
            //         if Confirm('Are you sure you want to Post?', false) = true then begin
            //             if ProdFac.Get(Rec."Loan Product Type") then begin
            //                 if ProdFac."Does not Require Batching" then
            //                     LoanProcess.PostSingleLoan(Rec."Loan No.")
            //                 else
            //                     Error('This product requires a batch process');
            //             end;
            //         end;
            //     end;
            // }
            action("Loan Terms And conditions")
            {
                ApplicationArea = all;
                Image = DocumentEdit;
                Promoted = true;
                Caption = '';
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunPageLink = "Loan No." = FIELD("Loan No.");
                RunObject = Page "loan Tearms And Conditions";
            }



            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Enabled = NOT OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    CustomApprovals: Codeunit "Custom Approvals Codeunit";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    MemberClass: Record "Member Classes";
                    SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";

                    EDMSFunc: Codeunit "EDMS Functions";
                    SendM: Boolean;
                    Loan: record Loans;
                    MemberGuarantor: record Members;
                    GlobalFunctions: Codeunit "Global Functions";
                    LRepaymentSchedule: record "Ideal Repayment Schedule";
                begin
                    userSetup.get(USERID);
                    if userSetup."Member No." = Rec."Member No." then begin
                        Error('You cannot capture your own loan application.');
                    end;

                    //Check minimum requirements
                    Rec.TestField("Recovery Mode");
                    if rec."Approved Amount" <= 0 then Error('Ensure Approved amount has a value');
                    //For DOD Members
                    if Mem.Get(Rec."Member No.") then begin
                        if Mem."Employer Code" = '05' then
                            Rec.TestField("SAD No.");
                    end;

                    // Verify EDMS
                    if Rec."Source Aplication" <> Rec."Source Aplication"::BC then begin
                        EDMSFunc.CheckApplicationHasScannedDocuments(Rec."Loan No.");
                    end;

                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Member No.", Rec."Member No.");
                    LoanApp.SetRange(LoanApp."Loan Product Type", Rec."Loan Product Type");
                    LoanApp.SetFilter(LoanApp."Total Loan Balance", '>0');
                    if LoanApp.Find('-') then begin
                        LoanApp.CalcFields("Total Loan Balance");
                        if LoanApp."Total Loan Balance" > LoanApp.Repayment then begin
                            LoansTopup.Reset;
                            LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                            LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                            if not LoansTopup.Find('-') then
                                Error('Member has an existing %1 Loan No. %2, Kindly TopUp', Rec."Loan Product Type Name", LoanApp."Loan No.");
                        end;
                    end;

                    ValidateReq;
                    TotalOffset := 0;
                    GenSetup.Get();
                    if Mem.Get(Rec."Member No.") then begin
                        RetirementDate := CalcDate(Format(GenSetup."Max. Member Age"), Mem."Date of Birth");
                        if Mem."Employer Code" <> '99' then begin
                            if Mem."From Another Sacco" = false then begin
                                ClientAge := HRDates.DetermineAge(Mem."Date of Birth", Today);
                                ClientAgePart := CopyStr(ClientAge, 1, 2);
                                ClientAgePart := CopyStr(ClientAge, 1, 2);
                                Evaluate(ClientAgeValue, ClientAgePart);
                                adj := Round((((RetirementDate - Rec."Repayment Start Date") / 365) * 12), 1, '<');
                                //if adj < Rec.Installments then
                                //    Error('This member is ' + ClientAgePart + ' ' + 'yrs' + ',' + 'and will be retiring in' + ' ' + Format(adj) + ' ' + 'Months');
                            end;
                        end;
                    end;
                    //Get if salary based loan and the frequency in that period
                    ProdFac.Get(Rec."Loan Product Type");
                    //Commented for No salary
                    if ProdFac."Requires Salary Processing" = true then begin
                        if ProdFac."Repay Mode" = ProdFac."Repay Mode"::Salary then begin
                            EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                            SalProc.Reset;
                            SalProc.SetRange("Account No.", Rec."Disbursement Account No");
                            SalProc.SetRange("Posting Date", EndDateSalo, Today);
                            SalProc.SetRange(Posted, true);
                            if SalProc.Find('-') then begin
                                if SalProc.Count < ProdFac."No. of Salary Times" then
                                    Error(Text010);

                            end; /*ELSE
                       ERROR(Text010);*/
                        end;
                    end;
                    ProdFac.Get(Rec."Loan Product Type");
                    if ProdFac."Requires Salary Processing" = true then begin
                        EndDateSalo := CalcDate('-' + Format(ProdFac."Salary Period"), Today);//+FORMAT(ProdFac."No. of Salary Times")
                        SalProc.Reset;
                        SalProc.SetRange("Account No.", Rec."Disbursement Account No");
                        SalProc.SetRange("Posting Date", EndDateSalo, Today);
                        SalProc.SetRange(Posted, true);
                        if SalProc.Find('-') then begin
                            if SalProc.Count < ProdFac."No. of Salary Times" then
                                Error(Text010);

                        end;/* ELSE
                       ERROR(Text010);*/
                    end;



                    //Check if checkoff product and ensure salary details captured
                    //Check if company code expects salary
                    //IF Cust.GET(Members."Employer Code") THEN BEGIN
                    Members.Get(Rec."Member No.");
                    Cust.Reset;
                    Cust.SetRange("No.", Members."Employer Code");
                    if Cust.Find('-') then begin
                        if (Cust."Loan Qualification" = Cust."Loan Qualification"::"Basic Pay") or (Cust."Loan Qualification" = Cust."Loan Qualification"::"Gross Pay") then
                            if (Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::"Check Off") or (Rec."Appraisal Parameter Type" = Rec."Appraisal Parameter Type"::Salary) then begin
                                AppraisalSalDetails.Reset;
                                AppraisalSalDetails.SetRange("Loan No", Rec."Loan No.");
                                if not AppraisalSalDetails.Find('-') then
                                    Error(Text009);
                                if (AppraisalSalDetails.Type = AppraisalSalDetails.Type::"Gross Pay") and (AppraisalSalDetails.Amount = 0) then
                                    Error('Kindly capture Basic Salary information');
                            end else begin
                                RepMethods.Reset;
                                RepMethods.SetRange("Loan No.", Rec."Loan No.");
                                RepMethods.setfilter(amount, '>%1', 0);
                                if RepMethods.Find('-') then begin
                                    if (RepMethods."Payment Method" = RepMethods."Payment Method"::"Standing Order(External)") or
                                      (RepMethods."Payment Method" = RepMethods."Payment Method"::"Standing Order(Internal)") then
                                        Error(Text013);
                                end;
                            end;
                    end else
                        Error(Text012);



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
                    Rec.TestField("Loan Account");
                    //TESTFIELD("Global Dimension 2 Code");
                    Rec.TestField("Approved Amount");
                    Rec.TestField("Disbursement Account No");
                    //Rec.TestField("Sub Sector Level2");
                    Rec.TestField("Main Sector");
                    Rec.TestField("Sub Sector Level1");
                    ///Rec.TestField("Sub Sector Level2");
                    if Rec."Recovery Mode" = Rec."Recovery Mode"::Hybrid then begin
                        if Rec."Salary Amount" = 0 then begin
                            error('Please enter salary amount!')
                        end;
                    end;

                    //test recommended amount
                    IF Rec."Approved Amount" > Rec."Recommended Amount" THEN
                        ERROR('You cannot apply more than the recommended amount of %1 .', Rec."Recommended Amount");

                    IF Rec."Amount To Disburse" > Rec."Recommended Amount" THEN
                        ERROR('You cannot apply more than the recommended amount of %1 .', Rec."Recommended Amount");

                    //test recommendedamount
                    ProdFac.Get(Rec."Loan Product Type");
                    if ProdFac."Mortgage Loan" = true then begin
                        Rec.TestField("Three Months Payslip", true);
                        //TESTFIELD("Mortgage Protection Policy",TRUE);
                        //TESTFIELD("Domestic Insurance Cover",TRUE);
                        Rec.TestField("Employer Introduction Letter", true);
                        Rec.TestField("Six Months Bank Statement", true);
                        Rec.TestField("National ID", true);
                        Rec.TestField("Title/Lease Provided", true);
                        Rec.TestField("Title/Lease No");
                        Rec.TestField("ID No.");
                        Rec.TestField("KRA PIN");
                        Rec.TestField("KRA PIN Copy", true);
                        Rec.TestField("Vendor Letter/Sale Agreement", true);
                        "CheckDisbursementA/CBalance"(Rec."Disbursement Account No");
                        //IF "Mortgage Insurance Amount"<=0 THEN ERROR('Kindly specify Mortgage Insurance amount');
                        if Rec."Loan Product Type" = '138' then begin
                            Rec.TestField("Drawdown Schedule", true);
                            Rec.TestField("Injury Benefit Insurance", true);
                        end;
                    end;


                    if Rec."Loan Product Type" = '142' then begin
                        Rec.TestField("Land Valuation Done", true);
                        Rec.TestField("Sale Agreement", true);
                        Rec.TestField("20% Payment Slip", true);
                        Rec.TestField("Title Deed");
                    end;
                    //Repayment schedule
                    RSchedule.RESET;
                    RSchedule.SETRANGE(RSchedule."Loan No.", rec."Loan No.");
                    IF NOT RSchedule.FIND('-') THEN begin
                        if Confirm('Loan repayment schedule has not been generated. Do you want to generate it now?', false) then begin
                            LRepaymentSchedule.Reset;
                            LRepaymentSchedule.SetRange(LRepaymentSchedule."Loan No.", Rec."Loan No.");
                            LRepaymentSchedule.DeleteAll();
                            LoanProcess.GenerateSchedule(Rec, True);

                            Commit;
                            LoanApp.Reset;
                            LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                            if LoanApp.Find('-') then
                                REPORT.Run(Report::"Ideal Repayment Schedule", true, false, LoanApp);
                        end
                        else
                            ERROR('Loan repayment schedule must be generated first');
                    end;


                    //
                    // //Check if product allows multiple loans and if offset
                    // LoanApp.Reset;
                    // LoanApp.SetRange("Member No.", Rec."Member No.");
                    // LoanApp.SetRange(Posted, true);
                    // LoanApp.SetRange("Loan Product Type", Rec."Loan Product Type");
                    // LoanApp.SetFilter("Outstanding Balance", '>0');
                    // if LoanApp.Find('-') then begin
                    //     repeat
                    //         if ProdFac.Get(Rec."Loan Product Type") then begin
                    //             if ProdFac."Allow Multiple Running Loans" = false then begin
                    //                 LoansTopup.Reset;
                    //                 LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                    //                 LoansTopup.SetRange("Loan No.", Rec."Loan No.");
                    //                 if not LoansTopup.Find('-') then
                    //                     Error('Member already has an existing Loan %1 of same product', LoanApp."Loan No.");
                    //             end;
                    //         end;
                    //     until LoanApp.Next = 0;
                    // end;
                    //long term loans and multiple loans check
                    // Check if product allows multiple loans and if offset
                    LoanApp.Reset;
                    LoanApp.SetRange("Member No.", Rec."Member No.");
                    LoanApp.SetRange(Posted, true);
                    LoanApp.SetFilter("Outstanding Balance", '>0');
                    if LoanApp.Find('-') then begin
                        repeat
                            // Get product setup for this loan

                            if ProdFac.Get(LoanApp."Loan Product Type") then begin

                                //Check if this product is a Long Term Loan

                                //Allow multiple long term  loans--

                                // if ProdFac."Loan Term Type" = ProdFac."Loan Term Type"::"Long Term" then begin
                                //     LoansTopup.Reset;
                                //     LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                                //     LoansTopup.SetRange("Loan No.", Rec."Loan No.");
                                //     if not LoansTopup.Find('-') then
                                //         Error(
                                //           'Member already has an existing Long Term Loan %1 and cannot apply for another loan.',
                                //           LoanApp."Loan No."
                                //         );
                                // end;


                                //check if it allows multiple running loans             
                                if ProdFac."Allow Multiple Running Loans" = false then begin
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
                                end;
                                //end of check multiple running loans
                            end;
                        until LoanApp.Next = 0;
                    end;

                    //end of long term loans and multiple loans check
                    GenSetup.Get;
                    //Confirm amounts
                    LoansTopup.Reset;
                    LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                    if LoansTopup.Find('-') then begin
                        LoansTopup.CalcSums(LoansTopup."Total Top Up");
                        TotalOffset := LoansTopup."Total Top Up";
                    end;

                    LoanApp.Reset;
                    LoanApp.SetRange("Member No.", Rec."Member No.");
                    LoanApp.SetFilter("Outstanding Balance", '>0');
                    LoanApp.SetFilter("Loan Product Type", '<>FGL&<>BGL');
                    LoanApp.SetFilter("Loans Category-SASRA", '%1..%2', GenSetup."Allowed Loan Categories", LoanApp."Loans Category-SASRA"::Loss);
                    if LoanApp.Find('-') then begin
                        repeat
                            if GenSetup."Allowed Loan Categories" <> LoanApp."Loans Category-SASRA"::Loss then begin
                                LoansTopup.Reset;
                                LoansTopup.SetRange("Loan Top Up", LoanApp."Loan No.");
                                if not LoansTopup.Find('-') then begin
                                    Error('Member has a loan that is not performing %1', LoanApp."Loan No.");
                                end;
                            end;
                        until LoanApp.Next = 0;
                    end;

                    ExternalComm.Reset;
                    ExternalComm.SetRange(ExternalComm."Loan No.", Rec."Loan No.");
                    if ExternalComm.Find('-') then begin
                        ExternalComm.CalcSums(ExternalComm.Amount);
                        TotalOffset := TotalOffset + ExternalComm.Amount;
                    end;

                    if TotalOffset >= Rec."Approved Amount" then
                        Error(Text002, TotalOffset, Rec."Approved Amount");

                    TotalAssetFin := 0;
                    AssetFinanceLoan.Reset;
                    AssetFinanceLoan.SetRange(AssetFinanceLoan."Loan No.", Rec."Loan No.");
                    if AssetFinanceLoan.Find('-') then begin
                        AssetFinanceLoan.CalcSums(AssetFinanceLoan.Amount);
                        TotalAssetFin := TotalAssetFin + AssetFinanceLoan.Amount;
                    end;

                    if TotalAssetFin >= Rec."Approved Amount" then
                        Error(Text014, TotalAssetFin, Rec."Approved Amount");



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


                    if Rec."Self Guarantee" = false then begin
                        if ProdFac.Get(Rec."Loan Product Type") then begin
                            if (ProdFac."Max Amt on Guarantors" <> 0) or (ProdFac."Minimum Guarantors" <> 0) then begin
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

                                            end;
                                            LoanGua.CalcSums("Amount Guaranteed");
                                            LoanGua.CalcFields("Total Sum");

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
                                                if LoanGua."Total Sum" < Rec."Approved Amount" then
                                                    Error(Text005);

                                            //SendSMS.SendSms(SourceType::"Loan Guarantors",Members."Phone No.",'Your have guaranteed  '+"Member Name"+''+"Loan Product Type Name"+' Loan of ' +FORMAT("Approved Amount")+
                                            //'. If in dispute call'+' '+CompInfo."Phone No.","Loan No.","Disbursement Account No",FALSE);
                                        end;
                                    until LoanGua.Next = 0;
                                end else
                                    Error(Text006, ProdFac."Minimum Guarantors");
                            end;
                        end;
                    end;

                    // Members.Get(Rec."Member No.");
                    // SegmentCountyDividendSignat.Reset;
                    // SegmentCountyDividendSignat.SetRange(Type, SegmentCountyDividendSignat.Type::Segment);
                    // SegmentCountyDividendSignat.SetRange(Code, Members."Member Segment");
                    // if SegmentCountyDividendSignat.Find('-') then begin
                    //     MemberClass.Reset;
                    //     MemberClass.SetRange("No.", Members."Member Class");
                    //     if MemberClass.FindFirst then begin
                    //         //Share Capital
                    //         SavAcc.Reset;
                    //         SavAcc.SetRange("Member No.", Rec."Member No.");
                    //         SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Share Capital");
                    //         if SavAcc.Find('-') then begin
                    //             SavAcc.CalcFields("Balance (LCY)");
                    //             if (SavAcc."Balance (LCY)") < MemberClass."Share Capital" then
                    //                 Error('Share capital less than Kes %1', MemberClass."Share Capital");
                    //         end;
                    //     end;
                    // end;

                    if (Rec."Recovery Mode" = Rec."Recovery Mode"::"External STO") then begin
                        Rec.TestField("Client Bank Code");
                        Rec.TestField("Client Account No");
                        Rec.TestField("External STO Effective Date");
                    end;
                    // //update amount guarantee
                    // GlobalFunctions.UpdateAmountGuaranteed(Rec."Loan No.", Rec."Approved Amount");
                    // //update amount guaranteed


                    LoanGua.Reset;
                    LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
                    LoanGua.SetRange("SMS Sent", false);
                    if LoanGua.FindFirst then begin
                        //Message('Some Messages have not been sent to the guarantors');
                        SendM := true;
                    end;
                    if SendM = true then begin
                        if Confirm('Do you wish to Send Guarantor SMS?', false) then begin
                            if Loan.Get(Rec."Loan No.") then begin
                                LoanGua.Reset;
                                LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
                                LoanGua.SetRange("SMS Sent", false);
                                if LoanGua.Find('-') then begin
                                    repeat
                                        // MESSAGE(FORMAT(LoanGua."Member No"));
                                        if Members.Get(LoanGua."Member No") then begin
                                            if Members."Phone No." <> '' then begin
                                                if Loan.Posted = true then
                                                    exit;
                                                CompInfo.Get;
                                                MemberGuarantor.Get(LoanGua."Member Guaranteed");

                                                msg := 'Dear Member, You have guaranteed MNo: '
                                                + LoanGua."Member Guaranteed" + '-' + MemberGuarantor.Name + ' ' + Loan."Loan Product Type Name" + ' of KES ' +
                                                Format(Loan."Requested Amount") + '. If in dispute call' + ' ' + CompInfo."Phone No.";

                                                SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');

                                                LoanGua."SMS Sent" := true;
                                                LoanGua.Modify;
                                            end;
                                        end;
                                    until LoanGua.Next = 0;

                                    //END;
                                end;
                                // if Members.Get(Loan."Member No.") then begin
                                //     if Loan."SMS Sent" = false then begin

                                //         msg := 'You loan application of ' + ' ' + Loan."Loan Product Type Name" + ' of ' + ' Kes' + Format(Loan."Approved Amount") + ' ' + 'is being processed';

                                //         SendSMS.SendSms(Source::MBANKING, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');
                                //     end;
                                // end;
                            end;
                        end;
                    end;

                    //checkguarcount
                    if Loan.Get(Rec."Loan No.") then begin
                        LoanGua.Reset;
                        LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No.");
                        LoanGua.SetRange("Self Guarantee", false);
                        if LoanGua.count < 6 then begin
                            if rec."Approved Amount" > 100000 then begin
                                Error('Minimum guarantors should be 6 for loans above 100000');
                            end;
                        end;
                    end;

                    CompInfo.Get;
                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                        currpage.close;
                    end;

                end;
            }
            action(Comments)
            {
                Caption = 'Approval/Rejection Comments';
                ApplicationArea = Basic, Suite;
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category9;

                RunObject = page "Comments List";
                RunPageLink = "Header No." = field("Loan No.");
                RunPageView = where(Types = CONST(comment));
            }
            // action("Change Current user'")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Update Current User';
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     Visible = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     begin
            //         if Rec."Current User" <> '' then begin
            //             Rec."Current User" := UserId;
            //             Rec.WorkTime := CurrentDateTime;
            //             rec.modify();
            //             Message('Changes Updated!');
            //         end;

            //     end;
            // }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Enabled = OpenApprovalEntriesExist;
                Image = Cancel;
                Visible = true;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    AppraisaComme: Record "Loan Appraisal Comments";
                begin
                    AppraisaComme.Reset();
                    AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                    AppraisaComme.SetRange(Commented, false);
                    //AppraisaComme.SetRange(AppraisaComme."Entry Date", Today);
                    if not AppraisaComme.FindFirst() then
                        Error('Loan Appraisal Comments Must have a value');
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
            action("Re-Open Deferred  Loan")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re-Open Document';
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                Image = ReOpen;

                trigger OnAction()
                var
                    AppraisaComme: Record "Loan Appraisal Comments";
                begin
                    //Rec.TestField(Status, Rec.Status::Deffered);
                    // AppraisaComme.Reset();
                    // AppraisaComme.SetRange("Loan No.", Rec."Loan No.");
                    // AppraisaComme.SetRange(Commented, false);
                    // if not AppraisaComme.FindFirst() then
                    //     Error('Loan Appraisal Comments Must have a value');
                    if (Rec.Status = Rec.Status::Deffered) or (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) or (Rec.Status = Rec.Status::Rejected) or (Rec.Status = Rec.Status::Archived)
                     then begin
                        if not Confirm('Are you sure you want to re-open the loan?') then exit;
                        Rec.Status := Rec.Status::Open;
                        Rec."Loan Defferal Reason" := '';
                        rec."Loan Rejection Reason" := '';
                        Rec.Modify(true);
                    end;
                end;
            }
            action(Archive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Archive Application';
                Image = Archive;
                //Visible = RejectVisible;
                Promoted = true;
                PromotedCategory = Category9;

                trigger OnAction()
                var
                    GlobalFunctions: Codeunit "Global Functions";
                begin
                    if Rec.Status = Rec.Status::Archived then
                        Error(('This record is already in archived state.'));
                    GlobalFunctions.CommentsManagement(Rec."Loan No.");
                    if not Rec.posted then begin
                        if not Confirm('Are you sure you want to archive this record?') then exit;
                        GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                        Rec.Status := Rec.Status::Archived;
                        Rec.Validate(Status);
                        Rec.Modify(true);
                        Message('Record archived succsessfully');
                    end else
                        Error('You cannot archive a created record');
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category9;


                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
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
                    if CustMembr.Find('-') then
                        REPORT.Run(Report::"Member Detailed Statement", true, false, CustMembr);
                end;
            }
            action("Loan Offer Letter")
            {
                ApplicationArea = Basic, Suite;
                Image = OrderPromising;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    LoanApp.RESET;
                    LoanApp.SETRANGE(LoanApp."Loan No.", Rec."Loan No.");
                    LoanApp.SETRANGE(LoanApp."Member No.", Rec."Member No.");
                    IF LoanApp.FIND('-') THEN BEGIN
                        //REPORT.RUN(50101, TRUE, FALSE, LoanApp);
                        REPORT.RUN(Report::"Loan Offer Letter", true, false, LoanApp);
                    END;
                end;
            }


            action("Charge Excemptions.")
            {
                ApplicationArea = all;
                Image = Note;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Excempted Product Charges";
                RunPageLink = "Loan No." = field("Loan No.");//, "Product Code" = field("Loan Product Type");
                trigger OnAction()
                begin
                    //Load defaults
                    ProductCharges.Reset();
                    ProductCharges.SetRange("Product Code", Rec."Loan Product Type");
                    ProductCharges.SETRANGE("Charge Type", ProductCharges."Charge Type"::"Top up");
                    if ProductCharges.find('-') then begin
                        repeat
                            ExcemptCharges.reset;
                            ExcemptCharges.setrange("Loan No.", Rec."Loan No.");
                            ExcemptCharges.setrange("Charge Code", ProductCharges."Charge Code");
                            if not ExcemptCharges.find('-') then begin
                                ExcemptCharges.Init();
                                ExcemptCharges."Loan No." := Rec."Loan No.";
                                ExcemptCharges."Charge Code" := ProductCharges."Charge Code";
                                ExcemptCharges."Product Code" := Rec."Loan Product Type";
                                ExcemptCharges."Charge Description" := ProductCharges."Charge Description";
                                ExcemptCharges.Insert;
                            end;
                        until ProductCharges.Next = 0;
                    end;
                end;
            }
            action("Post Loan")
            {
                ApplicationArea = Basic, Suite;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                Visible = PostLoan;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    SeriesSetup: Record "Banking No Setup";
                    FosaAcc, idno : Code[30];
                    GlobalFunctions: Codeunit "Global Functions";
                begin
                    UserSetup.Reset();
                    UserSetup.SetRange(UserSetup."User ID", UserId);
                    UserSetup.SetRange(UserSetup."Member No.", Rec."Member No.");
                    if UserSetup.FindFirst() then
                        Error('You cannot process your own loan');
                    ProdFac.Get(Rec."Loan Product Type");
                    if ProdFac."Shamba Loan" = true then begin
                        Rec.TestField("Land Valuation Done", true);
                        Rec.TestField("Sale Agreement", true);
                        Rec.TestField("20% Payment Slip", true);
                        Rec.TestField("Title Deed");
                    end;
                    //get Ordinary Savings
                    SavAcc.Reset;
                    SavAcc.SetRange("Member No.", Rec."Member No.");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
                    SavAcc.SetRange("Product Type", '191');
                    if SavAcc.Find('-') then begin
                        FosaAcc := SavAcc."No.";
                        idno := SavAcc."ID No.";
                    end;
                    //get ODS


                    // Rec.TestField("Recovery Mode");
                    // if Rec."Recovery Mode" = Rec."Recovery Mode"::Checkoff then begin
                    //     if Rec."Tpay Approved" = false then
                    //         Error('Please validate payroll deduction before posting this loan.');
                    // end;
                    UserSetup1.Reset;
                    UserSetup1.SetRange("User ID", UserId);
                    UserSetup1.SetRange("Credit FOSA Account", true);
                    if not UserSetup1.Find('-') then Error('Yo do not have permissions to run this process kindly contact your system administrator');

                    if UserSetup1."Member No." = Rec."Member No." then Error('You are not allowed to post on your own account');

                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Approved);
                    if Confirm('Do You want to post this loan of Member No' + '...' + Rec."Member No." + '...' + 'Loan No' + '...' + Rec."Loan No.") then begin

                        Posting.PostLoanNormal(Rec."Loan No.");
                        Rec."disbursement time" := Time;
                        Rec."Disbursement Date" := Today;
                        //********************Creation of STOs***********************************************************************************************//
                        Rec.TestField("Recovery Mode");
                        Rec.TestField("Member No.");
                        if Rec."Recovery Mode" = Rec."Recovery Mode"::Hybrid then begin
                            StandingOrderHeader.Reset;
                            // StandingOrderHeader.SetRange("Member No.", Rec."Member No.");
                            // if StandingOrderHeader.FindFirst then begin
                            StandingOrderHeader.init;
                            // Assign the number from the number series
                            SeriesSetup.Get();
                            DocNo := NoSeriesMgt.GetNextNo(SeriesSetup."Standing Order Nos.", Today, TRUE);
                            StandingOrderHeader."No." := DocNo;

                            // Populate other fields
                            StandingOrderHeader."No." := StandingOrderHeader."No.";//number series implentation
                            DocumentNo := StandingOrderHeader."No.";
                            StandingOrderHeader."Application Date" := Today;
                            StandingOrderHeader."Transaction Type" := 'STO';
                            StandingOrderHeader."Source Account Type" := StandingOrderHeader."Source Account Type"::Savings;
                            StandingOrderHeader."Source Account No." := FosaAcc;
                            StandingOrderHeader."Source Account Name" := Rec."Member Name";
                            StandingOrderHeader."Member No." := Rec."Member No.";
                            StandingOrderHeader."ID Number" := idno;
                            StandingOrderHeader.Description := rec."Loan No." + ' Monthly STO';
                            StandingOrderHeader."Allocated Amount" := Rec."Salary Amount";
                            StandingOrderHeader.Amount := Rec."Salary Amount";
                            StandingOrderHeader."Income Type" := StandingOrderHeader."Income Type"::Salary;
                            // StandingOrderHeader."Global Dimension 1 Code" := '';
                            // StandingOrderHeader."Global Dimension 2 Code" := '';
                            StandingOrderHeader.Status := StandingOrderHeader.Status::Approved;
                            //------------------------------------Date thingy
                            DurationText := '1M';  // Ensure it's always '1M' for one month
                            Evaluate(DurationText2, Format(DurationText));
                            DurationText2 := DelChr(Format(DurationText), '=', '-|+|');
                            Evaluate(StandingOrderHeader."Frequency (Months)", DurationText2);
                            StandingOrderHeader."Effective/Start Date" := CALCDATE('<1M>', WORKDATE);
                            //   --------------------date thingy
                            // StandingOrderHeader."Duration (Months)" := Rec.Installments ;
                            Install := Format(Rec.Installments);
                            installtext := install + 'M';
                            DurationText := '1M';  // Ensure it's always '1M' for one month
                            Evaluate(installtext2, Format(installtext));
                            installtext2 := DelChr(Format(installtext), '=', '-|+|');
                            Evaluate(StandingOrderHeader."Duration (Months)", installtext2);
                            StandingOrderHeader."End Date" := CalcDate(StandingOrderHeader."Duration (Months)", StandingOrderHeader."Effective/Start Date");//DURATION+EFFECTIVE DATE
                            StandingOrderHeader.Insert();

                            // end;
                            //insert on lines
                            StandingOrderLines.Reset;
                            // StandingOrderLines.SetRange("Document No.", StandingOrderHeader."No.");
                            //StandingOrderLines.SetRange("Destination Account Type", StandingOrderLines."Destination Account Type"::Savings);
                            // StandingOrderLines.SetRange("Loan No.", Rec."Loan No.");
                            //if StandingOrderLines.FindFirst then begin
                            StandingOrderLines.Init();
                            StandingOrderLines."Document No." := DocumentNo;
                            StandingOrderLines."Destination Account Type" := StandingOrderLines."Destination Account Type"::Credit;
                            // StandingOrderLines."Destination Account No." := Rec."Loan Account";
                            StandingOrderLines."Destination Account No." := Rec."Loan Account";
                            StandingOrderLines."Destination Account Name" := Rec."Member Name";
                            StandingOrderLines."Loan No." := rec."Loan No.";
                            StandingOrderLines.Amount := round(Rec."Salary Amount", 0.01, '=');
                            StandingOrderLines."Transaction Type" := StandingOrderLines."Transaction Type"::Armotised;
                            StandingOrderLines."Member No" := Rec."Member No.";
                            StandingOrderLines.Insert();
                            //end;
                        end;


                        //********************Creation of STOs***********************************************************************************************//
                        // LoansR.reset;
                        // LoansR.SetRange("Loan No.", Rec."Loan No.");
                        // if LoansR.Find('-') then begin
                        //     LoansR."Loan Appraised By" := UserId;
                        //     LoansR.Modify;
                        // end;

                        //Send SMS when Topup

                        if Rec."Hold Installment(s)" then begin
                            OneMonthInstallment.Init();
                            OneMonthInstallment."Record No." := Rec."Loan No.";
                            OneMonthInstallment."Member No." := Rec."Member No.";
                            OneMonthInstallment."Account No." := Rec."Disbursement Account No";
                            OneMonthInstallment."Principal Amount" := Rec."Loan Principle Repayment";
                            OneMonthInstallment."Interest Amount" := Rec."Loan Interest Repayment";
                            if Rec."Number Of Installment(s)" > 0 then
                                OneMonthInstallment.Total := (Rec."Loan Interest Repayment" + Rec."Loan Principle Repayment") * Rec."Number Of Installment(s)" else
                                OneMonthInstallment.Total := Rec."Loan Interest Repayment" + Rec."Loan Principle Repayment";
                            OneMonthInstallment."Created By" := UserId;
                            OneMonthInstallment."Funds Status" := OneMonthInstallment."Funds Status"::WithHeld;
                            OneMonthInstallment."Entry Date" := CurrentDateTime;
                            OneMonthInstallment.Insert();
                        end;
                        //exit;
                        //remove guarator sms on loan topup for staff members- ticket 
                        UserSetup.reset;
                        UserSetup.setrange("Member No.", rec."Member No.");
                        if not UserSetup.findfirst then begin
                            LoansTopup.Reset;
                            LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                            if LoansTopup.FindFirst then begin
                                repeat
                                    LoanGuar.Reset;
                                    LoanGuar.SetRange("Loan No", LoansTopup."Loan Top Up");
                                    LoanGuar.SetRange("Self Guarantee", false);
                                    if LoanGuar.FindFirst then begin
                                        if Loans2.Get(LoanGuar."Loan No") then begin
                                            ProductType := Loans2."Loan Product Type Name";
                                            AppAmount := Loans2."Approved Amount";
                                        end;
                                        repeat
                                            if Members.Get(LoanGuar."Member No") then
                                                CompInfo.Get;

                                            msg := 'Dear ' + LoanGuar.Name + ', The ' + ProductType + ' of Ksh. ' + Format(AppAmount) + ', you had guaranteed ' + LoanGuar."Loanee Name" + ' is now fully repaid.';
                                            SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loans2."Disbursement Account No"), '', true, 0, false, 'CBS', Loans2."Disbursement Account No", 'CBS');

                                        until LoanGuar.Next = 0;
                                    end;
                                until LoansTopup.Next = 0;
                            end;
                        end;

                        //AutoCreateFile

                        //GlobalFunctions.CreateFile(Rec."Member No.", Enum::"File Types"::"Member File");

                        Message('Loan Posted Successfully');
                        CurrPage.Close();
                    end;
                end;
            }
        }

        area(Processing)
        {
            // DO NOT comment out this!
            group("EDMS Integration")
            {
                //     // action("Import")
                //     // {
                //     //     ApplicationArea = All;
                //     //     Caption = 'Import File';
                //     //     Promoted = true;
                //     //     PromotedCategory = Category10;
                //     //     Visible = false;
                //     //     Image = Import;
                //     //     trigger OnAction()
                //     //     var
                //     //         Base64Convert: Codeunit "Base64 Convert";
                //     //         TempBlob: Codeunit "Temp Blob";
                //     //         InStr: InStream;
                //     //         ApplicantMember: Record Members;

                //     //         EDMSFunctions: Codeunit "EDMS Functions";
                //     //         FileName: Text;
                //     //         FileContentsB64: Text;

                //     //         IDNumber: Text;
                //     //         ApplicationType: Label 'LA'; // Loan Application
                //     //         PFNumber: Text;
                //     //     begin
                //     //         if Rec."Loan No." <> '' then begin
                //     //             FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                //     //             TempBlob.CreateInStream(InStr);
                //     //             FileContentsB64 := Base64Convert.ToBase64(InStr);

                //     //             if FileContentsB64 <> '' then begin
                //     //                 ApplicantMember.Reset;

                //     //                 ApplicantMember.SetRange("No.", Rec."Member No.");

                //     //                 if ApplicantMember.FindFirst then begin
                //     //                     if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                //     //                         IDNumber := ApplicantMember."Primary Identification";
                //     //                     end else
                //     //                         if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                //     //                             IDNumber := ApplicantMember."Secondary Identification";
                //     //                         end else begin
                //     //                             IDNumber := ApplicantMember."Primary Identification";
                //     //                         end;

                //     //                     if ApplicantMember."Payroll/Staff No." <> '' then begin
                //     //                         PFNumber := ApplicantMember."Payroll/Staff No.";
                //     //                     end else begin
                //     //                         PFNumber := IDNumber;
                //     //                     end;

                //     //                     EDMSFunctions.EDMSLoanFileUpload(
                //     //                       IDNumber,
                //     //                         ApplicantMember.Name,
                //     //                         Rec."Loan Product Type Name",
                //     //                         PfNumber,
                //     //                         ApplicantMember."No.",
                //     //                         Rec."Loan No.",
                //     //                         Rec."Loan No.",
                //     //                         FileName,
                //     //                         FileContentsB64,
                //     //                         false
                //     //                     );
                //     //                 end;
                //     //             end;
                //     //         end else begin
                //     //             Error('Application No. is required for EDMS document upload');
                //     //         end;
                //     //     end;
                //     // }

                // DO NOT comment out this!
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category10;

                    RunObject = page "Loan FIle Upload";
                    RunPageLink = "Loan No" = field("Loan No.");
                }
                //     // action("Test")
                //     // {
                //     //     ApplicationArea = Basic, Suite;
                //     //     Image = TestFile;
                //     //     Promoted = true;
                //     //     PromotedCategory = Category10;

                //     //     trigger OnAction()
                //     //     var
                //     //         XmlParameters: Text;
                //     //     begin
                //     //         XmlParameters := Report.RunRequestPage(Report::"Loan Application Report");
                //     //         Message(XmlParameters);
                //     //     end;
                //     // }
            }

            // group("CRB - Metropol")
            // {
            //     action("Report Type 4: [PDF Report]")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Full Credit Report';
            //         Promoted = true;
            //         PromotedCategory = Category11;
            //         Image = Report;

            //         RunObject = Page "CRB Metropol PDF Viewer";
            //         RunPageLink = "Loan No." = field("Loan No.");

            //         // trigger OnAction()
            //         // begin
            //         //     if not confirm('Are you sure you want to get the credit score report of the loan applicant from Metropol?') then begin
            //         //         Error('Operation cancelled successfully');
            //         //     end;
            //         // end;
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        StatusControl;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        StatusControl;

        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Mortgage Loan" = true then
                IfMortgage := true
            else
                IfMortgage := false
        end;

        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Mortgage Loan" = true then begin
                Members.Get(Rec."Member No.");
                if Members."Employer Code" = '99' then
                    CheckRetirementDate := true
                else
                    CheckRetirementDate := false
            end;
        end;

        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Mortgage Loan" = true then
                IsMortgageLoan := true
            else
                IsMortgageLoan := false;
            if Rec."Loan Product Type" = '138' then
                IfJenga := true
            else
                IfJenga := false;

        end;
    end;

    trigger OnClosePage()
    begin
        Rec."Discounted Amount" := 0;
        //Rec.Modify;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        StatusControl
    end;

    trigger OnOpenPage()
    var
        Comments: record Comments;
    begin
        StatusControl;
        if UserSetup.Get(Rec."Captured By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
            Rec.Modify;
        end;

        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Mortgage Loan" = true then
                IfMortgage := true
            else
                IfMortgage := false;
            if Rec."Loan Product Type" = '138' then
                IfJenga := true
            else
                IfJenga := false;

            if ProdFac."Loan Security" = ProdFac."Loan Security"::" " then begin
                isRequireSecurity := false;

            end else begin
                isRequireSecurity := true;
            end;
        end;

        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Mortgage Loan" = true then begin
                Members.Get(Rec."Member No.");
                if Members."Employer Code" = '99' then
                    CheckRetirementDate := true
                else
                    CheckRetirementDate := false
            end;
        end;
        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Mortgage Loan" = true then
                IsMortgageLoan := true
            else
                IsMortgageLoan := false;

        end;

        if ProdFac.Get(Rec."Loan Product Type") then begin
            if ProdFac."Shamba Loan" = true then
                IsShambaLoan := true
            else
                IsShambaLoan := false;
        end;
        if rec."Member No." <> '' then begin
            Comments.reset;
            Comments.SetRange(Comments."Header No.", rec."Member No.");
            Comments.setrange(Types, Comments.types::"Member Flagging");
            Comments.setrange("Disable Flag", false);
            if Comments.Find('-') then
                Message(Comments."Comment");
        end;

    end;

    procedure UploadToEDMS(Rec: Record Loans; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        ApplicantMember: Record Members;

        IDNumber: Text;
        ApplicationType: Label 'LA'; // Loan Application
        PFNumber: Text;
    begin
        ApplicantMember.Reset;

        ApplicantMember.SetRange("No.", Rec."Member No.");

        if ApplicantMember.FindFirst then begin
            if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                IDNumber := ApplicantMember."Primary Identification";
            end else
                if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                    IDNumber := ApplicantMember."Secondary Identification";
                end else begin
                    IDNumber := ApplicantMember."Primary Identification";
                end;

            if ApplicantMember."Payroll/Staff No." <> '' then begin
                PFNumber := ApplicantMember."Payroll/Staff No.";
            end else begin
                PFNumber := IDNumber;
            end;

            EDMSFunctions.EDMSLoanFileUpload(
              IDNumber,
                ApplicantMember.Name,
                Rec."Loan Product Type Name",
                PfNumber,
                ApplicantMember."No.",
                Rec."Loan No.",
                Rec."Loan No.",
                FileName,
                FileContentsB64,
                false
            );
        end;
    end;



    var
        Text001: Label 'Status Must Be Open';
        adj: Integer;
        pinst: Integer;
        HRDates: Codeunit "HR Dates 2";
        ClientAgeValue: Integer;
        ClientAgePart: Text;
        ClientAge: Text;
        ProdMinAgeText: Text;
        ProdMinAge: Integer;
        RetirementDate: Date;
        Mem: Record Members;
        UserSetup: Record "User Setup";
        CustMembr: Record Members;
        LoanProcess: Codeunit "Loans Process";
        UpdateMember: Codeunit "DCS Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
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
        AmtErr: Label 'Total  partial disbursement Amount PLUS current amount to diburse must be equal to approved amount';
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
        Credit: Record "Credit Accounts";
        AssetFinanceLoan: Record "Asset Finance Loan";
        TotalAssetFin: Decimal;
        Text014: Label 'Total Asset Finance of %1 is more than approved amount of %2';
        SubSectorLevel2: Code[30];
        IfMortgage: Boolean;
        CheckRetirementDate: Boolean;
        IsMortgageLoan: Boolean;
        IfJenga: Boolean;
        ShareBoostingField: Boolean;
        ShareBoostError: Label 'This member is  Self Employed. Therefore cannot apply for share boosting';
        Text0015: Label 'This Member Does not fullfill all the conditions';
        IsShambaLoan: Boolean;
        isRequireSecurity: Boolean;
        LoanGuar: Record "Loan Guarantors and Security";
        SavingsAccounts: Record "Savings Accounts";
        Posting: Codeunit "Loans Process";
        Loans2: Record Loans;
        ProductType: Text;
        PAGEEDITABLE: Boolean;
        AppAmount: Decimal;
        UseBatch: Boolean;
        UserSetup1: Record "User Setup";
        AppliedAmountEdit: Boolean;
        SADVisible: Boolean;
        StandingOrderHeader: Record "Standing Order Header";
        StandingOrderLines: Record "Standing Order Lines";
        DocumentNo: Code[20];
        DurationText: Text;
        DurationText2: Text;
        install: Text;
        installtext: Text;
        installtext2: Text;
        NoSeriesMgt: Codeunit "No. Series";
        //  "No. Series Management";
        DocNo: Code[20];
        FoundOne: Boolean;
        LoanApprove: Boolean;
        AppraisalFile: Boolean;
        PostLoan: Boolean;
        OneMonthInstallment: Record "One Month Installment";
        SendSMS: Codeunit SendSms;
        msg: Text;
        Source: enum "SMS Source";
        PageEdit: Boolean;
        ProductCharges: Record "Loan Product Charges";
        ExcemptCharges: Record "Excempted Product Charges";
        BatchEdit: Boolean;


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        if Rec."Captured By" <> USERID THEN
            PAGEEDITABLE := FALSE;
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

        if Rec.Posted then AppraisalFile := true;
        case Rec.Status of
            Rec.Status::Open:
                begin
                    ApplicationDetailsEdit := true;
                    DisbursementEdit := true;
                    ApprovedEdit := false;
                    AppliedAmountEdit := true;

                    PageEdit := true;
                end;


            Rec.Status::Pending:
                begin
                    ApplicationDetailsEdit := false;
                    DisbursementEdit := false;
                    AppliedAmountEdit := false;
                    LoanApprove := true;

                end;
            Rec.Status::Rejected:
                begin
                    ApplicationDetailsEdit := false;
                    DisbursementEdit := false;
                    AppliedAmountEdit := false;
                end;
            Rec.Status::Approved:
                begin
                    ApprovedEdit := true;
                    ApplicationDetailsEdit := false;
                    DisbursementEdit := false;
                    AppliedAmountEdit := false;
                    PostLoan := true;
                end;
        end;
        if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::"Partial Disbursement" then
            UseBatch := true else
            UseBatch := false;
        // if (Rec.Status = Rec.Status::Approved) AND (Rec.Posted = Rec.Posted = false) then
        //     UseBatch := true;




        if Rec."Member No." <> '' then begin
            if Members.Get(Rec."Member No.") then
                if Members."Employer Code" = '05' then
                    SADVisible := true;
        end;
    end;

    local procedure "CheckDisbursementA/CBalance"(Account: Code[30])
    var
        cashierTransactions: Record "Cashier Transactions";
        lienAmount: Decimal;
        saccoAccount: Record "Savings Accounts";
        Accounttypes: Record "Product Factory";
        MiniBalance: Decimal;
        AccountBal: Decimal;
    begin
        GenSetup.Get;
        saccoAccount.Reset;
        saccoAccount.SetRange(saccoAccount."No.", Account);
        saccoAccount.SetRange(saccoAccount."Product Type", '505');
        if saccoAccount.Find('-') then begin
            Accounttypes.Reset;
            Accounttypes.SetRange(Accounttypes."Product ID", saccoAccount."Product Type");
            if Accounttypes.Find('-') then begin
                MiniBalance := Accounttypes."Minimum Balance";
            end;
            saccoAccount.CalcFields(saccoAccount."Balance (LCY)");
            saccoAccount.CalcFields(saccoAccount."ATM Transactions");
            saccoAccount.CalcFields(saccoAccount."Uncleared Cheques");


            cashierTransactions.Reset;
            cashierTransactions.SetRange("Account No", saccoAccount."No.");
            cashierTransactions.SetRange(Posted, true);
            cashierTransactions.SetRange(Type, cashierTransactions.Type::Lien);
            cashierTransactions.SetRange("Cheque Status", cashierTransactions."Cheque Status"::Pending);
            if cashierTransactions.Find('-') then begin
                repeat
                    lienAmount += cashierTransactions.Amount;
                until cashierTransactions.Next = 0;
            end;





            AccountBal := saccoAccount."Balance (LCY)" - (saccoAccount."ATM Transactions" + saccoAccount."Uncleared Cheques" + MiniBalance + lienAmount);

            if AccountBal < GenSetup."Mortgage FOSA Min Balance" then Error('Account No %1 balance must be over %2', Rec."Disbursement Account No", GenSetup."Mortgage FOSA Min Balance");
        end
    end;


    local procedure CreateAppraisalBackup(LoanNumber: Code[40]; ReportNumber: Integer)
    var
        Loans: Record Loans;
        EDMS: Record EDMS;
        url: Text;
        FilePath: Text;

        RecRef: RecordRef;
        BlobOutStream: OutStream;
        BlobInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";

        // Base64Convert: Codeunit "Base64 Convert";
        // TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        ApplicantMember: Record Members;

        EDMSFunctions: Codeunit "EDMS Functions";
        FileName: Text;
        FileContentsB64: Text;

        IDNumber: Text;
        ApplicationType: Label 'LA'; // Loan Application
        PFNumber: Text;
    begin
        FileName := 'LoanAppraisalForm.pdf';
        Loans.Reset;
        Loans.SetRange("Loan No.", LoanNumber);
        if Loans.FindFirst then begin
            // EDMS.Reset;
            // EDMS.SetRange(Key, EDMS.Key::"Appraisal File");
            // if EDMS.FindFirst then begin
            //     url := EDMS."url path";
            //     FilePath := url + 'appraisal' + Loans."Member No." + Loans."Loan No." + '.pdf';
            //     if (Loans.Status = Loans.Status::Open) or (Loans.Status = Loans.Status::Pending) then begin
            //         if Exists(FilePath) then Erase(FilePath);
            //         REPORT.SaveAsPdf(ReportNumber, FilePath, Loans);
            //     end;
            // end;

            //if (Loans.Status = Loans.Status::Open) or (Loans.Status = Loans.Status::Pending) then begin
            TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
            TempBlob.CreateInStream(BlobInStream);

            RecRef.GetTable(Loans);
            Report.SaveAs(ReportNumber, '', ReportFormat::Pdf, BlobOutStream, RecRef);


            CopyStream(BlobOutStream, BlobInStream);

            TempBlob.CreateInStream(BlobInStream);
            FileContentsB64 := Base64Convert.ToBase64(BlobInStream);

            if FileContentsB64 <> '' then begin
                ApplicantMember.Reset;
                ApplicantMember.SetRange("No.", Rec."Member No.");

                if ApplicantMember.FindFirst then begin
                    if ApplicantMember."Primary Identification Type" = ApplicantMember."Primary Identification Type"::"ID Number" then begin
                        IDNumber := ApplicantMember."Primary Identification";
                    end else
                        if ApplicantMember."Secondary Identification Type" = ApplicantMember."Secondary Identification Type"::"ID Number" then begin
                            IDNumber := ApplicantMember."Secondary Identification";
                        end else begin
                            IDNumber := ApplicantMember."Primary Identification";
                        end;

                    if ApplicantMember."Payroll/Staff No." <> '' then begin
                        PFNumber := ApplicantMember."Payroll/Staff No.";
                    end else begin
                        PFNumber := IDNumber;
                    end;

                    EDMSFunctions.EDMSLoanFileUpload(
                      IDNumber,
                        ApplicantMember.Name,
                        Rec."Loan Product Type Name",
                        PfNumber,
                        ApplicantMember."No.",
                        Rec."Loan No.",
                        Rec."Loan No.",
                        FileName,
                        FileContentsB64,
                        false
                    );
                    // Message('Appraisal form uploaded successfully to EDMS files');
                end;
            end
            else
                Message('Appraisal form was not uploaded kindly check the file value');
            //end;
        end;
    end;
}


