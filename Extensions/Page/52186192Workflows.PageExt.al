#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186192 pageextension52186192 extends Workflows 
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on "Workflows(Page 1500)".

    layout
    {
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Category Code")
        {
            ApplicationArea = Basic;
        }
        modify("Workflow Code")
        {
            ApplicationArea = Basic;
        }
        modify(Enabled)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 11)".
  
        //Unsupported feature: Property Deletion (ToolTipML) on ""Category Code"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Workflow Code"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Enabled(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control7(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control8(Control 8)".

    }
    actions
    {
        modify(NewAction)
        {
            ApplicationArea = Basic;
        }
        modify(CopyFromTemplate)
        {
            ApplicationArea = Basic;
        }
        modify(CopyWorkflow)
        {
            ApplicationArea = Basic;
        }
        modify(EditAction)
        {
            ApplicationArea = Basic;
        }
        modify(ViewAction)
        {
            ApplicationArea = Basic;
        }
        modify(DeleteAction)
        {
            ApplicationArea = Basic;
        }
        modify(ImportWorkflow)
        {
            ApplicationArea = Basic;
        }
        modify(ExportWorkflow)
        {
            ApplicationArea = Basic;
        }
        modify(ViewTemplates)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "NewAction(Action 17)".


        //Unsupported feature: Code Modification on "CopyFromTemplate(Action 18).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ISEMPTY THEN BEGIN
              CLEAR(Rec);
              INSERT;
            END;
            IF PAGE.RUNMODAL(PAGE::"Workflow Templates",TempWorkflowBuffer) = ACTION::LookupOK THEN BEGIN
              CopyWorkflow(TempWorkflowBuffer);

              // If first workflow on an empty page
              IF COUNT = 1 THEN
                Rec := TempWorkflowBuffer;

              RefreshTempWorkflowBuffer;
            END;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..4
            IF PAGE.RUNMODAL(PAGE::"Workflow Templates",TempWorkflowBuffer) = ACTION::LookupOK THEN
              CopyWorkflow(TempWorkflowBuffer);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CopyFromTemplate(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CopyWorkflow(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EditAction(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ViewAction(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DeleteAction(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ImportWorkflow(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ExportWorkflow(Action 21)".

        modify(Flow)
        {
            Visible = false;
        }
        modify(WebhookClientLink)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ViewTemplates(Action 16)".

    }


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RefreshTempWorkflowBufferRow;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        RefreshTempWorkflowBuffer
        */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RefreshTempWorkflowBuffer;
        ExportEnabled := NOT ISEMPTY;

        IF "Workflow Code" = '' THEN BEGIN
          DescriptionStyle := 'Strong';
          ExternalLinkEnabled := FALSE;
        END ELSE BEGIN
          DescriptionStyle := 'Standard';

          // Enable/disable external links
          CALCFIELDS("External Client ID");
          ExternalLinkEnabled := NOT ISNULLGUID("External Client ID");
        END
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        RefreshTempWorkflowBuffer;
        ExportEnabled := NOT ISEMPTY;
        IF "Workflow Code" = '' THEN
          DescriptionStyle := 'Strong'
        ELSE
          DescriptionStyle := 'Standard';
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WorkflowSetup.InitWorkflow;
        IF NOT WorkflowBufferInitialized THEN
          InitBufferForWorkflows(Rec);

        IsSaaS := PermissionManager.SoftwareAsAService;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WorkflowSetup.InitWorkflow;
        InitBufferForWorkflows(Rec)
        */
    //end;


    //Unsupported feature: Code Modification on "RefreshTempWorkflowBuffer(PROCEDURE 1)".

    //procedure RefreshTempWorkflowBuffer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WorkflowCode := "Workflow Code";
        IF Workflow.GET(WorkflowCode) THEN
          CurrentWorkflowChanged := ("Category Code" <> Workflow.Category) OR (Description <> Workflow.Description)
        ELSE
          CurrentWorkflowChanged := WorkflowCode <> '';

        Workflow.SETRANGE(Template,FALSE);

        #9..14

        IF CurrentWorkflowChanged OR WorkflowCountChanged THEN BEGIN
          InitBufferForWorkflows(Rec);
          Refresh := TRUE;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF Workflow.GET("Workflow Code") THEN
          CurrentWorkflowChanged := ("Category Code" <> Workflow.Category) OR (Description <> Workflow.Description);
        #6..17
          CurrPage.UPDATE(FALSE);
          IF FINDFIRST THEN;
        END;
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "RefreshTempWorkflowBuffer(PROCEDURE 1).WorkflowCode(Variable 1004)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
