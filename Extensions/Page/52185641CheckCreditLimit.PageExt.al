#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185641 pageextension52185641 extends "Check Credit Limit" 
{
    Editable = false;
    layout
    {
        modify(Control2)
        {
            ApplicationArea = Basic;
        }
        modify(HideMessage)
        {
            Visible = false;
        }
        modify(CreditLimitDetails)
        {
            Visible = false;
        }
        addafter(Control2)
        {
            group(Details)
            {
                Caption = 'Details';
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)";Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                // field(OrderAmountTotalLCY;OrderAmountTotalLCY)
                // {
                //     ApplicationArea = Basic;
                //     AutoFormatType = 1;
                //     Caption = 'Outstanding Amt. (LCY)';
                // }
                // field(ShippedRetRcdNotIndLCY;ShippedRetRcdNotIndLCY)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Shipped/Ret. Rcd. Not Invd. (LCY)';
                // }
                // field(OrderAmountThisOrderLCY;OrderAmountThisOrderLCY)
                // {
                //     ApplicationArea = Basic;
                //     AutoFormatType = 1;
                //     Caption = 'Current Amount (LCY)';
                // }
                // field(CustCreditAmountLCY;CustCreditAmountLCY)
                // {
                //     ApplicationArea = Basic;
                //     AutoFormatType = 1;
                //     Caption = 'Total Amount (LCY)';
                // }
                field("Credit Limit (LCY)";Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Due (LCY)";Rec."Balance Due (LCY)")
                {
                    ApplicationArea = Basic;
                    CaptionClass = FORMAT(STRSUBSTNO(Text001,FORMAT(Rec.GETRANGEMAX(Rec."Date Filter"))));
                }
                field(GetInvoicedPrepmtAmountLCY;Rec.GetInvoicedPrepmtAmountLCY)
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoiced Prepayment Amount (LCY)';
                }
            }
        }
    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 26)".

    }

    var
        Text001: label 'Overdue Amounts (LCY) as of %1';
        Text002: label 'The customer''s credit limit has been exceeded.';
        Text003: label 'This customer has an overdue balance.';

    var
        Text004: label 'This customer has an overdue balance and the customer''s credit limit has been exceeded.';


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CalcCreditLimitLCY;
        CalcOverdueBalanceLCY;

        SetParametersOnDetails;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CalcCreditLimitLCY;
        CalcOverdueBalanceLCY;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "GenJnlLineShowWarning(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SalesHeaderShowWarning(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SalesHeaderShowWarning(PROCEDURE 3)".

    //procedure SalesHeaderShowWarning();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        // Used when additional lines are inserted
        SalesSetup.GET;
        IF SalesSetup."Credit Warnings" =
           SalesSetup."Credit Warnings"::"No Warning"
        THEN
          EXIT(FALSE);
        IF SalesHeader."Currency Code" = '' THEN
          NewOrderAmountLCY := SalesHeader."Amount Including VAT"
        ELSE
          NewOrderAmountLCY :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                WORKDATE,SalesHeader."Currency Code",
                SalesHeader."Amount Including VAT",SalesHeader."Currency Factor"));

        IF NOT (SalesHeader."Document Type" IN
                [SalesHeader."Document Type"::Quote,
                 SalesHeader."Document Type"::Order,
                 SalesHeader."Document Type"::"Return Order"])
        THEN
          NewOrderAmountLCY := NewOrderAmountLCY + SalesLineAmount(SalesHeader."Document Type",SalesHeader."No.");
        OldSalesHeader := SalesHeader;
        IF OldSalesHeader.FIND THEN
          // If "Bill-To Customer" is the same and Sales Header exists then do not consider amount in credit limit calculation since it's already included in "Outstanding Amount"
          // If "Bill-To Customer" was changed the consider amount in credit limit calculation since changes was not yet commited and not included in "Outstanding Amount"
          AssignDeltaAmount := OldSalesHeader."Bill-to Customer No." <> SalesHeader."Bill-to Customer No."
        ELSE
          // If Sales Header is not inserted yet then consider the amount in credit limit calculation
          AssignDeltaAmount := TRUE;
        IF AssignDeltaAmount THEN
          DeltaAmount := NewOrderAmountLCY;
        EXIT(ShowWarning(SalesHeader."Bill-to Customer No.",NewOrderAmountLCY,0,TRUE));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..21
        DeltaAmount := NewOrderAmountLCY;
        EXIT(ShowWarning(SalesHeader."Bill-to Customer No.",NewOrderAmountLCY,0,TRUE));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SalesLineShowWarning(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "SalesLineShowWarning(PROCEDURE 4)".

    //procedure SalesLineShowWarning();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesSetup.GET;
        IF SalesSetup."Credit Warnings" =
           SalesSetup."Credit Warnings"::"No Warning"
        #4..17
        NewOrderAmountLCY :=
          DeltaAmount + SalesLineAmount(SalesLine."Document Type",SalesLine."Document No.");

        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN
          DeltaAmount := NewOrderAmountLCY;

        EXIT(ShowWarning(SalesHeader."Bill-to Customer No.",NewOrderAmountLCY,OldOrderAmountLCY,FALSE))
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..20
        EXIT(ShowWarning(SalesHeader."Bill-to Customer No.",NewOrderAmountLCY,OldOrderAmountLCY,FALSE))
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ServiceHeaderShowWarning(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "ServiceHeaderShowWarning(PROCEDURE 8)".

    //procedure ServiceHeaderShowWarning();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ServSetup.GET;
        SalesSetup.GET;
        IF SalesSetup."Credit Warnings" =
        #4..22

        IF ServHeader."Document Type" <> ServHeader."Document Type"::Order THEN
          NewOrderAmountLCY := NewOrderAmountLCY + ServLineAmount(ServHeader."Document Type",ServHeader."No.",ServLine);
        OldServHeader := ServHeader;
        IF OldServHeader.FIND THEN
          AssignDeltaAmount := OldServHeader."Bill-to Customer No." <> ServHeader."Bill-to Customer No."
        ELSE
          AssignDeltaAmount := TRUE;
        IF AssignDeltaAmount THEN
          DeltaAmount := NewOrderAmountLCY;
        EXIT(ShowWarning(ServHeader."Bill-to Customer No.",NewOrderAmountLCY,0,TRUE));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..25
        DeltaAmount := NewOrderAmountLCY;
        EXIT(ShowWarning(ServHeader."Bill-to Customer No.",NewOrderAmountLCY,0,TRUE));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ServiceLineShowWarning(PROCEDURE 10)".


    //Unsupported feature: Property Insertion (Local) on "ServiceLineShowWarning(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "ShowWarning(PROCEDURE 1)".

    //procedure ShowWarning();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NewCustNo = '' THEN
          EXIT;
        CustNo := NewCustNo;
        NewOrderAmountLCY := NewOrderAmountLCY2;
        OldOrderAmountLCY := OldOrderAmountLCY2;
        GET(CustNo);
        SETRANGE("No.","No.");
        Cust2.COPY(Rec);

        IF (SalesSetup."Credit Warnings" IN
            [SalesSetup."Credit Warnings"::"Both Warnings",
             SalesSetup."Credit Warnings"::"Credit Limit"]) AND
           CustCheckCrLimit.IsCreditLimitNotificationEnabled(Rec)
        THEN BEGIN
          CalcCreditLimitLCY;
          IF (CustCreditAmountLCY > "Credit Limit (LCY)") AND ("Credit Limit (LCY)" <> 0) THEN
            ExitValue := 1;
        END;
        IF CheckOverDueBalance AND
           (SalesSetup."Credit Warnings" IN
            [SalesSetup."Credit Warnings"::"Both Warnings",
             SalesSetup."Credit Warnings"::"Overdue Balance"]) AND
           CustCheckCrLimit.IsOverdueBalanceNotificationEnabled(Rec)
        THEN BEGIN
          CalcOverdueBalanceLCY;
          IF "Balance Due (LCY)" > 0 THEN
            ExitValue := ExitValue + 2;
        END;

        IF ExitValue > 0 THEN BEGIN
          CASE ExitValue OF
            1:
              BEGIN
                Heading := COPYSTR(CustCheckCrLimit.GetCreditLimitNotificationMsg,1,250);
                NotificationId := CustCheckCrLimit.GetCreditLimitNotificationId;
              END;
            2:
              BEGIN
                Heading := COPYSTR(CustCheckCrLimit.GetOverdueBalanceNotificationMsg,1,250);
                NotificationId := CustCheckCrLimit.GetOverdueBalanceNotificationId;
              END;
            3:
              BEGIN
                Heading := COPYSTR(CustCheckCrLimit.GetCreditLimitNotificationMsg,1,250);
                SecondHeading := COPYSTR(CustCheckCrLimit.GetOverdueBalanceNotificationMsg,1,250);
                NotificationId := CustCheckCrLimit.GetBothNotificationsId;
              END;
          END;
          EXIT(TRUE);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        IF SalesSetup."Credit Warnings" IN
           [SalesSetup."Credit Warnings"::"Both Warnings",
            SalesSetup."Credit Warnings"::"Credit Limit"]
        #14..21
             SalesSetup."Credit Warnings"::"Overdue Balance"])
        #24..32
              Heading := Text002;
            2:
              Heading := Text003;
            3:
              Heading := Text004;
        #48..50
        */
    //end;


    //Unsupported feature: Code Modification on "CalcCreditLimitLCY(PROCEDURE 6)".

    //procedure CalcCreditLimitLCY();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GETFILTER("Date Filter") = '' THEN
          SETFILTER("Date Filter",'..%1',WORKDATE);
        CALCFIELDS("Balance (LCY)","Shipped Not Invoiced (LCY)","Serv Shipped Not Invoiced(LCY)");
        #4..12
        CustCreditAmountLCY :=
          "Balance (LCY)" + "Shipped Not Invoiced (LCY)" + "Serv Shipped Not Invoiced(LCY)" - RcdNotInvdRetOrdersLCY +
          OrderAmountTotalLCY - GetInvoicedPrepmtAmountLCY;

        OnAfterCalcCreditLimitLCY(Rec,CustCreditAmountLCY);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..15
        */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "CalcReturnAmounts(PROCEDURE 9)".


    //Unsupported feature: Deletion (VariableCollection) on "SalesHeaderShowWarning(PROCEDURE 3).OldSalesHeader(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "SalesHeaderShowWarning(PROCEDURE 3).AssignDeltaAmount(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "ServiceHeaderShowWarning(PROCEDURE 8).OldServHeader(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "ServiceHeaderShowWarning(PROCEDURE 8).AssignDeltaAmount(Variable 1003)".


    //Unsupported feature: Deletion (VariableCollection) on "ShowWarning(PROCEDURE 1).CustCheckCrLimit(Variable 1007)".


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
