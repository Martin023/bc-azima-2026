namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186158 "Legal Share Capital Register"
{
    ApplicationArea = All;
    Caption = 'Legal Share Capital Register';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Legal Share Capital Register.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Name; Name) { }
            column(ShareCpaBal; ShareCapBal) { }
            column(TransferedShareCapBal; TransferedShareCapBal) { }
            column(DestinationMemberNo; DestinationMemberNo) { }
            column(DestinationMemberName; DestinationMemberName) { }
            column(TransfferredAmount; TransfferredAmount) { }
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
            // dataitem(ShareCapitalTransferBuffer; "Share Capital Transfer Buffer")
            // {
            //     DataItemLinkReference = Members;
            //     DataItemLink = "Source Member No" = field("No.");
            //     DataItemTableView = where(Transfered = const(True));
            //     column("MemberNo"; "Source Member No") { }
            //     column(Source_Member_Name; "Source Member Name") { }
            //     column(Source_Balance; "Source Balance") { }
            //     dataitem("Share Capital Transfer Lines"; "Share Capital Transfer Lines")
            //     {
            //         DataItemLinkReference = ShareCapitalTransferBuffer;
            //         DataItemLink = "Destination Member No" = field("Destination Member No.");
            //         column("DestinationMemberNo"; "Destination Member No") { }
            //         column("DestinationMemberName"; "Destination Member Name") { }
            //         column("AllocationAmount"; "Allocation Amount") { }
            //     }
            // }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ShareCapBal := 0;
                TransferedShareCapBal := 0;
                MinimumShareCap := 0;
                DestinationMemberNo := '';
                DestinationMemberName := '';
                TransfferredAmount := 0;

                GenSetups.GET;
                MinimumShareCap := GenSetups."Minimum Share Capital";

                SavingsAccounts.Reset();
                SavingsAccounts.SETRANGE("Member No.", Members."No.");
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Share Capital");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    ShareCapBal := SavingsAccounts."Balance (LCY)";
                end;

                if ShareCapBal < MinimumShareCap then begin
                    ShareCapitalTransferBufferTable.Reset();
                    ShareCapitalTransferBufferTable.SETRANGE("Source Member No", Members."No.");
                    if ShareCapitalTransferBufferTable.Find('-') then begin
                        ShareCapitalTransferLines.RESET;
                        ShareCapitalTransferLines.SetRange("Document No.", ShareCapitalTransferBufferTable."Document No");
                        if ShareCapitalTransferLines.Find('-') then begin
                            repeat
                                TransfferredAmount := ShareCapitalTransferLines."Allocation Amount";
                                DestinationMemberNo := ShareCapitalTransferLines."Destination Member No";
                                DestinationMemberName := ShareCapitalTransferLines."Destination Member Name";
                            until ShareCapitalTransferLines.Next = 0;
                        end;
                    end else
                        CurrReport.Skip();
                end;

                // if ShareCapBal < MinimumShareCap then begin
                //     CurrReport.Skip();
                // end;

                SavingsAccounts.Reset();
                SavingsAccounts.SETRANGE("Member No.", Members."No.");
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Transfered Share Capital");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    TransferedShareCapBal := SavingsAccounts."Balance (LCY)";
                end;
            end;

            // The system should have a function to generate a share certificate register. The register should contain.
            // i.	Member name
            // ii.	Member number
            // iii.	Number of shares held.
            // iv.	Total certificates issued out.
            // v.	The transferred/ cancelled shares
            // vi.	Who the shares have been transferred to

        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
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
        ShareCapBal: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        TransferedShareCapBal: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        GenSetups: Record "General Set-up";
        MinimumShareCap: Decimal;
        ShareCapitalTransferLines: Record "Share Capital Transfer Lines";
        ShareCapitalTransferBufferTable: Record "Share Capital Transfer Buffer";
        TransfferredAmount: Decimal;
        DestinationMemberName: Text;
        DestinationMemberNo: Code[50];
}
