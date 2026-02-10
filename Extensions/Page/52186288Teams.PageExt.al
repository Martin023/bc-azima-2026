#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186288 pageextension52186288 extends Teams 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Next Task Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Next Task Date"(Control 12)".


            //Unsupported feature: Property Modification (Name) on ""Next Task Date"(Control 12)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Code Insertion (VariableCollection) on ""Next To-do Date"(Control 12).OnDrillDown".

        //trigger (Variable: ToDo)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Next Task Date"(Control 12).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            Task.SETCURRENTKEY("Team Code",Date,Closed);
            Task.SETRANGE("Team Code",Code);
            Task.SETRANGE(Closed,FALSE);
            Task.SETRANGE("System To-do Type",Task."System To-do Type"::Team);
            IF Task.FINDFIRST THEN
              PAGE.RUN(0,Task);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ToDo.SETCURRENTKEY("Team Code",Date,Closed);
            ToDo.SETRANGE("Team Code",Code);
            ToDo.SETRANGE(Closed,FALSE);
            ToDo.SETRANGE("System To-do Type",ToDo."System To-do Type"::Team);
            IF ToDo.FINDFIRST THEN
              PAGE.RUN(0,ToDo);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Next Task Date"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Tasks)
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on "Tasks(Action 10)".

        }
        modify(Salespeople)
        {
            ApplicationArea = Basic;
        }
        modify("Team - Tasks")
        {
            Caption = 'Team To-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Team - Tasks"(Action 1900200106)".

        }
        modify("Salesperson - Tasks")
        {
            Caption = 'Salesperson - To-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Salesperson - Tasks"(Action 1901525906)".

        }
        modify("Salesperson - Opportunities")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Tasks(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Salespeople(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Team - Tasks"(Action 1900200106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson - Tasks"(Action 1901525906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson - Opportunities"(Action 1902318806)".

    }

    var
        ToDo: Record "To-do";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
