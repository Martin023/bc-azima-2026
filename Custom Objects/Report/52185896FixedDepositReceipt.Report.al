#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185896 "Fixed Deposit Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Fixed Deposit Receipt.rdl';

    dataset
    {
        dataitem("Fixed Deposit Contract"; "Fixed Deposit Contract")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyPic; CompInfo.Picture)
            {
            }
            column(tODAYSdATE; Format(Today, 0, 4))
            {
            }
            column(Name; UpperCase("Fixed Deposit Contract".Name))
            {
            }
            column(Balance; "Fixed Deposit Contract".Balance)
            {
            }
            column(MaturityDate; Format("Fixed Deposit Contract"."FD Maturity Date", 0, 4))
            {
            }
            column(FixedType; "Fixed Deposit Contract"."Fixed Deposit Type")
            {
            }
            column(FDRate; FixedRate)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(ID_No; "Fixed Deposit Contract"."ID No.")
            {
            }
            column(No; "Fixed Deposit Contract"."No.")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(SNo; "SNo.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                "SNo." += 1;

                FixedRate := 0;
                FDCalcRules.Reset;
                FDCalcRules.SetRange(Code, "Fixed Deposit Contract"."Fixed Deposit Type");
                if FDCalcRules.Find('-') then begin
                    repeat
                        if ("Fixed Deposit Contract".Balance >= FDCalcRules."Minimum Amount") and ("Fixed Deposit Contract".Balance <= FDCalcRules."Maximum Amount") then
                            FixedRate := FDCalcRules."Interest Rate";
                    until
                    FDCalcRules.Next = 0;
                end;

                if "Fixed Deposit Contract"."Neg. Interest Rate" <> 0 then
                    FixedRate := "Fixed Deposit Contract"."Neg. Interest Rate";

                "Fixed Deposit Contract".CalcFields("Fixed Deposit Contract".Balance);

                // Amount into words
                // CheckReport.InitTextVariable;
                // CheckReport.FormatNoText(NumberText, "Fixed Deposit Contract"."Balance (LCY)", '');
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(CompInfo.Picture);
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompInfo: Record "Company Information";
        FixedRate: Decimal;
        FDCalcRules: Record "FD Interest Calculation Rules";
        // CheckReport: Report Check;
        NumberText: array[2] of Text[120];
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        "SNo.": Integer;
        CommunicationOnline: Text;
}
