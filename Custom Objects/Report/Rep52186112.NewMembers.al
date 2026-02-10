report 52186112 "New Members Report"
{
    ApplicationArea = All;
    Caption = 'New Members';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/NewMembers.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status;
            column(No_Members; "No.")
            {
            }
            column(Status_Members; Status)
            {
            }
            column(Name; Name)
            {
            }
            column(Phone_Number; "Phone No.")
            {
            }

            column(CompPic; CompInfo.Picture)
            {
            }

            trigger OnPreDataItem()
            begin
                Members.SETRANGE(Status, Status::New);

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
            }
        }

    }

    trigger OnPreReport()
    begin

        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";


}
