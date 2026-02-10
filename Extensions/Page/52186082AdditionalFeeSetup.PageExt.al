#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186082 pageextension52186082 extends "Additional Fee Setup" 
{
    layout
    {
        modify("Charge Per Line")
        {
            ApplicationArea = Basic;
        }
        modify("Reminder Terms Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reminder Level No.")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Threshold Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Additional Fee Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Additional Fee %")
        {
            ApplicationArea = Basic;
        }
        modify("Min. Additional Fee Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Additional Fee Amount")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Charge Per Line"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reminder Terms Code"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reminder Level No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Threshold Remaining Amount"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Fee Amount"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Fee %"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Min. Additional Fee Amount"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Additional Fee Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Chart(Control 1006)".

    }

    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
        /*
        IF ShowChart THEN
          CurrPage.Chart.PAGE.UpdateData;
        */
    //end;
}
