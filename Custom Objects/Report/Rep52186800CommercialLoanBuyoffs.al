report 52186800 "Commercial Loan buyoffs"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Commercial Buyoff report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Commercial Buyoff" = const(true));
            RequestFilterFields = "Employer Code", Posted, Status, "Source Unit";
            column(Loan_No_; "Loan No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Staff_No; "Staff No")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")

            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Employername; Employername)
            {

            }
            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Loan_Account; "Loan Account")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Compapicture; CompanyInformation.Picture)
            {

            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            { }
            column(CompanyNam; CompanyNam)
            {

            }
            column(CheqNo; CheqNo)
            { }
            column(CommentApp; CommentApp)
            {

            }
            column(Employer_Code; "Employer Code")
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                Cust: Record Customer;
            begin
                Employername := '';
                CommentApp := '';
                if Cust.get(Loans."Employer Code") then
                    Employername := Cust.Name;
                AppraisalComm.Reset();
                AppraisalComm.SetRange("Loan No.", Loans."Loan No.");
                if AppraisalComm.FindLast() then
                    CommentApp := AppraisalComm.Comment;

            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);

        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

    end;

    var
        myInt: Integer;
        Employername: Text;
        CheqNo: code[40];
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommentApp: Text;
        CheqDepositDate: Date;
        CommunicationOnline: Text;
        AppraisalComm: Record "Loan Appraisal Comments";
        CompanyNam: Text;
        BankName: Text;
        CompanyInformation: Record "Company Information";
}