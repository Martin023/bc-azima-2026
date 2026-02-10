namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186063 "BBF/Risk/entrance fees/Depo"
{
    ApplicationArea = All;
    Caption = 'BBF/Risk/entrance fees/Depo';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/BBFRiskentrancefeesDepo.rdl';
    dataset
    {
        dataitem(Members; "Members")
        {
            column(MemberNo; "No.") { }
            column(MemberName; "Name") { }
            column(StaffPFno; "Payroll/Staff No.") { }
            column(Primary_Identification_Type; "Primary Identification Type") { }
            column(Primary_Identification; "Primary Identification") { }

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
            column(BBF; BBF) { }
            Column(Risk; Risk) { }
            column(EntranceFees; EntranceFees) { }
            column(BosaDeposits; BosaDeposits) { }
            //BBF, Risk, entrance fees, Deposits summary reports (Mno., TSC / PF, names, total deposits, amounts).

            trigger OnAfterGetRecord()
            begin
                BBF := 0;
                Risk := 0;
                EntranceFees := 0;
                BosaDeposits := 0;

                // SavingsAccount.reset();
                // SavingsAccount.setrange(SavingsAccount."Member No.", Members."No.");
                // if SavingsAccount.Find('-') then begin
                //     //repeat
                //         case SavingsAccount."Product Category" of
                //             SavingsAccount."Product Category"::"BOSA Deposits":
                //                 BosaDeposits := SavingsAccount."Balance (LCY)";
                //             SavingsAccount."Product Category"::"Benevolent (BBF)":
                //                 BBF := SavingsAccount."Balance";
                //             SavingsAccount."Product Category"::"Risk":
                //                 Risk := SavingsAccount."Balance (LCY)";
                //             SavingsAccount."Product Category"::"Entrance Fee":
                //                 EntranceFees := SavingsAccount."Balance (LCY)";
                //         end;
                //     //until SavingsAccount.Next = 0;
                // end;


                //Deposit Balance
                SavingsAccount.Reset();
                SavingsAccount.SetRange(SavingsAccount."Member No.", Members."No.");
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"BOSA Deposits");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BOSADeposits := SavingsAccount."Balance (LCY)";
                end;
                //BBF Balance
                SavingsAccount.Reset();
                SavingsAccount.SetRange(SavingsAccount."Member No.", Members."No.");
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Benevolent (BBF)");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BBF := SavingsAccount."Balance (LCY)";
                end;

                //Risk Balance
                SavingsAccount.Reset();
                SavingsAccount.SetRange(SavingsAccount."Member No.", Members."No.");
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::Risk);
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    Risk := SavingsAccount."Balance (LCY)";
                end;

                SavingsAccount.Reset();
                SavingsAccount.SetRange(SavingsAccount."Member No.", Members."No.");
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    EntranceFees := SavingsAccount."Balance (LCY)";
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
        BBF: Decimal;
        Risk: Decimal;
        EntranceFees: Decimal;
        BosaDeposits: Decimal;
        SavingsAccount: Record "Savings Accounts";

}
