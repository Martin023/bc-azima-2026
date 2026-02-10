#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186399 "Invest Historical Comparison"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Invest Historical Comparison.rdl';

    dataset
    {
        dataitem("Investment Header"; "Investment Header")
        {
            DataItemTableView = where(Posted = filter(true), Status = filter(Fulfilled | Matured));
            RequestFilterFields = "Investment Type Code", "Period Type";
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
            column(Institution_Name; "Institution Name")
            {
            }
            column(Institution; Institution)
            {
            }
            column(Maturity_Date; "Maturity Date")
            {
            }
            column(Period; Period)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(Quater1; Quater1)
            {
            }
            column(Quater2; Quater2)
            {
            }
            column(Quater3; Quater3)
            {
            }
            column(Quater4; Quater4)
            {
            }

            // dataitem("Investment Lines"; "Investment Lines")
            // {
            //     DataItemLink = "Investment No" = FIELD("Investment No");
            //     column(Face_Value; "Face Value")
            //     {
            //     }
            //     column(Interest_Amount; "Interest Amount")
            //     {
            //     }


            // }
            trigger OnPreDataItem()
            begin
                EndDate := CalcDate(Period, StartDate);
                "Investment Header".SetFilter("Date Posted", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                NumberOfdays := EndDate - StartDate;
                Quater1 := CalcDate('<1D>', StartDate) + (NumberOfdays / 4 - 1);
                Quater2 := CalcDate('<1D>', StartDate) + (NumberOfdays / 2 - 1);
                Quater3 := CalcDate('<1D>', StartDate) + (3 * NumberOfdays / 4 - 1);
                Quater4 := EndDate;

                InvestLines.Reset();
                InvestLines.SETRANGE("Investment No", "Investment No");
                InvestLines.CalcSums("Face Value", "Interest Amount");
                InvestedAmount := InvestLines."Face Value";
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }

                field(Period; Period)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                }

            }
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
        Period: DateFormula;
        StartDate: Date;
        InvestLines: Record "Investment Lines";
        Quater1: date;
        Quater2: date;
        Quater3: date;
        Quater4: date;
        EndDate: Date;
        NumberOfdays: Integer;
        InvestedAmount: Decimal;
}
