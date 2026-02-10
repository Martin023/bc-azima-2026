#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185868 pageextension52185868 extends "IC Chart of Accounts" 
{
    Caption = 'IC Chart of Accounts';
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
        modify(Blocked)
        {
            ApplicationArea = Basic;
        }
        // modify("Map-to G/L Acc. No.")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Blocked(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Map-to G/L Acc. No."(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify("Map to Acc. with Same No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Copy from Chart of Accounts")
        {
            ApplicationArea = Basic;
        }
        modify("In&dent IC Chart of Accounts")
        {
            ApplicationArea = Basic;
        }
        modify(Import)
        {
            ApplicationArea = Basic;
        }
        modify("E&xport")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""Map to Acc. with Same No."(Action 18).OnAction".

        //trigger  with Same No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICGLAcc);
            IF ICGLAcc.FIND('-') AND ConfirmManagement.ConfirmProcess(Text000,TRUE) THEN
              REPEAT
                ICMapping.MapAccounts(ICGLAcc);
              UNTIL ICGLAcc.NEXT = 0;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(ICGLAcc);
            IF ICGLAcc.FIND('-') AND CONFIRM(Text000) THEN
            #3..5
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Map to Acc. with Same No."(Action 18)".


        //Unsupported feature: Property Deletion (Promoted) on ""Map to Acc. with Same No."(Action 18)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Map to Acc. with Same No."(Action 18)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Map to Acc. with Same No."(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy from Chart of Accounts"(Action 23)".


        //Unsupported feature: Property Deletion (Promoted) on ""Copy from Chart of Accounts"(Action 23)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Copy from Chart of Accounts"(Action 23)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Copy from Chart of Accounts"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In&dent IC Chart of Accounts"(Action 20)".


        //Unsupported feature: Property Deletion (Promoted) on ""In&dent IC Chart of Accounts"(Action 20)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""In&dent IC Chart of Accounts"(Action 20)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""In&dent IC Chart of Accounts"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Import(Action 17)".


        //Unsupported feature: Property Deletion (Promoted) on "Import(Action 17)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Import(Action 17)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Import(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xport"(Action 22)".


        //Unsupported feature: Property Deletion (Promoted) on ""E&xport"(Action 22)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""E&xport"(Action 22)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""E&xport"(Action 22)".

        addfirst(navigation)
        {
            group("IC A&ccount")
            {
                Caption = 'IC A&ccount';
                Image = Intercompany;
            }
            action("&Card")
            {
                ApplicationArea = Basic;
                Caption = '&Card';
                Image = EditLines;
                RunObject = Page "IC G/L Account Card";
                RunPageLink = "No."=field("No.");
                ShortCutKey = 'Shift+F7';
            }
        }
    }


    //Unsupported feature: Code Modification on "CopyFromChartOfAccounts(PROCEDURE 1)".

    //procedure CopyFromChartOfAccounts();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT ConfirmManagement.ConfirmProcess(STRSUBSTNO(Text004,ChartofAcc.CAPTION),TRUE) THEN
          EXIT;

        ICGLAccEmpty := NOT ICGLAcc.FINDFIRST;
        #5..14
              ICGLAcc.Name := GLAcc.Name;
              ICGLAcc."Account Type" := GLAcc."Account Type";
              ICGLAcc."Income/Balance" := GLAcc."Income/Balance";
              ICGLAcc.VALIDATE(Indentation,PrevIndentation);
              ICGLAcc.INSERT;
            END;
            PrevIndentation := GLAcc.Indentation;
            IF GLAcc."Account Type" = GLAcc."Account Type"::"Begin-Total" THEN
              PrevIndentation := PrevIndentation + 1;
          UNTIL GLAcc.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT CONFIRM(Text004,FALSE,ChartofAcc.CAPTION) THEN
        #2..17
              ICGLAcc.Indentation := PrevIndentation;
        #19..24
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CopyFromChartOfAccounts(PROCEDURE 1).ConfirmManagement(Variable 1006)".


    //Unsupported feature: Property Modification (Id) on "ImportFromXML(PROCEDURE 2).ICGLAccIO(Variable 1002)".


    //Unsupported feature: Property Modification (Id) on "ImportFromXML(PROCEDURE 2).IFile(Variable 1000)".


    //Unsupported feature: Move on "ImportFromXML(PROCEDURE 2).FileName(Variable 1004)".


    //Unsupported feature: Move on "ExportToXML(PROCEDURE 3).FileName(Variable 1004)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (CardPageID).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
