page 52185572 "HR Applicant Qualifications"
{
    Caption = 'Applicant Qualifications';
    PageType = List;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Applicant Qualifications";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory=true;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory=true;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory=true;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                    ShowMandatory=true;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                    ShowMandatory=true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    ShowMandatory=true;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    ShowMandatory=true;
                }
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }
}

