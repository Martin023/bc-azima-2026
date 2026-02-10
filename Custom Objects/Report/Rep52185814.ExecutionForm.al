namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185814 "Execution Form"
{
    ApplicationArea = All;
    Caption = 'Execution Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './bc-kenpipe-2024/Layout/Execution Form.docx';

    dataset
    {
        dataitem(Securities_Collection_Register; "Securities Collection Register")
        {
            column(Loan_Number_; "Loan No.")
            {
            }
            column(Members_Name; "Member Name") { }
            column(DischargeDocument_Attachments; "Document Attachments") { }
            column(Reviewed_By_Legal_Department; "Reviewed By Legal Department") { }
            column(Reviewed_By_Legal_Officer; "Reviewed By") { }
            column(ReviewBoolean; ReviewBoolean) { }
            // trigger OnAfterGetRecord()
            // var
            //     myInt: Integer;
            // begin
            //     if Securities_Collection_Register."Reviewed By Legal Department" then begin
            //         ReviewBoolean := Format('Yes');
            //     end
            //     else if not Securities_Collection_Register."Reviewed By Legal Department" then begin
            //         ReviewBoolean := Format('No');
            //     end;
            // end;

            dataitem(SecurityPerfection; "Security Perfection")
            {
                DataItemLinkReference = Securities_Collection_Register;
                DataItemLink = "Loan No." = field("Loan No.");
                column(PerfectionNo; "No.")
                {
                }
                column(Loan_No_; "Loan No.")
                {
                }
                column(Member_No_; "Member No.")
                {
                }
                column(Member_Name; "Member Name")
                {
                }
                column(Loan_Name; "Loan Name")
                {
                }
                column(LoanAmount; Amount)
                {
                }
                column(Lending_Unit; "Lending Unit")
                {
                }
                column(AllLoansSecurity; AllLoansSecurity) { }
                column(Perfection_Attachements; "Perfection Attachements")
                {
                }
                column(LegalOfficers; CompanyInformation."Legal Officer Name")
                {
                }
                column(LegalOfficerTitle; CompanyInformation."Legal Officer Title")
                {
                }
                column(ConcatenatedChargedProperty; ConcatenatedChargedProperty) { }
                column(TodayYear; TodayYear) { }
                dataitem("Perfection Lines"; "Perfection Lines")
                {
                    column(Security_No_; "Security No.")
                    {
                    }
                    column(Property_No_; "Property No.")
                    {
                    }
                    column(Charge_Type; "Charge Type")
                    {
                    }
                    column(Amount_to_Charge; "Amount to Charge")
                    {
                    }
                    column(Market_Value; "Market Value")
                    {
                    }
                    column(Forced_Sale_Value; "Forced Sale Value")
                    {
                    }
                    column(CollateralValue; "Collateral Value Sum")
                    {
                    }
                    column(ChargedProperty; ChargedProperty) { }

                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;

                    begin
                        TodayYear := 0;
                        TodayYear := Date2DMY(Today, 3);

                        HeaderRec.RESET;
                        HeaderRec.SETRANGE("Loan No.", HeaderRec."Loan No.");
                        if HeaderRec.FINDFIRST() then begin
                            LinesRec.RESET;
                            LinesRec.SETRANGE("Loan No.", HeaderRec."Loan No.");
                            LineCount := LinesRec.COUNT;
                            if LinesRec.FINDSET() then begin
                                i := 1;
                                repeat
                                    Property := LinesRec."Charge Type" + ' over Property No. ' + LinesRec."Property No." + ' ' + 'to be charged KES. ' + FORMAT(LinesRec."Amount to Charge") + '.00' + ' ';
                                    ChargedProperty := LinesRec."Property No.";
                                    if i = LineCount then begin
                                        Concatenatedproperty += Property;
                                        ConcatenatedChargedProperty += ChargedProperty
                                    end
                                    else
                                        Concatenatedproperty += Property + 'and,' + ' ';
                                    ConcatenatedChargedProperty += ChargedProperty + 'and,' + ' ';
                                    i += 1;
                                until LinesRec.NEXT = 0;
                            end;
                        end;
                        //Message('Concatenated Property: %1', Concatenatedproperty);
                        //Message('Charged Property: %1', ChargedProperty);
                        //Message('Concatenated Charged Property: %1', ConcatenatedChargedProperty);
                        //HeaderRec."Concatenated Property" := Concatenatedproperty;
                        //HeaderRec.MODIFY;
                    end;
                }
                dataitem("LoanGuarantorsandSecurity"; "Loan Guarantors and Security")
                {
                    column(LoanGuarantorsandSecurityLoan_No; "Loan No")
                    {
                    }
                    column(Guarantor_Type; "Guarantor Type")
                    {
                    }
                    column(Amount_Guaranteed; "Amount Guaranteed")
                    {
                    }
                    column(LoanSecured1; LoanSecured1) { }
                    column(LoanSecured2; LoanSecured2) { }
                    column(LoanSecured3; LoanSecured3) { }
                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;


                    begin
                        // Securities_Collection_Register.TestField("Reviewed By Legal Department");
                        // if Securities_Collection_Register."Reviewed By Legal Department" = true then begin
                        //     ReviewBoolean := Format('Yes.');
                        // end
                        // else if Securities_Collection_Register."Reviewed By Legal Department" = false then begin
                        //     ReviewBoolean := Format('No.');
                        // end;
                        //Loan has been secured by:
                        LoanGuarantorsandSecurity.RESET;
                        LoanGuarantorsandSecurity.SETRANGE(LoanGuarantorsandSecurity."Loan No", SecurityPerfection."Loan No.");
                        if LoanGuarantorsandSecurity.Find('-') then begin
                            repeat
                                LoanGuarantorsandSecurity.TestField("Guarantor Type");
                                if LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::"Guarantor" then begin
                                    LoanGuarantorsandSecurity.CalcSums("Amount Guaranteed");
                                    LoanSecured1 := '-' + ' Guarantorship of KES. ' + FORMAT(LoanGuarantorsandSecurity."Amount Guaranteed") + '.00' + ' ';
                                end;
                                if LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::"Collateral" then begin
                                    LoanGuarantorsandSecurity.CalcSums("Amount Guaranteed");
                                    LoanSecured2 := '-' + 'Collateral Security of amount KES. ' + FORMAT(LoanGuarantorsandSecurity."Amount Guaranteed") + '.00' + ' ';
                                end;
                                if LoanGuarantorsandSecurity."Guarantor Type" = LoanGuarantorsandSecurity."Guarantor Type"::"Lien" then begin
                                    LoanGuarantorsandSecurity.CalcSums("Amount Guaranteed");
                                    LoanSecured3 := '-' + 'Deposits ' + 'of amoun KES. ' + FORMAT(LoanGuarantorsandSecurity."Amount Guaranteed") + '.00' + ' ';
                                end;
                            until LoanGuarantorsandSecurity.Next = 0;
                        end;
                        AllLoansSecurity := LoanSecured1 + LoanSecured2 + LoanSecured3;
                        //Message('All Loans Security: %1', AllLoansSecurity);
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    securities_Collection_Register.TestField("Reviewed By Legal Department");
                    if Securities_Collection_Register."Reviewed By Legal Department" = true then begin
                        ReviewBoolean := Format('Yes.');
                    end
                    else if Securities_Collection_Register."Reviewed By Legal Department" = false then begin
                        ReviewBoolean := Format('No.');
                    end;
                end;
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

    var
        Companyinformation: Record "Company Information";
        CollateralCollection: Record "Securities Collection Register";
        TodayYear: Integer;
        LoanSecured1: Text;
        LoanSecured2: Text;
        LoanSecured3: Text;
        AllLoansSecurity: Text;
        HeaderRec: Record "Security Perfection";
        LinesRec: Record "Perfection Lines";
        Concatenatedproperty: Text;
        LineCount: Integer;
        i: Integer;
        Property: Text;
        ChargedProperty: Text;
        ReviewBoolean: Text;
        ConcatenatedChargedProperty: Text;
}
