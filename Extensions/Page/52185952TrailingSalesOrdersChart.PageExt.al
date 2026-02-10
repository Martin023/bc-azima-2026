#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185952 pageextension52185952 extends "Trailing Sales Orders Chart"
{
    layout
    {
        modify(StatusText)
        {
            ApplicationArea = Basic;
        }
        modify(BusinessChart)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "StatusText(Control 12)".


        //Unsupported feature: Property Deletion (Editable) on "StatusText(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BusinessChart(Control 5)".

    }
    actions
    {
        modify(AllOrders)
        {
            ApplicationArea = Basic;
        }
        modify(OrdersUntilToday)
        {
            ApplicationArea = Basic;
        }
        modify(DelayedOrders)
        {
            ApplicationArea = Basic;
        }
        modify(Day)
        {
            ApplicationArea = Basic;
        }
        modify(Week)
        {
            ApplicationArea = Basic;
        }
        modify(Month)
        {
            ApplicationArea = Basic;
        }
        modify(Quarter)
        {
            ApplicationArea = Basic;
        }
        modify(Year)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify(NoofOrders)
        {
            ApplicationArea = Basic;
        }
        modify(StackedArea)
        {
            ApplicationArea = Basic;
        }
        modify(StackedAreaPct)
        {
            ApplicationArea = Basic;
        }
        modify(StackedColumn)
        {
            ApplicationArea = Basic;
        }
        modify(StackedColumnPct)
        {
            ApplicationArea = Basic;
        }
        modify(Setup)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AllOrders(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OrdersUntilToday(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DelayedOrders(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Day(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Week(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Month(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quarter(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Year(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoofOrders(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StackedArea(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StackedAreaPct(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StackedColumn(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StackedColumnPct(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Setup(Action 13)".

        addafter(Action25)
        {
            action(Refresh)
            {
                ApplicationArea = Basic;
                Caption = 'Refresh';
                Image = Refresh;

                trigger OnAction()
                begin
                    // NeedsUpdate := true;
                    //UpdateStatus;
                end;
            }
            separator(Action27)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "SetActionsEnabled(PROCEDURE 10)".


    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointClicked"(EVENT 12).point(Parameter 1000)".


    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointDoubleClicked"(EVENT 13).point(Parameter 1000)".

}
