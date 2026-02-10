#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187371 "Matured Investments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Matured Investments.rdl';

    dataset
    {
        dataitem("Investment Header"; "Investment Header")
        {
            DataItemTableView = where(Posted = filter(true), Status = const(Matured), "Deposit Type" = filter(<> Shares));
            RequestFilterFields = "Deposit Type", "Period Type", "Investment Date", "Expected Payment Date", "Maturity Date";
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
            column(Status; Status)
            {
            }
            column(Maturity_Date; "Maturity Date")
            {
            }
            column(Institution_Name; "Institution Name")
            {
            }
            column(Investment_No; "Investment No")
            {

            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }
            column(Deposit_Type; "Deposit Type")
            {

            }
            column(IntEarned; IntEarned)
            {

            }


            dataitem("Investment Lines"; "Investment Lines")
            {
                DataItemLink = "Investment No" = FIELD("Investment No");
                column(Face_Value; "Face Value")
                {
                }
                column(Interest_Amount; "Interest Amount")
                {
                }
                column(Wht_Tax_Amount; "Wht Tax Amount")
                {
                }


            }

            trigger OnPreDataItem()
            begin
                "Investment Header".SetFilter("Date Posted", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                IntEarned := 0;
                InvestReceiptHead.Reset();
                InvestReceiptHead.SetRange(Institution, "Investment Header".Institution);
                InvestReceiptHead.SetRange(Investments, "Investment Header"."Investment No");
                InvestReceiptHead.SetRange(Posted, true);
                if InvestReceiptHead.FindFirst() then begin
                    InvestReceiptHead.CalcFields("Invested Amount");
                    IntEarned := InvestReceiptHead."Amount Recieved" - InvestReceiptHead."Invested Amount";
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
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = True;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
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
        InvestReceiptHead: Record "Receipts Header";
        IntEarned: Decimal;
}
