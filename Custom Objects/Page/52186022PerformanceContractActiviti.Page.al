page 52186022 "Performance Contract Activiti"
{
    Editable = true;
    PageType = List;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            // repeater(Group)
            // {
            //     IndentationColumn = NameIndent;
            //     IndentationControls = Control20, Control15;
            //     ShowAsTree = false;
            // }
        }
        area(factboxes)
        {
            systempart(Control2; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = false;
                action(IndentWorkPlan)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Indent Workplan Activities';
                    Image = IndentChartOfAccounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Workplan Indent";
                }
                action("Import Workplan Activities")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ////RunObject = XMLport WorkPlan;
                }
            }
        }
    }

    var

        NoEmphasize: Boolean;

        NameEmphasize: Boolean;

        NameIndent: Integer;
        Text0001: Label 'Convert to Workplan Activity [ %1-%2 ]to a Workplan Budget Entry?';
        Text0002: Label 'Workplan Budget Entry created for Workplan Activity [ %1-%2 ]';

    //[Scope('OnPrem')]
    procedure UpdateControls()
    begin
        /*
        IF (Type = Type::"Begin-Total") OR (Type = Type::"End-Total") THEN
        BEGIN
            FieldEditable:=FALSE;
        END ELSE
        BEGIN
            FieldEditable:=TRUE;
        END;
        */

        //For Bold and Indentation
        // NoEmphasize := "Account Type" <> "Account Type"::"0";
        // NameIndent := Indentation;
        // NameEmphasize := "Account Type" <> "Account Type"::"0";

    end;
}

