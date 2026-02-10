page 52185717 "Next of KIN Application"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = true;
    InsertAllowed = true;
    LinksAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Next of KIN Application";
    Caption = 'Dependancies Page';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Record ID"; Rec."Record ID")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Identification Type"; Rec."Identification Type")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        PageControl();
                        CurrPage.Update();
                    end;
                }
                field("Identification Number"; Rec.Identification)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = IdentificationEditable;
                    // Visible = IdentificationVisible;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Gender; Rec.Gender)
               {
                    ApplicationArea = Basic, Suite;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Age; Rec.Age)
                {
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mobile No.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Next of Kin"; Rec."Is Next of Kin")
                {
                    ApplicationArea = all;
                }

                field("Is a Beneficiary"; Rec."Is a Beneficiary")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Guardian';
                }
                field("Is Contact Person"; Rec."Is Contact Person")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Is Nominee"; Rec."Is Nominee")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        PageControl();
                    end;
                }
                field("Is A WitNess"; Rec."Is A WitNess")
                {

                }
                field(Allocation; Rec.Allocation)
                {
                    Caption = 'Allocation [%]';
                    ApplicationArea = Basic, Suite;
                    Editable = AllocationEditable;
                }

                field("Special Instructions"; Rec."Special Instructions")
                {
                    Caption = 'Nominee Special Instructions';
                    Editable = AllocationEditable;
                }

                field(Removed; Rec.Removed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Assigned Guardian"; Rec."Assigned Guardian")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        PageControl;
    end;

    trigger OnOpenPage()
    begin
        PageControl;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        PageControl();
    end;

    //[Scope('OnPrem')]
    procedure PageControl()
    var
        MemberAppl: Record "Member Application";
        DependancyApp: Record "Dependancies Applications";
    begin
        if MemberAppl.Get(Rec."Record ID") then begin
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

        if DependancyApp.Get(Rec."Record ID") then begin
            case DependancyApp.Status of
                DependancyApp.Status::Pending, DependancyApp.Status::Approved, DependancyApp.Status::Rejected:
                    begin
                        CurrPage.Editable := false;
                    end;

                DependancyApp.Status::Open:
                    begin
                        CurrPage.Editable := true;
                    end;
            end;

            if DependancyApp."Source Application" = DependancyApp."Source Application"::"Member Portal" then begin
                CurrPage.Editable := false;
            end;
        end;

        if Rec."Identification Type" = Rec."Identification Type"::"System UID" then begin
            IdentificationEditable := false;
            IdentificationVisible := false;
        end else begin
            IdentificationEditable := true;
            IdentificationVisible := true;
        end;

        if Rec."Is Nominee" then
            AllocationEditable := true
        else
            AllocationEditable := false;
    end;

    var
        IdentificationEditable: Boolean;
        IdentificationVisible: Boolean;
        AllocationEditable: Boolean;
}

