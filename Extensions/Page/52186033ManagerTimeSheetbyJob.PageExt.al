#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186033 pageextension52186033 extends "Manager Time Sheet by Job" 
{
    layout
    {
        modify(StartingDate)
        {
            ApplicationArea = Basic;
        }
        modify(EndingDate)
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Task No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify(Chargeable)
        {
            ApplicationArea = Basic;
        }
        modify(Field1)
        {
            ApplicationArea = Basic;
        }
        modify(Field2)
        {
            ApplicationArea = Basic;
        }
        modify(Field3)
        {
            ApplicationArea = Basic;
        }
        modify(Field4)
        {
            ApplicationArea = Basic;
        }
        modify(Field5)
        {
            ApplicationArea = Basic;
        }
        modify(Field6)
        {
            ApplicationArea = Basic;
        }
        modify(Field7)
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Total Quantity")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "StartingDate(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndingDate(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Chargeable(Control 2)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field1(Control 11)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field2(Control 15)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field3(Control 17)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field4(Control 19)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field5(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Quantity"(Control 16)".

    }
    actions
    {
        modify("&Previous Period")
        {
            ApplicationArea = Basic;
        }
        modify("&Next Period")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Posting E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Activity &Details")
        {
            ApplicationArea = Basic;
        }
        modify(Approve)
        {

            //Unsupported feature: Property Modification (Name) on "Approve(Action 37)".

            ApplicationArea = Basic;
        }
        modify(Reject)
        {

            //Unsupported feature: Property Modification (Name) on "Reject(Action 46)".

            ApplicationArea = Basic;
        }
        modify(Reopen)
        {

            //Unsupported feature: Property Modification (Name) on "Reopen(Action 14)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Previous Period"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Next Period"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting E&ntries"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Activity &Details"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approve(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 14)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 11)".


    //Unsupported feature: Code Modification on "Process(PROCEDURE 1)".

    //procedure Process();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrPage.SAVERECORD;
        CASE Action OF
          Action::"Approve All",
        #4..7
          ELSE
            CurrPage.SETSELECTIONFILTER(TimeSheetLine);
        END;
        OnProcessOnAfterTimeSheetLinesFiltered(TimeSheetLine,Action);
        TimeSheetMgt.CopyFilteredTimeSheetLinesToBuffer(TimeSheetLine,TempTimeSheetLine);
        IF TimeSheetLine.FINDSET THEN
          REPEAT
            CASE Action OF
        #16..23
                TimeSheetApprovalMgt.Reject(TimeSheetLine);
            END;
          UNTIL TimeSheetLine.NEXT = 0;
        OnAfterProcess(TempTimeSheetLine,Action);
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..10
        #13..26
        CurrPage.UPDATE(FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on "FilterAllLines(PROCEDURE 22)".

    //procedure FilterAllLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TimeSheetLine.COPYFILTERS(Rec);
        TimeSheetLine.FILTERGROUP(2);
        TimeSheetLine.SETRANGE("Time Sheet Starting Date",StartingDate,EndingDate);
        #4..10
          ActionType::Reopen:
            TimeSheetLine.SETRANGE(Status,TimeSheetLine.Status::Approved);
        END;

        OnAfterFilterAllLines(TimeSheetLine,ActionType);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..13
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "Process(PROCEDURE 1).TempTimeSheetLine(Variable 1003)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
