#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187056 pageextension52187056 extends "Resource Details FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfResourcePrices)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfResourceCosts)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 7)".


        //Unsupported feature: Code Modification on "NoOfResourcePrices(Control 2).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            RescPrice.SETRANGE(Type,RescPrice.Type::Resource);
            RescPrice.SETRANGE(Code,"No.");

            PAGE.RUN(PAGE::"Resource Prices",RescPrice);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            RescPrice.SETRANGE(Type,RescPrice.Type::Resource);
            RescPrice.SETRANGE(Code,"No.");
            RescPricesList.SETTABLEVIEW(RescPrice);
            RescPricesList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfResourcePrices(Control 2)".



        //Unsupported feature: Code Modification on "NoOfResourceCosts(Control 4).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            RescCost.SETRANGE(Type,RescCost.Type::Resource);
            RescCost.SETRANGE(Code,"No.");

            PAGE.RUN(PAGE::"Resource Costs",RescCost);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            RescCost.SETRANGE(Type,RescCost.Type::Resource);
            RescCost.SETRANGE(Code,"No.");
            RescCostsList.SETTABLEVIEW(RescCost);
            RescCostsList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfResourceCosts(Control 4)".

    }

    var
        RescPricesList: Page "Resource Prices";

    var
        RescCostsList: Page "Resource Costs";
}
