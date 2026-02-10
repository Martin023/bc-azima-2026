#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187190 pageextension52187190 extends "Custom Report Layouts"
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Code(Control 6)".


            //Unsupported feature: Property Modification (Name) on "Code(Control 6)".

        }
        modify("Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Report Name")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Company Name")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Last Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Last Modified by User")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 6)".


        //Unsupported feature: Property Deletion (Editable) on "Code(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report ID"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Company Name"(Control 5)".

        modify("Built-In")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Modified"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Modified by User"(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control11(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control12(Control 12)".

    }
    actions
    {
        modify(NewLayout)
        {
            ApplicationArea = Basic;
        }
        modify(CopyRec)
        {
            ApplicationArea = Basic;
        }
        modify(ExportWordXMLPart)
        {
            ApplicationArea = Basic;
        }
        modify(ImportLayout)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "ImportLayout(Action 16)".

        }
        modify(ExportLayout)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "ExportLayout(Action 19)".

        }
        // modify(EditLayout)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (PromotedCategory) on "EditLayout(Action 24)".

        //     Enabled = CanEdit;
        // }
        modify(UpdateWordLayout)
        {
            ApplicationArea = Basic;
        }
        modify(RunReport)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "RunReport(Action 21)".

        }

        //Unsupported feature: Code Modification on "NewLayout(Action 25).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CopyBuiltInLayout;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        InsertBuiltInLayout;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NewLayout(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "NewLayout(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyRec(Action 15)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CopyRec(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExportWordXMLPart(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ImportLayout(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExportLayout(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EditLayout(Action 24)".


        //Unsupported feature: Property Deletion (Visible) on "EditLayout(Action 24)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "EditLayout(Action 24)".



        //Unsupported feature: Code Modification on "UpdateWordLayout(Action 20).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CanBeModified THEN
          IF UpdateLayout(FALSE,FALSE) THEN
            MESSAGE(UpdateSuccesMsg,FORMAT(Type))
          ELSE
            MESSAGE(UpdateNotRequiredMsg,FORMAT(Type));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF UpdateLayout(FALSE,FALSE) THEN
          MESSAGE(UpdateSuccesMsg,FORMAT(Type))
        ELSE
          MESSAGE(UpdateNotRequiredMsg,FORMAT(Type));
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "UpdateWordLayout(Action 20)".


        //Unsupported feature: Property Deletion (Promoted) on "UpdateWordLayout(Action 20)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "UpdateWordLayout(Action 20)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "UpdateWordLayout(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RunReport(Action 21)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "RunReport(Action 21)".

    }


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.CAPTION := GetPageCaption;
    ReportLayoutSelection.SetTempLayoutSelected('');
    IsNotBuiltIn := NOT "Built-In";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.CAPTION := GetPageCaption;
    ReportLayoutSelection.SetTempLayoutSelected(0);
    */
    //end;


    //Unsupported feature: Code Modification on "OnClosePage".

    //trigger OnClosePage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ReportLayoutSelection.SetTempLayoutSelected('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ReportLayoutSelection.SetTempLayoutSelected(0);
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
