#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185742 pageextension52185742 extends "No. Series"
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
            trigger OnBeforeValidate()
            begin
                if StrLen(rec.Code) > 10 then
                    Error('Code must be less than or equal to 10 characters.');
            end;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(StartDate)
        {
            ApplicationArea = Basic;
        }
        modify(StartNo)
        {
            ApplicationArea = Basic;
        }
        modify(EndNo)
        {
            ApplicationArea = Basic;
        }
        modify(LastDateUsed)
        {
            ApplicationArea = Basic;
        }
        modify(LastNoUsed)
        {
            ApplicationArea = Basic;
        }
        modify(WarningNo)
        {
            ApplicationArea = Basic;
        }
        modify(IncrementByNo)
        {
            ApplicationArea = Basic;
        }
        modify("Default Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Manual Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Date Order")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StartDate(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StartNo(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndNo(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastDateUsed(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastNoUsed(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WarningNo(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncrementByNo(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Default Nos."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Manual Nos."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Order"(Control 32)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Lines)
        {
            ApplicationArea = Basic;
        }
        modify(Relationships)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Lines(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Relationships(Action 3)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
