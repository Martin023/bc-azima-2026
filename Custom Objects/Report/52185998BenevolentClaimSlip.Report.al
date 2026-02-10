#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185998 "Benevolent Claim Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Benevolent Claim Slip.rdl';
    Caption = 'Claim Slip';

    dataset
    {
        dataitem("SinkFund Report Information"; "SinkFund Report Information")
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(ReportForNavId_1; 1)
            {
            }
            column(No_SinkFundReportInformation; No)
            {
            }
            column(MemberName; "SinkFund Report Information"."Member Name")
            {
            }
            column(MemberNo; "SinkFund Report Information"."Member No")
            {
            }
            column(ReportedByName; "SinkFund Report Information"."Reported By Name")
            {
            }
            column(ReportedByID; "SinkFund Report Information"."Reported By ID No")
            {
            }
            column(ReportedByRel; "SinkFund Report Information"."Reported By Relationship")
            {
            }
            column(ReportedByPhone; "SinkFund Report Information"."Reported By Phone No")
            {
            }
            column(DeathDate; "SinkFund Report Information"."Date of Death")
            {
            }

            column(DecPerson; "SinkFund Report Information"."Deceased Person")
            {
            }
            column(Status; "SinkFund Report Information".Status)
            {
            }
            column(ClaimType_SinkFundReportInformation; "Claim Type")
            {
            }
            column(BBFClaimAmout_SinkFundReportInformation; "BBF Claim Amount")
            {
            }

            column(CompanyInfo__Address_2_; Company."Address 2")
            {
            }
            column(CompanyInfo_Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }

            column(ClaimDate; "SinkFund Report Information".Date)
            {
            }

            column(UserName; UserName)
            {
            }
            column(TotalLoans_SinkFundReportInformation; "Total Loans")
            {
            }
            column(TotalSavings_SinkFundReportInformation; "Total Savings")
            {
            }
            column(TotalAmountAllocated_SinkFundReportInformation; "Total Amount Allocated")
            {
            }
            column(NetEffects_SinkFundReportInformation; "Net Effects")
            {
            }
            column(ReceiptAmount_SinkFundReportInformation; "Receipt Amount")
            {
            }
            column(ReceiptDocumentNumber_SinkFundReportInformation; "Receipt Document Number")
            {
            }
            column(AvailableBeneficiaryAmount_SinkFundReportInformation; "Available Beneficiary Amount")
            {
            }
            column(Account_Closure_Fee; "Account Closure Fee")
            {
            }
            dataitem("BBF Claim Lines"; "BBF Claim Lines")
            {
                DataItemLink = "Header No." = field(No);

                column(ProductCode_BBFClaimLines; "Product Code")
                {
                }
                column(ProductClassType_BBFClaimLines; "Product Class Type")
                {
                }
                column(AccountNo_BBFClaimLines; "Account No")
                {
                }
                column(ProductName_BBFClaimLines; "Product Name")
                {
                }
                column(LoanNo_BBFClaimLines; "Loan No.")
                {
                }
                column(OutstandingInterest_BBFClaimLines; "Outstanding Interest")
                {
                }
                column(OutstandingBalance_BBFClaimLines; "Outstanding Balance")
                {
                }
                column(AmountAllocated_BBFClaimLines; "Amount Allocated")
                {
                }
                column(TotalBalance_BBFClaimLines; "Total Balance")
                {
                }
            }
            dataitem("NextofKin Payment Allocation"; "NextofKin Payment Allocation")
            {
                DataItemLink = "Header No." = field(No);

                column(IdentificationType_NextofKinPaymentAllocation; "Identification Type")
                {
                }
                column(Identification_NextofKinPaymentAllocation; Identification)
                {
                }
                column(Name_NextofKinPaymentAllocation; Name)
                {
                }
                column(Relationship_NextofKinPaymentAllocation; Relationship)
                {
                }
                column(DateofBirth_NextofKinPaymentAllocation; "Date of Birth")
                {
                }
                column(PrincipalMemberNo_NextofKinPaymentAllocation; "Principal Member No.")
                {
                }
                column(Allocation_NextofKinPaymentAllocation; Allocation)
                {
                }
                column(BeneficiaryMemberNo_NextofKinPaymentAllocation; "Beneficiary Member No.")
                {
                }
                column(BeneficiaryAmount_NextofKinPaymentAllocation; "Beneficiary Amount")
                {
                }
            }
            dataitem("Risk External Payment"; "Risk External Payment")
            {
                DataItemLink = "Risk Claim No." = field(No);
                column(Account_Type; "Account Type")
                {
                }
                column(Account_No_; "Account No.")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Description; Description)
                {

                }
            }


            trigger OnAfterGetRecord()
            begin
                UserSetup.Reset;
                UserSetup.SetRange("User ID", "SinkFund Report Information"."Posted By");
                if UserSetup.Find('-') then begin
                    UserName := UserSetup."Full Name";
                end;
            end;

            trigger OnPreDataItem()
            begin
                if Company.Get() then
                    Company.CalcFields(Company.Picture);
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

    var
        Company: Record "Company Information";
        UserSetup: Record "User Setup";
        UserName: Text;
}
