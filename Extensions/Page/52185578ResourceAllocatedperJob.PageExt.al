#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185578 pageextension52185578 extends "Resource Allocated per Job" 
{
    layout
    {
        modify(ResourceFilter)
        {
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnsSet)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceFilter(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnsSet(Control 18)".

    }
    actions
    {
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on "ShowMatrix(Action 13)".

        }
        modify("Previous Set")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify("Next Set")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 17)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 17)".

        moveafter(ShowMatrix;"Next Set")
    }

    //Unsupported feature: Property Modification (Data type) on "ResourceFilter(Variable 1020)".

    //var
        //>>>> ORIGINAL VALUE:
        //ResourceFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ResourceFilter : Code;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (OptionString) on "SetWanted(Variable 1033)".

    //var
        //>>>> ORIGINAL VALUE:
        //SetWanted : Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SetWanted : Initial,Previous,Same,Next;
        //Variable type has not been exported.
    var
        ArrayLength: Integer;
        InternalDateFilter: Text[30];


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetColumns(SetWanted::Initial);
        IF HASFILTER THEN
          ResourceFilter := GETFILTER("Resource Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ArrayLength := 32;
        #1..3
        */
    //end;


    //Unsupported feature: Code Modification on "DateControl(PROCEDURE 6)".

    //procedure DateControl();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TextManagement.MakeDateFilter(DateFilter);

        ResRec2.SETFILTER("Date Filter",DateFilter);
        DateFilter := ResRec2.GETFILTER("Date Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
        #2..4
        InternalDateFilter := DateFilter;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 7)".


    //Unsupported feature: Property Modification (OptionString) on "SetColumns(PROCEDURE 7).SetWanted(Parameter 1001)".

}
