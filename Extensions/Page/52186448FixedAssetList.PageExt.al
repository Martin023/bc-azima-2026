// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186448 pageextension52186448 extends "Fixed Asset List"
{
    Caption = 'Fixed Asset List';
    //CardPageId = "Fixed Asset Card";
    layout
    {
        addafter(Description)
        {
            field("Serial No."; SerialNumber)
            {
                ApplicationArea = Basic;
            }

        }
        addafter(Description)
        {
            field("Asset Tag"; Rec."Asset Tag")
            {
                ApplicationArea = Basic;
            }

        }
        addafter(Description)
        {
            field("Old Asset Tag"; Rec."Old Asset Tag")
            {
                ApplicationArea = Basic;
            }
        }
        addafter(Description)
        {
            field("Acquisition Type"; Rec."Acquisition Type")
            {
                ApplicationArea = Basic;
            }
            field(Disposed; Rec.Disposed)
            {
                ApplicationArea = Basic;
            }
            field("Disposal Date"; Rec."Disposal Date")
            {
                ApplicationArea = Basic;
            }

        }
        modify("Responsible Employee")
        {
            Visible = False;
        }
        addafter("Responsible Employee")
        {
            field("Employee Responsible"; Rec."Employee Responsible")
            {
                ApplicationArea = Basic;
                Caption = 'Responsible Employee';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        addafter(CalculateDepreciation)
        {
            action(CalculateDepreciationCust)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Calculate Depreciation Custom';
                Ellipsis = true;
                Image = CalculateDepreciation;
                ToolTip = 'Calculate depreciation according to conditions that you specify. If the related depreciation book is set up to integrate with the general ledger, then the calculated entries are transferred to the fixed asset general ledger journal. Otherwise, the calculated entries are transferred to the fixed asset journal. You can then review the entries and post the journal.';

                trigger OnAction()
                begin
                    REPORT.RunModal(REPORT::"Calculate Depreciation Custom", true, false, Rec);
                end;
            }
        }
        modify(CalculateDepreciation)
        {
            Visible = False;
        }
    }

}
