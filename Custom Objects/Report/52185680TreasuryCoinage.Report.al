#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185680 "Treasury Coinage."
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Treasury Coinage..rdl';

    dataset
    {
        dataitem("Treasury Cashier Transactions"; "Treasury Cashier Transactions")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(No_TreasuryCashierTransactions; "Treasury Cashier Transactions".No)
            {
            }
            column(TransactionDate_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Transaction Date")
            {
            }
            column(TransactionType_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Transaction Type")
            {
            }
            column(FromAccount_TreasuryCashierTransactions; "Treasury Cashier Transactions"."From Account")
            {
            }
            column(ToAccount_TreasuryCashierTransactions; "Treasury Cashier Transactions"."To Account")
            {
            }
            column(Description_TreasuryCashierTransactions; "Treasury Cashier Transactions".Description)
            {
            }
            column(Amount_TreasuryCashierTransactions; "Treasury Cashier Transactions".Amount)
            {
            }
            column(Posted_TreasuryCashierTransactions; "Treasury Cashier Transactions".Posted)
            {
            }
            column(DatePosted_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Date Posted")
            {
            }
            column(TimePosted_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Time Posted")
            {
            }
            column(FromAccountName_TreasuryCashierTransactions; "Treasury Cashier Transactions"."From Account Name")
            {
            }
            column(ToAccountName_TreasuryCashierTransactions; "Treasury Cashier Transactions"."To Account Name")
            {
            }
            column(ActualCashAtHand_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Actual Cash At Hand")
            {
            }
            column(ResponsibilityCenter_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Responsibility Center")
            {
            }
            column(Status_TreasuryCashierTransactions; "Treasury Cashier Transactions".Status)
            {
            }
            column(Type_TreasuryCashierTransactions; "Treasury Cashier Transactions".Type)
            {
            }
            column(FromTill_TreasuryCashierTransactions; "Treasury Cashier Transactions"."From Till")
            {
            }
            column(ToTill_TreasuryCashierTransactions; "Treasury Cashier Transactions"."To Till")
            {
            }
            column(ExcessShortageAmount_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Excess/Shortage Amount")
            {
            }
            column(DateIssued_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Date Issued")
            {
            }
            column(TimeIssued_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Time Issued")
            {
            }
            column(IssueReceived_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Issue Received")
            {
            }
            column(DateReceived_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Date Received")
            {
            }
            column(TimeReceived_TreasuryCashierTransactions; "Treasury Cashier Transactions"."Time Received")
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
            dataitem(Coinage; Coinage)
            {
                DataItemLink = No = field(No);
                column(ReportForNavId_1000000011; 1000000011)
                {
                }
                column(No_Coinage; Coinage.No)
                {
                }
                column(Code_Coinage; Coinage.Code)
                {
                }
                column(Description_Coinage; Coinage.Description)
                {
                }
                column(Type_Coinage; Coinage.Type)
                {
                }
                column(Value_Coinage; Coinage.Value)
                {
                }
                column(Quantity_Coinage; Coinage.Quantity)
                {
                }
                column(TotalAmount_Coinage; Coinage."Total Amount")
                {
                }
            }


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
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + ' -Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
