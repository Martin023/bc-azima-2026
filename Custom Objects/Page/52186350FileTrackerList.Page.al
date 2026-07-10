page 52186350 "File Tracker List"
{
    CardPageID = "File Tracker Card";
    DeleteAllowed = false;
    // Editable = false;
    PageType = List;
    InsertAllowed = true;
    SourceTable = "File Tracker";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request Number"; Rec."Request Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Creation No.';
                    StyleExpr = StyleExprTxt;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Folio Number"; Rec."Folio Number")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("File Request Status"; Rec."File Request Status")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Sent To"; Rec."Sent To")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Current Location';
                    StyleExpr = StyleExprTxt;
                }
                field("Office Name"; Rec."Office Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Current Responsibility Centre"; Rec."Current Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("Other  Doc  No"; Rec."Other  Doc  No")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field("File  Forwarded"; Rec."File  Forwarded")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleExprTxt;
                }
                field(Create; Rec.Create)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'File Created';
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    actions
    {
    }

    // trigger OnOpenPage()
    // var
    //     UserSetup: Record "User Setup";
    // begin
    //     if UserSetup.Get(UserId) then begin
    //         UserSetup.TestField("Responsibility Centre");
    //         Rec.SetFilter(Rec."Current Responsibility Centre", UserSetup."Responsibility Centre");
    //     end else
    //         Error('You must be set up in user setup');
    // end;
    trigger OnAfterGetRecord()
    begin
    
        StyleExprTxt := '';
        if FileTracker.Get(Rec."Request Number") then begin
            if (FileTracker."File Request Date" <= CalcDate('<-2W>', Today)) 
            then 
                StyleExprTxt := 'Unfavorable'
            else StyleExprTxt := '';
        end;

    end;
    var
        StyleExprTxt : Text;
        FileTracker : Record "File Tracker";
}

