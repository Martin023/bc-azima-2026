#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186213 pageextension52186213 extends "Workflow Status FactBox" 
{

    //Unsupported feature: Property Modification (Name) on ""Workflow Status FactBox"(Page 1528)".

    layout
    {
        modify(WorkflowDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "WorkflowDescription(Control 1)".

    }

    //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //begin
        /*
        IF Workflow.GET("Workflow Code") THEN
          WorkflowDescription := Workflow.Description;
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SelectionFilterManagement) (VariableCollection) on "SetFilterOnWorkflowRecord(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: Filter) (VariableCollection) on "SetFilterOnWorkflowRecord(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetFilterOnWorkflowRecord(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetFilterOnWorkflowRecord(PROCEDURE 1)".

    //procedure SetFilterOnWorkflowRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        DELETEALL;
        WorkflowStepInstance.SETRANGE("Record ID",WorkflowStepRecID);
        IF NOT WorkflowStepInstance.FINDSET THEN
          EXIT(FALSE);

        REPEAT
          IF WorkflowStepInstance.ID <> InstanceID THEN BEGIN
            Rec := WorkflowStepInstance;
            INSERT;
          END;
          InstanceID := WorkflowStepInstance.ID;
        UNTIL WorkflowStepInstance.NEXT = 0;
        EXIT(NOT ISEMPTY);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #2..6
          IF WorkflowStepInstance.ID <> InstanceID THEN
            WorkflowStepInstance.MARK(TRUE);
          InstanceID := WorkflowStepInstance.ID;
        UNTIL WorkflowStepInstance.NEXT = 0;

        WorkflowStepInstance.MARKEDONLY(TRUE);
        Filter := SelectionFilterManagement.GetSelectionFilterForWorkflowStepInstance(WorkflowStepInstance);
        IF Filter = '' THEN
          EXIT(FALSE);

        RESET;
        SETRANGE("Record ID",WorkflowStepRecID);
        SETFILTER("Original Workflow Step ID",Filter);
        CurrPage.UPDATE(FALSE);
        EXIT(FINDSET);
        */
    //end;

    //Unsupported feature: Property Deletion (SourceTableTemporary).

}
