#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186276 pageextension52186276 extends Segment
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify(Date)
        {
            ApplicationArea = Basic;
        }
        modify("No. of Lines")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Criteria Actions")
        {
            ApplicationArea = Basic;
        }
        modify("Interaction Template Code")
        {
            ApplicationArea = Basic;
        }
        modify("Language Code (Default)")
        {
            ApplicationArea = Basic;
            Enabled = "Language Code (Default)Enable";
        }
        modify("Subject (Default)")
        {
            ApplicationArea = Basic;
            Enabled = "Subject (Default)Enable";
        }
        modify(Attachment)
        {
            ApplicationArea = Basic;
        }
        modify("Ignore Contact Corres. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Correspondence Type (Default)")
        {
            ApplicationArea = Basic;
        }
        modify("Information Flow")
        {
            ApplicationArea = Basic;
            Enabled = "Information FlowEnable";
        }
        modify("Initiated By")
        {
            ApplicationArea = Basic;
            Enabled = "Initiated ByEnable";
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
            Enabled = "Unit Cost (LCY)Enable";
        }
        modify("Unit Duration (Min.)")
        {
            ApplicationArea = Basic;
            Enabled = "Unit Duration (Min.)Enable";
        }
        modify("Send Word Docs. as Attmt.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Description")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Target")
        {
            ApplicationArea = Basic;
            Enabled = "Campaign TargetEnable";
        }
        modify("Campaign Response")
        {
            ApplicationArea = Basic;
            Enabled = "Campaign ResponseEnable";
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (Importance) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Date(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Lines"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Criteria Actions"(Control 52)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SegLines(Control 21)".


        //Unsupported feature: Property Deletion (PartType) on "SegLines(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Template Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Language Code (Default)"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Subject (Default)"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Attachment(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ignore Contact Corres. Type"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Correspondence Type (Default)"(Control 57)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Information Flow"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Initiated By"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Duration (Min.)"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Send Word Docs. as Attmt."(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Description"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Target"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Response"(Control 43)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Criteria)
        {
            ApplicationArea = Basic;
        }
        modify("Oppo&rtunities")
        {
            ApplicationArea = Basic;
        }
        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 27)".

        }
        modify(LogSegment)
        {

            //Unsupported feature: Property Modification (Name) on "LogSegment(Action 25)".

            ApplicationArea = Basic;
        }
        modify(AddContacts)
        {
            ApplicationArea = Basic;
        }
        modify(ReduceContacts)
        {
            ApplicationArea = Basic;
        }
        modify(RefineContacts)
        {
            ApplicationArea = Basic;
        }
        modify("Go Back")
        {
            ApplicationArea = Basic;
        }
        modify(ReuseCriteria)
        {
            ApplicationArea = Basic;
        }
        modify("Reuse Segment")
        {
            ApplicationArea = Basic;
        }
        modify(SaveCriteria)
        {
            ApplicationArea = Basic;
        }
        modify(Open)
        {
            ApplicationArea = Basic;
        }
        modify(Create)
        {
            ApplicationArea = Basic;
        }
        modify(Import)
        {
            ApplicationArea = Basic;
        }
        modify(Export)
        {
            ApplicationArea = Basic;
        }
        modify(Remove)
        {
            ApplicationArea = Basic;
        }
        modify(ExportContacts)
        {

            //Unsupported feature: Property Modification (Name) on "ExportContacts(Action 34)".

            Caption = 'E&xport File';
            ApplicationArea = Basic;
        }
        modify("Apply &Mailing Group")
        {
            ApplicationArea = Basic;
        }
        modify(CoverSheet)
        {

            //Unsupported feature: Property Modification (Name) on "CoverSheet(Action 37)".

            ApplicationArea = Basic;
        }
        modify("Print &Labels")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Criteria(Action 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Oppo&rtunities"(Action 69)".

        modify("Create opportunity")
        {
            Visible = false;
        }
        modify("Create opportunities")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LogSegment(Action 25)".


        //Unsupported feature: Code Insertion (VariableCollection) on "AddContacts(Action 29).OnAction".

        //trigger (Variable: AddContacts)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "AddContacts(Action 29).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        REPORT.RUNMODAL(REPORT::"Add Contacts",TRUE,FALSE,SegHeader);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        AddContacts.SETTABLEVIEW(SegHeader);
        AddContacts.SETTABLEVIEW(Cont);
        AddContacts.SETTABLEVIEW(ContProfileAnswer);
        AddContacts.SETTABLEVIEW(ContMailingGrp);
        AddContacts.SETTABLEVIEW(InteractLogEntry);
        AddContacts.SETTABLEVIEW(ContJobResp);
        AddContacts.SETTABLEVIEW(ContIndustGrp);
        AddContacts.SETTABLEVIEW(ContBusRel);
        AddContacts.SETTABLEVIEW(ValueEntry);
        AddContacts.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "AddContacts(Action 29)".



        //Unsupported feature: Code Insertion (VariableCollection) on "ReduceContacts(Action 30).OnAction".

        //trigger (Variable: ReduceContacts)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "ReduceContacts(Action 30).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        REPORT.RUNMODAL(REPORT::"Remove Contacts - Reduce",TRUE,FALSE,SegHeader);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        ReduceContacts.SETTABLEVIEW(SegHeader);
        ReduceContacts.SETTABLEVIEW(Cont);
        ReduceContacts.SETTABLEVIEW(ContProfileAnswer);
        ReduceContacts.SETTABLEVIEW(ContMailingGrp);
        ReduceContacts.SETTABLEVIEW(InteractLogEntry);
        ReduceContacts.SETTABLEVIEW(ContJobResp);
        ReduceContacts.SETTABLEVIEW(ContIndustGrp);
        ReduceContacts.SETTABLEVIEW(ContBusRel);
        ReduceContacts.SETTABLEVIEW(ValueEntry);
        ReduceContacts.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ReduceContacts(Action 30)".



        //Unsupported feature: Code Insertion (VariableCollection) on "RefineContacts(Action 31).OnAction".

        //trigger (Variable: RefineContacts)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "RefineContacts(Action 31).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        REPORT.RUNMODAL(REPORT::"Remove Contacts - Refine",TRUE,FALSE,SegHeader);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        RefineContacts.SETTABLEVIEW(SegHeader);
        RefineContacts.SETTABLEVIEW(Cont);
        RefineContacts.SETTABLEVIEW(ContProfileAnswer);
        RefineContacts.SETTABLEVIEW(ContMailingGrp);
        RefineContacts.SETTABLEVIEW(InteractLogEntry);
        RefineContacts.SETTABLEVIEW(ContJobResp);
        RefineContacts.SETTABLEVIEW(ContIndustGrp);
        RefineContacts.SETTABLEVIEW(ContBusRel);
        RefineContacts.SETTABLEVIEW(ValueEntry);
        RefineContacts.RUNMODAL;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "RefineContacts(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Go Back"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReuseCriteria(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reuse Segment"(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SaveCriteria(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Open(Action 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Create(Action 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Import(Action 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Remove(Action 65)".



        //Unsupported feature: Code Modification on "ExportContacts(Action 34).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SegLineLocal.SETRANGE("Segment No.","No.");
        IF PermissionManager.SoftwareAsAService THEN
          SegLineLocal.ExportODataFields
        ELSE
          XMLPORT.RUN(XMLPORT::"Export Segment Contact",FALSE,FALSE,SegLineLocal);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SegLineLocal.SETRANGE("Segment No.","No.");
        XMLPORT.RUN(XMLPORT::"Export Segment Contact",FALSE,FALSE,SegLineLocal);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportContacts(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Apply &Mailing Group"(Action 35)".



        //Unsupported feature: Code Modification on "CoverSheet(Action 37).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        ContactCoverSheet.SetRunFromSegment;
        ContactCoverSheet.SETTABLEVIEW(SegHeader);
        ContactCoverSheet.RUNMODAL;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SegHeader := Rec;
        SegHeader.SETRECFILTER;
        REPORT.RUN(REPORT::"Segment - Cover Sheet",TRUE,FALSE,SegHeader);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CoverSheet(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print &Labels"(Action 38)".

    }

    var
        AddContacts: Report "Add Contacts";
        Cont: Record Contact;
        ContProfileAnswer: Record "Contact Profile Answer";
        ContMailingGrp: Record "Contact Mailing Group";
        InteractLogEntry: Record "Interaction Log Entry";
        ContJobResp: Record "Contact Job Responsibility";
        ContIndustGrp: Record "Contact Industry Group";
        ContBusRel: Record "Contact Business Relation";
        ValueEntry: Record "Value Entry";

    var
        ReduceContacts: Report "Remove Contacts - Reduce";



    var
        RefineContacts: Report "Remove Contacts - Refine";


    var

        "Campaign TargetEnable": Boolean;

        "Campaign ResponseEnable": Boolean;

    var

        "Subject (Default)Enable": Boolean;

        "Language Code (Default)Enable": Boolean;

    var

        "Information FlowEnable": Boolean;

        "Initiated ByEnable": Boolean;

        "Unit Cost (LCY)Enable": Boolean;

        "Unit Duration (Min.)Enable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UnitDurationMinEnable := TRUE;
    UnitCostLCYEnable := TRUE;
    InitiatedByEnable := TRUE;
    InformationFlowEnable := TRUE;
    IgnoreContactCorresTypeEnable := TRUE;
    AttachmentEnable := TRUE;
    LanguageCodeDefaultEnable := TRUE;
    SubjectDefaultEnable := TRUE;
    CorrespondenceTypeDefaultEnabl := TRUE;
    CampaignResponseEnable := TRUE;
    CampaignTargetEnable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Unit Duration (Min.)Enable" := TRUE;
    "Unit Cost (LCY)Enable" := TRUE;
    "Initiated ByEnable" := TRUE;
    "Information FlowEnable" := TRUE;
    IgnoreContactCorresTypeEnable := TRUE;
    AttachmentEnable := TRUE;
    "Language Code (Default)Enable" := TRUE;
    "Subject (Default)Enable" := TRUE;
    CorrespondenceTypeDefaultEnabl := TRUE;
    "Campaign ResponseEnable" := TRUE;
    "Campaign TargetEnable" := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateEditable(PROCEDURE 4)".

    //procedure UpdateEditable();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CampaignTargetEnable := "Campaign No." <> '';
    CampaignResponseEnable := "Campaign No." <> '';
    CorrespondenceTypeDefaultEnabl := "Ignore Contact Corres. Type" = TRUE;
    LanguageCodeDefaultEnable := "Interaction Template Code" <> '';
    SubjectDefaultEnable := SegInteractLanguage.GET("No.",0,"Language Code (Default)");
    AttachmentEnable := "Interaction Template Code" <> '';
    IgnoreContactCorresTypeEnable := "Interaction Template Code" <> '';
    InformationFlowEnable := "Interaction Template Code" <> '';
    InitiatedByEnable := "Interaction Template Code" <> '';
    UnitCostLCYEnable := "Interaction Template Code" <> '';
    UnitDurationMinEnable := "Interaction Template Code" <> '';
    LanguageCodeDefaultEnable := "Interaction Template Code" <> '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Campaign TargetEnable" := "Campaign No." <> '';
    "Campaign ResponseEnable" := "Campaign No." <> '';
    CorrespondenceTypeDefaultEnabl := "Ignore Contact Corres. Type" = TRUE;
    "Language Code (Default)Enable" := "Interaction Template Code" <> '';
    "Subject (Default)Enable" := SegInteractLanguage.GET("No.",0,"Language Code (Default)");
    AttachmentEnable := "Interaction Template Code" <> '';
    IgnoreContactCorresTypeEnable := "Interaction Template Code" <> '';
    "Information FlowEnable" := "Interaction Template Code" <> '';
    "Initiated ByEnable" := "Interaction Template Code" <> '';
    "Unit Cost (LCY)Enable" := "Interaction Template Code" <> '';
    "Unit Duration (Min.)Enable" := "Interaction Template Code" <> '';
    "Language Code (Default)Enable" := "Interaction Template Code" <> '';
    */
    //end;


    //Unsupported feature: Code Modification on "CampaignNoOnAfterValidate(PROCEDURE 19036822)".

    //procedure CampaignNoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Campaign No." = '' THEN BEGIN
      "Campaign Target" := FALSE;
      "Campaign Response" := FALSE;
    END;

    CALCFIELDS("Campaign Description");
    CampaignTargetEnable := "Campaign No." <> '';
    CampaignResponseEnable := "Campaign No." <> '';
    CurrPage.SegLines.PAGE.UpdateForm;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    "Campaign TargetEnable" := "Campaign No." <> '';
    "Campaign ResponseEnable" := "Campaign No." <> '';
    CurrPage.SegLines.PAGE.UpdateForm;
    */
    //end;
}
