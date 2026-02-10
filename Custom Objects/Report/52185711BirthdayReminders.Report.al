#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185711 "Birthday Reminders"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './bc-azima-2026/Layout/Birthday Reminders.rdl';
    UsageCategory = Tasks;
    Caption = 'Send Birthday reminders';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Members; Members)
        {
            //RequestFilterFields = "No.", "Date of Birth", "Global Dimension 2 Code";
            DataItemTableView = where("Date of Birth" = filter(<> ''));

            trigger OnAfterGetRecord()
            begin
                PeriodicActivities.SendMemberBirthdayMessages(Members."No.");
                PeriodicActivities.SendMemberTotoBirthdayMessages(Members."No.");
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
    end;

    var
        PeriodicActivities: Codeunit "Periodic Activities";
}
