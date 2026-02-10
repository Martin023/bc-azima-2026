page 52186716 "Certificate Management" 
{
    SourceTable = "Certificate Management";
    PageType = List;
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("No.";Rec."No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Record ID";Rec."Record ID")
                {
                    Editable = false;
                }
                field("Document Type";Rec."Document Type")
                {
                    Editable = true;
                }
                field("Document No.";Rec."Document No.")
                {
                    Editable = true;
                }

                field("Start Date";Rec."Start Date")
                {
                    Editable = true;
                }
                field("End Date";Rec."End Date")
                {
                    Editable = true;
                }
                field(Description;Rec.Description)
                {
                    Editable = true;
                }
            }
        }
    }
}