namespace MNS.MNS;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.Company;

report 52186122 "Employer Allocation Report"
{
    ApplicationArea = All;
    Caption = 'Employer Allocation Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Employer Allocation Report.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Account Type" = Const("Employer"));
            column(CustomerNo; "No.")
            {
            }
            column(CustomerName; Name)
            {
            }

            column(Responsible_Employee_Name; "Responsible Employee Name")
            {
            }
            column(ExtensionNo; "Responsible Employee Extension")
            {
            }
            column(CheckoffType; CheckoffType) { }
            column(BPReceiptDate; BPReceiptDate) { }
            column(BPAmount; BPAmount) { }
            column(BPMonth; BPMonth) { }
            column(LastCheckoffPostingDate; LastCheckoffPostingDate) { }
            column(LastChekoffPostingMonth; LastChekoffPostingMonth) { }
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
            var
                myInt: Integer;
            begin
                CheckoffHeader.Reset;
                CheckoffHeader.SetRange(Posted, true);
                CheckoffHeader.SetRange("Employer Code", Customer."No.");
                if CheckoffHeader.Find('-') then begin
                    CheckoffType := FORMAT(CheckoffHeader."CheckOff Type");
                    BPReceiptDate := CheckoffHeader."Posting Date";
                    BPMonth := CopyStr(Format(CheckoffHeader."Posting Period", 0, '<Month Text>'), 1, 3);
                    BPAmount := CheckoffHeader.Amount;
                end;

                // CheckoffHeader.Reset;
                // CheckoffHeader.SetRange(Posted, true);
                // CheckoffHeader.SetRange("Employer Code", Customer."No.");
                // if CheckoffHeader.FindLast() then begin
                //     LastCheckoffPostingDate := CheckoffHeader."Posting Date";
                //     LastChekoffPostingMonth := CopyStr(Format(CheckoffHeader."Posting Period", 0, '<Month Text>'), 1, 3);
                // end;

                CheckoffHeader.Reset();
                CheckoffHeader.SetRange("Employer Code", Customer."No.");
                CheckoffHeader.SetRange(Posted, true);
                CheckoffHeader.SetCurrentKey("Posting Date");
                CheckoffHeader.SetAscending("Posting Date", false);
                IF CheckoffHeader.Find('-') then begin
                    myInt := 0;
                    REPEAT
                        myInt += 1;
                        if myInt = 2 then begin
                            LastCheckoffPostingDate := CheckoffHeader."Posting Date";
                            LastChekoffPostingMonth := CopyStr(Format(CheckoffHeader."Posting Period", 0, '<Month Text>'), 1, 3);
                        end;
                    UNTIL CheckoffHeader.Next() = 0;
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
        CheckoffHeader: Record "Checkoff Header";
        LastCheckoffPostingDate: Date;
        LastChekoffPostingMonth: Code[100];
        BPReceiptDate: Date;
        BPMonth: Code[100];
        BPAmount: Decimal;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CheckoffType: Code[100];
}
