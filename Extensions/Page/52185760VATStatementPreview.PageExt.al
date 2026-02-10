#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185760 pageextension52185760 extends "VAT Statement Preview" 
{
    layout
    {
        modify(Selection)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodSelection)
        {
            ApplicationArea = Basic;
        }
        modify(UseAmtsInAddCurr)
        {
            ApplicationArea = Basic;
        }
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Selection(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodSelection(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UseAmtsInAddCurr(Control 17)".


        //Unsupported feature: Code Insertion (VariableCollection) on "DateFilter(Control 2).OnValidate".

        //trigger (Variable: ApplicationManagement)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "DateFilter(Control 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TextManagement.MakeDateFilter(DateFilter);
            SETFILTER("Date Filter",DateFilter);
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
            SETFILTER("Date Filter",DateFilter);
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "VATStatementLineSubForm(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
}
