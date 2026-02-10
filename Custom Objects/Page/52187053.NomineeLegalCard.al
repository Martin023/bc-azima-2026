page 52187053 "Nominee Legal Card"
{
    ApplicationArea = All;
    Caption = 'Nominee Legal Card';
    PageType = Card;
    SourceTable = "Nominee Legal";
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Reports,History/Edms,Loan File,Cancellation,Category7_caption,Category8_caption';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                }
                // field("Nominee Name"; Rec."Nominee Name")
                // {
                //     Applicationarea = Basic, Suite;
                //     Editable = False;
                // }
                // field("Nominee Allocation"; Rec."Percentage Allocated")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Branch; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Activity; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Created at"; Rec."Created at")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Comments"; Rec."Comments")
                // {
                //     ToolTip = 'Specifies the value of the Comments field.';
                // }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                } 
            }
            part("Nominees Lines"; "Nominee Legal Lines" )
            {
                Caption = 'Nominees';
                ApplicationArea = Basic;
                SubPageLink = "No." =  field("No.");
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("View Nominee Form")
            {
                ApplicationArea = All;
                Image = View;
                Caption = 'View Nominee Form';
                Promoted = true;
                Visible = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

            trigger OnAction()
            begin
                Rec.TestField("Member No.");
                Message('Input Member Number!');
            end;
            }
            action("Request Nominee Form")
            {
                ApplicationArea = All;
                Image = Document;
                Caption = 'Request Nominee Form';
                Promoted = true;
                Visible = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                Rec.TestField("Member No.");
                Message('Input Member Number!');
                
                end;
            }
        }
    }


    var
        UserSetup: Record "User Setup";
    trigger OnOpenPage()
    begin
        // StatusControl;
        if UserSetup.Get(Rec."Created By") then begin
            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            Rec."Responsibility Centre" := UserSetup."Responsibility Centre";
            Rec.Modify;
        end;
        
        Rec."Created By" := UserId;
        Rec."Created at" := CurrentDateTime;
        
    end;
}
