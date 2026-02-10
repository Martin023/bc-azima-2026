#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185768 "Sink Fund Notice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sink Fund Notice Report.rdl';
    caption = 'Deceased Member Report';

    dataset
    {
        dataitem(Members; "SinkFund Report Information")
        {
            // DataItemTableView = where("Claim Option" = filter('PRINCIPAL MEMBER'));

            column(Name; CompanyInformation.Name)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(Address; CompanyAddress)
            {
            }
            column(PhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(No_Members; Members.No)
            {
            }
            column(Date_Members; Members."Date")
            {
            }
            column(ReportedByName_Members; Members."Reported By Name")
            {
            }
            column(ReportedByIDNo_Members; Members."Reported By ID No")
            {
            }
            column(ReportedByRelationship_Members; Members."Reported By Relationship")
            {
            }
            column(MemberNo_Members; Members."Member No")
            {
            }
            column(DateofDeath_Members; Members."Date of Death")
            {
            }

            column(DeceasedPerson_Members; Members."Deceased Person")
            {
            }
            column(MemberName_Members; Members."Member Name")
            {
            }

            column(Date_of_Death; "Date of Death")
            {

            }
            column(GlobalDimension1Code_Members; Members."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Members; Members."Global Dimension 2 Code")
            {
            }
            column(Status_Members; Members.Status)
            {
            }
            column(ResponsibilyCenter_Members; Members."Responsibily Center")
            {
            }
            column(CapturedBy_Members; Members."Captured By")
            {
            }

            column(Posted_Members; Members.Posted)
            {
            }
            column(DatePosted_Members; Members."Date Posted")
            {
            }
            column(PostedBy_Members; Members."Posted By")
            {
            }

            column(Scount; SNo)
            {
            }
            column(IDNo; IDNo)
            {
            }
            column(DeptCode; DeptCode)
            {
            }
            column(ClaimDate; Members.Date)
            {
            }
            column(Paid; Paid)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                IDNo := '';
                DeptCode := '';
                if Mem.Get(Members.No) then begin
                    IDNo := Mem."Primary Identification";
                    DeptCode := Mem."Employer Code";
                end;
                // ClaimDate := SkyHarambeePortal.FormatDate(Members.Date);
                Paid := false;
                BBFRequisationHeader.Reset;
                BBFRequisationHeader.SetRange("Report Notice No", Members.No);
                BBFRequisationHeader.SetRange(Posted, true);
                if BBFRequisationHeader.FindFirst then Paid := true;
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
        SNo: Integer;
        SavingAcc: Record "Savings Accounts";
        CreditAcc: Record "Credit Accounts";
        LoanAcc: Record Loans;
        AplhaDeposit: Decimal;
        SharesCapital: Decimal;
        RegFees: Decimal;
        CreditLoans: Decimal;
        BankingLoans: Decimal;
        AlphaDepositProduct: Code[10];
        SharesCapitalProduct: Code[10];
        RegFeesProduct: Code[10];
        ShortTLoans: Decimal;
        LongTLoans: Decimal;
        TotalLoans: Decimal;
        CreatedBy: Text;
        User: Record User;
        NextofKIN: Record "Next of KIN";
        ImageData: Record "Image Data";
        HASNextKin: Boolean;
        HASImage: Boolean;
        ShowNextofKin: Boolean;
        ShowImage: Boolean;
        IDNo: Code[20];
        Mem: Record "Members";
        DeptCode: Code[10];
        ClaimDate: Text;
        // SkyHarambeePortal: Codeunit "Sky Harambee Portal";
        BBFRequisationHeader: Record "BBF Requisation Header";
        Paid: Boolean;
}
