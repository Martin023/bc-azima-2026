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
                        Rec.Validate("System Type");
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

                    trigger OnValidate()
                    begin
                        UpdateHeaderBusinessJustification();
                    end;
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

    local procedure UpdateHeaderBusinessJustification()
    var
        UserRequest: Record "User Creation Requests";
        AccessLine: Record "User Access Request Lines";
        CombinedJustification: Text[2048];
    begin
        if not UserRequest.Get(Rec."Request ID") then
            exit;

        // Build combined justification from all lines
        AccessLine.Reset();
        AccessLine.SetRange("Request ID", Rec."Request ID");

        if AccessLine.FindSet() then begin
            repeat

                if AccessLine."Business Justification" <> '' then begin

                    if CombinedJustification <> '' then
                        CombinedJustification += ' | ';

                    CombinedJustification +=
                        AccessLine."Business Justification";
                end;

            until AccessLine.Next() = 0;
        end;

        // Prevent unnecessary modify
        if UserRequest."Business Justification" <>
           CopyStr(CombinedJustification, 1,
           MaxStrLen(UserRequest."Business Justification"))
        then begin

            UserRequest."Business Justification" :=
                CopyStr(
                    CombinedJustification,
                    1,
                    MaxStrLen(UserRequest."Business Justification"));

            UserRequest.Modify();
        end;
    end;

    var
        SoDStyle: Text;
}