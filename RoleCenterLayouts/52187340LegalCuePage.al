page 52187340 "Legal Cue Page"
{
    Caption = 'Legal Activities';
    PageType = CardPart;
    SourceTable = "Other Operations Cue Table";
    RefreshOnActivate = true;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            //cuegroup(Activity)
            cuegroup(General)
            {
                Caption = 'Activity';
                //CuegroupLayout = wide;
                field("Open Contracts"; Rec.NewContracts)
                {
                    ApplicationArea = All;
                    
                    DrillDownPageId = "Contract List";
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        Contracts: Record Contracts;
                    begin
                        Contracts.RESET;
                        Contracts.SETRANGE("Status", Contracts.Status::New);
                        Page.Run(Page::"Contract List", Contracts);
                    end;
                }
                field("Open Legal Cases"; Rec."Open Legal Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Cases';
                    //ToolTip = 'Legal Cases';
                    DrillDownPageId = "Legal List";
                   
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        Legal: Record Legal;
                    begin
                        Legal.RESET;
                        Legal.SETRANGE("Status", Legal.Status::Open);
                        Page.Run(Page::"Legal List", Legal);
                    end;
                }
                field("Ongoing Matters"; Rec."Ongoing Matters")
                {
                    ApplicationArea = All;
                    Caption = 'Ongoing Matters';
                    //ToolTip = 'Ongoing Matters';
                    DrillDownPageId = "Legal List";
                    
                    trigger OnDrillDown()

                    var
                        Legal: Record Legal;
                    begin
                        Legal.RESET;
                        Legal.SETRANGE("Case Status", Legal."Case Status"::Ongoing);
                        PAGE.RUN(PAGE::"Legal List", Legal);
                    end;

                }
                field("ADR Cases"; Rec."ADR Cases")
                {
                    ApplicationArea = All;
                    Caption = 'ADR Cases';
                    //ToolTip = 'ADR Cases';
                    DrillDownPageId = "Legal List";
                    
                    trigger OnDrillDown()
                    var
                    Legal : Record Legal;
                    begin
                        Legal.RESET;

                    end;

                }
                field("Open Appeals"; Rec."Open Appeals")
                {
                    ApplicationArea = All;
                    Caption = 'Open Appeals';
                    //ToolTip = 'Open Appeals';
                    DrillDownPageId = "Appealed Legal List";
                    
                }
                field("Ongoing Appeals"; Rec."Ongoing Appeals")
                {
                    ApplicationArea = All;
                    Caption = 'Ongoing Appeals';
                    //ToolTip = 'Ongoing Appeals';
                    DrillDownPageId = "Appealed Legal List";
                    
                }
                // field("Contract Purchase invoices"; rec."Contract Purchase invoices")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Contract Purchase invoices';
                //     ToolTip = 'Contract Purchase invoices';
                //     DrillDownPageId = "Contract Purchase Invoices";
                // }
                field("Closed Cases"; rec."Closed Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Cases';
                    //ToolTip = 'Closed Cases';
                    DrillDownPageId = "Legal List Aproved";
                    
                }
                // field("Upcoming Matters"; rec."Upcoming Matters")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Upcoming Matters';
                //     //ToolTip = 'Upcoming Matters';
                //     DrillDownPageId = "Upcoming Matters";
                //     Editable = false;
                // }
                field("Pending Nominee Form Request"; Rec."Pending Nominee Form Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Nominee Form Request';
                    //ToolTip = 'Pending Nominee Form Request';
                    DrillDownPageId = "Nominee Request Form List";
                    
                }
                field("Open Contract Request"; Rec."Pending Contract Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Open Contract Request';
                    //ToolTip = 'Open Contract Request';
                    DrillDownPageId = "Contract Request List";
                
                }
                field("Open Surety Applications"; Rec."Open Surety Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Open Surety Applications';
                    //ToolTip = 'Open Surety Applications';
                    DrillDownPageId = "Surety Management List";
                    
                }
                field("Invoicing of Parking"; Rec."Invoicing of Parking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of Invoicing of Parking';
                    DrillDownPageId = "Parking Space List";
                    
                }
                field("Expired Leasee"; Rec."Expired Leases")
                {
                    ApplicationArea = all;
                    DrillDownPageId = Lease;
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
}
