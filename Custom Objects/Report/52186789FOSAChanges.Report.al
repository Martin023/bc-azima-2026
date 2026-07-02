Report 52186789 "FOSA Account Change Logs"
{
    DefaultLayout = RDLC;
    ApplicationArea = Basic, suite;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/FOSA Account Change Logs.rdl';

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            // DataItemTableView = where("Table No." = filter(52185730));
            RequestFilterFields = "User ID";
            column(Entry_No_; "Entry No.")
            {
            }
            column(Date_and_Time; "Date and Time")
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(Table_No_; "Table No.")
            {
            }
            column(Table_Caption; "Table Caption")
            {
            }
            column(Field_No_; "Field No.")
            {
            }
            column(Field_Caption; "Field Caption")
            {
            }
            column(Type_of_Change; "Type of Change")
            {
            }
            column(Old_Value; Format("Old Value"))
            {
            }
            column(New_Value; Format("New Value"))
            {
            }
            column(Primary_Key; "Primary Key")
            {
            }
            column(Primary_Key_Field_1_Caption; "Primary Key Field 1 Caption")
            {
            }
            column(Primary_Key_Field_1_Value; "Primary Key Field 1 Value")
            {
            }
            column(Primary_Key_Field_1_No_; "Primary Key Field 1 No.")
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

            end;

            trigger OnPreDataItem()
            begin
                "Change Log Entry".reset;
                "Change Log Entry".SetRange("Table No.", 52185730);
                if AccountNo <> '' then begin
                    "Change Log Entry".SetFilter("Primary Key Field 1 Value", '%1', AccountNo);
                end;

                // if EndDate = 0D then Error('Kindly set the end date');
                // // Company.Get;
                // Company.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        // SaveValues = true;

        layout
        {
            area(content)
            {
                field(AccountNo; AccountNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                    TableRelation = "Savings Accounts"."No." where("Product Type" = filter('191'));
                }
                // field(EndDate; EndDate)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'End Date';
                // }
            }
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
        AccountNo: text;
        EndDate: Date;
        Company: Record "Company Information";
        IntEarned: Decimal;
        NoOfDays: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}

