#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186651 pageextension52186651 extends "Standard Serv. Item Gr. Codes" 
{
    layout
    {
        modify(CurrServItemGroupCodeCtrl)
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrServItemGroupCodeCtrl(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 12)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetServItemGroupCode(PROCEDURE 2)".

    local procedure CheckServItemGroupCode(CodeToCheck: Code[10]): Boolean
    begin
        //exit(ServiceItemGroup.Get(CodeToCheck));
    end;

    local procedure EnableChangeServItemGroupCode()
    begin
       // CurrServItemGroupCodeCtrlEdita := true;
    end;

    local procedure DisableChangeServItemGroupCode()
    begin
       // CurrServItemGroupCodeCtrlEdita := false;
    end;
}
