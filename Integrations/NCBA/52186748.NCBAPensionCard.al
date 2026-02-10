page 52186748 "NCBA Pension Card"
{
    Caption = 'NCBA Pension Card';
    PageType = Card;
    //UsageCategory = Administration;
    SourceTable = "NCBA Pension Buffer";
    ModifyAllowed = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Pension Number"; Rec."pensionNumber")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pension Number field.', Comment = '%';
                }

                field("Account No"; Rec."accountNo")
                {
                    ApplicationArea = All;
                    Editable = NeedsChange;
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';

                    trigger OnValidate()
                    var
                        SavingsAccountRec: Record "Savings Accounts";
                    begin
                        if SavingsAccountRec.Get(Rec."accountNo") then begin
                            Rec.Name := SavingsAccountRec.Name;
                            //Rec."Pension Number" := SavingsAccountRec."Member No.";
                        end;
                    end;
                }
                field("Reference Number"; Rec."referenceNumber")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Reference Number field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Company field.', Comment = '%';
                }
                field("Needs change"; Rec."Needs change")
                {
                    ApplicationArea = All;
                    Editable = not Rec.Posted; // editable if Posted is false
                    ToolTip = 'Specifies the value of the Needs change field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Date Entered"; Rec."dateEntered")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Entered field.', Comment = '%';
                }
                field("Date posted"; Rec."postingDate")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date posted field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field(ModifiedAt; Rec.ModifiedAt)
                {
                    ToolTip = 'specifies the value of theModifiedAt', Comment = '%';
                    Editable = false;
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'spcifies the value of ModifiedBy', Comment = '%';
                    Editable = false;
                }
            }
        }
    }

    // actions
    // {
    //     area(Navigation)
    //     {
    //         action(Post)
    //         {
    //             ApplicationArea = Basic, Suite;
    //             Image = Post;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             Caption = 'Post';

    //             trigger OnAction()
    //             var
    //             begin

    //             end;
    //         }
    //     }
    // }

    var
        NeedsChange: Boolean;

    procedure SetAccountNoEditable()
    begin
        NeedsChange := rec."Needs change";
    end;

    trigger OnAfterGetRecord()
    begin
        SetAccountNoEditable;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetAccountNoEditable;
    end;
}
