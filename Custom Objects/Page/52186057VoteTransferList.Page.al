page 52186057 "Vote Transfer List."
{
    CardPageID = "Vote Transfer";
    DeleteAllowed = false;
    PageType = list;
    SourceTable = "Vote Transfer";
    //SourceTableView = WHERE(Posted = CONST(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Source Vote"; Rec."Source Vote")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Destination Vote"; Rec."Destination Vote")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Source Dimension 1"; Rec."Source Dimension 1")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Destination Dimension 1"; Rec."Destination Dimension 1")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Raised Date"; Rec."Raised Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Source Dimension 2"; Rec."Source Dimension 2")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
                field("Destination Dimension 2"; Rec."Destination Dimension 2")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = rec.Posted = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

