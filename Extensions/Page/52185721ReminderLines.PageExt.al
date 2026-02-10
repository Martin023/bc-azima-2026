#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185721 pageextension52185721 extends "Reminder Lines" 
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        // modify("Document No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Original Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("No. of Reminders")
        {
            ApplicationArea = Basic;
        }
        modify("Line Type")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Document No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (IndentationColumnName) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (IndentationControls) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 6)".

        modify("Document No.")
        {
            Visible = false;
        }
        // modify("Document No.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (Style) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Original Amount"(Control 14)".


        //Unsupported feature: Property Deletion (Style) on ""Original Amount"(Control 14)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Original Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 16)".


        //Unsupported feature: Property Deletion (Style) on ""Remaining Amount"(Control 16)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Remaining Amount"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 18)".


        //Unsupported feature: Property Deletion (Style) on "Amount(Control 18)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Amount(Control 18)".


        //Unsupported feature: Property Deletion (CaptionML) on ""No. of Reminders"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Reminders"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Type"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Document Type"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Document No."(Control 34)".

    }
    actions
    {
        modify("Insert &Ext. Texts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 1900206104)".

    }

    //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 5)".

    //procedure InsertExtendedText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OnBeforeInsertExtendedText(Rec);

        IF TransferExtendedText.ReminderCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
          CurrPage.SAVERECORD;
          TransferExtendedText.InsertReminderExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
          CurrPage.UPDATE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #3..8
        */
    //end;
}
