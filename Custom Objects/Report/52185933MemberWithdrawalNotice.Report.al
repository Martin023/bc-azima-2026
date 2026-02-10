#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185933 "Member Withdrawal Notice"
{
    DefaultLayout = RDLC;

    Caption = 'Member Withdrawal Notices';
    RDLCLayout = './bc-kenpipe-2024/Layout/Member Withdrawal Notice.rdl';

    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Member withdrawal Notice"; "Member withdrawal Notice")
        {
            RequestFilterFields = "Member No.", Status, "Notice Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(Notice_No; "Member withdrawal Notice"."No.")
            {
            }
            column(Mem_No; "Member withdrawal Notice"."Member No.")
            {
            }
            column(NoticeDate; "Member withdrawal Notice"."Withdrawal Notice Date")
            {
            }
            column(MaturityDate; "Member withdrawal Notice"."Maturity Date")
            {
            }
            column(NoticeType; "Member withdrawal Notice"."Notice Type")
            {
            }
            column(LoanBalance; "Member withdrawal Notice"."Loans Outstanding Balance")
            {
            }
            column(Out_Interest; "Member withdrawal Notice"."Loans Outstanding Interest")
            {
            }
            column(Mem_Deposits; "Member withdrawal Notice"."Member Deposit")
            {
            }
            // column(CompName; Company.Name)
            // {
            // }
            // column(CompPic; Company.Picture)
            // {
            // }
            column(MemName; MemName)
            {
            }
            column(SNo; StaffNo)
            {
            }
            column(Paid; paid)
            {
            }
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

            trigger OnAfterGetRecord()
            begin
                Members.Reset;
                Members.SetRange("No.", "Member withdrawal Notice"."Member No.");
                if Members.FindFirst then
                    MemName := Members.Name;
                StaffNo := Members."Payroll/Staff No.";

                //check if posted on member closure
                MemClosure.Reset;
                MemClosure.SetRange("Notice Number", "Member withdrawal Notice"."No.");
                if MemClosure.FindFirst then
                    if MemClosure.Posted = true then
                        paid := 'Paid'
                    else
                        if MemClosure.Posted = false then
                            paid := 'Pending';

                if not MemClosure.FindFirst then
                    paid := 'Pending';
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
        MemName: Text;
        Members: Record "Members";
        StaffNo: Code[50];
        MemClosure: Record "Membership closure";
        paid: Text;
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
