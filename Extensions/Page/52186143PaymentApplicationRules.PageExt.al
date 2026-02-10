#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186143 pageextension52186143 extends "Payment Application Rules" 
{
    layout
    {
        modify("Match Confidence")
        {
            ApplicationArea = Basic;
        }
        modify(Priority)
        {
            ApplicationArea = Basic;
        }
        modify("Related Party Matched")
        {
            ApplicationArea = Basic;
        }
        modify("Doc. No./Ext. Doc. No. Matched")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Incl. Tolerance Matched")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Match Confidence"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Related Party Matched"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Doc. No./Ext. Doc. No. Matched"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Incl. Tolerance Matched"(Control 7)".

        modify("Direct Debit Collect. Matched")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(RestoreDefaultRules)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "RestoreDefaultRules(Action 9)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (DelayedInsert).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
