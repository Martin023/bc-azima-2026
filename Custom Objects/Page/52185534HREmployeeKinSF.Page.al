page 52185534 "HR Employee Kin SF"
{
    Caption = 'HR Employee Kin & Beneficiaries';
    PageType = List;
    SourceTable = "HR Employee Kin";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Identification Type"; Rec."Identification Type")
                {
                    ApplicationArea = Basic;
                }
                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                    Caption = 'Identification';
                    ApplicationArea = Basic;
                    NotBlank = True;
                    Editable = (Rec."Identification Type" <> Rec."Identification Type"::"System UID");
                }

                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }

                field("Other Names"; Rec."Other Names")
                {
                    Caption = 'Name';
                    ApplicationArea = Basic;
                }

                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    trigger OnValidate()
                    var
                        DateofBirthError: Label 'This date cannot be greater than today.';
                    begin
                        if rec."Date Of Birth" > Today then
                            Error(DateofBirthError);
                    end;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurance No.";Rec."Medical Insurance No.")
                {
                    
                }

                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Next of Kin")
            {
                Caption = '&Next of Kin';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Employee Relative"),
                                  "No." = FIELD("Employee Code"),
                                  "Table Line No." = FIELD("Line No.");
                }
            }
        }
    }

    var
        D: Date;
}

