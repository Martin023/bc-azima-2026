#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186034 "Staff Daily Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Staff Daily Transactions DMU.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("User Setup"; "User Setup")
        {
            RequestFilterFields = "Member No.", "User ID", "Global Dimension 1 Code", "Global Dimension 2 Code", "Responsibility Centre";

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
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "User ID" = field("User ID");
                RequestFilterFields = "Posting Date", "Source Type", Amount;
                column(Document_No_; "Document No.")
                {

                }
                column(PostingDate; PostingDate)
                {

                }
                column(Debit_Amount; "Debit Amount")
                {

                }
                column(Credit_Amount; "Credit Amount")
                {

                }
                column(Reversed; Reversed)
                {

                }
                column(Description; Description)
                {

                }
                column(Source_Type; "Source Type")
                {

                }
                column(Source_No_; "Source No.")
                {

                }
                column(MemberNo; MemberNo)
                {

                }
                column(MemberName; MemberName)
                {

                }
                column(UserName; UserName)
                {

                }
                column(Last_Modified_DateTime; "Last Modified DateTime") { }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code") { }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code") { }
                trigger OnAfterGetRecord()
                begin
                    if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Credit then begin
                        LoanAccounts.Reset();
                        LoanAccounts.SetRange("No.", "G/L Entry"."Source No.");
                        LoanAccounts.SetLoadFields("No.", Name);
                        if LoanAccounts.FindFirst() then begin
                            MemberName := LoanAccounts.Name;
                            MemberNo := LoanAccounts."Member No.";
                        end;
                    end;
                    if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Savings then begin
                        SavingsAccounts.Reset();
                        SavingsAccounts.SetRange("No.", "G/L Entry"."Source No.");
                        SavingsAccounts.SetLoadFields(Name, "No.");
                        if SavingsAccounts.FindFirst() then begin
                            MemberName := SavingsAccounts.Name;
                            MemberNo := SavingsAccounts."Member No.";
                        end;
                    end;

                    UserName := GlobalFunctions.FormatUserName("User ID");
                    PostingDate := GlobalFunctions.FormatDate("G/L Entry"."Posting Date");
                end;

                trigger OnPreDataItem()
                begin
                    if Transactions = Transactions::Reversed then
                        "G/L Entry".SetRange(Reversed, true);
                    if Transactions = Transactions::"Non-Reversed" then
                        "G/L Entry".SetRange(Reversed, false);
                end;
            }
            trigger OnAfterGetRecord()
            begin

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
                field(Transactions; Transactions)
                {

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

    // trigger OnPreReport()
    // begin
    //     CompanyInformation.Get;
    //     //    CompanyInformation.CalcFields(CompanyInformation.Picture);
    //     CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
    //     CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
    //     CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    // end;

    var
        //Colums
        MemberNo: Code[50];
        MemberName: Text;
        UserName: Text;
        PostingDate: Text;


        //Request Page
        Transactions: Option All,Reversed,"Non-Reversed";

        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        //  Members: Record Members;
        LoanAccounts: Record "Credit Accounts";
        SavingsAccounts: Record "Savings Accounts";
        GlobalFunctions: Codeunit "Global Functions";


}
