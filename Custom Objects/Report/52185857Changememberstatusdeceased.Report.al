#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185857 "Change member status deceased"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Change member status deceased.rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Membershipclosure.Reset;
                Membershipclosure.SetRange("Member No.", "No.");
                // Membershipclosure.SetRange("Closure Type", Membershipclosure."closure type"::"Withdrawal - Death");
                Membershipclosure.SetRange(Posted, true);
                Membershipclosure.SetFilter("Closing Date", '>=%1', 20200101D);
                if Membershipclosure.Find('-') then begin
                    Members.Status := Members.Status::Deceased;
                    Members.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Successful');
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

    var
        SavingsAccounts: Record "Savings Accounts";
        Membershipclosure: Record "Membership closure";
}
