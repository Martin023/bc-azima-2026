#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185996 pageextension52185996 extends "CF Availability by Periods" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Manual Payments From")
        {
            ApplicationArea = Basic;
        }
        modify("Manual Payments To")
        {
            ApplicationArea = Basic;
        }
        modify(LiquidFunds)
        {
            ApplicationArea = Basic;
        }
        modify("Creation Date")
        {
            ApplicationArea = Basic;
        }
        modify(RoundingFactor)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ToolTip = 'Day';
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ToolTip = 'Net Change';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 1011)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Manual Payments From"(Control 1015)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Manual Payments To"(Control 1017)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LiquidFunds(Control 1021)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 1013)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RoundingFactor(Control 1019)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "CFAvailabLines(Control 1000)".


        //Unsupported feature: Property Deletion (PartType) on "CFAvailabLines(Control 1000)".

    }
    var
        LastDate: Date;


    //Unsupported feature: Code Insertion on "OnQueryClosePage".

    //trigger OnQueryClosePage(CloseAction: Action): Boolean
    //begin
        /*
        IF CloseAction = ACTION::LookupOK THEN
          LookupOKOnPush;
        */
    //end;

    local procedure GetLastDate(): Date
    begin
        exit(LastDate);
    end;

    local procedure LookupOKOnPush()
    var
        Date: Record Date;
    begin
        CurrPage.CFAvailabLines.Page.GetRecord(Date);
        LastDate := Date."Period Start";
    end;
}
