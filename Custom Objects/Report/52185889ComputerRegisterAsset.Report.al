#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185889 "Computer Register Asset"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Computer Register Asset.rdl';

    dataset
    {
        dataitem("Computer Asset Register"; "Computer Asset Register")
        {
            RequestFilterFields = Location, "Responsibility Center";
            column(ReportForNavId_30; 30)
            {
            }
            column(No_ComputerAssetRegister; "Computer Asset Register".No)
            {
            }
            column(Location_ComputerAssetRegister; "Computer Asset Register".Location)
            {
            }
            column(AssetDescription_ComputerAssetRegister; "Computer Asset Register"."Asset Description")
            {
            }
            column(Manufacturer_ComputerAssetRegister; "Computer Asset Register".Manufacturer)
            {
            }
            column(AllocatedUser_ComputerAssetRegister; "Computer Asset Register"."Allocated User")
            {
            }
            column(SystemSoftware_ComputerAssetRegister; "Computer Asset Register"."System Software")
            {
            }
            column(Applications_ComputerAssetRegister; "Computer Asset Register".Applications)
            {
            }
            column(ProcessorType_ComputerAssetRegister; "Computer Asset Register"."Processor Type")
            {
            }
            column(MemorySize_ComputerAssetRegister; "Computer Asset Register"."Memory Size")
            {
            }
            column(AssetSerialNo_ComputerAssetRegister; "Computer Asset Register"."Asset Serial No")
            {
            }
            column(YearofPurchase_ComputerAssetRegister; "Computer Asset Register"."Year of Purchase")
            {
            }
            column(PurchaseAmount_ComputerAssetRegister; "Computer Asset Register"."Purchase Amount")
            {
            }
            column(Status_ComputerAssetRegister; "Computer Asset Register".Status)
            {
            }
            column(YearofServiceLeft_ComputerAssetRegister; "Computer Asset Register"."Year of Service Left")
            {
            }
            column(ExpectedValueatendofLife_ComputerAssetRegister; "Computer Asset Register"."Expected Value at end of Life")
            {
            }
            column(StaffNo_ComputerAssetRegister; "Computer Asset Register"."Staff No")
            {
            }
            column(Disposed_ComputerAssetRegister; "Computer Asset Register".Disposed)
            {
            }
            column(DateDisposed_ComputerAssetRegister; "Computer Asset Register"."Date Disposed")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(ResponsibilityCenter_ComputerAssetRegister; "Computer Asset Register"."Responsibility Center")
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
        Company.Get;
        //Company.CALCFIELDS(Company.Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        AmntTp: Decimal;
        Days: Integer;
        OtherCommitementsClearance: Record "Other Commitements Clearance";
        Customer: Record Customer;
        EmployerName: Text;
        ProductFactory: Record "Product Factory";
        AccountCategory: Option Member,"Staff Members","Board Members",Delegates;
        Member: Record "Members";
        DisbursmentDate: Date;
        LoanMaturity: Date;
        IntstallMentPeriodText: Text;
        InstalmentPeriods: DateFormula;
        LnReshedule: Record "Ideal Repayment Schedule";
        DateFilter: Text[100];
        FromDate: Text[100];
        ToDate: Text[100];
        StartDate: Date;
        EndDate: Date;
        ExpdRepayment: Decimal;
        LoanAge: Integer;
        LoanNo: Code[20];
        CutOffDate: Date;
        AmtPaid: Decimal;
        AmtInArrears: Decimal;
        IssueDate: Date;
        DaysInArrears: Decimal;
        PrincipalRepay: Decimal;
        DefaultedDays: Integer;
        DaysDefaulted: Decimal;
        InterestPaid: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        CountMonths: Decimal;
        NoDays: Decimal;
        FirstPayDate: Date;
        LastPayDate: Date;
        LastPayAmnt: Decimal;
        LastIntPaid: Decimal;
        TotalLastPay: Decimal;
}
