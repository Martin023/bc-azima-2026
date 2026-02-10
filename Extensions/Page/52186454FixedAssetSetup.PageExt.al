PageExtension 52186454 pageextension52186454 extends "Fixed Asset Setup"
{
    layout
    {
        modify("Default Depr. Book")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Posting to Main Assets")
        {
            ApplicationArea = Basic;
        }
        modify("Allow FA Posting From")
        {
            ApplicationArea = Basic;
        }
        modify("Allow FA Posting To")
        {
            ApplicationArea = Basic;
        }
        modify("Insurance Depr. Book")
        {
            ApplicationArea = Basic;
        }
        modify("Automatic Insurance Posting")
        {
            ApplicationArea = Basic;
        }
        modify("Fixed Asset Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Insurance Nos.")
        {
            ApplicationArea = Basic;
        }

        addafter("Insurance Nos.")
        {
            field("Asset Transfer Nos."; rec."Asset Transfer Nos.")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {

        modify("Depreciation Books")
        {
            Visible = false;
        }
        modify("Depreciation Tables")
        {
            Visible = false;
        }
        modify("FA Classes")
        {
            Visible = false;
        }
        modify("FA Subclasses")
        {
            Visible = false;
        }
        modify("FA Locations")
        {
            Visible = false;
        }
        modify(Posting)
        {
            Visible = false;
        }
        modify("FA Posting Type Setup")
        {
            Visible = false;
        }
        modify("FA Posting Groups")
        {
            Visible = false;
        }
        modify("FA Journal Templates")
        {
            Visible = false;
        }
        modify("FA Reclass. Journal Templates")
        {
            Visible = false;
        }
    }

}
