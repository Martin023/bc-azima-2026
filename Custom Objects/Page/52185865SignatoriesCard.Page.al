page 52185865 "Signatories Card"
{
    AutoSplitKey = false;
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Account Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        if rec."Account Type" = rec."Account Type"::Member then
                            PageEdit := false
                        else
                            PageEdit := true;
                    end;

                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = PageEdit;
                    ShowMandatory = true;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = PageEdit;
                }

                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    
                }
                field("Staff/Payroll"; Rec."Staff/Payroll")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory=true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Instructions)
            {
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Must Sign"; Rec."Must Sign")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Must be Present"; Rec."Must be Present")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Can Access Member Portal"; Rec."Can Access Member Portal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Members Portal Access?';
                }
            }
            group(Pictures)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
            }
            group(Signatures)
            {
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control13; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control14; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        UpdateControl;
    end;

    var
        PageEdit: Boolean;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    var
        MemberAppl: Record "Member Application";
    begin
        if Rec."Account Type" = Rec."Account Type"::"Non-Member" then begin
            PageEdit := true
        end else
            PageEdit := false;
        // end;

        if MemberAppl.Get(Rec."Account No") then begin
            case MemberAppl.Status of
                MemberAppl.Status::Pending, MemberAppl.Status::Approved, MemberAppl.Status::Rejected:
                    begin
                        CurrPage.Editable := false;
                    end;

                MemberAppl.Status::Open:
                    begin
                        CurrPage.Editable := true;
                    end;
            end;
        end;
    end;
}

