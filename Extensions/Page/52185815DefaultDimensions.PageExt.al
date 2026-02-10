#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185815 pageextension52185815 extends "Default Dimensions"
{
    layout
    {
        modify("Dimension Code")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension Value Code")
        {
            ApplicationArea = Basic;
        }
        modify("Value Posting")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Value Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Value Posting"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    //Unsupported feature: Code Insertion on "OnOpenPage".

    //trigger OnOpenPage()
    //begin
    /*
    FnRestrictAccess();
    */
    //end;

    procedure FnRestrictAccess()
    var
        StatusPermission: Record 52185687;
        ErrorOnRestrictViewTxt: label 'You do not have permissions to EDIT this Page. Contact your system administrator for further details';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("Edit  G/L Account", true);
        StatusPermission.SetRange("View G/L Account", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end;
    end;
}
