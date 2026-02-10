#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186444 pageextension52186444 extends "Make Supply Orders"
{
    layout
    {
        modify("Make Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Create Purchase Order")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Req. Wksh. Template")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Wksh. Name")
        {
            ApplicationArea = Basic;
            Enabled = "Purchase Wksh. NameEnable";
        }
        modify("Create Production Order")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Req. Wksh. Template")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Wksh. Name")
        {
            ApplicationArea = Basic;
            Enabled = "Prod. Wksh. NameEnable";
        }
        modify("Create Transfer Order")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Req. Wksh. Template")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Wksh. Name")
        {
            ApplicationArea = Basic;
            Enabled = "Transfer Wksh. NameEnable";
        }
        modify("Create Assembly Order")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Make Orders"(Control 27)".


        //Unsupported feature: Code Modification on ""Create Purchase Order"(Control 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PurchaseReqWkshTemplateEnable :=
          "Create Purchase Order" = "Create Purchase Order"::"Copy to Req. Wksh";
        PurchaseWkshNameEnable :=
          "Create Purchase Order" = "Create Purchase Order"::"Copy to Req. Wksh";
        CreatePurchaseOrderOnAfterVali;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PurchaseReqWkshTemplateEnable :=
          "Create Purchase Order" = "Create Purchase Order"::"Copy to Req. Wksh";
        "Purchase Wksh. NameEnable" :=
          "Create Purchase Order" = "Create Purchase Order"::"Copy to Req. Wksh";
        CreatePurchaseOrderOnAfterVali;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Purchase Order"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Req. Wksh. Template"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Wksh. Name"(Control 11)".



        //Unsupported feature: Code Modification on ""Create Production Order"(Control 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ProdReqWkshTemplateEnable :=
          "Create Production Order" = "Create Production Order"::"Copy to Req. Wksh";
        ProdWkshNameEnable :=
          "Create Production Order" = "Create Production Order"::"Copy to Req. Wksh";
        CreateProductionOrderOnAfterVa;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ProdReqWkshTemplateEnable :=
          "Create Production Order" = "Create Production Order"::"Copy to Req. Wksh";
        "Prod. Wksh. NameEnable" :=
          "Create Production Order" = "Create Production Order"::"Copy to Req. Wksh";
        CreateProductionOrderOnAfterVa;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Production Order"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Req. Wksh. Template"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Wksh. Name"(Control 15)".



        //Unsupported feature: Code Modification on ""Create Transfer Order"(Control 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TransferReqWkshTemplateEnable :=
          "Create Transfer Order" = "Create Transfer Order"::"Copy to Req. Wksh";
        TransferWkshNameEnable :=
          "Create Transfer Order" = "Create Transfer Order"::"Copy to Req. Wksh";
        CreateTransferOrderOnAfterVali;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TransferReqWkshTemplateEnable :=
          "Create Transfer Order" = "Create Transfer Order"::"Copy to Req. Wksh";
        "Transfer Wksh. NameEnable" :=
          "Create Transfer Order" = "Create Transfer Order"::"Copy to Req. Wksh";
        CreateTransferOrderOnAfterVali;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Transfer Order"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Req. Wksh. Template"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Wksh. Name"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Assembly Order"(Control 2)".

    }

    var

        "Purchase Wksh. NameEnable": Boolean;

    var

        "Prod. Wksh. NameEnable": Boolean;

    var

        "Transfer Wksh. NameEnable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchaseReqWkshTemplateEnable :=
      "Create Purchase Order" = "Create Purchase Order"::"Copy to Req. Wksh";
    PurchaseWkshNameEnable :=
      "Create Purchase Order" = "Create Purchase Order"::"Copy to Req. Wksh";

    ProdReqWkshTemplateEnable :=
      "Create Production Order" = "Create Production Order"::"Copy to Req. Wksh";
    ProdWkshNameEnable :=
      "Create Production Order" = "Create Production Order"::"Copy to Req. Wksh";

    TransferReqWkshTemplateEnable :=
      "Create Transfer Order" = "Create Transfer Order"::"Copy to Req. Wksh";
    TransferWkshNameEnable :=
      "Create Transfer Order" = "Create Transfer Order"::"Copy to Req. Wksh";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PurchaseReqWkshTemplateEnable :=
      "Create Purchase Order" = "Create Purchase Order"::"Copy to Req. Wksh";
    "Purchase Wksh. NameEnable" :=
    #4..7
    "Prod. Wksh. NameEnable" :=
    #9..12
    "Transfer Wksh. NameEnable" :=
      "Create Transfer Order" = "Create Transfer Order"::"Copy to Req. Wksh";
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TransferWkshNameEnable := TRUE;
    TransferReqWkshTemplateEnable := TRUE;
    ProdWkshNameEnable := TRUE;
    ProdReqWkshTemplateEnable := TRUE;
    PurchaseWkshNameEnable := TRUE;
    PurchaseReqWkshTemplateEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Transfer Wksh. NameEnable" := TRUE;
    TransferReqWkshTemplateEnable := TRUE;
    "Prod. Wksh. NameEnable" := TRUE;
    ProdReqWkshTemplateEnable := TRUE;
    "Purchase Wksh. NameEnable" := TRUE;
    PurchaseReqWkshTemplateEnable := TRUE;
    */
    //end;
}
