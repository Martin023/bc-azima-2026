namespace ALProject.ALProject;

page 52186885 NotificationSetupSms
{
    ApplicationArea = All;
    Caption = 'NotificationSetupSms';
    PageType = List;
    SourceTable = "Notification EmSms setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("user id"; Rec."user id")
                {
                    ToolTip = 'Specifies the value of the user id field.';
                }
                field("Notification"; Rec."Notification")
                {
                    ToolTip = 'Specifies the value of the Notification field.';
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ToolTip = 'Specifies the value of the Responsibility Centre field.';
                    Editable = false;

                }
                field("Send Email"; Rec."Send Email")
                {
                    ToolTip = 'Specifies the value of the Send Email field.';
                }
                field("send sms"; Rec."send sms")
                {
                    ToolTip = 'Specifies the value of the send sms field.';
                }

            }
        }
    }

    
}
