#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185759 "Sales Agents Performance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sales Agents Performance.rdl';

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_SalespersonPurchaser; "Salesperson/Purchaser".Code)
            {
            }
            column(Name_SalespersonPurchaser; "Salesperson/Purchaser".Name)
            {
            }
            column(TotalATMS; TotalATMS)
            {
            }
            column(TotalMembers; TotalMembers)
            {
            }
            column(TotalLoans; TotalLoans)
            {
            }
            column(SNo; SNo)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyName2; CompanyInformation."Name 2")
            {
            }
            column(Address; CompanyInformation.Address)
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(PhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                //Get Total Members recruited
                Members.Reset;
                Members.SetRange(Members."Recruited By", "Salesperson/Purchaser".Code);
                if Members.Find('-') then begin
                    repeat
                        if (Members."Registration Date" >= FromDate) and (Members."Registration Date" <= "To Date") then
                            TotalMembers += 1;
                    until Members.Next = 0;
                end;
                //Get Total ATMS
                ATMApplications.Reset;
                ATMApplications.SetRange(ATMApplications."Sales Agent", "Salesperson/Purchaser".Code);
                if ATMApplications.Find('-') then begin
                    repeat
                        if (ATMApplications."Application Date" >= FromDate) and (ATMApplications."Application Date" <= "To Date") then
                            TotalATMS += 1;
                    until ATMApplications.Next = 0;
                end;
                //Get Total Sold Loans
                Loans.Reset;
                Loans.SetRange(Loans."Sales Agent", "Salesperson/Purchaser".Code);
                if Loans.Find('-') then begin
                    repeat
                        if (Loans."Application Date" >= FromDate) and (Loans."Application Date" <= "To Date") then
                            TotalLoans += 1;
                    until Loans.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if (FromDate = 0D) or ("To Date" = 0D) then
                    Error('Kindly specify date filters');
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
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
                field(FromDate; FromDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'From:';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'To:';
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

    var
        FromDate: Date;
        "To Date": Date;
        Members: Record "Members";
        ATMApplications: Record "ATM Applications";
        Loans: Record Loans;
        TotalATMS: Integer;
        TotalMembers: Integer;
        TotalLoans: Integer;
        SNo: Integer;
        CompanyInformation: Record "Company Information";
}
