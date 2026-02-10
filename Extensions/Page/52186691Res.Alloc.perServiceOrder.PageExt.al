#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186691 pageextension52186691 extends "Res. Alloc. per Service Order" 
{
    layout
    {
        modify(ResourceFilter)
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


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnsSet(Control 9)".

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

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 14)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 13)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 10)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 14)".

        moveafter(ShowMatrix;"Next Set")
    }

    //Unsupported feature: Property Modification (Data type) on "ResourceFilter(Variable 1018)".

    //var
        //>>>> ORIGINAL VALUE:
        //ResourceFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ResourceFilter : Code;
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
        ResRec2.SETFILTER("Date Filter",DateFilter);
        DateFilter := ResRec2.GETFILTER("Date Filter");
        InternalDateFilter := DateFilter;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 7)".

}
