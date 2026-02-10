#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186173 pageextension52186173 extends "Accountant Portal User Tasks"
{

    //Unsupported feature: Property Modification (Name) on ""Accountant Portal User Tasks"(Page 1316)".

    Caption = 'Extended Text List';

    //Unsupported feature: Property Modification (SourceTable) on ""Accountant Portal User Tasks"(Page 1316)".

    Editable = false;

    //Unsupported feature: Property Insertion (DataCaptionFields) on ""Accountant Portal User Tasks"(Page 1316)".


    //Unsupported feature: Property Insertion (CardPageID) on ""Accountant Portal User Tasks"(Page 1316)".

    layout
    {
        // modify(Control1)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


        //     //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


        //     //Unsupported feature: Property Modification (Name) on "Control1(Control 1)".

        //     ToolTip = 'Specifies a date on which the text will no longer be used on the item, account, resource or standard text.';

        //     //Unsupported feature: Property Insertion (SourceExpr) on "Control1(Control 1)".

        //     ApplicationArea = Basic;
        // }
        // modify(Task)
        // {

        //     //Unsupported feature: Property Modification (Level) on "Task(Control 2)".


        //     //Unsupported feature: Property Modification (ControlType) on "Task(Control 2)".


        //     //Unsupported feature: Property Modification (Name) on "Task(Control 2)".

        //     ToolTip = 'Specifies a date from which the text will be used on the item, account, resource or standard text.';

        //     //Unsupported feature: Property Insertion (SourceExpr) on "Task(Control 2)".

        //     ApplicationArea = Basic;
        // }
        modify(Title)
        {
            ToolTip = 'Specifies the language code of the extended text.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "Title(Control 4)".


            //Unsupported feature: Property Modification (Name) on "Title(Control 4)".

        }

        //Unsupported feature: Property Modification (Level) on ""Due DateTime"(Control 5)".


        //Unsupported feature: Property Modification (ControlType) on ""Due DateTime"(Control 5)".


        //Unsupported feature: Property Modification (Name) on ""Due DateTime"(Control 5)".


        //Unsupported feature: Property Insertion (GroupType) on ""Due DateTime"(Control 5)".

        modify("Percent Complete")
        {
            ToolTip = 'Specifies the content of the extended item description.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Percent Complete"(Control 6)".


            //Unsupported feature: Property Modification (Name) on ""Percent Complete"(Control 6)".

        }

        //Unsupported feature: Property Modification (Level) on "Priority(Control 7)".


        //Unsupported feature: Property Modification (ControlType) on "Priority(Control 7)".


        //Unsupported feature: Property Modification (Name) on "Priority(Control 7)".


        //Unsupported feature: Property Insertion (ContainerType) on "Priority(Control 7)".

        modify("Assigned To")
        {
            ToolTip = 'Specifies whether the text should be used for all language codes. If a language code has been chosen in the Language Code field, it will be overruled by this function.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Assigned To"(Control 3)".


            //Unsupported feature: Property Modification (Name) on ""Assigned To"(Control 3)".

        }

        //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".


        //Unsupported feature: Property Deletion (GroupType) on "Task(Control 2)".

        modify(ID)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on "Title(Control 4)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Due DateTime"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due DateTime"(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on ""Due DateTime"(Control 5)".


        //Unsupported feature: Property Deletion (SourceExpr) on ""Due DateTime"(Control 5)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Percent Complete"(Control 6)".


        //Unsupported feature: Property Deletion (CaptionML) on "Priority(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Priority(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Priority(Control 7)".


        //Unsupported feature: Property Deletion (SourceExpr) on "Priority(Control 7)".

        modify(Description)
        {
            Visible = false;
        }
        modify("Created_By_Name")
        {
            Visible = false;
        }
        modify("Created DateTime")
        {
            Visible = false;
        }
        modify("Start DateTime")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Assigned To"(Control 3)".

        modify(Link)
        {
            Visible = false;
        }
        modify("User Task Group Assigned To")
        {
            Visible = false;
        }
        // moveafter(;Priority)
        // moveafter(Control7;"Due DateTime")
        // moveafter(Description;Title)
        // moveafter("Language Code";"Assigned To")
        // moveafter("All Language Codes";Task)
    }

    //Unsupported feature: Property Deletion (SourceTableView).

}

