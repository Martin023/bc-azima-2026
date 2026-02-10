#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186031 pageextension52186031 extends "Manager Time Sheet" 
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Manager Time Sheet"(Page 952)".

    layout
    {
        modify(CurrTimeSheetNo)
        {
            ApplicationArea = Basic;
        }
        modify(ResourceNo)
        {
            ApplicationArea = Basic;
        }
        modify(ApproverUserID)
        {
            ApplicationArea = Basic;
        }
        modify(StartingDate)
        {
            ApplicationArea = Basic;
        }
        modify(EndingDate)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
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
        modify("Cause of Absence Code")
        {
            ApplicationArea = Basic;
        }
        modify(Chargeable)
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Service Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Assembly Order No.")
        {
            ApplicationArea = Basic;
        }
        modify(Posted)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrTimeSheetNo(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceNo(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApproverUserID(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StartingDate(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndingDate(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cause of Absence Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Chargeable(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order No."(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly Order No."(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Posted(Control 9)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field1(Control 11)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field2(Control 15)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field3(Control 17)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field4(Control 19)".


        //Unsupported feature: Property Deletion (DecimalPlaces) on "Field5(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Quantity"(Control 48)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "TimeSheetStatusFactBox(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ActualSchedSummaryFactBox(Control 1905767507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ActivityDetailsFactBox(Control 38)".

    }
    actions
    {
        modify(PreviousPeriod)
        {
            ApplicationArea = Basic;
        }
        modify(NextPeriod)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on "NextPeriod(Action 35)".

        }
        modify("Posting E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Posting E&ntries"(Action 24)".

        }
        modify("Activity &Details")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Activity &Details"(Action 39)".

        }
        modify(TimeSheetComment2)
        {

            //Unsupported feature: Property Modification (Name) on "TimeSheetComment2(Action 22)".

            ApplicationArea = Basic;
        }
        modify(LineComments)
        {

            //Unsupported feature: Property Modification (Name) on "LineComments(Action 18)".

            ApplicationArea = Basic;
        }
        modify(Approve)
        {
            ApplicationArea = Basic;
        }
        modify(Reject)
        {
            ApplicationArea = Basic;
        }
        modify(Reopen)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PreviousPeriod(Action 34)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PreviousPeriod(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NextPeriod(Action 35)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "NextPeriod(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting E&ntries"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Activity &Details"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TimeSheetComment2(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineComments(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approve(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 30)".

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
        TimeSheetLine.SETRANGE("Time Sheet No.",CurrTimeSheetNo);
        TimeSheetLine.COPYFILTERS(Rec);
        TimeSheetLine.FILTERGROUP(2);
        #4..9
          ActionType::Reopen:
            TimeSheetLine.SETRANGE(Status,TimeSheetLine.Status::Approved);
        END;

        OnAfterFilterAllLines(TimeSheetLine,ActionType);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..12
        */
    //end;

    //Unsupported feature: Property Insertion (OptionString) on "FindTimeSheet(PROCEDURE 7).Which(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "Process(PROCEDURE 1).TempTimeSheetLine(Variable 1003)".

}
