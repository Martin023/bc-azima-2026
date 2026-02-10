namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186101 "Files Due For Archiving"
{
    ApplicationArea = All;
    Caption = 'Files Due For Archiving';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Files Due For Archiving.rdl';
    dataset
    {
        dataitem(FileVolumes; "File Volumes")
        {
            DataItemTableView = where(Batched = Const(true), Archived = Const(false));
            Column(FileNo; "File No.") { }
            Column(FileVolume; "File Volume No.") { }
            Column(FileType; "File Type") { }
            column(Location; Location) { }
            column(Year_Opened; "Year Opened") { }
            column(Year_of_Closure; "Year of Closure") { }
            column(Closed; "Closed") { }
            column(DateClosed; "Date Closed") { }
            column(ClosedBy; "Closed By") { }
            column(Batch_No_; "Batch No.") { }
            column(Date_Batched; "Date Batched") { }
            column(Batched_By; "Batched By") { }
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
        MemberCardLog: Record "Member Card Printing Log";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
