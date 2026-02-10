#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185886 pageextension52185886 extends "Chart of Accounts Overview" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Income/Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Net Change")
        {
            ApplicationArea = Basic;
        }
        modify("Balance at Date")
        {
            ApplicationArea = Basic;
        }
        modify(Balance)
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Net Change")
        {
            ApplicationArea = Basic;
        }
        modify("Add.-Currency Balance at Date")
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Budgeted Amount")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance at Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Balance(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional-Currency Net Change"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Add.-Currency Balance at Date"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional-Currency Balance"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted Amount"(Control 21)".

    }
    var
        ActualExpansionStatus: Integer;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        NameIndent := 0;
        FormatLine;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        NameIndent := 0;
        IF IsExpanded(Rec) THEN
          ActualExpansionStatus := 1
        ELSE
          IF HasChildren(Rec) THEN
            ActualExpansionStatus := 0
          ELSE
            ActualExpansionStatus := 2;
        FormatLine;
        */
    //end;

    local procedure HasChildren(ActualGLAcc: Record "G/L Account"): Boolean
    var
        GLAcc2: Record "G/L Account";
    begin
        GLAcc2 := ActualGLAcc;
        if GLAcc2.Next = 0 then
          exit(false);

        exit(GLAcc2.Indentation > ActualGLAcc.Indentation);
    end;

    local procedure IsExpanded(ActualGLAcc: Record "G/L Account"): Boolean
    var
        xGLAcc: Record "G/L Account";
        Found: Boolean;
    begin
        xGLAcc := Rec;
        Rec := ActualGLAcc;
        Found := (Rec.Next <> 0);
        if Found then
          Found := (Rec.Indentation > ActualGLAcc.Indentation);
        Rec := xGLAcc;
        exit(Found);
    end;
}
