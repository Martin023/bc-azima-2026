namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186089 "Archived Files"
{
    ApplicationArea = All;
    Caption = 'Archived Files';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Archived Files.rdl';
    dataset
    {
        dataitem("Files Table"; "Files Table")
        {
            RequestFilterFields = "File Type";
            column(FileNo_; "No.") { }
            column(File_Type; "File Type") { }
            column(File_Member_No_; "File/Member No.") { }
            column(File_Name_Descrption; "File Name/Descrption") { }
            column(StaffPFNo; StaffPFNo) { }
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

            dataitem(FileVolumes; "File Volumes")
            {
                DataItemLinkReference = "Files Table";
                DataItemLink = "File No." = field("No.");
                column(FileNo; "File No.")
                {
                }
                column(FileVolumeNo; "File Volume No.")
                {
                }
                column(BatchNo; "Batch No.")
                {
                }
                column(YearOpened; "Year Opened")
                {
                }
                column(YearofClosure; "Year of Closure")
                {
                }
                column(Archived; Archived)
                {
                }
                column(VolumesDateArchived; "Date Archived")
                {
                }
                column(VolumesArchivedBy; "Archived By")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BatchLines.RESET;
                    BatchLines.Setrange(Archived, false);
                    BatchLines.SETRANGE("File No.", FileVolumes."File No.");
                    if BatchLines.FIND('-') then begin
                        repeat
                            StaffPFNo := BatchLines."Staff PF No.";
                        until BatchLines.NEXT = 0;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    CompanyInformation.Get;
                    CompanyInformation.CalcFields(Picture);
                end;
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
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var

        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StaffPFNo: Code[20];
        BatchLines: Record "Batch Lines Table";
}
