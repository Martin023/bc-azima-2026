page 52185646 "HR Training Need Request Card"
{
    PageType = Card;
    SourceTable = "HR Training Need Request";
    Caption = 'Training Need Request Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Training Category"; Rec."Training Category")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Training Type"; Rec."Training Type")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = Basic;
                }
                field("No. of Employees"; Rec."No. of Employees")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Justification; Rec.Justification)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    MultiLine = true;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Proposed Dates & Cost")
            {
                Caption = 'Proposed Dates & Cost';
                field("Proposed Start Date"; Rec."Proposed Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Proposed End Date"; Rec."Proposed End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Provider & Location")
            {
                Caption = 'Preferred Provider & Location';
                field("Preferred Provider"; Rec."Preferred Provider")
                {
                    ApplicationArea = Basic;
                }
                field("Preferred Location"; Rec."Preferred Location")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Request Information")
            {
                Caption = 'Request Information';
                field("Requested By Employee No."; Rec."Requested By Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By Name"; Rec."Requested By Name")
                {
                    ApplicationArea = Basic;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = Basic;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Official Training Need No."; Rec."Official Training Need No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1; Outlook)
            {
                ApplicationArea = Basic;
            }
            systempart(Control2; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Official Training Need")
            {
                ApplicationArea = Basic;
                Caption = 'View Official Training Need';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."Official Training Need No." <> '';

                trigger OnAction()
                var
                    HRTrainingNeeds: Record "HR Training Needs";
                begin
                    if Rec."Official Training Need No." <> '' then begin
                        HRTrainingNeeds.Reset;
                        if HRTrainingNeeds.Get(Rec."Official Training Need No.") then begin
                            PAGE.Run(PAGE::"HR Training Needs Card", HRTrainingNeeds);
                        end;
                    end;
                end;
            }
        }
    }
}
