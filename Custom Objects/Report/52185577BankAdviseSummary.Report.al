#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185577 "Bank Advise Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Bank Advise Summary.rdl';

    dataset
    {
        dataitem("PR Bank Branches"; "PR Bank Branches")
        {
            DataItemTableView = sorting("Branch Code", "Branch Name");
            //RequestFilterFields = Field10, Field11, Field12, Field13, Field14, Field15;
            column(ReportForNavId_4233; 4233)
            {
            }
            column(GETFILTERS_; "PR Bank Branches".GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(NetAmount; NetAmount)
            {
            }
            column(RCount; RCount)
            {
            }
            column(prBank_Structure__Branch_Name_; "Bank Name")
            {
            }
            column(prBank_Structure__Bank_Name_; "Bank Code")
            {
            }
            column(TCount; TCount)
            {
            }
            column(NetAmount_Control1102755006; NetAmount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Advice_SummaryCaption; Bank_Advice_SummaryCaptionLbl)
            {
            }
            column(Bank_NameCaption; Bank_NameCaptionLbl)
            {
            }
            column(Bank_BranchCaption; Bank_BranchCaptionLbl)
            {
            }
            column(No__Of_EmployeesCaption; No__Of_EmployeesCaptionLbl)
            {
            }
            column(Net_AmountCaption; Net_AmountCaptionLbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755017; EmptyStringCaption_Control1102755017Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755018; Signature___DateCaption_Control1102755018Lbl)
            {
            }
            column(NameCaption_Control1102755019; NameCaption_Control1102755019Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755020; EmptyStringCaption_Control1102755020Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755028; EmptyStringCaption_Control1102755028Lbl)
            {
            }
            column(NameCaption_Control1102755029; NameCaption_Control1102755029Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755030; Signature___DateCaption_Control1102755030Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755031; EmptyStringCaption_Control1102755031Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755032; EmptyStringCaption_Control1102755032Lbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(prBank_Structure_Bank_Code; "Branch Code")
            {
            }
            column(prBank_Structure_Branch_Code; "Branch Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := 0;
                NetAmount := 0;

                // Employee.RESET;
                // Employee.SETRANGE(Employee."Main Bank","PR Bank Branches"."Branch Code");
                // Employee.SETRANGE(Employee."Branch Bank","PR Bank Branches"."Branch Name");
                // //Employee.SETFILTER("Current Month Filter","PR Bank Branches".GETFILTER("PR Bank Branches"."Current Month Filter"));
                // //Employee.SETFILTER("Location/Division Code","PR Bank Branches".GETFILTER("PR Bank Branches"."Location/Division Filter"));
                // //Employee.SETFILTER("Department Code","PR Bank Branches".GETFILTER("PR Bank Branches"."Department Filter"));
                // Employee.SETFILTER("Cost Center Code","PR Bank Branches".GETFILTER("PR Bank Branches"."Cost Centre Filter"));
                // Employee.SETFILTER("Salary Grade","PR Bank Branches".GETFILTER("PR Bank Branches"."Salary Grade Filter"));
                // Employee.SETFILTER("Salary Notch/Step","PR Bank Branches".GETFILTER("PR Bank Branches"."Salary Notch Filter"));
                // IF Employee.FIND('-') THEN BEGIN
                // REPEAT
                // Employee.CALCFIELDS(Employee."Net Pay");
                // IF Employee."Net Pay" > 0 THEN BEGIN
                // RCount:=RCount+1;
                // TCount:=TCount+1;
                // NetAmount:=NetAmount+Employee."Net Pay";
                // END;
                // UNTIL Employee.NEXT = 0;
                // END;
            end;

            trigger OnPreDataItem()
            begin
                //IF "PR Bank Branches".GETFILTER("Current Month Filter") = '' THEN
                //ERROR('You must specify current Period filter.');

                CurrReport.CreateTotals(NetAmount);

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        EmployeeName: Text[200];
        bankStruct: Record "PR Bank Branches";
        bankAcc: Text[50];
        BranchBankNM: Text[100];
        mainBankNM: Text[100];
        RCount: Integer;
        NetAmount: Decimal;
        Employee: Record "HR Employees";
        TCount: Integer;
        CompanyInfo: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Bank_Advice_SummaryCaptionLbl: label 'Bank Advice Summary';
        Bank_NameCaptionLbl: label 'Bank Name';
        Bank_BranchCaptionLbl: label 'Bank Branch';
        No__Of_EmployeesCaptionLbl: label 'No. Of Employees';
        Net_AmountCaptionLbl: label 'Net Amount';
        Signature___DateCaptionLbl: label 'Signature & Date';
        NameCaptionLbl: label 'Name';
        EmptyStringCaptionLbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755017Lbl: label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755018Lbl: label 'Signature & Date';
        NameCaption_Control1102755019Lbl: label 'Name';
        EmptyStringCaption_Control1102755020Lbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755028Lbl: label '......................................................................................................................................................';
        NameCaption_Control1102755029Lbl: label 'Name';
        Signature___DateCaption_Control1102755030Lbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755031Lbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755032Lbl: label '......................................................................................................................................................';
        Prepared_by_CaptionLbl: label 'Prepared by:';
        Authorised_by_CaptionLbl: label 'Authorised by:';
        Approved_by_CaptionLbl: label 'Approved by:';
}
