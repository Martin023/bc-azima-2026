page 52187309 "HR  Manager Activities"
{
    PageType = CardPart;
    SourceTable = "HR Officer Cue";
    Caption = 'Activities';


    layout
    {
        area(content)
        {
            cuegroup(Control4)
            {
                //CuegroupLayout = Wide;
                ShowCaption = false;

                field("Approved Leave"; Rec."Approved Leave")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "HR Leave Applications List1";
                    ToolTip = 'Specifies total count of  Approved Leave applications';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        HRLEaev: Record "HR Leave Application";
                    begin
                        HRLEaev.Reset();
                        HRLEaev.SetRange(Status, HRLEaev.Status::Approved);
                        PAGE.Run(PAGE::"HR Leave Applications List1", HRLEaev);
                    end;
                }
                field("Approved  Trainings"; Rec."Approved  Trainings")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "HR Training ApplicationList";
                    ToolTip = 'Specifies total count of  Approved training applications';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        HrTRainin: Record "HR Training App Header";
                    begin
                        HrTRainin.Reset();
                        HrTRainin.SetRange(Status, HrTRainin.Status::Approved);
                        PAGE.Run(PAGE::"HR Training ApplicationList", HrTRainin);
                    end;
                }
                field("Approved Transport Requisition"; Rec."Approved Transport Requisition")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic;
                    Caption = 'All Active Employees';
                    DrillDownPageId = "HR Employee List - Active";
                    ToolTip = 'Specifies total count of  all active employees';
                }
                field(Female; Rec.Female)
                {
                    ApplicationArea = Basic;
                    Caption = 'Female Employees';
                    ToolTip = 'Specifies total count of  female active employees';
                    DrillDownPageId = "HR Employee List - Active";
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ActiVeEm: Record "HR Employees";
                    begin
                        ActiVeEm.Reset();
                        ActiVeEm.SetRange(ActiVeEm.Status, ActiVeEm.Status::Active);
                        ActiVeEm.SetRange(ActiVeEm.Gender, ActiVeEm.Gender::Female);
                        PAGE.Run(PAGE::"HR Employee List - Active", ActiVeEm);
                    end;
                }
                field(Male; Rec.Male)
                {
                    ApplicationArea = Basic;
                    Caption = 'Male Employees';
                    DrillDownPageId = "HR Employee List - Active";
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ActiVeEm: Record "HR Employees";
                    begin
                        ActiVeEm.Reset();
                        ActiVeEm.SetRange(ActiVeEm.Status, ActiVeEm.Status::Active);
                        ActiVeEm.SetRange(ActiVeEm.Gender, ActiVeEm.Gender::Male);
                        PAGE.Run(PAGE::"HR Employee List - Active", ActiVeEm);
                    end;
                }
                
                field("Inactive Employees"; Rec."HR Employees Inactive")
                {
                    ApplicationArea = Basic;
                    Caption = 'Inactive Employees';
                    DrillDownPageId = "HR Employee List - Inactive";
                    ToolTip = 'Specifies total count of  inactive employees';
                }
                field("Posted Revolving"; Rec."Posted Revolving")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Loan Posted List";
                    Image = Cash;
                    ToolTip = 'Specifies the Hr Loans of Loans Disbursed';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
                    begin
                        CustomCuesCodeunit.DrillDownLoansHrFunds();
                    end;

                }
                // field("RevolvingFund bal"; Rec."RevolvingFund bal")
                // {
                //     ApplicationArea = all;
                //     Image = Cash;
                //     ToolTip = 'Specifies the outstanding revolving Loan balance';

                // }
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
        Rec."Posted Revolving" := custCues.SumHrLoansPosted;
        Rec."RevolvingFund bal" := custCues.Revolvingfundbal();
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        Rec."Posted Revolving" := custCues.SumHrLoansPosted;
        Rec."RevolvingFund bal" := custCues.Revolvingfundbal();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec."Posted Revolving" := custCues.SumHrLoansPosted;
        Rec."RevolvingFund bal" := custCues.Revolvingfundbal();
    end;

    var
        custCues: Codeunit CustomCuesCodeunit;
}

