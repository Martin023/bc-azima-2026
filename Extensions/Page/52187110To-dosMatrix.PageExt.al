#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187110 pageextension52187110 extends "Tasks Matrix" 
{

    //Unsupported feature: Property Modification (Name) on ""Tasks Matrix"(Page 9255)".

    Caption = 'To-dos Matrix';
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

    //Unsupported feature: Property Modification (OptionString) on "OutputOption(Variable 1084)".

    //var
        //>>>> ORIGINAL VALUE:
        //OutputOption : "No. of Tasks","Contact No.";
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OutputOption : "No. of To-dos","Contact No.";
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1093)".

    //var
        //>>>> ORIGINAL VALUE:
        //Text001 : ENU=No. of Tasks,Contact No.;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Text001 : ENU=No. of To-dos,Contact No.;
        //Variable type has not been exported.

    var
        ToDos: Record "To-do";

    var
        "Salesperson/Purchaser": Record "Salesperson/Purchaser";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);
        IF IncludeClosed THEN
          SETRANGE("Task Closed Filter")
        ELSE
          SETRANGE("Task Closed Filter",FALSE);

        IF StatusFilter <> StatusFilter::" " THEN
          SETRANGE("Task Status Filter",StatusFilter - 1)
        ELSE
          SETRANGE("Task Status Filter");

        IF PriorityFilter <> PriorityFilter::" " THEN
          SETRANGE("Priority Filter",PriorityFilter - 1)
        ELSE
          SETRANGE("Priority Filter");

        ValidateFilter;
        ValidateTableOption;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        MATRIX_NoOfMatrixColumns := ARRAYLEN(MATRIX_CellData);
        IF IncludeClosed THEN
          SETRANGE("To-do Closed Filter")
        ELSE
          SETRANGE("To-do Closed Filter",FALSE);

        IF StatusFilter <> StatusFilter::" " THEN
          SETRANGE("To-do Status Filter",StatusFilter - 1)
        ELSE
          SETRANGE("To-do Status Filter");
        #11..18
        */
    //end;


    //Unsupported feature: Code Modification on "SetFilters(PROCEDURE 1098)".

    //procedure SetFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF StatusFilter <> StatusFilter::" " THEN BEGIN
          SETRANGE("Task Status Filter",StatusFilter - 1);
          Task.SETRANGE(Status,StatusFilter - 1);
        END ELSE BEGIN
          SETRANGE("Task Status Filter");
          Task.SETRANGE(Status);
        END;

        Task.SETFILTER("System To-do Type",'%1|%2',"System Task Type Filter"::Organizer,
          "System Task Type Filter"::"Salesperson Attendee");

        IF IncludeClosed THEN
          Task.SETRANGE(Closed)
        ELSE
          Task.SETRANGE(Closed,FALSE);

        IF PriorityFilter <> PriorityFilter::" " THEN BEGIN
          SETRANGE("Priority Filter",PriorityFilter - 1);
          Task.SETRANGE(Priority,PriorityFilter - 1);
        END ELSE BEGIN
          SETRANGE("Priority Filter");
          Task.SETRANGE(Priority);
        END;

        CASE TableOption OF
          TableOption::Salesperson:
            BEGIN
              SETRANGE("Salesperson Filter","No.");
              SETFILTER(
                "System Task Type Filter",'%1|%2',
                "System Task Type Filter"::Organizer,
                "System Task Type Filter"::"Salesperson Attendee");
            END;
          TableOption::Team:
            BEGIN
              SETRANGE("Team Filter","No.");
              SETRANGE("System Task Type Filter","System Task Type Filter"::Team);
            END;
          TableOption::Campaign:
            BEGIN
              SETRANGE("Campaign Filter","No.");
              SETRANGE("System Task Type Filter","System Task Type Filter"::Organizer);
            END;
          TableOption::Contact:
            IF Type = Type::Company THEN BEGIN
              SETRANGE("Contact Filter");
              SETRANGE("Contact Company Filter","Company No.");
              SETRANGE(
                "System Task Type Filter","System Task Type Filter"::"Contact Attendee");
            END ELSE BEGIN
              SETRANGE("Contact Filter","No.");
              SETRANGE("Contact Company Filter");
              SETRANGE(
                "System Task Type Filter","System Task Type Filter"::"Contact Attendee");
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF StatusFilter <> StatusFilter::" " THEN BEGIN
          SETRANGE("To-do Status Filter",StatusFilter - 1);
          ToDos.SETRANGE(Status,StatusFilter - 1);
        END ELSE BEGIN
          SETRANGE("To-do Status Filter");
          ToDos.SETRANGE(Status);
        END;

        ToDos.SETFILTER("System To-do Type",'%1|%2',"System To-do Type Filter"::Organizer,
          "System To-do Type Filter"::"Salesperson Attendee");

        IF IncludeClosed THEN
          ToDos.SETRANGE(Closed)
        ELSE
          ToDos.SETRANGE(Closed,FALSE);
        #16..18
          ToDos.SETRANGE(Priority,PriorityFilter - 1);
        END ELSE BEGIN
          SETRANGE("Priority Filter");
          ToDos.SETRANGE(Priority);
        #23..29
                "System To-do Type Filter",'%1|%2',
                "System To-do Type Filter"::Organizer,
                "System To-do Type Filter"::"Salesperson Attendee");
        #33..36
              SETRANGE("System To-do Type Filter","System To-do Type Filter"::Team);
        #38..41
              SETRANGE("System To-do Type Filter","System To-do Type Filter"::Organizer);
        #43..48
                "System To-do Type Filter","System To-do Type Filter"::"Contact Attendee");
        #50..53
                "System To-do Type Filter","System To-do Type Filter"::"Contact Attendee");
            END;
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "FindRec(PROCEDURE 1099)".

    //procedure FindRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE TableOpt OF
          TableOpt::Salesperson:
            BEGIN
              RMMatrixMgt."No." := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(Salesperson.Code));
              Salesperson.Code := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(Salesperson.Code));
              Found := Salesperson.FIND(Which);
              IF Found THEN
                CopySalesPersonToBuf(Salesperson,RMMatrixMgt);
            END;
          TableOpt::Teams:
            BEGIN
        #12..34
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
                CopySalesPersonToBuf("Salesperson/Purchaser",RMMatrixMgt);
        #9..37
        */
    //end;


    //Unsupported feature: Code Modification on "NextRec(PROCEDURE 1101)".

    //procedure NextRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CASE TableOpt OF
          TableOpt::Salesperson:
            BEGIN
              RMMatrixMgt."No." := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(Salesperson.Code));
              Salesperson.Code := COPYSTR(RMMatrixMgt."No.",1,MAXSTRLEN(Salesperson.Code));
              ResultSteps := Salesperson.NEXT(Steps);
              IF ResultSteps <> 0 THEN
                CopySalesPersonToBuf(Salesperson,RMMatrixMgt);
            END;
          TableOpt::Teams:
            BEGIN
        #12..34
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
                CopySalesPersonToBuf("Salesperson/Purchaser",RMMatrixMgt);
        #9..37
        */
    //end;


    //Unsupported feature: Code Modification on "CopySalesPersonToBuf(PROCEDURE 1103)".

    //procedure CopySalesPersonToBuf();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        WITH RMMatrixMgt DO BEGIN
          INIT;
          "Company Name" := Salesperson.Code;
          Type := Type::Person;
          Name := Salesperson.Name;
          "No." := Salesperson.Code;
          "Company No." := '';
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        WITH RMMatrixMgt DO BEGIN
          INIT;
          "Company Name" := SalesPurchPerson.Code;
          Type := Type::Person;
          Name := SalesPurchPerson.Name;
          "No." := SalesPurchPerson.Code;
          "Company No." := '';
        END;
        */
    //end;


    //Unsupported feature: Code Modification on "CopyCampaignToBuf(PROCEDURE 1104)".

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


    //Unsupported feature: Code Modification on "CopyContactToBuf(PROCEDURE 1105)".

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


    //Unsupported feature: Code Modification on "UpdateSalesPersonFilter(PROCEDURE 1118)".

    //procedure UpdateSalesPersonFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Salesperson.RESET;
        Salesperson.SETFILTER(Code,FilterSalesPerson);
        Salesperson.SETFILTER("Team Filter",FilterTeam);
        Salesperson.SETFILTER("Campaign Filter",FilterCampaign);
        Salesperson.SETFILTER("Contact Company Filter",FilterContact);
        Salesperson.SETFILTER("Task Status Filter",GETFILTER("Task Status Filter"));
        Salesperson.SETFILTER("Closed Task Filter",GETFILTER("Task Closed Filter"));
        Salesperson.SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        Salesperson.SETRANGE("Task Entry Exists",TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Salesperson/Purchaser".RESET;
        "Salesperson/Purchaser".SETFILTER(Code,FilterSalesPerson);
        "Salesperson/Purchaser".SETFILTER("Team Filter",FilterTeam);
        "Salesperson/Purchaser".SETFILTER("Campaign Filter",FilterCampaign);
        "Salesperson/Purchaser".SETFILTER("Contact Company Filter",FilterContact);
        "Salesperson/Purchaser".SETFILTER("To-do Status Filter",GETFILTER("To-do Status Filter"));
        "Salesperson/Purchaser".SETFILTER("Closed To-do Filter",GETFILTER("To-do Closed Filter"));
        "Salesperson/Purchaser".SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        "Salesperson/Purchaser".SETRANGE("To-do Entry Exists",TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateCampaignFilter(PROCEDURE 1119)".

    //procedure UpdateCampaignFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Campaign.RESET;
        Campaign.SETFILTER("No.",FilterCampaign);
        Campaign.SETFILTER("Salesperson Filter",FilterSalesPerson);
        Campaign.SETFILTER("Team Filter",FilterTeam);
        Campaign.SETFILTER("Contact Company Filter",FilterContact);
        Campaign.SETFILTER("Task Status Filter",GETFILTER("Task Status Filter"));
        Campaign.SETFILTER("Task Closed Filter",GETFILTER("Task Closed Filter"));
        Campaign.SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        Campaign.SETRANGE("Task Entry Exists",TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        Campaign.SETFILTER("To-do Status Filter",GETFILTER("To-do Status Filter"));
        Campaign.SETFILTER("To-do Closed Filter",GETFILTER("To-do Closed Filter"));
        Campaign.SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        Campaign.SETRANGE("To-do Entry Exists",TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateContactFilter(PROCEDURE 1120)".

    //procedure UpdateContactFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Cont.RESET;
        Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
        Cont.SETFILTER("Company No.",FilterContact);
        Cont.SETFILTER("Campaign Filter",FilterCampaign);
        Cont.SETFILTER("Salesperson Filter",FilterSalesPerson);
        Cont.SETFILTER("Team Filter",FilterTeam);
        Cont.SETFILTER("Task Status Filter",GETFILTER("Task Status Filter"));
        Cont.SETFILTER("Task Closed Filter",GETFILTER("Task Closed Filter"));
        Cont.SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        Cont.SETRANGE("Task Entry Exists",TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        Cont.SETFILTER("To-do Status Filter",GETFILTER("To-do Status Filter"));
        Cont.SETFILTER("To-do Closed Filter",GETFILTER("To-do Closed Filter"));
        Cont.SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        Cont.SETRANGE("To-do Entry Exists",TRUE);
        */
    //end;


    //Unsupported feature: Code Modification on "UpdateTeamFilter(PROCEDURE 1121)".

    //procedure UpdateTeamFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Team.RESET;
        Team.SETFILTER(Code,FilterTeam);
        Team.SETFILTER("Campaign Filter",FilterCampaign);
        Team.SETFILTER("Salesperson Filter",FilterSalesPerson);
        Team.SETFILTER("Contact Company Filter",FilterContact);
        Team.SETFILTER("Task Status Filter",GETFILTER("Task Status Filter"));
        Team.SETFILTER("Task Closed Filter",GETFILTER("Task Closed Filter"));
        Team.SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        Team.SETRANGE("Task Entry Exists",TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        Team.SETFILTER("To-do Status Filter",GETFILTER("To-do Status Filter"));
        Team.SETFILTER("To-do Closed Filter",GETFILTER("To-do Closed Filter"));
        Team.SETFILTER("Priority Filter",GETFILTER("Priority Filter"));
        Team.SETRANGE("To-do Entry Exists",TRUE);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1122)".


    //Unsupported feature: Variable Insertion (Variable: DrilDownForm) (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 1123)".



    //Unsupported feature: Code Modification on "MatrixOnDrillDown(PROCEDURE 1123)".

    //procedure MatrixOnDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Task.SETRANGE(Date,MatrixRecords[ColumnID]."Period Start",MatrixRecords[ColumnID]."Period End");
        CASE TableOption OF
          TableOption::Salesperson:
            Task.SETFILTER("Salesperson Code","No.");
          TableOption::Team:
            Task.SETFILTER("Team Code","No.");
          TableOption::Campaign:
            Task.SETFILTER("Campaign No.","No.");
          TableOption::Contact:
            Task.SETFILTER("Contact No.","No.");
        END;
        Task.SETFILTER("Salesperson Code",GETFILTER("Salesperson Filter"));
        Task.SETFILTER("Team Code",GETFILTER("Team Filter"));
        Task.SETFILTER("Contact Company No.",GETFILTER("Contact Company Filter"));
        Task.SETFILTER(Status,GETFILTER("Task Status Filter"));
        Task.SETFILTER(Closed,GETFILTER("Task Closed Filter"));
        Task.SETFILTER(Priority,GETFILTER("Priority Filter"));
        Task.SETFILTER("System To-do Type",GETFILTER("System Task Type Filter"));

        PAGE.RUNMODAL(PAGE::"Task List",Task);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ToDos.SETRANGE(Date,MatrixRecords[ColumnID]."Period Start",MatrixRecords[ColumnID]."Period End");
        CASE TableOption OF
          TableOption::Salesperson:
            ToDos.SETFILTER("Salesperson Code","No.");
          TableOption::Team:
            ToDos.SETFILTER("Team Code","No.");
          TableOption::Campaign:
            ToDos.SETFILTER("Campaign No.","No.");
          TableOption::Contact:
            ToDos.SETFILTER("Contact No.","No.");
        END;
        ToDos.SETFILTER("Salesperson Code",GETFILTER("Salesperson Filter"));
        ToDos.SETFILTER("Team Code",GETFILTER("Team Filter"));
        ToDos.SETFILTER("Contact Company No.",GETFILTER("Contact Company Filter"));
        ToDos.SETFILTER(Status,GETFILTER("To-do Status Filter"));
        ToDos.SETFILTER(Closed,GETFILTER("To-do Closed Filter"));
        ToDos.SETFILTER(Priority,GETFILTER("Priority Filter"));
        ToDos.SETFILTER("System To-do Type",GETFILTER("System To-do Type Filter"));

        DrilDownForm.SETTABLEVIEW(ToDos);
        DrilDownForm.RUNMODAL;
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1)".

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetFilters;
        SETRANGE("Date Filter",MatrixRecords[Matrix_ColumnOrdinal]."Period Start",MatrixRecords[Matrix_ColumnOrdinal]."Period End");
        CALCFIELDS("No. of Tasks");
        IF OutputOption <> OutputOption::"Contact No." THEN BEGIN
          IF "No. of Tasks" = 0 THEN
            MATRIX_CellData[Matrix_ColumnOrdinal] := ''
          ELSE
            MATRIX_CellData[Matrix_ColumnOrdinal] := FORMAT("No. of Tasks");
        END ELSE BEGIN
          IF GETFILTER("Team Filter") <> '' THEN
            Task.SETFILTER("Team Code",GETFILTER("Team Filter"));
          IF GETFILTER("Salesperson Filter") <> '' THEN
            Task.SETFILTER("Salesperson Code",GETFILTER("Salesperson Filter"));
          IF GETFILTER("Campaign Filter") <> '' THEN
            Task.SETFILTER("Campaign No.",GETFILTER("Campaign Filter"));
          IF GETFILTER("Contact Filter") <> '' THEN
            Task.SETFILTER("Contact No.","Contact Filter");
          IF GETFILTER("Date Filter") <> '' THEN
            Task.SETFILTER(Date,GETFILTER("Date Filter"));
          IF GETFILTER("Task Status Filter") <> '' THEN
            Task.SETFILTER(Status,GETFILTER("Task Status Filter"));
          IF GETFILTER("Priority Filter") <> '' THEN
            Task.SETFILTER(Priority,GETFILTER("Priority Filter"));
          IF GETFILTER("Task Closed Filter") <> '' THEN
            Task.SETFILTER(Closed,GETFILTER("Task Closed Filter"));
          IF GETFILTER("Contact Company Filter") <> '' THEN
            Task.SETFILTER("Contact Company No.",GETFILTER("Contact Company Filter"));
          IF "No. of Tasks" = 0 THEN
            MATRIX_CellData[Matrix_ColumnOrdinal] := ''
          ELSE
            IF "No. of Tasks" > 1 THEN
              MATRIX_CellData[Matrix_ColumnOrdinal] := MultipleTxt
            ELSE BEGIN
              Task.FINDFIRST;
              IF Task."Contact No." <> '' THEN
                MATRIX_CellData[Matrix_ColumnOrdinal] := Task."Contact No."
              ELSE
                MATRIX_CellData[Matrix_ColumnOrdinal] := MultipleTxt
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetFilters;
        SETRANGE("Date Filter",MatrixRecords[Matrix_ColumnOrdinal]."Period Start",MatrixRecords[Matrix_ColumnOrdinal]."Period End");
        CALCFIELDS("No. of To-dos");
        IF OutputOption <> OutputOption::"Contact No." THEN BEGIN
          IF "No. of To-dos" = 0 THEN
            MATRIX_CellData[Matrix_ColumnOrdinal] := ''
          ELSE
            MATRIX_CellData[Matrix_ColumnOrdinal] := FORMAT("No. of To-dos");
        END ELSE BEGIN
          IF GETFILTER("Team Filter") <> '' THEN
            ToDos.SETFILTER("Team Code",GETFILTER("Team Filter"));
          IF GETFILTER("Salesperson Filter") <> '' THEN
            ToDos.SETFILTER("Salesperson Code",GETFILTER("Salesperson Filter"));
          IF GETFILTER("Campaign Filter") <> '' THEN
            ToDos.SETFILTER("Campaign No.",GETFILTER("Campaign Filter"));
          IF GETFILTER("Contact Filter") <> '' THEN
            ToDos.SETFILTER("Contact No.","Contact Filter");
          IF GETFILTER("Date Filter") <> '' THEN
            ToDos.SETFILTER(Date,GETFILTER("Date Filter"));
          IF GETFILTER("To-do Status Filter") <> '' THEN
            ToDos.SETFILTER(Status,GETFILTER("To-do Status Filter"));
          IF GETFILTER("Priority Filter") <> '' THEN
            ToDos.SETFILTER(Priority,GETFILTER("Priority Filter"));
          IF GETFILTER("To-do Closed Filter") <> '' THEN
            ToDos.SETFILTER(Closed,GETFILTER("To-do Closed Filter"));
          IF GETFILTER("Contact Company Filter") <> '' THEN
            ToDos.SETFILTER("Contact Company No.",GETFILTER("Contact Company Filter"));
          IF "No. of To-dos" = 0 THEN
            MATRIX_CellData[Matrix_ColumnOrdinal] := ''
          ELSE
            IF "No. of To-dos" > 1 THEN
              MATRIX_CellData[Matrix_ColumnOrdinal] := MultipleTxt
            ELSE BEGIN
              ToDos.FINDFIRST;
              IF ToDos."Contact No." <> '' THEN
                MATRIX_CellData[Matrix_ColumnOrdinal] := ToDos."Contact No."
        #37..40
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "CopySalesPersonToBuf(PROCEDURE 1103).Salesperson(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "CopyCampaignToBuf(PROCEDURE 1104).Campaign(Parameter 1000)".


    //Unsupported feature: Property Modification (Name) on "CopyContactToBuf(PROCEDURE 1105).Cont(Parameter 1000)".


    //Unsupported feature: Property Modification (OptionString) on "Load(PROCEDURE 1122).OutputOptionLocal(Parameter 1011)".

}
