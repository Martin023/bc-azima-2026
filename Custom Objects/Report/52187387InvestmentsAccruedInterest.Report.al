#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187387 "Invest Accumulated Interest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Investment Accumulated Interest.rdl';

    dataset
    {
        dataitem("Investment Header"; "Investment Header")
        {
            DataItemTableView = where(Posted = filter(true), Status = const(Fulfilled));
            // RequestFilterFields = "Investment Type Code", "Period Type";
            column(ReportForNavId_1; 1)
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
            column(SCount; SNo)
            {
            }
            column(Investment_Type_Code; "Investment Type Code")
            {
            }
            column(Investment_Type_Description; "Investment Type Description")
            {
            }
            column(Interest_Rate; "Interest Rate")
            {
            }
            column(Investment_Date; "Investment Date")
            {
            }
            column(Tenor; Tenor)
            {
            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }
            column(Institution_Name; "Institution Name")
            {
            }
            column(Institution; Institution)
            {
            }
            column(Maturity_Date; "Maturity Date")
            {
            }

            // trigger OnAfterGetRecord()
            // begin
            //     //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
            //     // SNo += 1;

            // end;

            dataitem("Investment Lines"; "Investment Lines")
            {
                DataItemLink = "Investment No" = FIELD("Investment No");
                column(Face_Value; "Face Value")
                {
                }
                column(Interest_Amount; "Interest Amount")
                {
                }
                column(IntEarned; IntEarned)
                {
                }
                column(wtax; wtax)
                {
                }


            }


        }
    }

    // trigger OnPreReport()
    // begin

    // end;

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(ShowTotoDetail; ShowTotoDetail)
                {
                    ApplicationArea = Basic;
                    Caption = 'ShowTotoDetail';
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
        SNo: Integer;
        ShowTotoDetail: Boolean;
        StartDate: Date;
        EndDate: Date;
        Company: Record "Company Information";
        IntEarned: Decimal;
        NoOfDays: Integer;
        Inv: Record "Investment Header";
        InvLine: Record "Investment Lines";
        TarrifCodes: Record "Tariff Code s";
        wtax: Decimal;
        InvIntHeader: Record "Investment Interest Header";

}
