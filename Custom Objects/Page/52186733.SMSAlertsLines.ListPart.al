page 52186733 "SMS Alerts Lines"
{
    ApplicationArea = All;
    Caption = 'SMS Alerts Lines';
    PageType = ListPart;
    SourceTable = "SMS Alerts Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    Editable = false;
                    Caption = 'Recepient Member No';
                }
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.';
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    Editable = false;
                }
                field("Loan Product Type Name";Rec."Loan Product Type Name")
                {
                    Editable = false;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    Editable = true;
                }
                field("Email Address"; Rec."Email Address")
                {
                    Editable = true;
                }
                field("Days In Arreas"; Rec."Days In Arreas")
                {
                    Editable = false;
                }
                field("Amount In Arreas"; Rec."Amount In Arreas")
                {
                    Editable = false;
                }
                field("Letter Route"; Rec."Letter Route")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    Editable = false;
                }
                field("Notice Category"; Rec."Notice Category")
                {
                    Editable = false;
                }
                field(Recepient; Rec.Recepient)
                {
                    Editable = false;
                }
                field(Notice; Rec.Notice)
                {
                    ToolTip = 'Specifies the value of the SMS field.';
                    Editable = false;
                }
                field("Send this Notification"; Rec."Send this Notification")
                {

                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    ToolTip = 'Specifies the value of the Sent field.';
                    Editable = false;
                }
                field("Email Sent"; Rec."Email Sent")
                {

                }
                field("Letter Genetrated"; Rec."Letter Genetrated")
                {
                    Visible = false;

                }
                field("Sent At"; Rec."Sent At")
                {
                    ToolTip = 'Specifies the value of the Sent At field.';
                    Editable = false;
                }
            }
        }
    }
}
