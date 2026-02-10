#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187192 pageextension52187192 extends "Report Layout Selection" 
{
    layout
    {
        modify(SelectedCompany)
        {
            ApplicationArea = Basic;
        }
        modify("Report ID")
        {
            ApplicationArea = Basic;
        }
        modify("Report Name")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Custom Report Layout Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Custom Report Layout Code"(Control 13)".


            //Unsupported feature: Property Modification (Name) on ""Custom Report Layout Code"(Control 13)".

        }
        modify(CustomLayoutDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "SelectedCompany(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report ID"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Code Modification on ""Custom Report Layout Code"(Control 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ReportLayoutSelection.VALIDATE("Custom Report Layout Code",ReportLayoutSelection."Custom Report Layout Code");
            UpdateRec;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ReportLayoutSelection.VALIDATE("Custom Report Layout ID",ReportLayoutSelection."Custom Report Layout ID");
            UpdateRec;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Custom Report Layout Code"(Control 13)".



        //Unsupported feature: Code Modification on "CustomLayoutDescription(Control 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CustomReportLayout2.SETCURRENTKEY("Report ID","Company Name",Type);
            CustomReportLayout2.SETRANGE("Report ID",ReportLayoutSelection."Report ID");
            CustomReportLayout2.SETFILTER("Company Name",'%1|%2','',SelectedCompany);
            CustomReportLayout2.SETFILTER(
              Description,STRSUBSTNO('@*%1*',CustomLayoutDescription));
            IF NOT CustomReportLayout2.FINDFIRST THEN
              ERROR(CouldNotFindCustomReportLayoutErr,CustomLayoutDescription);

            IF CustomReportLayout2.Code <> "Custom Report Layout Code" THEN BEGIN
              VALIDATE("Custom Report Layout Code",CustomReportLayout2.Code);
              UpdateRec;
            END;
            CurrPage.UPDATE(FALSE);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..5
            CustomReportLayout2.FINDFIRST;
            IF CustomReportLayout2.ID <> "Custom Report Layout ID" THEN BEGIN
              VALIDATE("Custom Report Layout ID",CustomReportLayout2.ID);
            #11..13
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CustomLayoutDescription(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control7(Control 7)".

    }
    actions
    {
        modify(Customizations)
        {
            ApplicationArea = Basic;
        }
        modify(RunReport)
        {
            ApplicationArea = Basic;
        }
        modify(BulkUpdate)
        {
            ApplicationArea = Basic;
        }
        modify(TestUpdate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Customizations(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RunReport(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BulkUpdate(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestUpdate(Action 16)".

    }


    //Unsupported feature: Code Modification on "UpdateRec(PROCEDURE 18)".

    //procedure UpdateRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF ReportLayoutSelection.GET("Report ID",SelectedCompany) THEN BEGIN
          ReportLayoutSelection := Rec;
          ReportLayoutSelection."Report Name" := '';
          ReportLayoutSelection."Company Name" := SelectedCompany;
          OnUpdateRecOnBeforeModify(ReportLayoutSelection,Rec,SelectedCompany);
          ReportLayoutSelection.MODIFY;
        END ELSE BEGIN
          CLEAR(ReportLayoutSelection);
          ReportLayoutSelection := Rec;
          ReportLayoutSelection."Report Name" := '';
          ReportLayoutSelection."Company Name" := SelectedCompany;
          OnUpdateRecOnBeforeInsert(ReportLayoutSelection,Rec,SelectedCompany);
          ReportLayoutSelection.INSERT(TRUE);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ReportLayoutSelection.GET("Report ID",SelectedCompany) THEN BEGIN
          ReportLayoutSelection := Rec;
          ReportLayoutSelection."Company Name" := SelectedCompany;
        #6..9
          ReportLayoutSelection."Company Name" := SelectedCompany;
          ReportLayoutSelection.INSERT(TRUE);
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "GetRec(PROCEDURE 2)".

    //procedure GetRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT GET("Report ID",'') THEN
          EXIT;
        IF NOT ReportLayoutSelection.GET("Report ID",SelectedCompany) THEN BEGIN
          ReportLayoutSelection.INIT;
          ReportLayoutSelection.Type := GetDefaultType("Report ID");
        END;
        Type := ReportLayoutSelection.Type;
        "Custom Report Layout Code" := ReportLayoutSelection."Custom Report Layout Code";
        CALCFIELDS("Report Layout Description");
        CustomLayoutDescription := "Report Layout Description";
        OnGetRecOnBeforeModify(Rec,SelectedCompany);
        MODIFY;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        "Custom Report Layout ID" := ReportLayoutSelection."Custom Report Layout ID";
        CALCFIELDS("Report Layout Description");
        CustomLayoutDescription := "Report Layout Description";
        MODIFY;
        */
    //end;


    //Unsupported feature: Code Modification on "LookupCustomLayout(PROCEDURE 5)".

    //procedure LookupCustomLayout();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Type <> Type::"Custom Layout" THEN
          EXIT;

        IF NOT SelectReportLayout THEN
          EXIT;

        GetRec;
        IF (Type = Type::"Custom Layout") AND
           ("Custom Report Layout Code" = '')
        THEN BEGIN
          VALIDATE(Type,GetDefaultType("Report ID"));
          UpdateRec;
        END;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
           ("Custom Report Layout ID" = 0)
        #10..14
        */
    //end;


    //Unsupported feature: Code Modification on "SelectReportLayout(PROCEDURE 3)".

    //procedure SelectReportLayout();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CustomReportLayout2.FILTERGROUP(4);
        CustomReportLayout2.SETRANGE("Report ID","Report ID");
        CustomReportLayout2.FILTERGROUP(0);
        #4..6
          IF CustomReportLayout2.FIND THEN BEGIN
            IF NOT (CustomReportLayout2."Company Name" IN [SelectedCompany,'']) THEN
              ERROR(WrongCompanyErr);
            "Custom Report Layout Code" := CustomReportLayout2.Code;
            Type := Type::"Custom Layout";
            UpdateRec;
          END
        END ELSE
          IF Type = Type::"Custom Layout" THEN
            IF CustomReportLayout2.ISEMPTY THEN BEGIN
              Type := GetDefaultType("Report ID");
              "Custom Report Layout Code" := '';
              UpdateRec;
            END;
        EXIT(OK);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
            "Custom Report Layout ID" := CustomReportLayout2.ID;
        #11..17
              "Custom Report Layout ID" := 0;
        #19..21
        */
    //end;


    //Unsupported feature: Code Modification on "InitializeData(PROCEDURE 1)".

    //procedure InitializeData();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReportMetadata.SETRANGE(ProcessingOnly,FALSE);
        IF ReportMetadata.FINDSET THEN
          REPEAT
            INIT;
            "Report ID" := ReportMetadata.ID;
            "Report Name" := ReportMetadata.Caption;
            INSERT;
          UNTIL ReportMetadata.NEXT = 0;
        IF FINDFIRST THEN;
        IsInitialized := TRUE;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        #7..10
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
