#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185490 pageextension52185490 extends "Account Schedule" 
{

    //Unsupported feature: Property Insertion (DeleteAllowed) on ""Account Schedule"(Page 104)".

    layout
    {
        modify(CurrentSchedName)
        {
            ApplicationArea = Basic;
        }
        modify("Row No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Totaling Type")
        {
            ApplicationArea = Basic;
        }
        modify(Totaling)
        {
            ApplicationArea = Basic;
        }
        modify("Row Type")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Type")
        {
            ApplicationArea = Basic;
        }
        modify("Show Opposite Sign")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Show Opposite Sign"(Control 31)".

        }
        modify("Dimension 1 Totaling")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension 2 Totaling")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension 3 Totaling")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension 4 Totaling")
        {
            ApplicationArea = Basic;
        }
        modify(Show)
        {
            ApplicationArea = Basic;
        }
        modify(Bold)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Bold(Control 20)".

        }
        modify(Italic)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Italic(Control 25)".

        }
        modify(Underline)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on "Underline(Control 28)".

        }
        modify("Double Underline")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Double Underline"(Control 9)".

        }
        modify("New Page")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "CurrentSchedName(Control 18).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            AccSchedManagement.CheckName(CurrentSchedName);
            CurrentSchedNameOnAfterValidate;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            AccSchedManagement.CheckName(CurrentSchedName);
            CurrentSchedNameOnAfterValidat;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentSchedName(Control 18)".


        //Unsupported feature: Property Deletion (IndentationColumnName) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (IndentationControls) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Row No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (Style) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Totaling Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Totaling(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Row Type"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Type"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Opposite Sign"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 1 Totaling"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 2 Totaling"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 3 Totaling"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension 4 Totaling"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Show(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Bold(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Italic(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Underline(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Double Underline"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Page"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Amount Type";"Dimension 1 Totaling")
    }
    actions
    {
        // modify(Overview)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Overview(Action 29)".

        //     ApplicationArea = Basic;
        // }
        modify(InsertGLAccounts)
        {
            ApplicationArea = Basic;
        }
        modify(InsertCFAccounts)
        {
            ApplicationArea = Basic;
        }
        modify(InsertCostTypes)
        {
            ApplicationArea = Basic;
        }
        // modify(EditColumnLayoutSetup)
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Print)
        // {

        //     //Unsupported feature: Property Modification (Name) on "Print(Action 22)".

        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Overview(Action 29)".

        modify(Indent)
        {
            Visible = false;
        }
        modify(Outdent)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "InsertGLAccounts(Action 7)".


        //Unsupported feature: Property Deletion (Promoted) on "InsertGLAccounts(Action 7)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "InsertGLAccounts(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "InsertCFAccounts(Action 5)".


        //Unsupported feature: Property Deletion (Promoted) on "InsertCFAccounts(Action 5)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "InsertCFAccounts(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "InsertCostTypes(Action 3)".


        //Unsupported feature: Property Deletion (Promoted) on "InsertCostTypes(Action 3)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "InsertCostTypes(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EditColumnLayoutSetup(Action 24)".


        //Unsupported feature: Property Deletion (Promoted) on "EditColumnLayoutSetup(Action 24)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "EditColumnLayoutSetup(Action 24)".

        // modify(Reports)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Insertion (VariableCollection) on ""&Print"(Action 22).OnAction".

        //trigger (Variable: AccSchedName)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "Print(Action 22).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            AccScheduleName.GET("Schedule Name");
            AccScheduleName.Print;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            AccSchedName.GET("Schedule Name");
            AccSched.SetAccSchedName(AccSchedName.Name);
            AccSched.SetColumnLayoutName(AccSchedName."Default Column Layout");
            AccSched.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 22)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Print(Action 22)".

        addfirst(Navigation)
        {
            group("&Acc. Sched.")
            {
                Caption = '&Acc. Sched.';
                Image = ViewDetails;
            }
        }
    }

    var
        AccSchedName: Record "Acc. Schedule Name";
        AccSched: Report "Account Schedule";

    var
        AfterxRec: Boolean;


    //Unsupported feature: Code Insertion on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //begin
        /*
        AfterxRec := BelowxRec;
        */
    //end;


    //Unsupported feature: Code Insertion on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //begin
        /*
        AfterxRec := BelowxRec;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        OriginalSchedName := CurrentSchedName;
        AccSchedManagement.OpenAndCheckSchedule(CurrentSchedName,Rec);
        IF CurrentSchedName <> OriginalSchedName THEN
          CurrentSchedNameOnAfterValidate;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        AccSchedManagement.OpenSchedule(CurrentSchedName,Rec);
        AfterxRec := FALSE;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetAccSchedName(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetupAccSchedLine(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "SetupAccSchedLine(PROCEDURE 3)".

    //procedure SetupAccSchedLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        AccSchedLine := Rec;
        IF "Line No." = 0 THEN BEGIN
          AccSchedLine := xRec;
          AccSchedLine.SETRANGE("Schedule Name",CurrentSchedName);
          IF AccSchedLine.NEXT = 0 THEN
            AccSchedLine."Line No." := xRec."Line No." + 10000
          ELSE BEGIN
            IF AccSchedLine.FINDLAST THEN
              AccSchedLine."Line No." += 10000;
            AccSchedLine.SETRANGE("Schedule Name");
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        #5..7
            AccSchedLine.SETRANGE("Schedule Name",AccSchedLine."Schedule Name");
        #8..12
        */
    //end;

    local procedure CurrentSchedNameOnAfterValidat()
    begin
        CurrPage.SaveRecord;
        // AccSchedManagement.SetName(CurrentSchedName,Rec);
        CurrPage.Update(false);
    end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
