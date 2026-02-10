#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187111 pageextension52187111 extends "Opportunities Matrix" 
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
        modify(Field1)
        {
            ApplicationArea = Basic;
        }
        modify(Field2)
        {
            ApplicationArea = Basic;
        }
        modify(Field3)
        {
            ApplicationArea = Basic;
        }
        modify(Field4)
        {
            ApplicationArea = Basic;
        }
        modify(Field5)
        {
            ApplicationArea = Basic;
        }
        modify(Field6)
        {
            ApplicationArea = Basic;
        }
        modify(Field7)
        {
            ApplicationArea = Basic;
        }
        modify(Field8)
        {
            ApplicationArea = Basic;
        }
        modify(Field9)
        {
            ApplicationArea = Basic;
        }
        modify(Field10)
        {
            ApplicationArea = Basic;
        }
        modify(Field11)
        {
            ApplicationArea = Basic;
        }
        modify(Field12)
        {
            ApplicationArea = Basic;
        }
        modify(Field13)
        {
            ApplicationArea = Basic;
        }
        modify(Field14)
        {
            ApplicationArea = Basic;
        }
        modify(Field15)
        {
            ApplicationArea = Basic;
        }
        modify(Field16)
        {
            ApplicationArea = Basic;
        }
        modify(Field17)
        {
            ApplicationArea = Basic;
        }
        modify(Field18)
        {
            ApplicationArea = Basic;
        }
        modify(Field19)
        {
            ApplicationArea = Basic;
        }
        modify(Field20)
        {
            ApplicationArea = Basic;
        }
        modify(Field21)
        {
            ApplicationArea = Basic;
        }
        modify(Field22)
        {
            ApplicationArea = Basic;
        }
        modify(Field23)
        {
            ApplicationArea = Basic;
        }
        modify(Field24)
        {
            ApplicationArea = Basic;
        }
        modify(Field25)
        {
            ApplicationArea = Basic;
        }
        modify(Field26)
        {
            ApplicationArea = Basic;
        }
        modify(Field27)
        {
            ApplicationArea = Basic;
        }
        modify(Field28)
        {
            ApplicationArea = Basic;
        }
        modify(Field29)
        {
            ApplicationArea = Basic;
        }
        modify(Field30)
        {
            ApplicationArea = Basic;
        }
        modify(Field31)
        {
            ApplicationArea = Basic;
        }
        modify(Field32)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".

    }

    //Unsupported feature: Property Modification (Id) on "MatrixRecords(Variable 1013)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecords : 1013;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecords : 1610;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CellData"(Variable 1612)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CellData" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CellData" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1613)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    var
        "Salesperson/Purchaser": Record "Salesperson/Purchaser";

    var
        ESV: Text[1024];
        SCS: Text[1024];
        SCH: Text[1024];
        PRO: Text[1024];
        COM: Text[1024];
        CCV: Text[1024];
        SC: Text[1024];


    //Unsupported feature: Code Modification on "FindRec(PROCEDURE 1618)".

    //procedure FindRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE TableOpt OF
          TableOpt::Salesperson:
            BEGIN
              RMMatrixMgt."No." := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(SalespersonPurchaser.Code));
              SalespersonPurchaser.Code := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(SalespersonPurchaser.Code));
              Found := SalespersonPurchaser.FIND(Which);
              IF Found THEN
                CopySalespersonToBuf(SalespersonPurchaser,RMMatrixMgt);
            END;
          TableOpt::Campaign:
            BEGIN
        #12..26
            END;
        END;
        EXIT(Found);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
              RMMatrixMgt."No." := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN("Salesperson/Purchaser".Code));
              "Salesperson/Purchaser".Code := RMMatrixMgt."No.";
              Found := "Salesperson/Purchaser".FIND(Which);
              IF Found THEN
                CopySalespersonToBuf("Salesperson/Purchaser",RMMatrixMgt);
        #9..29
        */
    //end;


    //Unsupported feature: Code Modification on "NextRec(PROCEDURE 1620)".

    //procedure NextRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE TableOpt OF
          TableOpt::Salesperson:
            BEGIN
              RMMatrixMgt."No." := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(SalespersonPurchaser.Code));
              SalespersonPurchaser.Code := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(SalespersonPurchaser.Code));
              ResultSteps := SalespersonPurchaser.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopySalespersonToBuf(SalespersonPurchaser,RMMatrixMgt);
            END;
          TableOpt::Campaign:
            BEGIN
        #12..26
            END;
        END;
        EXIT(ResultSteps);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
              RMMatrixMgt."No." := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN("Salesperson/Purchaser".Code));
              "Salesperson/Purchaser".Code := RMMatrixMgt."No.";
              ResultSteps := "Salesperson/Purchaser".NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopySalespersonToBuf("Salesperson/Purchaser",RMMatrixMgt);
        #9..29
        */
    //end;


    //Unsupported feature: Code Modification on "CopyCampaignToBuf(PROCEDURE 1623)".

    //procedure CopyCampaignToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH RMMatrixMgt DO BEGIN
          INIT;
          "Company Name" := Campaign."No.";
          Type := Type::Person;
          Name := COPYSTR(Campaign.Description,1,MAXSTRLEN(Name));
          "No." := Campaign."No.";
          "Company No." := '';
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH RMMatrixMgt DO BEGIN
          INIT;
          "Company Name" := TheCampaign."No.";
          Type := Type::Person;
          Name := TheCampaign.Description;
          "No." := TheCampaign."No.";
          "Company No." := '';
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopyContactToBuf(PROCEDURE 1624)".

    //procedure CopyContactToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH RMMatrixMgt DO BEGIN
          INIT;
          "Company Name" := COPYSTR(Cont."Company Name",1,MAXSTRLEN("Company Name"));
          Type := Cont.Type;
          Name := COPYSTR(Cont.Name,1,MAXSTRLEN(Name));
          "No." := Cont."No.";
          "Company No." := Cont."Company No.";
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH RMMatrixMgt DO BEGIN
          INIT;
          "Company Name" := TheCont."Company Name";
          Type := TheCont.Type;
          Name := TheCont.Name;
          "No." := TheCont."No.";
          "Company No." := TheCont."Company No.";
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateSalespersonFilter(PROCEDURE 1627)".

    //procedure UpdateSalespersonFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalespersonPurchaser.RESET;
        IF GETFILTER("Action Taken Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Action Taken Filter",GETFILTER("Action Taken Filter"));
        IF GETFILTER("Sales Cycle Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Sales Cycle Filter",GETFILTER("Sales Cycle Filter"));
        IF GETFILTER("Sales Cycle Stage Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Sales Cycle Stage Filter",GETFILTER("Sales Cycle Stage Filter"));
        IF GETFILTER("Probability % Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Probability % Filter",GETFILTER("Probability % Filter"));
        IF GETFILTER("Completed % Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Completed % Filter",GETFILTER("Completed % Filter"));
        IF GETFILTER("Close Opportunity Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Close Opportunity Filter",GETFILTER("Close Opportunity Filter"));
        IF GETFILTER("Contact Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Contact Filter",GETFILTER("Contact Filter"));
        IF GETFILTER("Contact Company Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Contact Company Filter",GETFILTER("Contact Company Filter"));
        IF GETFILTER("Campaign Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Campaign Filter",GETFILTER("Campaign Filter"));
        IF GETFILTER("Estimated Value Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Estimated Value Filter",GETFILTER("Estimated Value Filter"));
        IF GETFILTER("Calcd. Current Value Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Calcd. Current Value Filter",GETFILTER("Calcd. Current Value Filter"));
        IF GETFILTER("Chances of Success % Filter") <> '' THEN
          SalespersonPurchaser.SETFILTER("Chances of Success % Filter",GETFILTER("Chances of Success % Filter"));
        SalespersonPurchaser.SETRANGE("Opportunity Entry Exists",TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Salesperson/Purchaser".RESET;
        IF GETFILTER("Action Taken Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Action Taken Filter",GETFILTER("Action Taken Filter"));
        IF GETFILTER("Sales Cycle Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Sales Cycle Filter",GETFILTER("Sales Cycle Filter"));
        IF GETFILTER("Sales Cycle Stage Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Sales Cycle Stage Filter",GETFILTER("Sales Cycle Stage Filter"));
        IF GETFILTER("Probability % Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Probability % Filter",GETFILTER("Probability % Filter"));
        IF GETFILTER("Completed % Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Completed % Filter",GETFILTER("Completed % Filter"));
        IF GETFILTER("Close Opportunity Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Close Opportunity Filter",GETFILTER("Close Opportunity Filter"));
        IF GETFILTER("Contact Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Contact Filter",GETFILTER("Contact Filter"));
        IF GETFILTER("Contact Company Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Contact Company Filter",GETFILTER("Contact Company Filter"));
        IF GETFILTER("Campaign Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Campaign Filter",GETFILTER("Campaign Filter"));

        IF GETFILTER("Estimated Value Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Estimated Value Filter",GETFILTER("Estimated Value Filter"));

        IF GETFILTER("Calcd. Current Value Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Calcd. Current Value Filter",GETFILTER("Calcd. Current Value Filter"));
        IF GETFILTER("Chances of Success % Filter") <> '' THEN
          "Salesperson/Purchaser".SETFILTER("Chances of Success % Filter",GETFILTER("Chances of Success % Filter"));
        "Salesperson/Purchaser".SETRANGE("Opportunity Entry Exists",TRUE);
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: RMRecordLocal) (ParameterCollection) on "Load(PROCEDURE 1630)".


    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1630)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 1630)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        COPYARRAY(MATRIX_CaptionSet,MatrixColumns1,1);
        COPYARRAY(MatrixRecords,MatrixRecords1,1);
        TableOption := TableOptionLocal;
        OutPutOption := OutPutOptionLocal;
        RoundingFactor := RoundingFactorLocal;
        OptionStatusFilter := OptionStatusFilterLocal;
        "Close Opportunity Filter" := CloseOpportunityFilterLocal;
        SuccessChanceFilter := SuccessChanceFilterLocal;
        ProbabilityFilter := ProbabilityFilterLocal;
        CompletedFilter := CompletedFilterLocal;
        CalcdCurrentValueFilter := CalcdCurrentValueFilterLocal;
        SalesCycleFilter := SalesCycleFilterLocal;
        SalesCycleStageFilter := SalesCycleStageFilterLocal;
        EstimatedValueFilter := EstimatedValueFilterLocal;
        MATRIX_CurrentNoOfMatrixColumn := NoOfColumns;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        SCH := "SuccessChance % FilterLocal";
        PRO := "Probability % FilterLocal";
        COM := "Completed % FilterLocal";
        CCV := "Calcd. Current Value FilterLoc";
        SC := "Sales Cycle FilterLocal";
        SCS := "Sales Cycle Stage FilterLocal";
        ESV := "Estimated Value FilterLocal";
        MATRIX_CurrentNoOfMatrixColumn := NoOfColumns;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnDrillDown"(PROCEDURE 1631)".

    //procedure "MATRIX_OnDrillDown"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempOpp.DELETEALL;

        OppEntry.SETRANGE("Estimated Close Date",MatrixRecords[MATRIX_ColumnOrdinal]."Period Start",
          MatrixRecords[MATRIX_ColumnOrdinal]."Period End");
        #5..51
          UNTIL OppEntry.NEXT = 0;

        PAGE.RUN(PAGE::"Active Opportunity List",TempOpp);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TempOpp.DELETEALL;

        OppEntry.SETCURRENTKEY(Active,"Salesperson Code","Estimated Close Date",
          "Action Taken","Sales Cycle Code","Sales Cycle Stage",
          "Completed %","Probability %","Contact No.","Contact Company No.",
          "Campaign No.","Chances of Success %","Estimated Value (LCY)",
          "Calcd. Current Value (LCY)","Close Opportunity Code");
        #2..54
        */
    //end;


    //Unsupported feature: Code Modification on "TestFilters(PROCEDURE 2)".

    //procedure TestFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF EstimatedValueFilter <> '' THEN
          SETFILTER("Estimated Value Filter",EstimatedValueFilter)
        ELSE
          SETRANGE("Estimated Value Filter");

        IF SalesCycleStageFilter <> '' THEN
          SETFILTER("Sales Cycle Stage Filter",SalesCycleStageFilter)
        ELSE
          SETRANGE("Sales Cycle Stage Filter");

        IF SuccessChanceFilter <> '' THEN
          SETFILTER("Chances of Success % Filter",SuccessChanceFilter)
        ELSE
          SETRANGE("Chances of Success % Filter");

        IF ProbabilityFilter <> '' THEN
          SETFILTER("Probability % Filter",ProbabilityFilter)
        ELSE
          SETRANGE("Probability % Filter");

        IF CompletedFilter <> '' THEN
          SETFILTER("Completed % Filter",CompletedFilter)
        ELSE
          SETRANGE("Completed % Filter");

        IF CalcdCurrentValueFilter <> '' THEN
          SETFILTER("Calcd. Current Value Filter",CalcdCurrentValueFilter)
        ELSE
          SETRANGE("Calcd. Current Value Filter");

        IF SalesCycleFilter <> '' THEN
          SETFILTER("Sales Cycle Filter",SalesCycleFilter)
        ELSE
          SETRANGE("Sales Cycle Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ESV <> '' THEN
          SETFILTER("Estimated Value Filter",ESV)
        #3..5
        IF SCS <> '' THEN
          SETFILTER("Sales Cycle Stage Filter",SCS)
        #8..10
        IF SCH <> '' THEN
          SETFILTER("Chances of Success % Filter",SCH)
        #13..15
        IF PRO <> '' THEN
          SETFILTER("Probability % Filter",PRO)
        #18..20
        IF COM <> '' THEN
          SETFILTER("Completed % Filter",COM)
        #23..25
        IF CCV <> '' THEN
          SETFILTER("Calcd. Current Value Filter",CCV)
        #28..30
        IF SC <> '' THEN
          SETFILTER("Sales Cycle Filter",SC)
        ELSE
          SETRANGE("Sales Cycle Filter");
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetColumnVisibility(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Name) on "CopyCampaignToBuf(PROCEDURE 1623).Campaign(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "CopyContactToBuf(PROCEDURE 1624).Cont(Parameter 1000)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).CloseOpportunityFilterLocal(Parameter 1004)".


    //Unsupported feature: Property Modification (Name) on "Load(PROCEDURE 1630).SuccessChanceFilterLocal(Parameter 1005)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).SuccessChanceFilterLocal(Parameter 1005)".


    //Unsupported feature: Property Modification (Name) on "Load(PROCEDURE 1630).ProbabilityFilterLocal(Parameter 1006)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).ProbabilityFilterLocal(Parameter 1006)".


    //Unsupported feature: Property Modification (Name) on "Load(PROCEDURE 1630).CompletedFilterLocal(Parameter 1007)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).CompletedFilterLocal(Parameter 1007)".


    //Unsupported feature: Property Modification (Name) on "Load(PROCEDURE 1630).EstimatedValueFilterLocal(Parameter 1008)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).EstimatedValueFilterLocal(Parameter 1008)".


    //Unsupported feature: Property Modification (Name) on "Load(PROCEDURE 1630).CalcdCurrentValueFilterLocal(Parameter 1009)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).CalcdCurrentValueFilterLocal(Parameter 1009)".


    //Unsupported feature: Property Modification (Name) on "Load(PROCEDURE 1630).SalesCycleFilterLocal(Parameter 1010)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).SalesCycleFilterLocal(Parameter 1010)".


    //Unsupported feature: Property Modification (Name) on "Load(PROCEDURE 1630).SalesCycleStageFilterLocal(Parameter 1011)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1630).SalesCycleStageFilterLocal(Parameter 1011)".


    //Unsupported feature: Property Modification (Length) on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1633).TestAmount(Variable 1000)".

}
