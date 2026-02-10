#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186488 pageextension52186488 extends "Total Value Insured" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("FASetup.""Insurance Depr. Book""")
        {
            ApplicationArea = Basic;
        }
        modify("FADeprBook.""Acquisition Cost""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FASetup.""Insurance Depr. Book"""(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FADeprBook.""Acquisition Cost"""(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "TotalValue(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    var
        AcqCost: Decimal;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.TotalValue.PAGE.CreateTotalValue("No.");
        FASetup.GET;
        FADeprBook.INIT;
        IF FASetup."Insurance Depr. Book" <> '' THEN
          IF FADeprBook.GET("No.",FASetup."Insurance Depr. Book") THEN
            FADeprBook.CALCFIELDS("Acquisition Cost");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrPage.TotalValue.PAGE.CreateTotalValue("No.");
        FASetup.GET;
        AcqCost := 0;
        #3..6
        */
    //end;
}
