page 52186766 "Bulk SMS Lines Part"
{
    PageType = ListPart;
    SourceTable = "Bulk SMS Lines";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field(No; Rec.No)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member No';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Telephone No';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        /*
                     BulkSMSHeader.RESET;
                     BulkSMSHeader.SETRANGE(BulkSMSHeader.No,No);
                     IF BulkSMSHeader.FIND('-') THEN BEGIN
                     //DIMENSION
                     IF BulkSMSHeader."SMS Type"=BulkSMSHeader."SMS Type"::Dimension THEN BEGIN
                     DimensionValue.RESET;
                     DimensionValue.SETRANGE(DimensionValue."Global Dimension No.",2);
                     IF PAGE.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN BEGIN
                     Code:=DimensionValue.Code;
                     Description:=DimensionValue.Name;
                     END;

                     END;

                     END;
                        */

                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Text Message"; Rec."Text Message")
                {
                    ApplicationArea = Basic;
                    // MultiLine = true;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    var
        BulkSMSHeader: Record "prEmployee Trans IMP BAL";
        DimensionValue: Record "Dimension Value";
}

