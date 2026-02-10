page 52186210 "Computer Asset Register"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Computer Asset Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staff No"; Rec."Staff No")
                {
                    Caption = 'Allocated User No';
                    ApplicationArea = Basic, Suite;
                }
                field("Allocated User"; Rec."Allocated User")
                {
                    Caption = 'Allocated User Name';
                    ApplicationArea = Basic, Suite;
                }
                field("System Software"; Rec."System Software")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Applications; Rec.Applications)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Processor Type"; Rec."Processor Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Memory Size"; Rec."Memory Size")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Asset Serial No"; Rec."Asset Serial No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Year of Purchase"; Rec."Year of Purchase")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Year of Service Left"; Rec."Year of Service Left")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Disposed; Rec.Disposed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Disposed"; Rec."Date Disposed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Dispose)
            {
                ApplicationArea = Basic, Suite;
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to dispose this Asset', true) = false then exit;
                    Rec.Disposed := true;
                    Rec."Date Disposed" := Today;
                end;
            }
        }
    }
}

