#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185857 pageextension52185857 extends "Change Log Setup (Table) List" 
{
    layout
    {
        modify("Object ID")
        {
            ApplicationArea = Basic;
        }
        modify("Object Caption")
        {
            ApplicationArea = Basic;
        }
        modify(LogInsertion)
        {
            ApplicationArea = Basic;
        }
        modify(LogModification)
        {
            ApplicationArea = Basic;
        }
        modify(LogDeletion)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Object ID"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Object Caption"(Control 19)".


        //Unsupported feature: Code Modification on "LogInsertion(Control 6).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ChangeLogSetupTable."Table No." <> "Object ID" THEN
              BEGIN
              NewValue := ChangeLogSetupTable."Log Insertion";
            #4..9
              IF (xChangeLogSetupTable."Log Insertion" = xChangeLogSetupTable."Log Insertion"::"Some Fields") AND
                 (xChangeLogSetupTable."Log Insertion" <> ChangeLogSetupTable."Log Insertion")
              THEN
                IF ConfirmManagement.ConfirmProcess(
                     STRSUBSTNO(Text002,xChangeLogSetupTable.FIELDCAPTION("Log Insertion"),xChangeLogSetupTable."Log Insertion"),TRUE)
                THEN
                  ChangeLogSetupTable.DelChangeLogFields(0);
            END;
            ChangeLogSetupTableLogInsertio;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..12
                IF CONFIRM(
                     STRSUBSTNO(Text002,xChangeLogSetupTable.FIELDCAPTION("Log Insertion"),xChangeLogSetupTable."Log Insertion"),FALSE)
            #15..18
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "LogInsertion(Control 6)".


        //Unsupported feature: Property Deletion (Enabled) on "LogInsertion(Control 6)".


        //Unsupported feature: Property Deletion (Editable) on "LogInsertion(Control 6)".



        //Unsupported feature: Code Modification on "LogModification(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ChangeLogSetupTable."Table No." <> "Object ID" THEN
              BEGIN
              NewValue := ChangeLogSetupTable."Log Modification";
            #4..9
              IF (xChangeLogSetupTable."Log Modification" = xChangeLogSetupTable."Log Modification"::"Some Fields") AND
                 (xChangeLogSetupTable."Log Modification" <> ChangeLogSetupTable."Log Modification")
              THEN
                IF ConfirmManagement.ConfirmProcess(
                     STRSUBSTNO(Text002,xChangeLogSetupTable.FIELDCAPTION("Log Modification"),xChangeLogSetupTable."Log Modification"),TRUE)
                THEN
                  ChangeLogSetupTable.DelChangeLogFields(1);
            END;
            ChangeLogSetupTableLogModifica;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..12
                IF CONFIRM(
                     STRSUBSTNO(Text002,xChangeLogSetupTable.FIELDCAPTION("Log Modification"),xChangeLogSetupTable."Log Modification"),FALSE)
            #15..18
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "LogModification(Control 8)".


        //Unsupported feature: Property Deletion (Enabled) on "LogModification(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on "LogModification(Control 8)".



        //Unsupported feature: Code Modification on "LogDeletion(Control 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IF ChangeLogSetupTable."Table No." <> "Object ID" THEN
              BEGIN
              NewValue := ChangeLogSetupTable."Log Deletion";
            #4..9
              IF (xChangeLogSetupTable."Log Deletion" = xChangeLogSetupTable."Log Deletion"::"Some Fields") AND
                 (xChangeLogSetupTable."Log Deletion" <> ChangeLogSetupTable."Log Deletion")
              THEN
                IF ConfirmManagement.ConfirmProcess(
                     STRSUBSTNO(Text002,xChangeLogSetupTable.FIELDCAPTION("Log Deletion"),xChangeLogSetupTable."Log Deletion"),TRUE)
                THEN
                  ChangeLogSetupTable.DelChangeLogFields(2);
            END;
            ChangeLogSetupTableLogDeletion;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..12
                IF CONFIRM(
                     STRSUBSTNO(Text002,xChangeLogSetupTable.FIELDCAPTION("Log Deletion"),xChangeLogSetupTable."Log Deletion"),FALSE)
            #15..18
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "LogDeletion(Control 10)".


        //Unsupported feature: Property Deletion (Enabled) on "LogDeletion(Control 10)".


        //Unsupported feature: Property Deletion (Editable) on "LogDeletion(Control 10)".

    }


    //Unsupported feature: Code Modification on "AssistEdit(PROCEDURE 1)".

    //procedure AssistEdit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Field.FILTERGROUP(2);
        Field.SETRANGE(TableNo,"Object ID");
        Field.SETFILTER(ObsoleteState,'<>%1',Field.ObsoleteState::Removed);
        Field.FILTERGROUP(0);
        WITH ChangeLogSetupTable DO
          ChangeLogSetupFieldList.SelectColumn(
            "Log Insertion" = "Log Insertion"::"Some Fields",
            "Log Modification" = "Log Modification"::"Some Fields",
            "Log Deletion" = "Log Deletion"::"Some Fields");
        ChangeLogSetupFieldList.SETTABLEVIEW(Field);
        ChangeLogSetupFieldList.RUN;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Field.FILTERGROUP(2);
        Field.SETRANGE(TableNo,"Object ID");
        #4..11
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetSource(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (LinksAllowed).

}
