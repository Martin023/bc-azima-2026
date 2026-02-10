#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186809 pageextension52186809 extends "Sales Analysis Report" 
{
    layout
    {
        modify(CurrentReportName)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentLineTemplate)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentColumnTemplate)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentSourceTypeFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentSourceTypeNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnsSet)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "CurrentReportName(Control 40).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF AnalysisReportMgt.LookupReportName(GETRANGEMAX("Analysis Area"),CurrentReportName) THEN BEGIN
              Text := CurrentReportName;
              CurrentReportNameOnAfterValidate;
              EXIT(TRUE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF AnalysisReportMgt.LookupReportName(GETRANGEMAX("Analysis Area"),CurrentReportName) THEN BEGIN
              Text := CurrentReportName;
              EXIT(TRUE);
            END;
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentReportName(Control 40).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            AnalysisReportMgt.CheckReportName(CurrentReportName,Rec);
            CurrentReportNameOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            AnalysisReportMgt.CheckReportName(CurrentReportName,Rec);
            CurrentReportNameOnAfterValida;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentReportName(Control 40)".



        //Unsupported feature: Code Modification on "CurrentLineTemplate(Control 9).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            AnalysisReportMgt.CheckAnalysisLineTemplName(CurrentLineTemplate,Rec);
            CurrentLineTemplateOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            AnalysisReportMgt.CheckAnalysisLineTemplName(CurrentLineTemplate,Rec);
            CurrentLineTemplateOnAfterVali;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentLineTemplate(Control 9)".



        //Unsupported feature: Code Modification on "CurrentColumnTemplate(Control 8).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF AnalysisReportMgt.LookupColumnName(GETRANGEMAX("Analysis Area"),CurrentColumnTemplate) THEN BEGIN
              Text := CurrentColumnTemplate;
              CurrentColumnTemplateOnAfterValidate;
              EXIT(TRUE);
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF AnalysisReportMgt.LookupColumnName(GETRANGEMAX("Analysis Area"),CurrentColumnTemplate) THEN BEGIN
              Text := CurrentColumnTemplate;
              EXIT(TRUE);
            END;
            */
        //end;


        //Unsupported feature: Code Modification on "CurrentColumnTemplate(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            AnalysisReportMgt.GetColumnTemplate(GETRANGEMAX("Analysis Area"),CurrentColumnTemplate);
            CurrentColumnTemplateOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            AnalysisReportMgt.GetColumnTemplate(GETRANGEMAX("Analysis Area"),CurrentColumnTemplate);
            CurrentColumnTemplateOnAfterVa;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentColumnTemplate(Control 8)".



        //Unsupported feature: Code Modification on "CurrentSourceTypeFilter(Control 27).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            SETRANGE("Source Type Filter",CurrentSourceTypeFilter);
            CurrentSourceTypeNoFilter := '';
            AnalysisReportMgt.SetSourceNo(Rec,CurrentSourceTypeNoFilter);
            CurrentSourceTypeFilterOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            CurrentSourceTypeFilterOnAfter;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSourceTypeFilter(Control 27)".



        //Unsupported feature: Code Modification on "CurrentSourceTypeNoFilter(Control 25).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrentSourceTypeNoFilterOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrentSourceTypeNoFilterOnAft;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSourceTypeNoFilter(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnsSet(Control 5)".

    }
    actions
    {
        modify("Set Up &Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Set Up &Columns")
        {
            ApplicationArea = Basic;
        }
        modify("Create New Document")
        {
            ApplicationArea = Basic;
        }
        modify("Update Existing Document")
        {
            ApplicationArea = Basic;
        }
        modify(Print)
        {
            ApplicationArea = Basic;
        }
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedIsBig) on "ShowMatrix(Action 1)".

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

            //Unsupported feature: Property Insertion (PromotedIsBig) on ""Next Set"(Action 7)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Set Up &Lines"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Set Up &Columns"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create New Document"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Existing Document"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 1)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ShowMatrix(Action 1)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 6)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 7)".

        moveafter(ShowMatrix;"Next Set")
    }


    //Unsupported feature: Property Modification (Data type) on "CurrentSourceTypeNoFilter(Variable 1015)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentSourceTypeNoFilter : Text;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentSourceTypeNoFilter : Code;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetFilters(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "SetReportName(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Name) on "CurrentReportNameOnAfterValidate(PROCEDURE 19043622)".


    //Unsupported feature: Property Modification (Name) on "CurrentLineTemplateOnAfterValidate(PROCEDURE 19002239)".


    //Unsupported feature: Property Modification (Name) on "CurrentColumnTemplateOnAfterValidate(PROCEDURE 19007060)".


    //Unsupported feature: Property Modification (Name) on "CurrentSourceTypeNoFilterOnAfterValidate(PROCEDURE 19027013)".


    //Unsupported feature: Property Modification (Name) on "CurrentSourceTypeFilterOnAfterValidate(PROCEDURE 19072332)".

}
