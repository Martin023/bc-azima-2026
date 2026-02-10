#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186181 pageextension52186181 extends "Sales Price and Line Discounts" 
{

    //Unsupported feature: Property Modification (Name) on ""Sales Price and Line Discounts"(Page 1345)".


    //Unsupported feature: Property Modification (PageType) on ""Sales Price and Line Discounts"(Page 1345)".

    layout
    {
        modify("Line Type")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Type")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Code")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            ToolTip = 'This object supports the Microsoft Dynamics NAV infrastructure and is intended only for internal use.';
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ToolTip = 'Specifies the unit of measure that must be used on the sales document line to warrant the sales price or discount.';
            ApplicationArea = Basic;
        }
        modify("Minimum Quantity")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ToolTip = 'Specifies the discount percent that is granted if the criteria are met.';
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ToolTip = 'Specifies the unit price that is granted on sales documents if the criteria, such as sales code, currency code, and date, are met.';
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ToolTip = 'Specifies the date from which the sales line discount is valid. To specify that a discount should be valid during a specific period, such as during a sales campaign, enter a value in the Ending Date field as well. If you leave the Starting Date field blank, the sales line discount will be valid as soon as you implement it and will remain in effect until the ending date or until you delete the line.';
            ApplicationArea = Basic;
        }
        modify("Ending Date")
        {
            ToolTip = 'Specifies the date to which the sales line discount is valid. To specify that a discount should be valid during a specific period, such as during a sales campaign, enter a value in the Starting Date field as well. If you leave the Ending Date field blank, the sales line discount will be valid until you delete the line, or until the starting data of another sales line discount.';
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Price Includes VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Line Disc.")
        {
            ToolTip = 'This object supports the Microsoft Dynamics NAV infrastructure and is intended only for internal use.';
            ApplicationArea = Basic;
        }
    }
    actions
    {
        modify("Show Current Only")
        {
            ApplicationArea = Basic;
        }
        modify("Show All")
        {
            ApplicationArea = Basic;
        }
        modify("Refresh Data")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Refresh Data"(Action 15)".

        modify("Set Special Prices")
        {
            Visible = false;
        }
        modify("Set Special Discounts")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "InitPage(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "LoadItem(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "LoadCustomer(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "GetLoadedItemNo(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "GetLoadedCustNo(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "RunUpdatePriceIncludesVatAndPrices(PROCEDURE 6)".


    //Unsupported feature: Property Deletion (InsertAllowed).


    //Unsupported feature: Property Deletion (DeleteAllowed).


    //Unsupported feature: Property Deletion (ModifyAllowed).

}
