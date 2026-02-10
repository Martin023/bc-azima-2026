#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186590 pageextension52186590 extends "Posted Sales Document Lines" 
{
    layout
    {
        modify(ShowRevLine)
        {
            ApplicationArea = Basic;
        }
        modify(OriginalQuantity)
        {
            ApplicationArea = Basic;
        }
        modify(PostedShipmentsBtn)
        {
            ApplicationArea = Basic;
        }
        modify("STRSUBSTNO('(%1)',""No. of Pstd. Shipments"")")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfPostedInvoices)
        {

            //Unsupported feature: Property Modification (Name) on "NoOfPostedInvoices(Control 14)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "NoOfPostedInvoices(Control 14)".

        }
        modify("STRSUBSTNO('(%1)',""No. of Pstd. Return Receipts"")")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfPostedCrMemos)
        {

            //Unsupported feature: Property Modification (Name) on "NoOfPostedCrMemos(Control 11)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "NoOfPostedCrMemos(Control 11)".

        }
        modify(CurrentMenuTypeValue)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ShowRevLine(Control 63).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CASE CurrentMenuType OF
              0:
                CurrPage.PostedShpts.PAGE.Initialize(
                  ShowRevLinesOnly,
                  CopyDocMgt.IsSalesFillExactCostRevLink(
                    ToSalesHeader,CurrentMenuType,ToSalesHeader."Currency Code"),TRUE);
              1:
                CurrPage.PostedInvoices.PAGE.Initialize(
                  ToSalesHeader,ShowRevLinesOnly,
                  CopyDocMgt.IsSalesFillExactCostRevLink(
                    ToSalesHeader,CurrentMenuType,ToSalesHeader."Currency Code"),TRUE);
            END;
            ShowRevLinesOnlyOnAfterValidat;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            #9..11
            #7..13
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowRevLine(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OriginalQuantity(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('(%1)',""No. of Pstd. Shipments"")"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfPostedInvoices(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('(%1)',""No. of Pstd. Return Receipts"")"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfPostedCrMemos(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedInvoices(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedShpts(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedCrMemos(Control 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedReturnRcpts(Control 5)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "CopyLineToDoc(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "CopyLineToDoc(PROCEDURE 5)".

    //procedure CopyLineToDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeCopyLineToDoc(CopyDocMgt);

        ToSalesHeader.TESTFIELD(Status,ToSalesHeader.Status::Open);
        LinesNotCopied := 0;

        CASE CurrentMenuType OF
          0:
            BEGIN
              CurrPage.PostedShpts.PAGE.GetSelectedLine(FromSalesShptLine);
              CopyDocMgt.SetProperties(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
              CopyDocMgt.CopySalesLinesToDoc(
                SalesDocType::"Posted Shipment",ToSalesHeader,
                FromSalesShptLine,FromSalesInvLine,FromReturnRcptLine,FromSalesCrMemoLine,LinesNotCopied,MissingExCostRevLink);
            END;
          1:
            BEGIN
              CurrPage.PostedInvoices.PAGE.GetSelectedLine(FromSalesInvLine);
              CopyDocMgt.SetProperties(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
              CopyDocMgt.CopySalesLinesToDoc(
                SalesDocType::"Posted Invoice",ToSalesHeader,
                FromSalesShptLine,FromSalesInvLine,FromReturnRcptLine,FromSalesCrMemoLine,LinesNotCopied,MissingExCostRevLink);
            END;
          2:
            BEGIN
              CurrPage.PostedReturnRcpts.PAGE.GetSelectedLine(FromReturnRcptLine);
              CopyDocMgt.SetProperties(FALSE,TRUE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
              CopyDocMgt.CopySalesLinesToDoc(
                SalesDocType::"Posted Return Receipt",ToSalesHeader,
                FromSalesShptLine,FromSalesInvLine,FromReturnRcptLine,FromSalesCrMemoLine,LinesNotCopied,MissingExCostRevLink);
            END;
          3:
            BEGIN
              CurrPage.PostedCrMemos.PAGE.GetSelectedLine(FromSalesCrMemoLine);
              CopyDocMgt.SetProperties(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
              CopyDocMgt.CopySalesLinesToDoc(
                SalesDocType::"Posted Credit Memo",ToSalesHeader,
                FromSalesShptLine,FromSalesInvLine,FromReturnRcptLine,FromSalesCrMemoLine,LinesNotCopied,MissingExCostRevLink);
            END;
        END;
        CLEAR(CopyDocMgt);

        IF LinesNotCopied <> 0 THEN
          MESSAGE(Text000);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ToSalesHeader.TESTFIELD(Status,ToSalesHeader.Status::Open);
        LinesNotCopied := 0;
        #6..10
              CopyDocMgt.CopySalesShptLinesToDoc(
                ToSalesHeader,FromSalesShptLine,LinesNotCopied,MissingExCostRevLink);
        #14..18
              CopyDocMgt.CopySalesInvLinesToDoc(
                ToSalesHeader,FromSalesInvLine,LinesNotCopied,MissingExCostRevLink);
        #22..26
              CopyDocMgt.CopySalesReturnRcptLinesToDoc(
                ToSalesHeader,FromReturnRcptLine,LinesNotCopied,MissingExCostRevLink);
        #30..34
              CopyDocMgt.CopySalesCrMemoLinesToDoc(
                ToSalesHeader,FromSalesCrMemoLine,LinesNotCopied,MissingExCostRevLink);
        #38..43
        */
    //end;


    //Unsupported feature: Code Modification on "SetSubMenu(PROCEDURE 2)".

    //procedure SetSubMenu();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ShowRevLinesOnly AND (MenuType IN [0,1]) THEN
          ShowRevLinesOnly :=
            CopyDocMgt.IsSalesFillExactCostRevLink(ToSalesHeader,MenuType,ToSalesHeader."Currency Code");
        ShowRevLineEnable := MenuType IN [0,1];
        CASE MenuType OF
          0:
            BEGIN
              PostedShptsVisible := Visible;
              CurrPage.PostedShpts.PAGE.Initialize(
                ShowRevLinesOnly,
                CopyDocMgt.IsSalesFillExactCostRevLink(
                  ToSalesHeader,MenuType,ToSalesHeader."Currency Code"),Visible);
            END;
          1:
            BEGIN
              PostedInvoicesVisible := Visible;
              CurrPage.PostedInvoices.PAGE.Initialize(
                ToSalesHeader,ShowRevLinesOnly,
                CopyDocMgt.IsSalesFillExactCostRevLink(
                  ToSalesHeader,MenuType,ToSalesHeader."Currency Code"),Visible);
            END;
          2:
            PostedReturnRcptsVisible := Visible;
          3:
            PostedCrMemosVisible := Visible;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        #18..21
        #14..26
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetToSalesHeader(PROCEDURE 4)".


    //Unsupported feature: Deletion (VariableCollection) on "CopyLineToDoc(PROCEDURE 5).SalesDocType(Variable 1000)".

}
