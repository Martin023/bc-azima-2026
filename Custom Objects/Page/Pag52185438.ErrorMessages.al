namespace MNSProjectMwanga.MNSProjectMwanga;

using System.Utilities;

page 52185438 "Error Messages Log"
{
    ApplicationArea = All;
    Caption = 'Error Messages Log';
    PageType = List;
    SourceTable = 700;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Additional Information"; Rec."Additional Information")
                {
                    ToolTip = 'Specifies more information than the information shown in the Description field.';
                }
                field("Message Type"; Rec."Message Type")
                {
                    ToolTip = 'Specifies if the message is an error, a warning, or information.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the Context field.';
                }

                field("Context Table Number"; Rec."Context Table Number")
                {
                    ToolTip = 'Specifies the value of the Context Table Number field.';
                }
                field("Created On"; Rec."Created On")
                {
                    ToolTip = 'The time of error occurence.';
                }

                field(Message; Rec.Message)
                {
                    ToolTip = 'Specifies the message.';
                }


            }
        }
    }
}
