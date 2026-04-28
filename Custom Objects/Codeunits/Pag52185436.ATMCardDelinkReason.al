namespace BCAZIMA.BCAZIMA;

page 52185436 "ATM Card Delink Reason"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'Enter Reason for Delinking';

    layout
    {
        area(Content)
        {
            field(ReasonField; ReasonTxt)
            {
                ApplicationArea = All;
                Caption = 'Reason';
                MultiLine = true;
                ShowMandatory = true;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then
            if ReasonTxt = '' then begin
                Message('Please enter a reason for delinking');
                exit(false);
            end;
        exit(true);
    end;

    var
        ReasonTxt: Text[250];

    procedure GetReason(): Text[250]
    begin
        exit(ReasonTxt);
    end;
}
