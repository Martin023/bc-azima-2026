#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186696 pageextension52186696 extends "Resource Capacity Settings" 
{
    layout
    {
        modify(StartDate)
        {
            ApplicationArea = Basic;
        }
        modify(EndDate)
        {
            ApplicationArea = Basic;
        }
        modify(WorkTemplateCode)
        {
            ApplicationArea = Basic;
        }
        modify("WorkTemplateRec.Monday")
        {
            ApplicationArea = Basic;
        }
        modify("WorkTemplateRec.Tuesday")
        {
            ApplicationArea = Basic;
        }
        modify("WorkTemplateRec.Wednesday")
        {
            ApplicationArea = Basic;
        }
        modify("WorkTemplateRec.Thursday")
        {
            ApplicationArea = Basic;
        }
        modify("WorkTemplateRec.Friday")
        {
            ApplicationArea = Basic;
        }
        modify("WorkTemplateRec.Saturday")
        {
            ApplicationArea = Basic;
        }
        modify("WorkTemplateRec.Sunday")
        {
            ApplicationArea = Basic;
        }
        modify(WeekTotal)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "StartDate(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "EndDate(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WorkTemplateCode(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WorkTemplateRec.Monday"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WorkTemplateRec.Tuesday"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WorkTemplateRec.Wednesday"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WorkTemplateRec.Thursday"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WorkTemplateRec.Friday"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WorkTemplateRec.Saturday"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""WorkTemplateRec.Sunday"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WeekTotal(Control 39)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(UpdateCapacity)
        {

            //Unsupported feature: Property Modification (Name) on "UpdateCapacity(Action 50)".

            Caption = 'Add &Capacity';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "UpdateCapacity(Action 50).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF StartDate = 0D THEN
              ERROR(Text002);

            IF EndDate = 0D THEN
              ERROR(Text003);

            IF NOT CONFIRM(Text004,FALSE,TABLECAPTION,"No.") THEN
              EXIT;

            IF CompanyInformation.GET THEN
              IF CompanyInformation."Base Calendar Code" <> '' THEN
                CalendarCustomized :=
                  CalendarMgmt.CustomizedChangesExist(CalChange."Source Type"::Company,'','',CompanyInformation."Base Calendar Code");

            ResCapacityEntry.RESET;
            ResCapacityEntry.SETCURRENTKEY("Resource No.",Date);
            ResCapacityEntry.SETRANGE("Resource No.","No.");
            TempDate := StartDate;
            ChangedDays := 0;
            REPEAT
              IF CalendarCustomized THEN
                Holiday :=
                  CalendarMgmt.CheckCustomizedDateStatus(
                    CalChange."Source Type"::Company,'','',CompanyInformation."Base Calendar Code",TempDate,NewDescription)
              ELSE
                Holiday := CalendarMgmt.CheckDateStatus(CompanyInformation."Base Calendar Code",TempDate,NewDescription);

              ResCapacityEntry.SETRANGE(Date,TempDate);
              ResCapacityEntry.CALCSUMS(Capacity);
              TempCapacity := ResCapacityEntry.Capacity;

              IF Holiday THEN
                IF TempCapacity = 0 THEN
                  NewCapacity := 0
                ELSE BEGIN
                  // post reverse capacity entry to have zero balance
                  NewCapacity := SelectCapacity;
                  IF NewCapacity > TempCapacity THEN
                    NewCapacity := TempCapacity;
                END
              ELSE
                NewCapacity := TempCapacity - SelectCapacity;

              IF NewCapacity <> 0 THEN BEGIN
                ResCapacityEntry2.RESET;
                IF ResCapacityEntry2.FINDLAST THEN;
                LastEntry := ResCapacityEntry2."Entry No." + 1;
                ResCapacityEntry2.RESET;
                ResCapacityEntry2."Entry No." := LastEntry;
                ResCapacityEntry2.Capacity := -NewCapacity;
                ResCapacityEntry2."Resource No." := "No.";
                ResCapacityEntry2."Resource Group No." := "Resource Group No.";
                ResCapacityEntry2.Date := TempDate;
                IF ResCapacityEntry2.INSERT(TRUE) THEN;
                ChangedDays := ChangedDays + 1;
              END;
              TempDate := TempDate + 1;
            UNTIL TempDate > EndDate;
            COMMIT;
            IF ChangedDays > 1 THEN
              MESSAGE(Text006,ChangedDays)
            ELSE
              IF ChangedDays = 1 THEN
                MESSAGE(Text007,ChangedDays)
              ELSE
                MESSAGE(Text008);
            CurrPage.CLOSE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF WeekTotal <= 0 THEN
              ERROR(Text001);

            #1..27
              IF NOT Holiday THEN BEGIN
                ResCapacityEntry.SETRANGE(Date,TempDate);
                TempCapacity := 0;
                IF ResCapacityEntry.FIND('-') THEN
                  REPEAT
                    TempCapacity := TempCapacity + ResCapacityEntry.Capacity;
                  UNTIL ResCapacityEntry.NEXT = 0;

            #45..49
                ResCapacityEntry2.Capacity := -1 * (TempCapacity - SelectCapacity);
            #51..67
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "UpdateCapacity(Action 50)".

    }

    var
        Text001: label 'You must select a work-hour template.';
}
