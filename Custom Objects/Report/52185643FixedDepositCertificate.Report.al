#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185643 "Fixed Deposit Certificate"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Fixed Deposit Certificate.rdl';


    dataset
    {
        dataitem("Fixed Deposit Contract"; "Fixed Deposit Contract")
        {
            calcfields = Balance;
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

            column(CurrDate; Format(Today, 0, 4))
            {
            }
            column(FfixedDepositStatus; "Fixed Deposit Contract"."Fixed Deposit Status")
            {
            }
            column(Fixed_Deposit_Account_No_; "Fixed Deposit Contract"."Fixed Deposit Account No.")
            {
            }
            column(Fixed_Deposit_Amount; "Fixed Deposit Contract".Balance)
            {
            }
            column(No_; "Fixed Deposit Contract"."No.")
            {
            }
            column(Expected_Maturity_Date; "Fixed Deposit Contract"."Expected Maturity Date")
            {
            }
            column(FD_Maturity_Instructions; "Fixed Deposit Contract"."FD Maturity Instructions")
            {
            }
            column(Status; "Fixed Deposit Contract".Status)
            {
            }
            column(FD_Maturity_Date; "Fixed Deposit Contract"."FD Maturity Date")
            {
            }
            column(Fixed_Deposit_Type; "Fixed Deposit Contract"."Fixed Deposit Type")
            {
            }
            column(Fixed_Deposit_cert__no; "Fixed Deposit Contract"."Fixed Deposit cert. no")
            {
            }
            column(Neg__Interest_Rate; "Fixed Deposit Contract"."Neg. Interest Rate")
            {
            }
            column(Application_Date; "Fixed Deposit Contract"."Application Date")
            {
            }
            column(MemberName; "Fixed Deposit Contract".Name)
            {
            }
            column(Member_No_; "Fixed Deposit Contract"."Member No.")
            {
            }
            column(Global_Dimension_1_Code; "Fixed Deposit Contract"."Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Fixed Deposit Contract"."Global Dimension 2 Code")
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(Address; Address)
            {
            }

            column(KRAPin; KRAPin)
            {
            }
            column(Identification; Identification)
            {
            }
            column(FD_Duration; "FD Duration")
            {
            }
            // column(Monthly_Interest_Instructions; "Monthly Interest Instructions")
            // {
            // }
            column(Forecasted_Interest; "Forecasted Interest")
            {
            }
            column(TaxAmount; TaxAmount)
            {
            }
            column(PayableAfterTax; PayableAfterTax)
            {
            }
            column(PayableAmount; PayableAmount)
            {
            }
            trigger OnAfterGetRecord()
            begin
                clear(PayableAmount);
                clear(PayableAfterTax);
                DimensionValues.Reset();
                DimensionValues.SetRange(Code, "Global Dimension 1 Code");
                if DimensionValues.FindFirst() then
                    BranchName := DimensionValues.Name;
                if Members.get("Member No.") then begin
                    Address := Members."Home Address";
                    KRAPin := Members."P.I.N Number";
                    Identification := Members."Primary Identification";
                end;
                NoOfDays := 0;
                if ("Fixed Deposit Contract"."Application Date" = 0D) then
                    Error('Application date is missing!');
                if ("Fixed Deposit Contract"."FD Maturity Date" = 0D) then
                    Error('Maturity date is missing!');

                NoOfDays := Abs("Fixed Deposit Contract"."FD Maturity Date" - "Fixed Deposit Contract"."Application Date");

                if "Fixed Deposit Contract"."Neg. Interest Rate" = 0 then begin
                    FDTypes.Reset();
                    FDTypes.SetRange(Code, "Fixed Deposit Type");
                    if FDTypes.FindFirst() then begin
                        FDRates.Reset();
                        FDRates.SetRange(Code, FDTypes.Code);
                        if FDRates.findset() then
                            repeat
                                if ("Fixed Deposit Contract"."Fixed Deposit Amount" >= FDRates."Minimum Amount") and ("Fixed Deposit Contract"."Fixed Deposit Amount" <= FDRates."Maximum Amount") then begin
                                    "Fixed Deposit Contract"."Neg. Interest Rate" := FDRates."Interest Rate";
                                    break;
                                end;
                            until FDRates.Next() = 0;
                    end;
                end;
                if "Fixed Deposit Contract"."Forecasted Interest" = 0 then
                    "Fixed Deposit Contract"."Forecasted Interest" := "Fixed Deposit Contract"."Fixed Deposit Amount" * ("Fixed Deposit Contract"."Neg. Interest Rate" / 100) * (NoOfDays / 365);

                if ProdFac.get("Product Type") then
                    TaxAmount := "Fixed Deposit Contract"."Forecasted Interest" * 0.01 * ProdFac."WithHolding Tax";

                PayableAfterTax := "Fixed Deposit Contract"."Fixed Deposit Amount" + "Fixed Deposit Contract"."Forecasted Interest" - TaxAmount;
                PayableAmount := "Fixed Deposit Contract"."Fixed Deposit Amount" + "Fixed Deposit Contract"."Forecasted Interest" - TaxAmount;

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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: record Members;
        DimensionValues: record "Dimension Value";
        BranchName: Code[30];
        Address: Text;
        KRAPin: code[50];
        Identification: code[50];
        FDTypes: record "Fixed Deposit Type";
        FDRates: record "FD Interest Calculation Rules";
        ProdFac: record "Product Factory";
        TaxAmount: Decimal;
        NoOfDays: Integer;
        IntRate: Decimal;
        PayableAfterTax: Decimal;
        PayableAmount: Decimal;
}
