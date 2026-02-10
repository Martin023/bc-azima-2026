#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186154 pageextension52186154 extends "Service Connections" 
{

    //Unsupported feature: Property Insertion (PromotedActionCategoriesML) on ""Service Connections"(Page 1279)".

    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Name(Control 3)".


            //Unsupported feature: Property Modification (Name) on "Name(Control 3)".

        }
        modify("Host Name")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Insertion on "Description(Control 3)".

        //trigger OnDrillDown()
        //begin
            /*
            CallSetup;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Host Name"(Control 4)".


        //Unsupported feature: Property Deletion (Visible) on ""Host Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 10)".


        //Unsupported feature: Property Deletion (StyleExpr) on "Status(Control 10)".

        addafter(Status)
        {
            field(TestVar;TestVar)
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        modify(Setup)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Promoted) on "Setup(Action 5)".


            //Unsupported feature: Property Insertion (PromotedCategory) on "Setup(Action 5)".

        }

        //Unsupported feature: Property Deletion (ShortCutKey) on "Setup(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Setup(Action 5)".


        //Unsupported feature: Property Deletion (Scope) on "Setup(Action 5)".

    }

    var
        TestVar: Code[10];


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RefreshPressed := CurrRecordNo = "No.";
        IF RefreshPressed THEN
          Refresh
        ELSE
          CurrRecordNo := "No.";
        SetupActive := "Page ID" <> 0;
        SetStyle;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetupActive :=
          ("Page ID" <> 0);
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReloadServiceConnections;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        OnRegisterServiceConnection(Rec);
        */
    //end;


    //Unsupported feature: Code Modification on "CallSetup(PROCEDURE 1)".

    //procedure CallSetup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT SetupActive THEN
          EXIT;
        IF ((Status = Status::Error) OR (Status = Status::Disabled)) AND
           ("Assisted Setup Page ID" > 0) AND
           AssistedSetup.GET("Assisted Setup Page ID") AND
           (AssistedSetup.Status = AssistedSetup.Status::"Not Completed") AND
           AssistedSetup.Visible
        THEN
          AssistedSetup.Run
        ELSE BEGIN
          CurrentRecordId := "Record ID";
          IF CurrentRecordId = DummyRecordID THEN
            PAGE.RUNMODAL("Page ID")
          ELSE BEGIN
            RecordRef.GET("Record ID");
            RecordRefVariant := RecordRef;
            PAGE.RUNMODAL("Page ID",RecordRefVariant);
          END;
        END;
        ReloadServiceConnections;
        IF GET(xRec."No.") THEN;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF NOT SetupActive THEN
          EXIT;
        RecordRef.GET("Record ID");
        RecordRefVariant := RecordRef;
        PAGE.RUNMODAL("Page ID",RecordRefVariant);
        DELETE;
        OnRegisterServiceConnection(Rec);
        IF GET(xRec."No.") THEN;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "CallSetup(PROCEDURE 1).AssistedSetup(Variable 1004)".


    //Unsupported feature: Deletion (VariableCollection) on "CallSetup(PROCEDURE 1).DummyRecordID(Variable 1002)".


    //Unsupported feature: Deletion (VariableCollection) on "CallSetup(PROCEDURE 1).CurrentRecordId(Variable 1003)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (LinksAllowed).


    //Unsupported feature: Property Deletion (UsageCategory).

}
