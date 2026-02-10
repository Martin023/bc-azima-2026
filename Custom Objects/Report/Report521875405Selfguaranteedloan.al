report 52187405 "Self Guaranteed Loans Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Self Guaranteed loans Report';
    RDLCLayout = './bc-azima-2026/Layout/Disbursed Loans Report.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where("Self Guarantee" = const(true));
            column(Loan_No_; "Loan No.")
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Outstanding_Balance; "Outstanding Balance")
            {

            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyNam; CompanyNam)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(picture; CompanyInformation.Picture)
            {
            }
            column(Approved_Amount; "Approved Amount")
            {

            }
            column(Installments; Installments)
            {

            }
            column(EmployerCode; EmployerCode)
            { }
            column(GenderMemb; GenderMemb)
            {

            }
            column(IDnum; IDnum)
            {

            }
            column(Approved_By; "Approved By")
            {

            }
            column(Captured_By; "Captured By")
            {

            }

            column(Posted_By; "Posted By")
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                MembersRec: Record Members;
            begin
                MembersRec.Reset();
                MembersRec.SetRange("No.", Loans."Member No.");
                if MembersRec.FindFirst() then begin
                    EmployerCode := MembersRec."Employer Code";
                    GenderMemb := Format(MembersRec.Gender);
                    IDnum := MembersRec."Primary Identification";
                end;

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
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }

    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        myInt: Integer;
        DepositBal: Record "Savings Accounts";
        CompanyInformation: Record "Company Information";
        CompanyNam: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CountN: Integer;
        EmployerCode: Code[40];
        IDnum: Code[30];
        GenderMemb: Text;
}