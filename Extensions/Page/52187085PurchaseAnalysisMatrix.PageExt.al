#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187085 pageextension52187085 extends "Purchase Analysis Matrix" 
{
    layout
    {
        modify("Row Ref. No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
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
        modify(Field8)
        {
            ApplicationArea = Basic;
        }
        modify(Field9)
        {
            ApplicationArea = Basic;
        }
        modify(Field10)
        {
            ApplicationArea = Basic;
        }
        modify(Field11)
        {
            ApplicationArea = Basic;
        }
        modify(Field12)
        {
            ApplicationArea = Basic;
        }
        modify(Field13)
        {
            ApplicationArea = Basic;
        }
        modify(Field14)
        {
            ApplicationArea = Basic;
        }
        modify(Field15)
        {
            ApplicationArea = Basic;
        }
        modify(Field16)
        {
            ApplicationArea = Basic;
        }
        modify(Field17)
        {
            ApplicationArea = Basic;
        }
        modify(Field18)
        {
            ApplicationArea = Basic;
        }
        modify(Field19)
        {
            ApplicationArea = Basic;
        }
        modify(Field20)
        {
            ApplicationArea = Basic;
        }
        modify(Field21)
        {
            ApplicationArea = Basic;
        }
        modify(Field22)
        {
            ApplicationArea = Basic;
        }
        modify(Field23)
        {
            ApplicationArea = Basic;
        }
        modify(Field24)
        {
            ApplicationArea = Basic;
        }
        modify(Field25)
        {
            ApplicationArea = Basic;
        }
        modify(Field26)
        {
            ApplicationArea = Basic;
        }
        modify(Field27)
        {
            ApplicationArea = Basic;
        }
        modify(Field28)
        {
            ApplicationArea = Basic;
        }
        modify(Field29)
        {
            ApplicationArea = Basic;
        }
        modify(Field30)
        {
            ApplicationArea = Basic;
        }
        modify(Field31)
        {
            ApplicationArea = Basic;
        }
        modify(Field32)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Row Ref. No."(Control 2)".


        //Unsupported feature: Property Deletion (Style) on ""Row Ref. No."(Control 2)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Row Ref. No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (Style) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Description(Control 4)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        i := 1;

        IF AnalysisColumn.FIND('-') THEN
        #4..13
            SetStyle(i);
            i := i + 1;
          UNTIL AnalysisColumn.NEXT = 0;
        Emphasize := Bold;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SETFILTER(Show,'<>%1',Show::No);
        AnalysisColumn.SETRANGE("Analysis Area",AnalysisColumn."Analysis Area"::Purchase);
        AnalysisColumn.SETRANGE("Analysis Column Template",AnalysisColumn."Analysis Column Template");
        AnalysisColumn.SETRANGE("Line No.",FirstLineNo,LastLineNo);
        AnalysisColumn.SETFILTER(Show,'<>%1',AnalysisColumn.Show::Never);

        SetVisible;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #2..4
        SetVisible;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "GetMatrixDimension(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "FormatStr(PROCEDURE 7)".

}
