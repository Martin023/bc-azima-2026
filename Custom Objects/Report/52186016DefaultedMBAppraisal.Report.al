#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186016 "Defaulted MB Appraisal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Defaulted MB Appraisal.rdl';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem(Members; "Members")
        // {
        //     DataItemTableView = where(Status=filter(Active|New),"Employer Code"=filter(<>9901|<>9902));
        //     column(ReportForNavId_1; 1)
        //     {
        //     }
        //     column(SaccoName;SaccoName)
        //     {
        //     }
        //     column(SaccoAddress;SaccoAddress)
        //     {
        //     }
        //     column(Slogan;Slogan)
        //     {
        //     }
        //     column(SaccoPhone;SaccoPhone)
        //     {
        //     }
        //     column(DateIssued;DateIssued)
        //     {
        //     }
        //     column(Email;Email)
        //     {
        //     }
        //     column(Website;Website)
        //     {
        //     }
        //     column(PrintedBy;PrintedBy)
        //     {
        //     }
        //     column(QualifiedAmt;QualifiedAmt)
        //     {
        //     }
        //     column(Msg;MSG)
        //     {
        //     }

        //     trigger OnAfterGetRecord()
        //     begin
        //         SavingsAccounts.Reset;
        //         SavingsAccounts.SetRange("Product Type",'505');
        //         SavingsAccounts.SetRange("Member No.",Members."No.");
        //         if SavingsAccounts.FindFirst then begin
        //         SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.",Success,MSG,LoanLimit,QualifiedAmt,TopUp);
        //         end;

        //         if PrintTheQualified then begin
        //           if QualifiedAmt <= 0 then CurrReport.Skip;
        //         end else begin
        //           if QualifiedAmt > 0 then CurrReport.Skip;
        //         end;
        //     end;
        // }
        {
            DataItemTableView = where(Status = filter(Active | New), "Employer Code" = filter(<> 9901 | <> 9902));
            column(ReportForNavId_1; 1)
            {
            }
            column(SaccoName; SaccoName)
            {
            }
            column(SaccoAddress; SaccoAddress)
            {
            }
            column(Slogan; Slogan)
            {
            }
            column(SaccoPhone; SaccoPhone)
            {
            }
            column(DateIssued; DateIssued)
            {
            }
            column(Email; Email)
            {
            }
            column(Website; Website)
            {
            }
            column(PrintedBy; PrintedBy)
            {
            }
            column(QualifiedAmt; QualifiedAmt)
            {
            }
            column(Msg; MSG)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SavingsAccounts.Reset;
                SavingsAccounts.SetRange("Product Type", '505');
                SavingsAccounts.SetRange("Member No.", Members."No.");
                if SavingsAccounts.FindFirst then begin
                    //SkyMbanking.MBoostaAppraisal(SavingsAccounts."No.",Success,MSG,LoanLimit,QualifiedAmt,TopUp);
                end;

                if PrintTheQualified then begin
                    if QualifiedAmt <= 0 then CurrReport.Skip;
                end else begin
                    if QualifiedAmt > 0 then CurrReport.Skip;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Print The Qualified"; PrintTheQualified)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        CompanyInformation.Get;
        SaccoName := CompanyInformation.Name;
        SaccoAddress := CompanyInformation.Address;
        SaccoPhone := CompanyInformation."Phone No.";
        Slogan := 'Your Future Our Concern';
        CompanyInformation.CalcFields(Picture);
        Email := CompanyInformation."E-Mail";
        Website := CompanyInformation."Home Page";

        //DateIssued := (Today);

        PrintedBy := CopyStr(UserId, StrPos(UserId, '\') + 1, 50);
    end;

    var
        SaccoName: Text;
        SaccoAddress: Text;
        Slogan: Text;
        SaccoPhone: Text;
        DateIssued: Text;
        CompanyInformation: Record "Company Information";
        // MemPort: Codeunit "Sky Harambee Portal";
        Email: Text;
        Website: Text;
        PrintedBy: Text;
        PrintTheQualified: Boolean;
        // SkyMbanking: Codeunit "Sky Mbanking";
        SavingsAccounts: Record "Savings Accounts";
        Success: Boolean;
        MSG: Text;
        LoanLimit: Decimal;
        QualifiedAmt: Decimal;
        TopUp: Decimal;
}
