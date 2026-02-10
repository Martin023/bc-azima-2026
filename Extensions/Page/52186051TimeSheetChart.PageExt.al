#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186051 pageextension52186051 extends "Time Sheet Chart"
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

        //Unsupported feature: Property Deletion (ToolTipML) on "StatusText(Control 3)".

    }
    actions
    {
        modify("Previous Period")
        {
            ApplicationArea = Basic;
        }
        modify("Next Period")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify(Posted)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Previous Period"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Period"(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Posted(Action 10)".

        addafter("Show by")
        {
            action(Refresh)
            {
                ApplicationArea = Basic;
                Caption = 'Refresh';
                Image = Refresh;

                trigger OnAction()
                begin
                    //NeedsUpdate := true;
                    // UpdateStatus;
                end;
            }
        }
    }

    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointClicked"(EVENT 12).point(Parameter 1000)".


    //Unsupported feature: Property Modification (ExternalDataType) on ""BusinessChart@-5::DataPointDoubleClicked"(EVENT 13).point(Parameter 1000)".

}
