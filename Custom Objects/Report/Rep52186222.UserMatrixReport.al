report 52186222 "User Matrix Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'User Roles Report';
    DefaultLayout = RDLC;
    RdlcLayout = './bc-kenpipe-2024\Layout\UserRolesReport.rdl';

    dataset
    {
        dataitem(User; User)
        {
            RequestFilterFields = "State";
            column(Users_Security_ID; "User Security ID")
            {
            }
            column(UserName; "User Name")
            {
                IncludeCaption = true;
            }
            column(State; State)
            {
                IncludeCaption = true;
            }

            dataitem("Access Control"; "Access Control")
            {
                DataItemLink = "User Security ID" = field("User Security ID");
                column(User_Security_ID; "User Security ID")
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

                column(RoleName; "Role ID") //role id
                {
                }
                column(Description; "Role Name") //  Role name 
                {

                }
            }

            trigger OnAfterGetRecord()
            var
                StateFilter: Text;
            begin
                StateFilter := User.GetFilter("State");

                if not ShowDisabledUsers
                   and (State = State::Disabled)
                   and not StateFilter.Contains('Disabled') then begin
                    CurrReport.Skip();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowDisabledUsers; ShowDisabledUsers)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Disabled Users';
                        ToolTip = 'Include disabled users in the report';
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
            CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
            CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
            CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        end;
    end;

    var
        ShowDisabledUsers: Boolean;
        CompanyAddress: Text;
        BiuldingName: Text;
        CompanyEmail: Text;
        PhoneNumber: Text;
        CommunicationOnline: Text;
        CompanyName: Text;
        CompanyTelephone: Text;
        CompanyInformation: Record "Company Information";
}
