#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186038 pageextension52186038 extends "Time Sheet Archive" 
{
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
        modify(Status)
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Order No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assembly Order No."(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Quantity"(Control 48)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "PeriodSummaryArcFactBox(Control 1905767507)".

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
        modify("Posting E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify(TimeSheetComments)
        {

            //Unsupported feature: Property Modification (Name) on "TimeSheetComments(Action 22)".

            ApplicationArea = Basic;
        }
        modify(LineComments)
        {

            //Unsupported feature: Property Modification (Name) on "LineComments(Action 18)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Previous Period"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Next Period"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting E&ntries"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TimeSheetComments(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineComments(Action 18)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 11)".


    //Unsupported feature: Property Insertion (OptionString) on "FindTimeSheet(PROCEDURE 7).Which(Parameter 1000)".

}
