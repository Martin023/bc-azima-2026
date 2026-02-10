#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186283 pageextension52186283 extends Tasks 
{

    //Unsupported feature: Property Modification (Name) on "Tasks(Page 5099)".

    Caption = 'To-dos';
    layout
    {
        modify(TableOption)
        {
            ApplicationArea = Basic;
        }
        modify(OutputOption)
        {
            OptionCaption = 'No. of To-dos,Contact No.';
            ApplicationArea = Basic;
        }
        modify(FilterSalesPerson)
        {
            ApplicationArea = Basic;
        }
        modify(FilterTeam)
        {
            ApplicationArea = Basic;
        }
        modify(FilterCampaign)
        {
            ApplicationArea = Basic;
        }
        modify(FilterContact)
        {
            ApplicationArea = Basic;
        }
        modify(StatusFilter)
        {
            ApplicationArea = Basic;
        }
        modify(IncludeClosed)
        {
            Caption = 'Include Closed To-dos';
            ApplicationArea = Basic;
        }
        modify(PriorityFilter)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnSet)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "TableOption(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OutputOption(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FilterSalesPerson(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FilterTeam(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FilterCampaign(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FilterContact(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatusFilter(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncludeClosed(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PriorityFilter(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnSet(Control 4)".

    }
    actions
    {
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;
        }
        modify("Previous Set")
        {
            ToolTip = 'Previous Column Set';
            ApplicationArea = Basic;
        }
        modify("Next Set")
        {
            ToolTip = 'Next Column Set';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".

    }

    //Unsupported feature: Property Modification (Id) on "MatrixMgt(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixMgt : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixMgt : 1017;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (OptionString) on "OutputOption(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //OutputOption : "No. of Tasks","Contact No.";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OutputOption : "No. of To-dos","Contact No.";
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1016)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text001 : ENU=No. of Tasks,Contact No.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text001 : ENU=No. of To-dos,Contact No.;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
