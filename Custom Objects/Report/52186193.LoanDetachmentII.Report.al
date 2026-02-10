namespace Mwanga.Mwanga;
using Microsoft.Foundation.Company;

report 52186193 "Loan Detachment II"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Detachment II.rdl';

    dataset
    {
        dataitem("Loan Recovery Header II"; "Loan Recovery Header II")
        {
            RequestFilterFields = "Recovery Type", Action, "Header Reversed";
            DataItemTableView = where("Recovery Type" = const(Reversal), Action = const(Reversed));
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
            column(No_; "No.")
            {

            }
            column(HeaderMemberNo; "Member No.")
            {

            }
            column(HeaderName; Name)
            {

            }
            column(HeaderIdentifier; HeaderIdentifier)
            {

            }
            column(HeaderPostingDate; HeaderPostingDate)
            {

            }
            column(HeaderDepositsRecovered; HeaderDepositsRecovered)
            {

            }
            column(HeaderPrincipleAttached; HeaderPrincipleAttached)
            {

            }
            column(HeaderInterestAttached; HeaderInterestAttached)
            {

            }
            column(HeaderLoanNo; "Loan No.")
            {

            }
            column(HeaderTotalLoanBalance; "Total Balance")
            {

            }
            column(HeaderLoanType; HeaderLoanType)
            {

            }
            column(HeaderLoanDescription; HeaderLoanDescription)
            {

            }
            column(PostedBy; PostedBy)
            {

            }
            dataitem("Loan Reversal Lines II"; "Loan Reversal Lines II")
            {
                DataItemLink = "Header No." = field("No.");
                DataItemTableView = where("Refund Type" = filter("Guarantor Payoff" | "Deposits Reversal"));
                column(Header_No_; "Header No.")
                {

                }
                column(LinesMemberNo; "Guarantor Member No.")
                {

                }

                column(LinesMemberName; "Guarantor Name")
                {

                }
                column(LinesIdentifier; LinesIdentifier)
                {

                }
                column(LinesPrincipleAmount; "Principle Attached Amount")
                {

                }
                column(LinesInterestAmount; "Interest Attached Amount")
                {

                }
                column(LinesLoanNo; "Guarantor Loan No")
                {

                }
                column(LinesInterestBalance; "Guarantor Interest Balance")
                {

                }
                column(LinesPrincipleBalance; "Guarantor Principal Balance")
                {

                }
                column(LinesInterestsAccrued; "Interests Accrued")
                {

                }
                column(LinesInterestPaidByGuarantor; "Interest Paid By Guarantor")
                {

                }
                column(LinesPrinciplePaidByGuarantor; "Principle Paid By Guarantor")
                {

                }
                column(LinesInterestReappotionments; "Total Int To Defaulter")
                {

                }
                column(LinesPrincipleReappotionments; "Total Pr To Defaulter")
                {

                }
                column(LinesFOSAReappotionments; "FOSA Reappotionments")
                {

                }
                column(LinesFOSARefund; "Total FOSA Refund")
                {

                }
                column(LinesTotalIntToDefaulter; "Total Int To Defaulter")
                {

                }
                column(LinesTotalPrToDefaulter; "Total Pr To Defaulter")
                {

                }
                column(LinesTotalLoanToDefaulter; "Total Loan To Defaulter")
                {

                }
                column(Refund_Type; "Refund Type")
                {

                }

                trigger OnAfterGetRecord()
                var
                    GuarantorMember: Record Members;
                    GuarantorLoan: Record Loans;
                begin
                    LinesIdentifier := '';

                    if Members.Get("Loan Reversal Lines II"."Guarantor Member No.") then begin
                        LinesIdentifier := Members."Primary Identification";
                        if LinesIdentifier = '' then
                            LinesIdentifier := Members."Secondary Identification";

                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                HeaderIdentifier := '';
                HeaderPrincipleAttached := 0;
                HeaderDepositsRecovered := 0;
                HeaderLoanType := '';
                HeaderLoanDescription := '';
                HeaderDetachedBy := '';

                HeaderPostingDate := GlobalFunctions.FormatDate("Loan Recovery Header II"."Posting Date");

                if Members.Get("Loan Recovery Header II"."Member No.") then begin
                    HeaderIdentifier := Members."Primary Identification";
                    if HeaderIdentifier = '' then
                        HeaderIdentifier := Members."Secondary Identification";

                    if Loans.Get("Loan Recovery Header II"."Loan No.") then begin
                        Loans.CalcFields("Loans Category-SASRA");
                        HeaderLoanType := Loans."Loan Product Type";
                        HeaderLoanDescription := Loans."Loan Product Type Name";
                        HeaderDetachedBy := GlobalFunctions.FormatUserName("Loan Recovery Header II"."Posted By");
                    end;
                end;

                ReversalLines.Reset();
                ReversalLines.SetRange("Header No.", "Loan Recovery Header II"."No.");
                ReversalLines.SetRange("Refund Type", ReversalLines."Refund Type"::"Deposits Reversal");
                if ReversalLines.FindFirst() then begin
                    HeaderDepositsRecovered := ReversalLines."Principle Attached Amount" + ReversalLines."Interest Attached Amount";
                    HeaderPrincipleAttached := ReversalLines."Principle Attached Amount";
                    HeaderInterestAttached := ReversalLines."Interest Attached Amount";
                end;
                PostedBy := GlobalFunctions.FormatUserName("Loan Recovery Header II"."Posted By");
            end;

            trigger OnPostDataItem()
            begin
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        //Header
        HeaderIdentifier: Code[50];
        HeaderPrincipleAttached: Decimal;
        HeaderInterestAttached: Decimal;
        HeaderDepositsRecovered: Decimal;
        HeaderLoanType: Code[20];
        HeaderLoanDescription: Text;
        HeaderDetachedBy: Code[50];
        HeaderPostingDate: Text;
        PostedBy: Text;

        //Lines
        LinesIdentifier: Code[50];

        //Request Page
        RunLoansAttachedToDepositsOnly: Boolean;

        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";
        Loans: Record Loans;
        ProductFactory: Record "Product Factory";
        ReversalLines: Record "Loan Reversal Lines II";
}
