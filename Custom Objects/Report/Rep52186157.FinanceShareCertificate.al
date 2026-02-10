namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186157 "Finance Share Certificate"
{
    ApplicationArea = All;
    Caption = 'Finance Share Certificate';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './bc-kenpipe-2024/Layout/Finance Share Certificate.docx';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            DataItemTableView = where(Status = filter(<> Deceased));
            column(Name; Name)
            {
            }
            column(No; "No.")
            {
            }
            // column(TodaysDay;TodaysDay)
            // {
            // }
            // column(TodaysMonth;TodaysMonth)
            // {
            // }
            column(ShareCapBalance; ShareCapBalance)
            {
            }
            column(TransferedShareCapBalance; TransferedShareCapBalance)
            {
            }
            column(NoofShares; NoofShares)
            {
            }
            column(PrintingDate; PrintingDate)
            {
            }
            column(PrimaryIdentification; "Primary Identification")
            {
            }
            column(SharePrice; SharePrice)
            {
            }
            column(DirectorName; CompanyInformation."Director")
            {
            }
            column(CEOName; CompanyInformation."CEO")
            {
            }
            column(CEO_Signature; CompanyInformation."CEO Signature")
            {
            }
            column(Director_Signature; CompanyInformation."Director Signature")
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            
            column(CompanyName; CompanyInformation."Name")
            {
            }
            column(ISOCertification; CompanyInformation."ISO Certification")
            {
            }
            column(PostOfficeAddress; CompanyInformation."Address")
            {
            }
            column(SACCOName; CompanyInformation."Name")
            {
            }
            column(Telephone; CompanyInformation."Phone No.")
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(Website; CompanyInformation."Website")
            {
            }
            column(PhysicalAddress; CompanyInformation."Address 2")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //PrintingDate := '';
                // SharePrice := 0;
                // ShareCapBalance := 0;
                CertNo := 0;
                //TodaysDay := 0;
                //TodaysMonth := 0;
                //TodaysYear := 0;
                TotalShares := 0;

                //CertNo := +1;
                SavingsAccounts.RESET;
                SavingsAccounts.SETRANGE("Member No.", Members."No.");
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Transfered Share Capital");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    TransferedShareCapBalance := SavingsAccounts."Balance (LCY)";
                    if SavingsAccounts."Balance (LCY)" > 0 then
                        Message('Member has a Transfered Share Capital balance of Kshs. %1', TransferedShareCapBalance);
                end;

                SavingsAccounts.Reset();
                SavingsAccounts.SETRANGE("Member No.", Members."No.");
                SavingsAccounts.SETRANGE(SavingsAccounts."Product Category", SavingsAccounts."Product Category"::"Share Capital");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    ShareCapBalance := SavingsAccounts."Balance (LCY)";
                    TotalShares := ShareCapBalance + TransferedShareCapBalance;
                    GenSetups.GET;
                    if ShareCapBalance < GenSetups."Minimum Share Capital" then begin
                        if TotalShares < GenSetups."Minimum Share Capital" then begin
                            Error('Member has not met the minimum share capital requirement')
                        end
                        else begin
                            SharePrice := GenSetups."Shares Price";
                            NoofShares := ROUND((TotalShares / GenSetups."Shares Price"), 1, '<');
                            PrintingDate := GlobalFunctions.FormatDateFullMonth(Today);
                        end;
                    end;
                end;
            end;
        }
        // dataitem(ShareCertBufferT; "Share Certificate Buffer")
        // {
        //     RequestFilterFields = "Member No.";
        //     column(CertNo; "No.")
        //     {
        //     }
        //     column(CertMemberNo; "Member No.")
        //     {
        //     }
        // column(CertMemberName; "Member Name")
        // {
        // }
        // column(CertNoofShares; "No. of Shares")
        // {
        // }
        // column(Shares_Recepient_No; "Shares Recepient No")
        // {
        // }
        // column(Shares_Recepient_Name; "Shares Recepient Name")
        // {
        // }
        // column(Transffered_Shares; "Transffered Shares")
        // {
        //     }
        //     trigger OnAfterGetRecord()
        //     begin
        //         ShareCertBuffer.RESET;
        //         ShareCertBuffer.SETRANGE("Member No.", Members."No.");
        //         if ShareCertBuffer.FindFirst() then begin
        //             repeat
        //                 ShareCertBuffer.Init();
        //                 ShareCertBuffer."No." := Members."No.";
        //                 ShareCertBuffer."Member No." := Members."No.";
        //                 ShareCertBuffer."Member Name" := Members.Name;
        //                 ShareCertBuffer."No. of Shares" := NoofShares;

        //                 ShareCertBuffer.Insert();
        //             until ShareCertBuffer.Next() = 0;
        //             //PrintingDate := Today;
        //         end;
        //     end;
        // }
        //}
    }

    // ProcedureDateToWords(Var PrintingDate: Date; Var DateInWords: Text[250])
    // {
    //     begin
    //     var
    //     TempStr : Text[250];

    //     //DateInWords := Format(PrintingDate, 0, 1033);
    // end;
    // }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
            CompanyInformation.CalcFields(CompanyInformation."CEO Signature");
            CompanyInformation.CalcFields(CompanyInformation."Director Signature");
            CompanyAddress := CompanyInformation.Address;
            Telephone := CompanyInformation."Phone No.";
            EMail := CompanyInformation."E-Mail";
            Website := CompanyInformation."Website";
            PhysicalAddress := CompanyInformation."Address 2";
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        Website: Text;
        Email: Code[250];
        Telephone: Code[250];
        SACCOName: Code[250];
        CompanyAddress: Code[250];
        ISOCertification: Code[250];
        PhysicalAddress: Code[250];
        PostOfficeAddress: Code[250];
        SavingsAccounts: Record "Savings Accounts";
        Product_Category: Code[250];
        ShareCapBalance: Decimal;
        Member_No: Code[250];
        GenSetups: Record "General Set-up";
        ShareCertBuffer: Record "Share Certificate Buffer";
        ShareCapTranserBuffer: Record "Share Capital Transfer Buffer";
        ShareCapTranferLines: Record "Share Capital Transfer Lines";
        NoofShares: Decimal;
        PrintingDate: Text;
        SharePrice: Decimal;
        CertNo: Integer;
        TodaysDay: Integer;
        TodaysMonth: Integer;
        TodaysYear: Integer;
        GlobalFunctions: Codeunit "Global Functions";
        TransferedShareCapBalance: Decimal;
        TotalShares: Decimal;
}
