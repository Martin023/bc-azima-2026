#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185578 "Pension Advice Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Pension Advice Summary.rdl';

    dataset
    {
        //dataitem(52185643; 52185643)
        dataitem("prInstitutional Membership"; "prInstitutional Membership")
        {
            DataItemTableView = sorting("Group No", "Institution No") where("Group No" = const('PENSION'));
            RequestFilterFields = "Current Month Filter", "Location/Division Filter", "Department Filter", "Cost Centre Filter", "Salary Grade Filter", "Salary Notch Filter";
            column(ReportForNavId_4776; 4776)
            {
            }
            column(GETFILTERS_; "prInstitutional Membership".GetFilters)
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
            column(prInstitutional_Membership__prInstitutional_Membership__Description; "prInstitutional Membership".Description)
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
            column(Staff_Pension_Advice_SummaryCaption; Staff_Pension_Advice_SummaryCaptionLbl)
            {
            }
            column(Pension_HouseCaption; Pension_HouseCaptionLbl)
            {
            }
            column(No__Of_EmployeesCaption; No__Of_EmployeesCaptionLbl)
            {
            }
            column(Net_AmountCaption; Net_AmountCaptionLbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(Authorised_by_Caption; Authorised_by_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755016; EmptyStringCaption_Control1102755016Lbl)
            {
            }
            column(NameCaption_Control1102755017; NameCaption_Control1102755017Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755018; EmptyStringCaption_Control1102755018Lbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(NameCaption_Control1102755020; NameCaption_Control1102755020Lbl)
            {
            }
            column(Signature___DateCaption; Signature___DateCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755029; EmptyStringCaption_Control1102755029Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755030; Signature___DateCaption_Control1102755030Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755031; EmptyStringCaption_Control1102755031Lbl)
            {
            }
            column(Signature___DateCaption_Control1102755032; Signature___DateCaption_Control1102755032Lbl)
            {
            }
            column(EmptyStringCaption_Control1102755033; EmptyStringCaption_Control1102755033Lbl)
            {
            }
            column(prInstitutional_Membership_Group_No; "Group No")
            {
            }
            column(prInstitutional_Membership_Institution_No; "Institution No")
            {
            }

            trigger OnAfterGetRecord()
            begin
                RCount := 0;
                NetAmount := 0;


                Employee.Reset;
                Employee.SetRange(Employee."Pension House", "prInstitutional Membership"."Institution No");
                Employee.SetFilter("Current Month Filter", "prInstitutional Membership".GetFilter("Current Month Filter"));
                Employee.SetFilter("Location/Division Code", "prInstitutional Membership".GetFilter("Location/Division Filter"));
                Employee.SetFilter("Department Code", "prInstitutional Membership".GetFilter("Department Filter"));
                Employee.SetFilter("Cost Center Code", "prInstitutional Membership".GetFilter("Cost Centre Filter"));
                Employee.SetFilter("Salary Grade", "prInstitutional Membership".GetFilter("Salary Grade Filter"));
                Employee.SetFilter("Salary Notch/Step", "prInstitutional Membership".GetFilter("Salary Notch Filter"));
                Employee.SetFilter(Employee."Transaction Code Filter", TransCodeFilter);
                if Employee.Find('-') then begin
                    repeat
                        Employee.CalcFields(Employee."Transaction Amount");
                        if Employee."Transaction Amount" > 0 then begin
                            RCount := RCount + 1;
                            TCount := TCount + 1;
                            NetAmount := NetAmount + Employee."Transaction Amount";
                        end;
                    until Employee.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if "prInstitutional Membership".GetFilter("Current Month Filter") = '' then
                    Error('You must specify current Period filter.');

                CurrReport.CreateTotals(NetAmount);

                Trans.Reset;
                //Trans.SETRANGE(Trans.Pension,TRUE);
                if Trans.Find('-') then begin
                    repeat
                        if TransCodeFilter = '' then
                            TransCodeFilter := Trans."Transaction Code"
                        else
                            TransCodeFilter := TransCodeFilter + '|' + Trans."Transaction Code";
                    until Trans.Next = 0;
                end;

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
        TransCodeFilter: Code[200];
        Trans: Record "PR Transaction Codes";
        CompanyInfo: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Staff_Pension_Advice_SummaryCaptionLbl: label 'Staff Pension Advice Summary';
        Pension_HouseCaptionLbl: label 'Pension House';
        No__Of_EmployeesCaptionLbl: label 'No. Of Employees';
        Net_AmountCaptionLbl: label 'Net Amount';
        Prepared_by_CaptionLbl: label 'Prepared by:';
        Authorised_by_CaptionLbl: label 'Authorised by:';
        NameCaptionLbl: label 'Name';
        EmptyStringCaptionLbl: label '......................................................................................................................................................';
        EmptyStringCaption_Control1102755016Lbl: label '......................................................................................................................................................';
        NameCaption_Control1102755017Lbl: label 'Name';
        EmptyStringCaption_Control1102755018Lbl: label '......................................................................................................................................................';
        Approved_by_CaptionLbl: label 'Approved by:';
        NameCaption_Control1102755020Lbl: label 'Name';
        Signature___DateCaptionLbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755029Lbl: label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755030Lbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755031Lbl: label '......................................................................................................................................................';
        Signature___DateCaption_Control1102755032Lbl: label 'Signature & Date';
        EmptyStringCaption_Control1102755033Lbl: label '......................................................................................................................................................';
}
