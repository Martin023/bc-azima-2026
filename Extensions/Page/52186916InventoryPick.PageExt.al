#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186916 pageextension52186916 extends "Inventory Pick" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        // modify(Control15)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Source No.")
        {
            ApplicationArea = Basic;
        }
        modify("Destination No.")
        {
            ApplicationArea = Basic;
        }
        modify("WMSMgt.GetDestinationName(""Destination Type"",""Destination No."")")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.2")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control15(Control 15)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Source No."(Control 11).OnLookup".

        //trigger (Variable: CreateInvtPick)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Source No."(Control 11).OnLookup".

        //trigger "(Control 11)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CODEUNIT.RUN(CODEUNIT::"Create Inventory Pick/Movement",Rec);
            CurrPage.UPDATE;
            CurrPage.WhseActivityLines.PAGE.UpdateForm;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CreateInvtPick.RUN(Rec);
            CurrPage.UPDATE;
            CurrPage.WhseActivityLines.PAGE.UpdateForm;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination No."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WMSMgt.GetDestinationName(""Destination Type"",""Destination No."")"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No.2"(Control 21)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WhseActivityLines(Control 97)".


        //Unsupported feature: Property Deletion (PartType) on "WhseActivityLines(Control 97)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control4(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
       
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Picks")
        {
            ApplicationArea = Basic;
        }
        modify("Source Document")
        {
            ApplicationArea = Basic;
        }
        modify("&Get Source Document")
        {
            ApplicationArea = Basic;
        }
        modify(AutofillQtyToHandle)
        {
            ApplicationArea = Basic;
        }
        modify("Delete Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("P&ost")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""P&ost"(Action 28)".

        }
        modify(PostAndPrint)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PostAndPrint(Action 41)".

        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 6)".

        }
        modify("Picking List")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Picks"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document"(Action 40)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""&Get Source Document"(Action 13).OnAction".

        //trigger (Variable: CreateInvtPick)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""&Get Source Document"(Action 13).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CODEUNIT.RUN(CODEUNIT::"Create Inventory Pick/Movement",Rec);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CreateInvtPick.RUN(Rec);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Get Source Document"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AutofillQtyToHandle(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Qty. to Handle"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndPrint(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Picking List"(Action 1905733806)".

    }

    var
        //CreateInvtPick: Codeunit "Create Inventory Pick/Movement";

    var
        CreateInvtPick: Codeunit "Create Inventory Pick/Movement";

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
