#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186858 pageextension52186858 extends "Warehouse Movement Subform" 
{
    layout
    {
        modify("Action Type")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Lot No.")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
        }
        modify("Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Special Equipment Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Handle (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Outstanding")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Outstanding (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify(Weight)
        {
            ApplicationArea = Basic;
        }
        modify(Cubage)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Action Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 1106000000)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Zone Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Special Equipment Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Base)"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Handle (Base)"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Outstanding (Base)"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Weight(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Cubage(Control 28)".

    }
    actions
    {
        modify(SplitWhseActivityLine)
        {

            //Unsupported feature: Property Modification (Name) on "SplitWhseActivityLine(Action 1900724104)".

            ApplicationArea = Basic;
        }
        modify(ChangeUnitOfMeasure)
        {

            //Unsupported feature: Property Modification (Name) on "ChangeUnitOfMeasure(Action 1903867104)".

            ApplicationArea = Basic;
        }
        modify("Bin Contents List")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SplitWhseActivityLine(Action 1900724104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ChangeUnitOfMeasure(Action 1903867104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents List"(Action 1900206104)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "AutofillQtyToHandle(PROCEDURE 10)".


    //Unsupported feature: Property Deletion (Attributes) on "DeleteQtyToHandle(PROCEDURE 4)".


    //Unsupported feature: Code Modification on "CallSplitLine(PROCEDURE 6)".

    //procedure CallSplitLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseActivLine.COPY(Rec);
        SplitLine(WhseActivLine);
        COPY(WhseActivLine);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WhseActivLine.COPY(Rec);
        SplitLine(WhseActivLine);
        CurrPage.UPDATE(FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on "ChangeUOM(PROCEDURE 1)".

    //procedure ChangeUOM();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TESTFIELD("Action Type");
        TESTFIELD("Breakbulk No.",0);
        TESTFIELD("Qty. to Handle");
        WhseChangeOUM.DefWhseActLine(Rec);
        WhseChangeOUM.RUNMODAL;
        IF WhseChangeOUM.ChangeUOMCode(WhseActLine) = TRUE THEN
          ChangeUOMCode(Rec,WhseActLine);
        CLEAR(WhseChangeOUM);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TESTFIELD("Action Type");
        TESTFIELD("Breakbulk No.",0);
        #4..9
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: WhseActivityRegisterYesNo) (VariableCollection) on "RegisterActivityYesNo(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "RegisterActivityYesNo(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "RegisterActivityYesNo(PROCEDURE 2)".

    //procedure RegisterActivityYesNo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WhseActivLine.COPY(Rec);
        WhseActivLine.FILTERGROUP(3);
        WhseActivLine.SETRANGE(Breakbulk);
        WhseActivLine.FILTERGROUP(0);
        CODEUNIT.RUN(CODEUNIT::"Whse.-Act.-Register (Yes/No)",WhseActivLine);
        RESET;
        SETCURRENTKEY("Activity Type","No.","Sorting Sequence No.");
        FILTERGROUP(4);
        #9..11
        SETRANGE(Breakbulk,FALSE);
        FILTERGROUP(0);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        WhseActivityRegisterYesNo.RUN(WhseActivLine);
        #6..14
        */
    //end;

    //Unsupported feature: Property Modification (Id) on "SerialNoOnAfterValidate(PROCEDURE 19074494).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Move on "SerialNoOnAfterValidate(PROCEDURE 19074494).ExpDate(Variable 1106000002)".


    //Unsupported feature: Property Modification (Id) on "LotNoOnAfterValidate(PROCEDURE 19045288).ItemTrackingMgt(Variable 1000)".


    //Unsupported feature: Move on "LotNoOnAfterValidate(PROCEDURE 19045288).ExpDate(Variable 1106000002)".

}
