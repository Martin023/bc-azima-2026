#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185859 pageextension52185859 extends "Change Log Entries"
{
    layout
    {

        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Date and Time")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Table No.")
        {
            ApplicationArea = Basic;
            Visible = true;
        }
        modify("Table Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 1 No.")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 1 Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 1 Value")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 2 No.")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 2 Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 2 Value")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 3 No.")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 3 Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Primary Key Field 3 Value")
        {
            ApplicationArea = Basic;
        }
        modify("Field No.")
        {
            ApplicationArea = Basic;
        }
        modify("Field Caption")
        {
            ApplicationArea = Basic;
        }
        modify("Type of Change")
        {
            ApplicationArea = Basic;
        }
        modify("Old Value")
        {
            ApplicationArea = Basic;
        }
        modify("Old Value Local")
        {
            ApplicationArea = Basic;
        }
        modify("New Value")
        {
            ApplicationArea = Basic;
        }
        modify("New Value Local")
        {
            ApplicationArea = Basic;
        }



    }
    actions
    {
        modify("&Print")
        {
            ApplicationArea = Basic;
        }



        modify(Setup)
        {
            Visible = false;
        }
        // modify("Delete Entries")
        // {
        //     Visible = false;
        // }
    }

    var
        ChangeLogEntriesRep: Report "Change Log Entries";


}
