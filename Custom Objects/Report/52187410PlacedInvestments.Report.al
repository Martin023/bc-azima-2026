#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187410 "Current Placed Investments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Current Placed Investments.rdl';

    dataset
    {
        dataitem("Investment Header"; "Investment Header")
        {
            DataItemTableView = where(Posted = filter(true), Status = const(Fulfilled), "Deposit Type" = filter(<> Shares));
            RequestFilterFields = "Investment Type Code", "Period Type", "Date Filter";
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
            column(Investment_No; "Investment No")
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
            column(Deposit_Type; "Deposit Type")
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
            column(EndDate; EndDate) { }
            column(StartDate; StartDate) { }
            column(Transaction_Date; "Transaction Date") { }
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
                trigger OnAfterGetRecord()
                begin
                    //  += "Face Value";

                end;

            }
            trigger OnPreDataItem()
            begin
                if EndDate = 0D then
                    EndDate := TODAY;

                if StartDate = 0D then
                    "Investment Header".SetFilter("Date Filter", '..%2', EndDate)
                else
                    "Investment Header".SetFilter("Date Posted", '%1..%2', StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                //SavingsAccounts.SETCURRENTKEY(SavingsAccounts."Member No.");
                if Customer.Get(Institution) then begin
                    Customer.CalcFields(Customer."Balance (LCY)");
                    if Customer."Balance (LCY)" = 0 then CurrReport.Skip();// Any without balance not to show: Lifted
                end;
                SNo += 1;

                // IntEarned := 0;
                // InvestReceiptHead.Reset();
                // InvestReceiptHead.SetRange(Institution, "Investment Header".Institution);
                // InvestReceiptHead.SetRange(Investments, "Investment Header"."Investment No");
                // InvestReceiptHead.SetRange(Posted, true);
                // if InvestReceiptHead.FindFirst() then begin
                //     // InvestReceiptHead.CalcSums("Amount Recieved", "Invested Amount");
                //     IntEarned := InvestReceiptHead."Amount Recieved" - InvestReceiptHead."Invested Amount";
                // end;


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
                    field("End Date:/AsAt"; EndDate)
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

    trigger OnPostReport()
    begin

    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        ShowTotoDetail: Boolean;
        GrandTotals: Decimal;
        StartDate: Date;
        EndDate: Date;
        Customer: Record customer;
        InvestReceiptHead: Record "Receipts Header";
        IntEarned: Decimal;
        Percentage: Decimal;
}
