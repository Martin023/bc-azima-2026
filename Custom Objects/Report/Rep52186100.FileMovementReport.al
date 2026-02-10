namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186100 "File Movement Report"
{
    ApplicationArea = All;
    Caption = 'File Movement Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/File Movement Report.rdl';

    dataset
    {
        dataitem(FileTracker; "File Tracker")
        {
            //coLUMN(File_Request_No_; "File Request No.") { }
            column(File_Request_Number; "File Request Number") { }
            column(Request_Number; "Request Number") { }
            column(FileType; "File Type") { }
            column(FileORMember_No; "File Number") { }
            COLUMN(Name; "Member Name") { }
            column(File_Request_Remarks; "File Request Remarks") { }
            column(Narration; "Narration") { }
            column(ID_No_; "ID No.") { }
            column(Loan_No; "Loan No") { }
            column(Staff_No; "Staff No") { }
            column(File_Requested_By; "File Requested By") { }
            column(RequestingDepartment; "Responsibility Centre") { }
            column(File_Request_Date; "File Request Date") { }
            column(Status; Status) { }
            column(File_Request_Status; "File Request Status") { }
            column(Overdue; Overdue) { }
            column(DateClosed; "Date Closed") { }
            column(Date_Overdue; "Date Overdue") { }
            //filedeyails
            column(Volume_Entry_No_; "Volume Entry No.") { }
            column(File_No_; "File No.") { }
            column(File_Name; "File Name") { }
            column(File_Volume_No_; "File Volume No.") { }
            column(Folio_Number; "Folio Number") { }
            //FileLocation
            column(MoveTo; "Move To") { }
            column(Sent_To; "Sent To") { }
            column(Current_Responsibility_Centre; "Current Responsibility Centre") { }
            column(Responsibility_Centre; "Responsibility Centre") { }
            column(File_MVT_User_ID; "File MVT User ID") { }
            column(File_MVT_Time; "File MVT Time") { }
            COLUMN(File_MVT_Date; "File MVT Date") { }
            COLUMN(Current_File_Location; "Current File Location") { }
            column(File_received_date; "File received date") { }
            column(File_received_time; "File received time") { }
            column(File_Received_by; "File Received by") { }
            column(File_Received; "File Received") { }
            column(File_Recalled; "File Recalled") { }
            column(FileForwarded; "File  Forwarded") { }

            // column(Volume; "Folio Number") { }
            // column(DateIssued; "File MVT Date") { }
            // column(DateRequested; DateRequested) { }
            // column(ReasonForIssue; ReasonForIssue) { }


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
            dataitem("File Location"; "File Location")
            {
                //A log of all recepeints and departments
                DataItemLinkReference = FileTracker;
                DataItemLink = "Member No." = FIELD("File Number");

                column(Member_No_; "Member No.") { }
                column(Approval_Type; "Approval Type") { }
                column(Section_Code; "Section Code") { }
                column(TrackerResponsibility_Centre; "Responsibility Centre") { }
                column(Remarks; "Remarks") { }
                column(TrackerStatus; "Status") { }
                column(Current_Location; "Current Location") { }
                column(Date_Time_In; "Date/Time In") { }
                column(Date_Time_Out; "Date/Time Out") { }
                column(USER_ID; "USER ID") { }
                column(Entry_No_; "Entry No.") { }
                column(Station_Name; "Station Name") { }
                column(Station; "Station") { }
                column(TrakcerNarration; "Narration") { }
                column(Folio; "Folio") { }
                column(Issued_To; "Issued To") { }

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                // FileRequest.RESET;
                // FileRequest.SETRANGE("Request Number", FileTracker."File Request No.");
                // if FileRequest.Find('-') then begin
                //     DateRequested := FileRequest."File Request Date";
                //     ReasonForIssue := FileRequest."File Request Remarks";
                // end;

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
        FileRequest: Record "File Requests";
        DateRequested: Date;
        ReasonForIssue: Text[500];
}
