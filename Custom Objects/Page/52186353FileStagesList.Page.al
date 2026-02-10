page 52186353 "File Stages List"
{
    Editable = false;
    PageType = List;
    SourceTable = "File Location";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    Caption = 'File Stages list';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;

                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Section Code';
                    Editable = false;
                }
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Section Name';
                }
                field("Issued To"; Rec."Issued To")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Initial Issue';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    OptionCaption = 'Being Processed,Processed,Forwarded';

                    trigger OnValidate()
                    begin
                        //IF  PAGE 52018571 :=Status::Processed;  THEN
                        //TESTFIELD(Status);
                        //Status:=Status::Processed;
                    end;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date/Time In"; Rec."Date/Time In")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date/Time Out"; Rec."Date/Time Out")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Folio; Rec.Folio)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

