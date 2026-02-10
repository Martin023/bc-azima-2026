#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186536 pageextension52186536 extends "Transfer Route Specification" 
{
    layout
    {
        modify("In-Transit Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Service Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""In-Transit Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Service Code"(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }

    //Unsupported feature: Code Modification on "OnClosePage".

    //trigger OnClosePage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CanBeDeleted := TRUE;
        OnBeforeClosePage(Rec,CanBeDeleted);
        IF CanBeDeleted THEN
          IF GET("Transfer-from Code","Transfer-to Code") THEN
            IF ("Shipping Agent Code" = '') AND
               ("Shipping Agent Service Code" = '') AND
               ("In-Transit Code" = '')
            THEN
              DELETE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF GET("Transfer-from Code","Transfer-to Code") THEN BEGIN
          IF ("Shipping Agent Code" = '') AND
             ("Shipping Agent Service Code" = '') AND
             ("In-Transit Code" = '')
          THEN
            DELETE;
        END;
        */
    //end;
}
