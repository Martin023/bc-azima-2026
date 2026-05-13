namespace AZIMA.AZIMA;

page 52185429 "User Access Request Subpage"
{
    ApplicationArea = All;
    Caption = 'System Access & Roles';
    PageType = ListPart;
    SourceTable = "User Access Request Lines";

    AutoSplitKey = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("System Type"; Rec."System Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }

                field("System Name"; Rec."System Name")
                {
                    ApplicationArea = All;
                }

                field(Environment; Rec.Environment)
                {
                    ApplicationArea = All;
                }

                field("Access Type"; Rec."Access Type")
                {
                    ApplicationArea = All;
                }

                field("Permission Set"; Rec."Permission Set")
                {
                    ApplicationArea = All;
                }

                field("Department Role"; Rec."Department Role")
                {
                    ApplicationArea = All;
                }

                field("Business Justification"; Rec."Business Justification")
                {
                    ApplicationArea = All;
                }

                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                }

                field("SoD Conflict"; Rec."SoD Conflict")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = SoDStyle;
                }

                field("Requires ICT Approval"; Rec."Requires ICT Approval")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Requires Admin Approval"; Rec."Requires Admin Approval")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Provisioned; Rec.Provisioned)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Provisioned By"; Rec."Provisioned By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Provisioning Date"; Rec."Provisioning Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec."SoD Conflict" of
            true:
                SoDStyle := 'Unfavorable';
            false:
                SoDStyle := 'Favorable';
        end;
    end;

    var
        SoDStyle: Text;
}