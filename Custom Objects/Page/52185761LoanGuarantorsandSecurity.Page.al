page 52185761 "Loan Guarantors and Security"
{
    PageType = List;
    SourceTable = "Loan Guarantors and Security";
    SourceTableView = SORTING("Loan No")
                      ORDER(Ascending);
    ApplicationArea = Basic, Suite;
    PromotedActionCategories = 'New,Process,Process,Refresh';
    UsageCategory = Lists;
    DataCaptionFields = "Savings Account No./Member No.", Name;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Visible = false;
                }
                field("Guarantor Type"; Rec."Guarantor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Savings Account No./Member No."; Rec."Savings Account No./Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Collateral Reg. No."; Rec."Collateral Reg. No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor Status"; Rec."Guarantor Status")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Guarantor ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("User Specified"; Rec."User Specified")
                // {
                //     ApplicationArea = Basic, Suite;
                // }

                field("Available Shares"; Rec."Available Shares")
                {
                    ApplicationArea = all;
                }
                field("Deposits/Shares"; Rec."Deposits/Shares")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No Of Loans Guaranteed"; Rec."No Of Loans Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Guaranteed"; Rec."Total Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Substituted"; Rec."Member Substituted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(PercentageGur; Rec.PercentageGur)
                {
                    ApplicationArea = all;
                    Caption = '% Guaranteed';
                    Editable = false;
                }
                // field("Percentage Guaranteed"; Rec."Percentage Guaranteed")
                // {
                //     ApplicationArea = all;
                //     //Caption = '% Guaranteed';
                //     Editable = false;
                //     visible = false;
                // }
                // field("Loan Group"; Rec."Loan Groups")
                // {
                //     Editable = false;
                // }
                // field("Group Account No"; Rec."Group Account Nos")
                // {
                //     Editable = false;
                // }
                // field(Verified; Rec.Verified)
                // {
                //     ApplicationArea = Basic, Suite;
                // }

            }
            group(Control20)
            {
                ShowCaption = false;
                fixed(Control19)
                {
                    ShowCaption = false;
                    group("Guarantor Name")
                    {
                        Caption = 'Guarantor Name';
                        field("Guarantor Details"; Rec.Name)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = false;
                        }
                    }
                    group(GuarantorDetails)
                    {
                        Caption = 'Guarantor ID No.';
                        field("ID No."; Rec."ID No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Account Name';
                            Editable = false;
                        }
                    }
                    group("Guaranteed Amount")
                    {
                        Caption = 'Guaranteed Amount';
                        field(Balance; Rec."Amount Guaranteed")
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            Visible = true;
                        }
                    }
                    group(TotalGuarantors)
                    {
                        Caption = 'Total Guarantors';
                        field(TotalGuarantorz; Rec.Count)
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Caption = 'Total Guarantors';
                            Editable = false;
                            Visible = true;
                        }
                    }
                    group(Balances)
                    {
                        Caption = 'Balances';
                        field(TotalBalance; Rec."Total Sum")
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Caption = 'Amount Guranteed';
                            Editable = false;
                            Visible = true;
                        }
                    }
                    group("Security Level")
                    {
                        Caption = 'Security Level';
                        Visible = false;
                        field("Coverage Variance"; Rec."Total Sum" + Rec."Amount Guaranteed")
                        {
                            ApplicationArea = Basic, Suite;
                            AutoFormatType = 1;
                            Caption = 'Coverage Variance';
                            Editable = false;
                            Visible = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            part("Approved Images"; "Member Picture & Signature")
            {
                Caption = 'Approved Images';
                SubPageLink = "Member No" = FIELD("Member No");
            }
        }
    }


    actions
    {
        area(processing)
        {
            action("Loans Guaranteed List")
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Guarantors List";
                RunPageLink = "Member No" = field("Member No");
            }
            action("Sent SMS to Guarantors")
            {
                ApplicationArea = Basic, Suite;
                Image = Notes;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                begin

                    if Confirm('Do you want to send SMS notifications to guarantors?', false) = true then begin

                        if Loan.Get(Rec."Loan No") then begin
                            LoanGua.Reset;
                            LoanGua.SetRange(LoanGua."Loan No", Rec."Loan No");
                            LoanGua.SetRange("SMS Sent", false);
                            if LoanGua.Find('-') then begin
                                repeat
                                    Message(Format(LoanGua."Member No"));
                                    if Members.Get(LoanGua."Member No") then begin

                                        CompInfo.Get;

                                        msg := 'You have guaranteed  ' + LoanGua."Loanee Name" + ' Member No:-' + Loan."Member No." + ' ' + Loan."Loan Product Type Name" + ' Loan of ' + Format(Loan."Approved Amount") +
                                        '. If in dispute call' + ' ' + CompInfo."Phone No.";
                                        SendSMS.SendSms(Source::LOAN_GUARANTORS, Members."Phone No.", msg, Format(Loan."Loan No."), '', true, 0, false, 'CBS', Loan."Loan No.", 'CBS');

                                    end;
                                    LoanGua."SMS Sent" := true;
                                    LoanGua.Modify;
                                until LoanGua.Next = 0;

                                //END;
                            end;
                            if Members.Get(Loan."Member No.") then begin
                                //IF Loan."SMS Sent"=FALSE THEN BEGIN

                                msg := 'Your loan application of ' + ' ' + Loan."Loan Product Type Name" + ' Loan of ' + ' ' + Format(Loan."Approved Amount") + ' ' + 'is being processed';

                                SendSMS.SendSms(Source::LOAN_APPLICATION, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');

                                Loan."SMS Sent" := true;
                                //Loan.MODIFY;
                            end;
                        end;


                    end;


                    //END;
                end;
            }
            action("Guarantor Details Verified")
            {
                ApplicationArea = Basic, Suite;
                Image = View;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec.Verified = false then begin
                        repeat
                            Rec.Verified := true;
                            Rec.Modify;
                        until Rec.Next = 0;
                        Loan.Reset;
                        Loan.SetRange("Loan No.", Rec."Loan No");
                        if Loan.Find('-') then begin
                            AppraisalSalaryDetails.Reset;
                            AppraisalSalaryDetails.SetRange("Loan No", Loan."Loan No.");
                            if AppraisalSalaryDetails.Find('-') then begin
                                repeat
                                    if (AppraisalSalaryDetails.Verified = true) and (Rec.Verified = true) then
                                        Loan."Details Verified By" := UserId;
                                    Loan.Modify;
                                until AppraisalSalaryDetails.Next = 0;
                            end;

                        end;
                    end else
                        if Rec.Verified = true then begin
                            repeat
                                Rec.Verified := false;
                                Rec.Modify;
                            until Rec.Next = 0;
                            Loan.Reset;
                            Loan.SetRange("Loan No.", Rec."Loan No");
                            if Loan.Find('-') then begin
                                AppraisalSalaryDetails.Reset;
                                AppraisalSalaryDetails.SetRange("Loan No", Loan."Loan No.");
                                if AppraisalSalaryDetails.Find('-') then begin
                                    repeat
                                        if (AppraisalSalaryDetails.Verified = false) and (Rec.Verified = false) then
                                            Loan."Details Verified By" := '';
                                        Loan.Modify;
                                    until AppraisalSalaryDetails.Next = 0;
                                end;
                            end;

                        end;
                end;
            }
            action(Refresh)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;
                Image = Refresh;

                trigger OnAction()
                var
                    myInt: Integer;
                    LoanGr: Record "Loan Guarantors and Security";
                    TotaAmtGUR: Decimal;
                    PercentageGur: Decimal;
                    GuAmt: Decimal;
                    LoanR: Record Loans;
                    Membersrec: Record Members;
                    REqAmt: Decimal;
                    LONGU: Record "Loan Guarantors and Security";
                    GuarNo: Integer;
                begin
                    if LoanR.Status = LoanR.Status::Open then begin
                        if Membersrec.Get(Rec."Member No") then
                            if (Membersrec.Status <> Membersrec.Status::Deceased) and (Membersrec.Status <> Membersrec.Status::Closed) then begin
                                if LoanR.Posted = false then begin
                                    // REqAmt := LoanR."Approved Amount";
                                    // LoanGua.Reset;
                                    // LoanGua.SetRange("Loan No", Rec."Loan No");
                                    // //LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                                    // if LoanGua.Find('-') then begin
                                    //     LoanGua.CalcSums("Amount Guaranteed");
                                    //     TotaAmtGUR := LoanGua."Amount Guaranteed";
                                    // end;
                                    // LONGU.Reset();
                                    // LONGU.SetRange(LONGU."Loan No", Rec."Loan No");
                                    // if LONGU.Find('-') then begin
                                    //     LONGU.PercentageGur := 0;
                                    //     LONGU."Proportion Guaranteed" := 0;
                                    //     repeat
                                    //         if TotaAmtGUR <> 0 then begin
                                    //             LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                                    //             LONGU."Proportion Guaranteed" := Round(((REqAmt * LONGU.PercentageGur / 100)), 0.01, '=');
                                    //             LONGU.Modify();
                                    //         end;
                                    //     until LONGU.Next() = 0;
                                    // end;

                                    REqAmt := LoanR."Approved Amount";
                                    GuarNo := 0;
                                    LoanGua.Reset;
                                    LoanGua.SetRange("Loan No", Rec."Loan No");
                                    //LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
                                    if LoanR."Source Unit" = LoanR."Source Unit"::FOSA then
                                        GuarNo := LoanGua.Count;
                                    if LoanGua.Find('-') then begin
                                        LoanGua.CalcSums("Amount Guaranteed");

                                        TotaAmtGUR := LoanGua."Amount Guaranteed";
                                    end;

                                    LONGU.Reset();
                                    LONGU.SetRange(LONGU."Loan No", Rec."Loan No");
                                    if LONGU.Find('-') then begin
                                        LONGU.PercentageGur := 0;
                                        LONGU."Amount Guaranteed" := 0;
                                        repeat
                                            if TotaAmtGUR <> 0 then begin
                                                LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
                                                if LoanR."Source Unit" = LoanR."Source Unit"::FOSA then begin
                                                    if GuarNo > 0 then begin
                                                        LONGU.PercentageGur := Round((((1 / GuarNo) * 100)), 0.01, '=');

                                                    end;
                                                end;

                                                LONGU."Amount Guaranteed" := Round(((REqAmt * LONGU.PercentageGur / 100)), 0.01, '=');
                                                LONGU.Modify();
                                            end;
                                        until LONGU.Next() = 0;
                                    end;
                                end;
                                Message('Calculations Updated');
                            end;
                    end;
                end;

            }


        }
    }



    trigger OnOpenPage()
    var
        myInt: Integer;
        loansrec: Record Loans;
    begin
        if Rec."Loan No" <> '' then begin
            loansrec.Reset();
            loansrec.SetRange("Loan No.", Rec."Loan No");
            loansrec.SetRange(loansrec."Source Unit", loansrec."Source Unit"::BOSA);
            if loansrec.FindFirst() then begin

                if loansrec."Current User" <> '' then
                    if loansrec."Current User" <> UserId then begin
                        CurrPage.Editable := false;
                        message('User %1 is operating on the card', loansrec."Current User");
                    end;
            end;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin


        if Loan.Get(Rec."Loan No") then begin
            if Loan.Posted = true then begin
                if Members.Get(Rec."Member No") then begin
                    //ERROR(Members."Phone No.");
                    CompInfo.Get;

                    msg := 'Dear Member, You are no longer a guarantor to: '
                    + Loan."Member Name" + '-' + LoanGua."Loanee Name" + ' ' + Loan."Loan Product Type Name" + ' of Kes' +
                    Format(Loan."Approved Amount") + '. If in dispute call' + ' ' + CompInfo."Phone No.";

                    SendSMS.SendSms(Source::MBANKING, Members."Phone No.", msg, Format(Loan."Disbursement Account No"), '', true, 0, false, 'CBS', Loan."Disbursement Account No", 'CBS');

                end;
            end;
        end;
    end;

    // trigger OnAfterGetCurrRecord()
    // var
    //     myInt: Integer;
    //     LoanGr: Record "Loan Guarantors and Security";
    //     TotaAmtGUR: Decimal;
    //     PercentageGur: Decimal;
    //     GuAmt: Decimal;
    //     LoanR: Record Loans;
    //     Membersrec: Record Members;
    //     REqAmt: Decimal;
    //     LONGU: Record "Loan Guarantors and Security";
    //     GuarNo: Integer;
    //     TotalGuarantors: Integer;
    //     AppliedAmount: Decimal;
    //     LoanNo: Code[20];
    //     GlobalFunctions: Codeunit "Global Functions";

    // begin
    //     if LoanR.Get(Rec."Loan No") then begin
    //         if LoanR.Status = LoanR.Status::Open then begin
    //             if Membersrec.Get(Rec."Member No") then
    //                 if (Membersrec.Status <> Membersrec.Status::Deceased) and (Membersrec.Status <> Membersrec.Status::Closed) then begin
    //                     if LoanR.Posted = false then begin
    //                         REqAmt := LoanR."Approved Amount";
    //                         GuarNo := 0;
    //                         LoanGua.Reset;
    //                         LoanGua.SetRange("Loan No", Rec."Loan No");
    //                         //LoanGua.SetRange("Guarantor Type", LoanGua."guarantor type"::Guarantor);
    //                         if LoanR."Source Unit" = LoanR."Source Unit"::FOSA then
    //                             GuarNo := LoanGua.Count;
    //                         if LoanGua.Find('-') then begin
    //                             LoanGua.CalcSums("Amount Guaranteed");

    //                             TotaAmtGUR := LoanGua."Amount Guaranteed";
    //                         end;

    //                         LONGU.Reset();
    //                         LONGU.SetRange(LONGU."Loan No", Rec."Loan No");
    //                         if LONGU.Find('-') then begin
    //                             LONGU.PercentageGur := 0;
    //                             LONGU."Proportion Guaranteed" := 0;
    //                             repeat
    //                                 if TotaAmtGUR <> 0 then begin
    //                                     LONGU.PercentageGur := Round((((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100)), 0.01, '=');
    //                                     if LoanR."Source Unit" = LoanR."Source Unit"::FOSA then begin
    //                                         if GuarNo > 0 then begin
    //                                             LONGU.PercentageGur := Round((((1 / GuarNo) * 100)), 0.01, '=');

    //                                         end;
    //                                     end;

    //                                     LONGU."Proportion Guaranteed" := Round(((REqAmt * LONGU.PercentageGur / 100)), 0.01, '=');
    //                                     LONGU.Modify();
    //                                 end;
    //                             until LONGU.Next() = 0;
    //                         end;


    //                     end;
    //                 end;
    //         end;
    //     end;



    //     MSmartControl();
    //     UpdateLoanGroup();
    // end;
    // trigger OnAfterGetCurrRecord()
    // var
    //     myInt: Integer;
    //     LoanR: Record Loans;
    //     Membersrec: Record Members;
    //     LoanGua: Record "Loan Guarantors and Security";
    //     LONGU: Record "Loan Guarantors and Security";
    //     GuarNo: Integer;
    //     TotaAmtGUR: Decimal;
    //     REqAmt: Decimal;
    //     GlobalFunctions: Codeunit "Global Functions";
    // begin
    //     if LoanR.Get(Rec."Loan No") then begin
    //         if LoanR.Status = LoanR.Status::Open then begin
    //             if Membersrec.Get(Rec."Member No") then
    //                 if (Membersrec.Status <> Membersrec.Status::Deceased) and (Membersrec.Status <> Membersrec.Status::Closed) then begin
    //                     if not LoanR.Posted then begin
    //                         REqAmt := LoanR."Approved Amount";
    //                         GuarNo := 0;

    //                         // Get the total amount guaranteed
    //                         LoanGua.Reset();
    //                         LoanGua.SetRange("Loan No", Rec."Loan No");
    //                         if LoanGua.FindSet() then begin
    //                             LoanGua.CalcSums("Amount Guaranteed");
    //                             TotaAmtGUR := LoanGua."Amount Guaranteed";
    //                         end;

    //                         // Count the number of guarantors
    //                         if LoanR."Source Unit" = LoanR."Source Unit"::FOSA then
    //                             GuarNo := LoanGua.Count;

    //                         // Process Loan Guarantors
    //                         LONGU.Reset();
    //                         LONGU.SetRange("Loan No", Rec."Loan No");
    //                         if LONGU.FindSet() then begin
    //                             repeat
    //                                 if TotaAmtGUR <> 0 then begin
    //                                     LONGU.PercentageGur := Round(((LONGU."Amount Guaranteed" / TotaAmtGUR) * 100), 0.01, '=');

    //                                     if LoanR."Source Unit" = LoanR."Source Unit"::FOSA then
    //                                         if GuarNo > 0 then
    //                                             LONGU.PercentageGur := Round(((1 / GuarNo) * 100), 0.01, '=');

    //                                     LONGU."Amount Guaranteed" := Round((REqAmt * LONGU.PercentageGur / 100), 0.01, '=');

    //                                     // Modify only if the values are changing
    //                                     LONGU.Modify();
    //                                 end;
    //                             until LONGU.Next() = 0;
    //                         end;
    //                     end;
    //                 end;
    //         end;
    //     end;

    //     MSmartControl();
    //     UpdateLoanGroup();
    // end;

   

    var
        LoanGua: Record "Loan Guarantors and Security";
        IsNotSentBackToMSmart: boolean;
        Members: Record Members;
        SendSMS: Codeunit SendSms;
        Source: Enum "SMS Source";
        msg: Text;
        GenSetUp: Record "General Set-Up";
        Loan: Record Loans;
        CompInfo: Record "Company Information";
        SendM: Boolean;
        AppraisalSalaryDetails: Record "Appraisal Salary Details";
        MemberGuarantor: Record Members;
        pfact: Record "Product Factory";

}

