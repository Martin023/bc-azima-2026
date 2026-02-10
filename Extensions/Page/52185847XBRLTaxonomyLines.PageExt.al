#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185847 pageextension52185847 extends "XBRL Taxonomy Lines" 
// {

//     //Unsupported feature: Property Insertion (SourceTableTemporary) on ""XBRL Taxonomy Lines"(Page 583)".

//     layout
//     {
//         modify(CurrentTaxonomy)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(OnlyShowPresentation)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(CurrentLang)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Label)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Source Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Constant Amount")
//         {
//             ApplicationArea = Basic;
//         }
//         // modify(Control10)
//         // {
//         //     ApplicationArea = Basic;
//         // }
//         // modify(Control32)
//         // {
//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Modification (Name) on "Control32(Control 32)".

//         // }
//         // modify(Control12)
//         // {
//         //     ApplicationArea = Basic;
//         // }
//         // modify("G/L Map Lines")
//         // {
//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Modification (Name) on ""G/L Map Lines"(Control 8)".

//         // }
//         modify(Rollup)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Description)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Name)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Code Modification on "CurrentTaxonomy(Control 39).OnLookup".

//         //trigger OnLookup(var Text: Text): Boolean
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             XBRLTaxonomy.Name := CurrentTaxonomy;
//             IF PAGE.RUNMODAL(0,XBRLTaxonomy) <> ACTION::LookupOK THEN
//               EXIT(FALSE);

//             CurrentTaxonomy := XBRLTaxonomy.Name;
//             CurrentTaxonomyOnAfterValidate;
//             Text := XBRLTaxonomy.Name;
//             EXIT(TRUE);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #1..4
//             Text := XBRLTaxonomy.Name;
//             EXIT(TRUE);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "CurrentTaxonomy(Control 39)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "OnlyShowPresentation(Control 3)".



//         //Unsupported feature: Code Modification on "CurrentLang(Control 41).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             XBRLTaxonomyLabel.SETRANGE("XBRL Taxonomy Name",CurrentTaxonomy);
//             XBRLTaxonomyLabel.SETRANGE("XML Language Identifier",CurrentLang);
//             IF CurrentLang <> '' THEN
//               IF XBRLTaxonomyLabel.ISEMPTY THEN
//                 ERROR(Text001,CurrentLang);
//             SetFilters;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             #1..3
//               IF NOT XBRLTaxonomyLabel.FINDFIRST THEN
//                 ERROR(Text001,CurrentLang);
//             SetFilters;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "CurrentLang(Control 41)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Label(Control 2)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Source Type"(Control 4)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Constant Amount"(Control 6)".

//         modify(Control10)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Control10(Control 10)".

//         modify(Control32)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Control32(Control 32)".

//         modify(Control12)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Control12(Control 12)".


//         //Unsupported feature: Property Deletion (Editable) on "Control12(Control 12)".

//         modify("G/L Map Lines")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Map Lines"(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Rollup(Control 31)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 16)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control9(Control 9)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control11(Control 11)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control13(Control 13)".

//     }
//     actions
//     {
//         modify(Card)
//         {
//             ApplicationArea = Basic;
//         }
//         // modify(Information)
//         // {
//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Insertion (RunObject) on "Information(Action 24)".


//         //     //Unsupported feature: Property Insertion (RunPageLink) on "Information(Action 24)".

//         // }
//         // modify(Reference)
//         // {

//         //     //Unsupported feature: Property Modification (Name) on "Reference(Action 30)".

//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Insertion (RunObject) on "Reference(Action 30)".


//         //     //Unsupported feature: Property Insertion (RunPageLink) on "Reference(Action 30)".

//         // }
//         // modify(Rollups)
//         // {
//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Insertion (RunObject) on "Rollups(Action 25)".


//         //     //Unsupported feature: Property Insertion (RunPageLink) on "Rollups(Action 25)".

//         // }
//         // modify(Notes)
//         // {
//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Insertion (RunObject) on "Notes(Action 26)".


//         //     //Unsupported feature: Property Insertion (RunPageLink) on "Notes(Action 26)".

//         // }
//         // modify(GLMapLines)
//         // {

//         //     //Unsupported feature: Property Modification (Name) on "GLMapLines(Action 27)".

//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Insertion (RunObject) on "GLMapLines(Action 27)".


//         //     //Unsupported feature: Property Insertion (RunPageLink) on "GLMapLines(Action 27)".

//         // }
//         // modify(Constants)
//         // {

//         //     //Unsupported feature: Property Modification (Name) on "Constants(Action 34)".

//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Insertion (RunObject) on "Constants(Action 34)".


//         //     //Unsupported feature: Property Insertion (RunPageLink) on "Constants(Action 34)".

//         // }
//         // modify(CopyXBRLSetup)
//         // {

//         //     //Unsupported feature: Property Modification (Name) on "CopyXBRLSetup(Action 45)".

//         //     ApplicationArea = Basic;
//         // }

//         // //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 22)".

//         // modify(Information)
//         // {
//         //     Visible = false;
//         // }

//         // //Unsupported feature: Property Deletion (ToolTipML) on "Information(Action 24)".

//         // modify(Reference)
//         // {
//         //     Visible = false;
//         // }

//         // //Unsupported feature: Property Deletion (ToolTipML) on "Reference(Action 30)".

//         // modify(Rollups)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Rollups(Action 25)".

//         modify(Notes)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Notes(Action 26)".

//         modify(GLMapLines)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "GLMapLines(Action 27)".

//         modify(Constants)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Constants(Action 34)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "CopyXBRLSetup(Action 45)".

//     }

//     var
//         XBRLLine: Record "XBRL Taxonomy Line";

//     var
//         ActualExpansionStatus: Integer;


//     //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

//     //trigger (Variable: XBRLLine)()
//     //Parameters and return type have not been exported.
//     //begin
//         /*
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF Label = '' THEN
//           Label := Name;
//         LabelOnFormat;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF IsExpanded(Rec) THEN
//           ActualExpansionStatus := 1
//         ELSE
//           IF HasChildren(Rec) THEN
//             ActualExpansionStatus := 0
//           ELSE
//             ActualExpansionStatus := 2;

//         XBRLLine.GET("XBRL Taxonomy Name","Line No.");
//         IF ("Source Type" <> XBRLLine."Source Type") OR
//            ("Constant Amount" <> XBRLLine."Constant Amount") OR
//            (Description <> XBRLLine.Description)
//         THEN BEGIN
//           XBRLLine.CALCFIELDS(Label,Information,Rollup,"G/L Map Lines",Notes,Reference);
//           Rec := XBRLLine;
//           MODIFY;
//         END;

//         #1..3
//         */
//     //end;


//     //Unsupported feature: Code Insertion on "OnModifyRecord".

//     //trigger OnModifyRecord(): Boolean
//     //var
//         //XBRLLine: Record "XBRL Taxonomy Line";
//     //begin
//         /*
//         XBRLLine.GET("XBRL Taxonomy Name","Line No.");
//         XBRLLine := Rec;
//         XBRLLine.MODIFY;
//         Rec := XBRLLine;
//         MODIFY;
//         EXIT(FALSE);
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF GETFILTER("XBRL Taxonomy Name") <> '' THEN
//           CurrentTaxonomy := GETRANGEMIN("XBRL Taxonomy Name");
//         IF NOT XBRLTaxonomy.GET(CurrentTaxonomy) THEN
//         #4..15
//             IF XBRLTaxonomyLabel.FINDFIRST THEN
//               CurrentLang := XBRLTaxonomyLabel."XML Language Identifier"
//           END;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..18

//         ExpandAll;
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "SetCurrentSchema(PROCEDURE 2)".



//     //Unsupported feature: Code Modification on "SetCurrentSchema(PROCEDURE 2)".

//     //procedure SetCurrentSchema();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CurrentTaxonomy := NewCurrentTaxonomy;
//         ResetFilter;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CurrentTaxonomy := NewCurrentTaxonomy;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "ResetFilter(PROCEDURE 3)".

//     //procedure ResetFilter();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         RESET;
//         SETRANGE("XBRL Taxonomy Name",CurrentTaxonomy);
//         FILTERGROUP(0);
//         SetFilters;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         RESET;
//         SETCURRENTKEY("XBRL Taxonomy Name","Presentation Order");
//         FILTERGROUP(2);
//         #2..4
//         */
//     //end;


//     //Unsupported feature: Code Modification on "CurrentTaxonomyOnAfterValidate(PROCEDURE 19000234)".

//     //procedure CurrentTaxonomyOnAfterValidate();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         ResetFilter;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         FILTERGROUP(2);
//         SETRANGE("XBRL Taxonomy Name",CurrentTaxonomy);
//         FILTERGROUP(0);
//         SETRANGE("XBRL Taxonomy Name");
//         InitTempTable;
//         CurrPage.UPDATE(FALSE);
//         */
//     //end;


//     //Unsupported feature: Code Modification on "LabelOnFormat(PROCEDURE 19054229)".

//     //procedure LabelOnFormat();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         LabelEmphasize := Level = 0;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         LabelEmphasize := (Level = 0) OR (ActualExpansionStatus < 2);
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: XBRLLine) (VariableCollection) on "InitTempTable(PROCEDURE 4)".


//     //Unsupported feature: Property Modification (Name) on "OpenInformation(PROCEDURE 4)".



//     //Unsupported feature: Code Modification on "OpenInformation(PROCEDURE 4)".

//     //procedure OpenInformation();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         XBRLCommentLine.FILTERGROUP(2);
//         XBRLCommentLine.SETRANGE("XBRL Taxonomy Name","XBRL Taxonomy Name");
//         XBRLCommentLine.SETRANGE("XBRL Taxonomy Line No.","Line No.");
//         XBRLCommentLine.SETRANGE("Comment Type",XBRLCommentLine."Comment Type"::Information);
//         XBRLCommentLine.SETRANGE("Label Language Filter","Label Language Filter");
//         XBRLCommentLine.FILTERGROUP(0);

//         PAGE.RUNMODAL(PAGE::"XBRL Comment Lines",XBRLCommentLine);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         ResetFilter;
//         DELETEALL;
//         XBRLLine.SETRANGE("XBRL Taxonomy Name",CurrentTaxonomy);
//         XBRLLine.SETRANGE(Level,0);
//         IF XBRLLine.FIND('-') THEN
//           REPEAT
//             Rec := XBRLLine;
//             INSERT;
//           UNTIL XBRLLine.NEXT = 0;
//         */
//     //end;

//     //Unsupported feature: Variable Insertion (Variable: XBRLLine) (VariableCollection) on "ExpandAll(PROCEDURE 12)".


//     //Unsupported feature: Property Modification (Name) on "OpenGLMapLines(PROCEDURE 12)".



//     //Unsupported feature: Code Modification on "OpenGLMapLines(PROCEDURE 12)".

//     //procedure OpenGLMapLines();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         XBRLGLMapLine.FILTERGROUP(2);
//         XBRLGLMapLine.SETRANGE("XBRL Taxonomy Name","XBRL Taxonomy Name");
//         XBRLGLMapLine.SETRANGE("XBRL Taxonomy Line No.","Line No.");
//         XBRLGLMapLine.SETRANGE("Label Language Filter","Label Language Filter");
//         XBRLGLMapLine.FILTERGROUP(0);

//         PAGE.RUNMODAL(PAGE::"XBRL G/L Map Lines",XBRLGLMapLine);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         ResetFilter;
//         DELETEALL;
//         XBRLLine.SETRANGE("XBRL Taxonomy Name",CurrentTaxonomy);
//         IF XBRLLine.FIND('-') THEN
//           REPEAT
//             Rec := XBRLLine;
//             INSERT;
//           UNTIL XBRLLine.NEXT = 0;
//         */
//     //end;

//     local procedure HasChildren(ActualXBRLLine: Record "XBRL Taxonomy Line"): Boolean
//     var
//         XBRLLine2: Record "XBRL Taxonomy Line";
//     begin
//         XBRLLine2 := ActualXBRLLine;
//         XBRLLine2.SetCurrentkey("XBRL Taxonomy Name","Presentation Order");
//         XBRLLine2.SetRange("XBRL Taxonomy Name",ActualXBRLLine."XBRL Taxonomy Name");
//         if XBRLLine2.Next = 0 then
//           exit(false);

//         exit(XBRLLine2.Level > ActualXBRLLine.Level);
//     end;

//     local procedure IsExpanded(ActualXBRLLine: Record "XBRL Taxonomy Line"): Boolean
//     var
//         xXBRLLine: Record "XBRL Taxonomy Line";
//         Found: Boolean;
//     begin
//         xXBRLLine.Copy(Rec);
//         // ResetFilter;
//         Rec := ActualXBRLLine;
//         Found := (Rec.Next <> 0);
//         if Found then
//           Found := (Rec.Level > ActualXBRLLine.Level);
//         Rec.Copy(xXBRLLine);
//         exit(Found);
//     end;

//     //Unsupported feature: Deletion (VariableCollection) on "OpenInformation(PROCEDURE 4).XBRLCommentLine(Variable 1000)".


//     //Unsupported feature: Deletion (VariableCollection) on "OpenGLMapLines(PROCEDURE 12).XBRLGLMapLine(Variable 1000)".

// }
