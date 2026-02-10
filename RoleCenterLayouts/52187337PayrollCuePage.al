page 52187337 "Payroll Activity"
{
    PageType = CardPart;
    SourceTable = "Payroll Activities Cue";
    Caption = 'Activities';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(GroupName)
            {
                ShowCaption = false;
                field(SalaryList; rec.SalaryList)
                {
                    ApplicationArea = All;
                }
                field("Bank Accounts"; rec."Bank Accounts")
                {
                    ApplicationArea = All;
                }
                field("Employee Allowances"; rec."Employee Allowances")
                {
                    ApplicationArea = All;
                }
                field("Pending Leave Allowances"; rec."Pending Leave Allowances")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Cues SetUp")
            {
                ApplicationArea = Basic;
                Caption = 'Set up Cues';
                Image = Setup;
                ToolTip = 'Set up Cues related to the role';
                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecoredref: RecordRef;
                begin
                    CueRecoredref.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecoredref.Number);
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;


}