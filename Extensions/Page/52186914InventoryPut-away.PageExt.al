#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186914 pageextension52186914 extends "Inventory Put-away"
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
        // modify(Control13)
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
        modify("Expected Receipt Date")
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


        //Unsupported feature: Property Deletion (ToolTipML) on "Control13(Control 13)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Source No."(Control 11).OnLookup".

        //trigger (Variable: CreateInvtPutAway)()
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
        CODEUNIT.RUN(CODEUNIT::"Create Inventory Put-away",Rec);
        CurrPage.WhseActivityLines.PAGE.UpdateForm;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CreateInvtPutAway.RUN(Rec);
        CurrPage.WhseActivityLines.PAGE.UpdateForm;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination No."(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WMSMgt.GetDestinationName(""Destination Type"",""Destination No."")"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No.2"(Control 45)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WhseActivityLines(Control 97)".


        //Unsupported feature: Property Deletion (PartType) on "WhseActivityLines(Control 97)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control7(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
       
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Put-aways")
        {
            ApplicationArea = Basic;
        }
        modify("Source Document")
        {
            ApplicationArea = Basic;
        }
        modify(GetSourceDocument)
        {

            //Unsupported feature: Property Modification (Name) on "GetSourceDocument(Action 4)".

            ApplicationArea = Basic;
        }
        modify("Autofill Qty. to Handle")
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

            //Unsupported feature: Property Modification (PromotedCategory) on ""P&ost"(Action 18)".

        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Post and &Print"(Action 41)".

        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 6)".

        }
        modify("Put-away List")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "List(Action 101)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Put-aways"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document"(Action 40)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""&Get Source Document"(Action 4).OnAction".

        //trigger (Variable: CreateInvtPutAway)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "GetSourceDocument(Action 4).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Create Inventory Put-away",Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CreateInvtPutAway.RUN(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "GetSourceDocument(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Autofill Qty. to Handle"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delete Qty. to Handle"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-away List"(Action 1903358206)".

    }

    var
    //CreateInvtPutAway: Codeunit "Create Inventory Put-away";

    var
        CreateInvtPutAway: Codeunit "Create Inventory Put-away";

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
