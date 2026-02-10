page 52187392 "Admin Cue Page"
{
    ApplicationArea = All;
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Admin Cue Table";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                //Caption = 'Vehicles';
                field("Open Vehicle Requests"; Rec."Open Vehicle Requests")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Vehicle Requests Pending Approval"; Rec."Vehicle Requests Pending Appr")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Open Motor Vehicle Movt"; Rec."Open Motor Vehicle Movt")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Conference Hall & Meeting Room"; Rec."Conference Hall & Meeting Room")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Open Parking Requests"; Rec."Open Parking Requests")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Pending Key Requests"; Rec."Key Requests")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Returned"; Rec."Returned Keys")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Dispatched Keys"; Rec."Dispatched Keys")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Expired Leases"; Rec."Expired Leases")
                {
                    ApplicationArea = all;
                    Editable = False;
                    DrillDownPageId = "Lease-List";
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
    // trigger OnOpenPage()
    // begin
    //     Rec.Reset;
    //     if not Rec.Get then begin
    //         Rec.Init;
    //         Rec.Insert;
    //     end;
    // end;
}
