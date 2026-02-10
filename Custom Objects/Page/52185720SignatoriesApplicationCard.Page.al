page 52185720 "Signatories Application Card"
{
    AutoSplitKey = true;
    Caption = 'Group Member Application Card';
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Signatory Application";

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
                        MembNo := true;
                        if Rec."Account Type" = Rec."Account Type"::"Non-Member" then begin
                            MembNo := false;
                            MembName := true;
                        end
                    end;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = MembNo;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = MembName;
                    ShowMandatory = true;

                }
                field("Second Name"; Rec."Second Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = MembName;
                    ShowMandatory = true;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;

                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;

                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff/Payroll"; Rec."Staff/Payroll")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Designation';
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
                    Caption = 'Member Portal Access?';
                }
            }
            group(Pictures)
            {
                field(Picture; Rec.Picture)
                {
                    //ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Signatures)
            {
                field(Signature; Rec.Signature)
                {
                    //ShowMandatory = true;
                    ApplicationArea = Basic, Suite;
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
        MembNo := true;
        MembName := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        if (Rec."Account Type" = Rec."Account Type"::Member) then begin
            if Rec."Member No." <> '' then begin
                if not Confirm('Do you wish to save?') then begin
                    Rec.Delete;
                end;
                // else begin
                //     Rec.TestField("ID Number");
                //     Rec.TestField("Date Of Birth");
                //     Rec.TestField("Phone No.");
                //     //  Rec.TestField(Picture);
                //     //  Rec.Validate("Phone No.");
                // end;
            end;
        end;

        if (Rec."Account Type" = Rec."Account Type"::"Non-Member") then begin
            if Rec.Names <> '' then begin
                if not Confirm('Do you wish to save?') then begin
                    Rec.Delete
                end; 
                //     else begin
                //     Rec.TestField("ID Number");
                //     Rec.TestField("Date Of Birth");
                //     Rec.TestField("Phone No.");
                //     Rec.Validate("Phone No.");
                // end;
            end;
        end;
    end;

    var
        MembNo: Boolean;
        MembName: Boolean;
        Sig: Record "Signatory Application";

    //[Scope('OnPrem')]
    procedure UpdateControl()
    var
        MemberAppl: Record "Member Application";
    begin
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

