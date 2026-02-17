page 52186620 "HR Promotion Recommend AppHead"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Promotion';
    SourceTable = "HR Promo. Recommend Header";
    SourceTableView = WHERE(Promoted = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Salary Notch"; Rec."Salary Notch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension code1"; Rec."Shortcut Dimension code1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Region';
                    Editable = false;
                }
                field("Shortcut Dimension code2"; Rec."Shortcut Dimension code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Department';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Competencies; Rec.Competencies)
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Development Areas"; Rec."Development Areas")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("New Job ID"; Rec."New Job ID")
                {
                    ApplicationArea = Basic;
                }
                field("New Job Title"; Rec."New Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;
                }
                field("New Salary Grade"; Rec."New Salary Grade")
                {
                    ApplicationArea = Basic;
                }
                field("New Salary Notch"; Rec."New Salary Notch")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Promoted; Rec.Promoted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Employee Qualifications"; "HR Employee Qualification Line")
            {
                Caption = 'Employee Qualifications';
                SubPageLink = "Employee No." = FIELD("Employee No.");
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        PromoLinesrec.Reset;
        PromoLinesrec.SetRange(PromoLinesrec."Document No", Rec.No);
        if PromoLinesrec.Find('-') then
            PromoLinesrec."Document No" := Rec.No;
    end;

    var
        PromoLinesrec: Record "HR Promo. Recommend Lines";
}

