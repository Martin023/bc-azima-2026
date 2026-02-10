namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186091 "Overdue Files"
{
    ApplicationArea = All;
    Caption = 'Overdue Files';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Overdue Files.rdl';

    dataset
    {
        dataitem(FileRequests; "File Requests")
        {
            DataItemTableView = where(Overdue = const(true));
            RequestFilterFields = "File Recalled";
            column(RequestNo; "Request Number") { }
            column(File_Type; "File Type") { }
            column(File_No; "File Number") { }
            column(File_Request_Date; "File Request Date") { }
            column(File_Recalled; "File Recalled") { }
            column(Overdue; "Overdue") { }
            column(Due_Date; DueDate) { }
            column(FileNo; FileNo) { }
            column(FileVolume; FileVolume) { }
            column(CompanyInformation_Name; CompanyInformation.Name) { }
            column(CompanyInformation_Picture; CompanyInformation.Picture) { }
            column(CompanyAddress; CompanyAddress) { }
            column(CompanyTelephone; CompanyTelephone) { }
            column(CommunicationOnline; CommunicationOnline) { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                DueDate := 0D;
                DueDate := CalcDate('+4WD', FileRequests."File Request Date");

                FileTracker.Reset();
                FileTracker.SETRANGE("File Request No.", FileRequests."Request Number");
                if FileTracker.Find('-') then begin
                    FileNo := FileTracker."File Number";
                    FileVolume := FileTracker."Folio Number";
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
        CommunicationOnline := 'Email: ' + CompanyInformation."E-Mail" + ' -Website: ' + CompanyInformation."Website";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        DueDate: Date;
        FileTracker: Record "File Tracker";
        FileNo: Code[50];
        FileVolume: Code[50];
}
