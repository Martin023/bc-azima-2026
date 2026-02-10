#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186595 pageextension52186595 extends "Posted Purchase Document Lines"
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
        modify(PostedReceiptsBtn)
        {
            ApplicationArea = Basic;
        }
        modify("STRSUBSTNO('(%1)',""No. of Pstd. Receipts"")")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfPostedInvoices)
        {

            //Unsupported feature: Property Modification (Name) on "NoOfPostedInvoices(Control 14)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "NoOfPostedInvoices(Control 14)".

        }
        modify("STRSUBSTNO('(%1)',""No. of Pstd. Return Shipments"")")
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
            CurrPage.PostedRcpts.PAGE.Initialize(
              ShowRevLinesOnly,
              CopyDocMgt.IsPurchFillExactCostRevLink(
                ToPurchHeader,CurrentMenuType,ToPurchHeader."Currency Code"),TRUE);
          1:
            CurrPage.PostedInvoices.PAGE.Initialize(
              ToPurchHeader,ShowRevLinesOnly,
              CopyDocMgt.IsPurchFillExactCostRevLink(
                ToPurchHeader,CurrentMenuType,ToPurchHeader."Currency Code"),TRUE);
        END;
        CurrPage.UPDATE(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        #9..11
        #7..12
        ShowRevLinesOnlyOnAfterValidat;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowRevLine(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OriginalQuantity(Control 2)".



        //Unsupported feature: Code Modification on "PostedReceiptsBtn(Control 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x3 THEN
          ChangeSubMenu(3);
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x2 THEN
          ChangeSubMenu(2);
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x1 THEN
          ChangeSubMenu(1);
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x0 THEN
          ChangeSubMenu(0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x3 THEN
          x3CurrentMenuTypeOptOnValidate;
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x2 THEN
          x2CurrentMenuTypeOptOnValidate;
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x1 THEN
          x1CurrentMenuTypeOptOnValidate;
        IF CurrentMenuTypeOpt = CurrentMenuTypeOpt::x0 THEN
          x0CurrentMenuTypeOptOnValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('(%1)',""No. of Pstd. Receipts"")"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfPostedInvoices(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""STRSUBSTNO('(%1)',""No. of Pstd. Return Shipments"")"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfPostedCrMemos(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedInvoices(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedRcpts(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedCrMemos(Control 1)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PostedReturnShpts(Control 5)".

    }


    //Unsupported feature: Code Modification on "CopyLineToDoc(PROCEDURE 5)".

    //procedure CopyLineToDoc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeCopyLineToDoc(CopyDocMgt);
    ToPurchHeader.TESTFIELD(Status,ToPurchHeader.Status::Open);
    LinesNotCopied := 0;
    CASE CurrentMenuType OF
      0:
        BEGIN
          CurrPage.PostedRcpts.PAGE.GetSelectedLine(FromPurchRcptLine);
          CopyDocMgt.SetProperties(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
          CopyDocMgt.CopyPurchaseLinesToDoc(
            PurchDocType::"Posted Receipt",ToPurchHeader,
            FromPurchRcptLine,FromPurchInvLine,FromReturnShptLine,FromPurchCrMemoLine,LinesNotCopied,MissingExCostRevLink);
        END;
      1:
        BEGIN
          CurrPage.PostedInvoices.PAGE.GetSelectedLine(FromPurchInvLine);
          CopyDocMgt.SetProperties(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
          CopyDocMgt.CopyPurchaseLinesToDoc(
            PurchDocType::"Posted Invoice",ToPurchHeader,
            FromPurchRcptLine,FromPurchInvLine,FromReturnShptLine,FromPurchCrMemoLine,LinesNotCopied,MissingExCostRevLink);
        END;
      2:
        BEGIN
          CurrPage.PostedReturnShpts.PAGE.GetSelectedLine(FromReturnShptLine);
          CopyDocMgt.SetProperties(FALSE,TRUE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
          CopyDocMgt.CopyPurchaseLinesToDoc(
            PurchDocType::"Posted Return Shipment",ToPurchHeader,
            FromPurchRcptLine,FromPurchInvLine,FromReturnShptLine,FromPurchCrMemoLine,LinesNotCopied,MissingExCostRevLink);
        END;
      3:
        BEGIN
          CurrPage.PostedCrMemos.PAGE.GetSelectedLine(FromPurchCrMemoLine);
          CopyDocMgt.SetProperties(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,OriginalQuantity);
          CopyDocMgt.CopyPurchaseLinesToDoc(
            PurchDocType::"Posted Credit Memo",ToPurchHeader,
            FromPurchRcptLine,FromPurchInvLine,FromReturnShptLine,FromPurchCrMemoLine,LinesNotCopied,MissingExCostRevLink);
        END;
    END;
    CopyDocMgt.ShowMessageReapply(OriginalQuantity);
    CLEAR(CopyDocMgt);

    IF LinesNotCopied <> 0 THEN
      MESSAGE(Text000);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..8
          CopyDocMgt.CopyPurchRcptLinesToDoc(
            ToPurchHeader,FromPurchRcptLine,LinesNotCopied,MissingExCostRevLink);
    #12..16
          CopyDocMgt.CopyPurchInvLinesToDoc(
            ToPurchHeader,FromPurchInvLine,LinesNotCopied,MissingExCostRevLink);
    #20..24
          CopyDocMgt.CopyPurchReturnShptLinesToDoc(
            ToPurchHeader,FromReturnShptLine,LinesNotCopied,MissingExCostRevLink);
    #28..32
          CopyDocMgt.CopyPurchCrMemoLinesToDoc(
            ToPurchHeader,FromPurchCrMemoLine,LinesNotCopied,MissingExCostRevLink);
    #36..42
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
        CopyDocMgt.IsPurchFillExactCostRevLink(ToPurchHeader,MenuType,ToPurchHeader."Currency Code");
    ShowRevLineEnable := MenuType IN [0,1];
    CASE MenuType OF
      0:
        BEGIN
          PostedRcptsVisible := Visible;
          CurrPage.PostedRcpts.PAGE.Initialize(
            ShowRevLinesOnly,
            CopyDocMgt.IsPurchFillExactCostRevLink(
              ToPurchHeader,MenuType,ToPurchHeader."Currency Code"),Visible);
        END;
      1:
        BEGIN
          PostedInvoicesVisible := Visible;
          CurrPage.PostedInvoices.PAGE.Initialize(
            ToPurchHeader,ShowRevLinesOnly,
            CopyDocMgt.IsPurchFillExactCostRevLink(
              ToPurchHeader,MenuType,ToPurchHeader."Currency Code"),Visible);
        END;
      2:
        PostedReturnShptsVisible := Visible;
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

    //Unsupported feature: Property Deletion (Attributes) on "SetToPurchHeader(PROCEDURE 4)".


    local procedure ShowRevLinesOnlyOnAfterValidat()
    begin
        CurrPage.Update(true);
    end;

    local procedure x0CurrentMenuTypeOptOnPush()
    begin
        //  ChangeSubMenu(0);
    end;

    local procedure x0CurrentMenuTypeOptOnValidate()
    begin
        x0CurrentMenuTypeOptOnPush;
    end;

    local procedure x1CurrentMenuTypeOptOnPush()
    begin
        // ChangeSubMenu(1);
    end;

    local procedure x1CurrentMenuTypeOptOnValidate()
    begin
        x1CurrentMenuTypeOptOnPush;
    end;

    local procedure x2CurrentMenuTypeOptOnPush()
    begin
        // ChangeSubMenu(2);
    end;

    local procedure x2CurrentMenuTypeOptOnValidate()
    begin
        x2CurrentMenuTypeOptOnPush;
    end;

    local procedure x3CurrentMenuTypeOptOnPush()
    begin
        // ChangeSubMenu(3);
    end;

    local procedure x3CurrentMenuTypeOptOnValidate()
    begin
        x3CurrentMenuTypeOptOnPush;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "CopyLineToDoc(PROCEDURE 5).PurchDocType(Variable 1000)".

}
