#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187048 pageextension52187048 extends "Job No. of Prices FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfResourcePrices)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfItemPrices)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfAccountPrices)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Code Modification on "NoOfResourcePrices(Control 2).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            JobResPrice.SETRANGE("Job No.","No.");

            PAGE.RUN(PAGE::"Job Resource Prices",JobResPrice);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            JobResPrice.SETRANGE("Job No.","No.");
            JobResPricesList.SETTABLEVIEW(JobResPrice);
            JobResPricesList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfResourcePrices(Control 2)".



        //Unsupported feature: Code Modification on "NoOfItemPrices(Control 4).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            JobItPrice.SETRANGE("Job No.","No.");

            PAGE.RUN(PAGE::"Job Item Prices",JobItPrice);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            JobItPrice.SETRANGE("Job No.","No.");
            JobItemPricesList.SETTABLEVIEW(JobItPrice);
            JobItemPricesList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfItemPrices(Control 4)".



        //Unsupported feature: Code Modification on "NoOfAccountPrices(Control 11).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            JobAccPrice.SETRANGE("Job No.","No.");

            PAGE.RUN(PAGE::"Job G/L Account Prices",JobAccPrice);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            JobAccPrice.SETRANGE("Job No.","No.");
            JobAccountPricesList.SETTABLEVIEW(JobAccPrice);
            JobAccountPricesList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfAccountPrices(Control 11)".

    }

    var
        JobResPricesList: Page "Job Resource Prices";

    var
        JobItemPricesList: Page "Job Item Prices";

    var
        JobAccountPricesList: Page "Job G/L Account Prices";
}
