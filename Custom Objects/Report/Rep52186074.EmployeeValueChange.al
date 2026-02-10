namespace ALProject.ALProject;

using System.IO;
using Microsoft.Foundation.Company;

report 52186074 "Employee Value Change"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Employee Value Change Report.rdl';
    dataset
    {
        dataitem(Employee; "HR Employees")
        {
            column(No_; "No.")
            {

            }
            column(FullName; FullName)
            {

            }


            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(Status; Status)
            {

            }
            column(Responsibility_Center; "Responsibility Center")
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
            dataitem("System Edits Filters"; "System Edits Filters")
            {
                DataItemLink = Filter = field("No.");
                column(Record_ID; "Record ID")
                {

                }
                column(ChangeDate; ChangeDate)
                {

                }
                column(InnitiatingOfficer; InnitiatingOfficer)
                {

                }
                column(EditingOfficer; EditingOfficer)
                {

                }
                column(ApprovingOfficer; ApprovingOfficer)
                {

                }
                dataitem("System Edits Fields"; "System Edits Fields")
                {
                    DataItemLink = "Record ID" = field("Record ID");
                    DataItemTableView = where("Generally Edited" = const(true));

                    column(Field_Name; "Field Name")
                    {

                    }
                    column(Old_Value; "Old Value")
                    {

                    }
                    column(New_Value; "New Value")
                    {

                    }

                }
                trigger OnAfterGetRecord()
                var
                    SystemEdits: Record "System Edits";
                begin
                    SystemEdits.Reset();
                    SystemEdits.SetRange("No.", "System Edits Filters"."Record ID");
                    SystemEdits.SetRange(Posted, true);
                    if SystemEdits.FindFirst() then begin
                        ChangeDate := GlobalFunctions.DMUDateFormatDateTime(SystemEdits."Posting Date");
                        InnitiatingOfficer := GlobalFunctions.FormatUserName(SystemEdits."Innitiating Officer");
                        EditingOfficer := GlobalFunctions.FormatUserName(SystemEdits."Editing Officer");
                        ApprovingOfficer := GlobalFunctions.FormatUserName(SystemEdits."Approving Officer");
                    end else
                        CurrReport.Skip();


                end;
            }




            trigger OnPreDataItem()
            begin
                intProgressTotal := Employee.Count;
                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;

            trigger OnAfterGetRecord()
            var
                EditsFilters: Record "System Edits Filters";
            begin
                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

                EditsFilters.Reset();
                EditsFilters.SetRange(Filter, Employee."No.");
                if not EditsFilters.FindFirst() then
                    CurrReport.Skip();

            end;

            trigger OnPostDataItem()
            begin
                diaProgress.CLOSE;
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

        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        ChangeDate: Text;

        InnitiatingOfficer: Text;
        EditingOfficer: Text;
        ApprovingOfficer: Text;

        //Other Variables

        GlobalFunctions: Codeunit "Global Functions";

        //Task Progress
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;
}
