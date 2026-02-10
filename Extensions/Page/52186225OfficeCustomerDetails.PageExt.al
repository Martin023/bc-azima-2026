#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186225 pageextension52186225 extends "Office Customer Details" 
{
    layout
    {
        // modify("Balance (LCY)")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Past Due")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Numeric) on ""Past Due"(Control 5)".

        }
        modify("LTD Sales")
        {
            ApplicationArea = Basic;
        }
        modify("YTD Sales")
        {
            ApplicationArea = Basic;
        }
        // modify("Balance (LCY)")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance (LCY)"(Control 6)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Past Due"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Past Due"(Control 5)".


        //Unsupported feature: Property Deletion (CaptionML) on ""LTD Sales"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""LTD Sales"(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""YTD Sales"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""YTD Sales"(Control 3)".

    }
    var
        MiniCustomerMgt: Codeunit "Customer Mgt.";


    //Unsupported feature: Code Modification on "GetTotalSales(PROCEDURE 6)".

    //procedure GetTotalSales();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(CustomerMgt.GetTotalSales("No."));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(MiniCustomerMgt.GetTotalSales("No."));
        */
    //end;


    //Unsupported feature: Code Modification on "GetYTDSales(PROCEDURE 1)".

    //procedure GetYTDSales();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(CustomerMgt.GetYTDSales("No."));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(MiniCustomerMgt.GetYTDSales("No."));
        */
    //end;
}
