#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186398 "Reg Fee Arrears"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Member Register Fosa';
    RDLCLayout = './bc-azima-2026/Layout/Reg Fee Arrears.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            DataItemTableView = where(Status = filter(Status::New));
            RequestFilterFields = "No.", Status, "Employer Code", "Registration Date", "Account Type", "Global Dimension 1 Code", "Global Dimension 2 Code", Nationality;

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
            column(No_Members; Members."No.")
            {
            }

            column(Name_Members; Members.Name)
            {
            }
            column(GlobalDimension1Code_Members; Members."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Members; Members."Global Dimension 2 Code")
            {
            }
            column(RegistrationDate_Members; Members."Registration Date")
            {
            }
            column(EmployerCode_Members; Members."Employer Code")
            {
            }
            column(Nationality_Members; Members.Nationality)
            {
            }
            column(PayrollStaffNo_Members; Members."Payroll/Staff No.")
            {
            }
            column(PhoneNo_Members; Members."Phone No.")
            {
            }
            column(IDNumber_Members; Members."Primary Identification")
            {
            }

            column(GroupAccountNo_Members; Members."Group Account No.")
            {
            }
            column(SalespersonCode_Members; Members."Recruited By")
            {
            }
            column(MemberSegment_Members; Members."Member Segment")
            {
            }
            column(CreatedBy_Members; Members."Created By")
            {
            }

            column(Status_Members; Members.Status)
            {
            }
            column(SCount; SNo)
            {
            }
            column(MemberClass_Members; Members."Member Class")
            {
            }

            column(RegFees; RegFees)
            {
            }
            column(RegFeeBal; RegFeeBal)
            {
            }
            column(SavRegFees; SavRegFees)
            {
            }
            column(RegDate; RegDate)
            {
            }
            column(ShortTLoans; ShortTLoans)
            {
            }
            column(LongTLoans; LongTLoans)
            {
            }
            column(TotalLoans; TotalLoans)
            {
            }
            column(BranchCode_Members; Members."Branch Code")
            {
            }
            column(CreatedBy; CreatedBy)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                RegFees := 0;
                RegFeeBal := 0;
                CreatedBy := '';

                User.Reset;
                User.SetRange("User Name", Members."Created By");
                if User.Find('-') then begin
                    CreatedBy := User."Full Name";
                end;


                // ProdFact.Reset();
                // ProdFact.SetRange("Product Category", ProdFact."Product Category"::"Entrance Fee");
                // if ProdFact.FindFirst() then begin
                //     RegFees := ProdFact."Minimum Contribution";

                //     SavingAcc.Reset;
                //     SavingAcc.SetRange("Member No.", "No.");
                //     SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Entrance Fee");
                //     if SavingAcc.Find('-') then begin
                //         SavLedgerEntry.Reset();
                //         SavLedgerEntry.SetRange("Customer No.", SavingAcc."No.");
                //         SavLedgerEntry.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                //         SavLedgerEntry.SetFilter("Credit Amount (LCY)", '>0');
                //         if SavLedgerEntry.FindFirst() then begin
                //             SavLedgerEntry.CalcSums("Credit Amount (LCY)");
                //             // repeat
                //             SavRegFees := SavLedgerEntry."Credit Amount (LCY)";
                //             RegDate := SavLedgerEntry."Posting Date";
                //             // until
                //             // SavLedgerEntry.CalcFields("Amount (LCY)");
                //         end;
                //     end;


                // end;
                if Memberclass.get(Members."Member Class") then begin
                    RegFees := Memberclass."Entrance Fee";

                    SavingAcc.Reset;
                    SavingAcc.SetRange("Member No.", "No.");
                    SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Entrance Fee");
                    if SavingAcc.FindFirst() then begin
                        SavingAcc.CalcFields("Balance (LCY)");
                        SavregFees := SavingAcc."Balance (LCY)";

                    end;
                end;

                RegFeeBal := RegFees - SavRegFees;
                //if RegFeeBal <> 0 then RegFeeBal := 0;
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then
                    StartDate := 19900101D;

                if EndDate = 0D then
                    EndDate := Today;

                Members.Reset();
                Members.SetFilter("Registration Date", '%1..%2', StartDate, EndDate);
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
                group("Date Filter")
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ShowMandatory = true;

                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date/AsAt';
                        ShowMandatory = true;
                    }
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

    trigger OnPreReport()
    begin
        if StartDate = 0D then
            StartDate := 19900101D;
        if EndDate = 0D then
            EndDate := Today;

        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        Members.Reset();
        members.SetFilter("Registration Date", '%1..%2', StartDate, EndDate);
    end;

    var
        ProdFact: Record "Product Factory";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SNo: Integer;
        SavingAcc: Record "Savings Accounts";
        RegFees: Decimal;
        SavRegFees: Decimal;
        RegFeeBal: Decimal;
        ShortTLoans: Decimal;
        LongTLoans: Decimal;
        TotalLoans: Decimal;
        CreatedBy: Text;
        User: Record User;
        RegDate: Date;
        StartDate: Date;
        EndDate: Date;
        SavLedgerEntry: Record "Savings Ledger Entry";
        MemberClass: Record "Member Classes";
}
