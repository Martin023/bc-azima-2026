page 52186030 "Contracts list"
{
    CardPageID = "Contracts Details Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Contracts;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Description"; Rec."Contract Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor No"; Rec."Contractor No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contractor Name"; Rec."Contractor Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date of Request"; Rec."Date of Request")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Period"; Rec."Contract Period")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Contract Amount"; Rec."Contract Sum")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ApplicationArea = Basic, Suite;
                }
                
                field("Escalation For Leases"; Rec."Escalation For Leases")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Termination Clause"; Rec."Termination Clause")
                {
                }
                field("Renewal Clause"; Rec."Renewal Clause")
                {
                }
                field("Date of Execustion"; Rec."Date of Excecution")
                {
                }
                field("User Department"; Rec."User Department")
                {
                    Caption = 'User Department';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field("Captured By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
        }
        area(factboxes)
        {
            systempart(Control40; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control39; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control38; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Responsibility Centre");
            Rec.SetFilter("Current Department", UserSetup."Responsibility Centre");
        end else
            Error('You must be set up in user setup');
    end;
}

