#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187057 pageextension52187057 extends "Item Warehouse FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Identifier Code")
        {
            ApplicationArea = Basic;
        }
        modify("Base Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Put-away Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Purch. Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Item Tracking Code")
        {
            ApplicationArea = Basic;
        }
        modify("Special Equipment Code")
        {
            ApplicationArea = Basic;
        }
        modify("Last Phys. Invt. Date")
        {
            ApplicationArea = Basic;
        }
        modify(NetWeight)
        {
            ApplicationArea = Basic;
        }
        modify("Warehouse Class Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Warehouse Class Code"(Control 17)".


            //Unsupported feature: Property Modification (Name) on ""Warehouse Class Code"(Control 17)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Identifier Code"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base Unit of Measure"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-away Unit of Measure Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purch. Unit of Measure"(Control 7)".


        //Unsupported feature: Code Modification on ""Item Tracking Code"(Control 9).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ItemTrackCode.SETFILTER(Code,"Item Tracking Code");

            PAGE.RUN(PAGE::"Item Tracking Code Card",ItemTrackCode);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ItemTrackCode.SETFILTER(Code,"Item Tracking Code");
            ItemTrackCodeCard.SETTABLEVIEW(ItemTrackCode);
            ItemTrackCodeCard.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Tracking Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Special Equipment Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Phys. Invt. Date"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NetWeight(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Class Code"(Control 17)".

    }

    var
        ItemTrackCodeCard: Page "Item Tracking Code Card";


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        NetWeight;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WhseClassCode;
        NetWeight;
        */
    //end;

    local procedure WhseClassCode(): Code[20]
    var
        //ProductGroup: Record "Product Group";
    begin
        // if ProductGroup.Get(Rec."Item Category Code",Rec."Product Group Code") then
        //   exit(ProductGroup."Warehouse Class Code");

        // exit('');
    end;
}
