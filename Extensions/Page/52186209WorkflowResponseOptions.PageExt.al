#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186209 pageextension52186209 extends "Workflow Response Options" 
{
    layout
    {
        modify(NoArguments)
        {
            ApplicationArea = Basic;
        }
        modify("General Journal Template Name")
        {
            ApplicationArea = Basic;
        }
        modify("General Journal Batch Name")
        {
            ApplicationArea = Basic;
        }
        modify("Link Target Page Approvals")
        {
            ApplicationArea = Basic;
        }
        modify("Custom Link Approvals")
        {
            ApplicationArea = Basic;
        }
        modify("Notification User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Link Target Page")
        {
            ApplicationArea = Basic;
        }
        modify("Custom Link")
        {
            ApplicationArea = Basic;
        }
        modify(MessageField)
        {
            ApplicationArea = Basic;
        }
        modify("Show Confirmation Message")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date Formula")
        {
            ApplicationArea = Basic;
        }
        modify("Delegate After")
        {
            ApplicationArea = Basic;
        }
        modify("Approver Type")
        {
            ApplicationArea = Basic;
        }
        modify("Approver Limit Type")
        {
            ApplicationArea = Basic;
        }
        modify("Workflow User Group Code")
        {
            ApplicationArea = Basic;
        }
        modify(ApprovalUserSetupLabel)
        {
            ApplicationArea = Basic;
        }
        modify(TableFieldRevert)
        {
            ApplicationArea = Basic;
        }
        modify(ApplyAllValues)
        {
            ApplicationArea = Basic;
        }
        modify(TableFieldApply)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""General Journal Template Name"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""General Journal Batch Name"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Link Target Page Approvals"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Custom Link Approvals"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Notification User ID"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Link Target Page"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Custom Link"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "MessageField(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Confirmation Message"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date Formula"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Delegate After"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approver Type"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approver Limit Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Workflow User Group Code"(Control 13)".

        modify(Control34)
        {
            Visible = false;
        }
        modify(ApproverId)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "TableFieldRevert(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ApplyAllValues(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TableFieldApply(Control 30)".

        modify(Control35)
        {
            Visible = false;
        }
        modify("Response Type")
        {
            Visible = false;
        }
        modify(Control37)
        {
            Visible = false;
        }
        modify(ResponseUserId)
        {
            Visible = false;
        }
    }

    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetVisibilityOptions;
        GetEventTable;
        CALCFIELDS("Field Caption");
        TableFieldCaption := "Field Caption";
        ApplyAllValues := ("Field No." = 0);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetVisibilityOptions;
        #3..5
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        NoArguments := NoArgumentsTxt;
        ApprovalUserSetupLabel := STRSUBSTNO(OpenPageTxt,ApprovalUserSetup.CAPTION);
        HideExternalUsers;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        NoArguments := NoArgumentsTxt;
        ApprovalUserSetupLabel := STRSUBSTNO(OpenPageTxt,ApprovalUserSetup.CAPTION);
        */
    //end;


    //Unsupported feature: Code Modification on "SetVisibilityOptions(PROCEDURE 2)".

    //procedure SetVisibilityOptions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Response Option Group");
        ShowApprovalLimitType := "Approver Type" <> "Approver Type"::"Workflow User Group";
        ShowApproverUserId := ShowApprovalLimitType AND ("Approver Limit Type" = "Approver Limit Type"::"Specific Approver");
        ShowResponseUserID := "Response Type" = "Response Type"::"User ID";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CALCFIELDS("Response Option Group");
        ShowApprovalLimitType := "Approver Type" <> "Approver Type"::"Workflow User Group";
        */
    //end;


    //Unsupported feature: Code Modification on "LookupFieldCaption(PROCEDURE 4)".

    //procedure LookupFieldCaption();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Field.FILTERGROUP(2);
        Field.SETFILTER(Type,STRSUBSTNO('%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11|%12',
            Field.Type::Boolean,
        #4..15

        Field.SETFILTER(TableNo,TableNoFilter);
        Field.SETFILTER("No.",FieldNoFilter);
        Field.SETFILTER(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);
        Field.TableNo := "Table No.";
        Field."No." := "Field No.";
        IF PAGE.RUNMODAL(PAGE::"Field List",Field) = ACTION::LookupOK THEN BEGIN
          "Table No." := Field.TableNo;
          EXIT(Field."Field Caption");
        END;
        EXIT('');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..18
        #20..26
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: WorkflowStep) (VariableCollection) on "LookupFieldCaptionForApplyNewValues(PROCEDURE 17)".



    //Unsupported feature: Code Modification on "LookupFieldCaptionForApplyNewValues(PROCEDURE 17)".

    //procedure LookupFieldCaptionForApplyNewValues();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WorkflowStepApply.SETRANGE(Argument,ID);
        IF WorkflowStepApply.FINDFIRST THEN BEGIN
          WorkflowStepRevert.SETRANGE("Workflow Code",WorkflowStepApply."Workflow Code");
          WorkflowStepRevert.SETRANGE("Function Name",WorkflowResponseHandling.RevertValueForFieldCode);

          IF WorkflowStepRevert.FINDSET THEN
            REPEAT
              WorkflowStepArgument.GET(WorkflowStepRevert.Argument);
              IF WorkflowStepArgument."Field No." <> 0 THEN BEGIN
                IF AddSeparator THEN
                  Separator := '|';
                AddSeparator := TRUE;
                FilterForTable += Separator + FORMAT(WorkflowStepArgument."Table No.");
                FilterForField += Separator + FORMAT(WorkflowStepArgument."Field No.");
              END;
            UNTIL WorkflowStepRevert.NEXT = 0;

          EXIT(LookupFieldCaption(FilterForTable,FilterForField));
        END;
        EXIT('');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WorkflowStep.SETRANGE(Argument,ID);
        IF WorkflowStep.FINDFIRST THEN BEGIN
          WorkflowStep.SETRANGE("Workflow Code",WorkflowStep."Workflow Code");
          WorkflowStep.SETRANGE("Function Name",WorkflowResponseHandling.RevertValueForFieldCode);

          IF WorkflowStep.FINDSET THEN
            REPEAT
              WorkflowStepArgument.GET(WorkflowStep.Argument);
        #9..15
            UNTIL WorkflowStep.NEXT = 0;
        #17..20
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "LookupFieldCaptionForApplyNewValues(PROCEDURE 17).WorkflowStepApply(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "LookupFieldCaptionForApplyNewValues(PROCEDURE 17).WorkflowStepRevert(Variable 1000)".

}
