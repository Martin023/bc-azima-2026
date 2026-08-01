page 52185940 "HR Email Body Editor"
{
    Caption = 'Email Body Editor';
    PageType = Document;
    SourceTable = "HR Email Template";
    DataCaptionExpression = Rec."Event Code" + ' - ' + Format(Rec."Recipient Role");
    ApplicationArea = Basic;
    UsageCategory = None;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group(Info)
            {
                ShowCaption = false;
                Caption = ' ';

                field(EventInfo; Rec."Event Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Event';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(RoleInfo; Rec."Recipient Role")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recipient';
                    Editable = false;
                }
            }

            group(BodyGroup)
            {
                ShowCaption = false;
                Caption = ' ';

                field(BodyEditor; BodyText)
                {
                    ApplicationArea = Basic;
                    Caption = 'Email Body';
                    MultiLine = true;
                    ExtendedDatatype = RichContent;
                    ToolTip = 'Compose the email body. Use tokens from the Available Tokens tab on the template card e.g. [EMPLOYEE_NAME].';

                    trigger OnValidate()
                    begin
                        Rec.SetBody(BodyText);
                        Rec.Modify();
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SaveAndClose)
            {
                ApplicationArea = Basic;
                Caption = 'Save and Close';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetBody(BodyText);
                    Rec.Modify();
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BodyText := Rec.GetBody();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        BodyText := Rec.GetBody();
    end;

    procedure SetTemplate(var Template: Record "HR Email Template")
    begin
        Rec := Template;
        BodyText := Rec.GetBody();
    end;

    var
        BodyText: Text;
}
