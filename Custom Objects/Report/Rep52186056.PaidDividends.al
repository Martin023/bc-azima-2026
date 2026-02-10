report 52186056 "Paid Dividends"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Paid Dividends.rdl';
    dataset
    {
        dataitem(DividendProgression; "Dividend Progression")
        {
            column(AccountNo; "Account No")
            {
            }
            column(DividendCalcMethod; "Dividend Calc. Method")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(GrossDividends; "Gross Dividends")
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(Month; Month)
            {
            }
            column(NetDividends; "Net Dividends")
            {
            }
            column(PaymentMode; "Payment Mode")
            {
            }
            column(Posted; Posted)
            {
            }
            column(ProcessingDate; "Processing Date")
            {
            }
            column(ProductName; "Product Name")
            {
            }
            column(ProductType; "Product Type")
            {
            }
            column(QualifyingShares; "Qualifying Shares")
            {
            }
            column(Shares; Shares)
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(WitholdingTax; "Witholding Tax")
            {
            }
            column(Year; Year)
            {
            }
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
