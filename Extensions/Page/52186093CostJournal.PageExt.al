#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186093 pageextension52186093 extends "Cost Journal" 
{
    Caption = 'Cost Journal';
    layout
    {
        modify(CostJnlBatchName)
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Type No.")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Center Code")
        {
            ApplicationArea = Basic;
        }
        modify("Cost Object Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Debit Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Cost Type No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Cost Center Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Cost Object Code")
        {
            ApplicationArea = Basic;
        }
        modify(LineBalance)
        {
            ApplicationArea = Basic;
        }
        modify("G/L Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify(CostTypeName)
        {
            ApplicationArea = Basic;
        }
        modify(BalCostTypeName)
        {
            ApplicationArea = Basic;
        }
        modify(Balance)
        {
            ApplicationArea = Basic;
        }
        modify(TotalBalance)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CostJnlBatchName(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Type No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Center Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost Object Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Amount"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Amount"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Cost Type No."(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Cost Center Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bal. Cost Object Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineBalance(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Entry No."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Code"(Control 20)".


        //Unsupported feature: Property Deletion (ShowCaption) on "CostTypeName(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalCostTypeName(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Balance(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalBalance(Control 30)".

    }
    actions
    {
        modify(Post)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 3)".

        }
        modify(TestReport)
        {
            ApplicationArea = Basic;
        }
        modify(PostandPrint)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "PostandPrint(Action 33)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestReport(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostandPrint(Action 33)".

        modify("Page")
        {
            Visible = false;
        }
        modify(EditInExcel)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Modification (Length) on "CostTypeName(Variable 1006)".

    //var
        //>>>> ORIGINAL VALUE:
        //CostTypeName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CostTypeName : 50;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "BalCostTypeName(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //BalCostTypeName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //BalCostTypeName : 50;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsSaasExcelAddinEnabled := ServerConfigSettingHandler.GetIsSaasExcelAddinEnabled;
        IF ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::ODataV4 THEN
          EXIT;

        IF IsOpenedFromBatch THEN BEGIN
          CostJnlBatchName := "Journal Batch Name";
          CostJnlMgt.OpenJnl(CostJnlBatchName,Rec);
        #8..10
        IF NOT JnlSelected THEN
          ERROR('');
        CostJnlMgt.OpenJnl(CostJnlBatchName,Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #5..13
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
