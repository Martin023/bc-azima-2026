#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185450 "Edit Audit Trail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Edit Audit Trail.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "Employer Code", "No.", "Primary Identification";
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {

            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(No_; "No.")
            {

            }
            column(Name; Name)
            {

            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {

            }
            column(Employer_Code; "Employer Code")
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
                column(DateApproved; DateApproved) { }
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
                        DateApproved := SystemEdits."Posting Date";
                    end else
                        CurrReport.Skip();


                end;
            }


            trigger OnPreDataItem()
            begin
                intProgressTotal := Members.Count;
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
                EditsFilters.SetRange(Filter, Members."No.");
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
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";
        PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
        PrintingTime := Format(Time);
        PrintedBy := GlobalFunctions.FormatUserName(UserId);
    end;

    var
        //columns
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];

        ChangeDate: Text;

        InnitiatingOfficer: Text;
        EditingOfficer: Text;
        ApprovingOfficer: Text;
        DateApproved: DateTime;

        //Other Variables
        CompanyInformation: Record "Company Information";
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
