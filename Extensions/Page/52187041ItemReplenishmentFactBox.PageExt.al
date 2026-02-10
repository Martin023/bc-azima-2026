#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187041 pageextension52187041 extends "Item Replenishment FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Replenishment System")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Manufacturing Policy")
        {
            ApplicationArea = Basic;
        }
        modify("Routing No.")
        {
            ApplicationArea = Basic;
        }
        modify("Production BOM No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Replenishment System"(Control 1)".


        //Unsupported feature: Code Modification on ""Vendor No."(Control 5).OnDrillDown".

        //trigger "(Control 5)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Vendor.SETFILTER("No.","Vendor No.");

            PAGE.RUN(PAGE::"Vendor Card",Vendor);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            Vendor.SETFILTER("No.","Vendor No.");
            VendorCard.SETTABLEVIEW(Vendor);
            VendorCard.RUN
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Item No."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Manufacturing Policy"(Control 11)".



        //Unsupported feature: Code Modification on ""Routing No."(Control 13).OnDrillDown".

        //trigger "(Control 13)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            RoutingHeader.SETFILTER("No.","Routing No.");

            PAGE.RUN(PAGE::Routing,RoutingHeader);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            RoutingHeader.SETFILTER("No.","Routing No.");
            RoutingCard.SETTABLEVIEW(RoutingHeader);
            RoutingCard.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Routing No."(Control 13)".



        //Unsupported feature: Code Modification on ""Production BOM No."(Control 15).OnDrillDown".

        //trigger "(Control 15)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ProdBomHeader.SETFILTER("No.","Production BOM No.");

            PAGE.RUN(PAGE::"Production BOM",ProdBomHeader);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ProdBomHeader.SETFILTER("No.","Production BOM No.");
            ProdBomCard.SETTABLEVIEW(ProdBomHeader);
            ProdBomCard.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Production BOM No."(Control 15)".

    }

    var
        VendorCard: Page "Vendor Card";

    var
        RoutingCard: Page Routing;

    var
        ProdBomCard: Page "Production BOM";
}
