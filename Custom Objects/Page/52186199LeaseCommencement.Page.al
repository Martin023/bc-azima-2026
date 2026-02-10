page 52186199 "Lease-Commencement"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Lease;
    //SourceTableView = WHERE(Status = FILTER(Approved), Terminated = FILTER(false), Commenced = Const(True));     
    SourceTableView = WHERE(Status = FILTER(Approved));                
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                ShowCaption = false;
                field(Select; Rec.Select)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("L.R. No."; Rec."L.R. No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Floor No."; Rec."Floor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Floor Name"; Rec."Floor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Description"; Rec."Unit Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Unit Type Description"; Rec."Unit Type Description")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Unit Sub Type"; Rec."Unit Sub Type")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("Unit Sub Type Description"; Rec."Unit Sub Type Description")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                field("Landlord No."; Rec."Landlord No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease Status"; Rec."Lease Status")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Landlord Name"; Rec."Landlord Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Tenant No."; Rec."Tenant No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Tenant Name"; Rec."Tenant Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Letter Of Offer"; Rec."Letter Of Offer")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease Agreement Ref. No."; Rec."Lease Agreement Ref. No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Lease Commence Date"; Rec."Lease Commence Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Billing Frequency"; Rec."Billing Frequency")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Billing Frequency Value"; Rec."Billing Frequency Value")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Duration Type"; Rec."Duration Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Duration Value"; Rec."Duration Value")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Commence Lease")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Commence Lease';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    L.Reset;
                    L.SetFilter(L.Blocked, Format(false));
                    L.SetFilter(L.Commenced, Format(false));
                    L.SetFilter(L."Lease Commence Date", '<=' + Format(Today));
                    L.SetFilter(L.Select, Format(true));
                    if L.FindFirst then begin
                        if Confirm('Mark the Leases as Commenced?', false) = false then begin exit end;
                        repeat
                            L."Next Bill Date" := Today;
                            L."Last Bill Date" := Today;
                            L.Commenced := true;
                            L.Modify;

                            Unt.SetRange(Unt."Unit Code", Rec."Unit Code");
                            if Unt.Find('-') then
                                Unt."Unit Status" := Unt."Unit Status"::Occupied;
                            Unt.Modify;

                        until L.Next = 0;
                    end;
                    CurrPage.Update();
                    Message('The Selected Lease have been activated');
                end;
            }
            group(Functions)
            {
                Caption = 'Functions';
                action("Commence Leases")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Commence Leases';
                    Image = Add;

                    trigger OnAction()
                    begin
                        //CHECK WHETHER THERE IS ANY LEASE TO BE COMMENCEED
                        if Rec."No." = '' then begin
                            Error('No Lease Document for Commencement');
                        end;

                        /*TESTFIELD("L.R. No.");
                        TESTFIELD("LA Signed");
                        TESTFIELD("Landlord No.");
                        */
                        L.Reset;
                        L.SetFilter(L.Blocked, Format(false));
                        L.SetFilter(L.Commenced, Format(false));
                        L.SetFilter(L."Lease Commence Date", '<=' + Format(Today));
                        L.SetFilter(L.Select, Format(true));
                        if L.FindFirst then begin
                            if L.Cancelled = true then begin
                                Error('The Lease Has Already been Cancelled. You CANNOT Commence it.');
                            end else
                                if Confirm('Do you want to Mark the Leases as Commenced?', false) = false then begin exit end;
                            repeat
                                L."Next Bill Date" := Today;
                                L."Last Bill Date" := Today;
                                L.Commenced := true;
                                L.Modify;
                                Unt.Reset;
                                Unt.SetRange(Unt."Unit Code", L."Unit Code");
                                Unt.SetRange(Unt."Property No.", L."Property No.");
                                Unt.SetRange(Unt."Floor Code", L."Floor No.");
                                if Unt.Find('-') then
                                    Unt."Unit Status" := Unt."Unit Status"::Occupied;
                                Unt.Occupied := true;
                                Unt.Modify;

                            until L.Next = 0;
                        end;
                        CurrPage.Update();
                        Message('The Selected Lease have been activated');

                    end;
                }
                action("Cancel Leases")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Leases';
                    Image = Cancel;

                    trigger OnAction()
                    begin

                        if Rec."No." = '' then begin
                            Error('No Lease Document to be Cancelled ');
                        end;

                        // TESTFIELD("No.");
                        L.Reset;
                        L.SetFilter(L.Blocked, Format(false));
                        L.SetFilter(L.Commenced, Format(false));
                        L.SetFilter(L."Lease Commence Date", '<=' + Format(Today));
                        L.SetFilter(L.Select, Format(true));

                        if L.FindFirst then begin
                            if L.Cancelled = true then begin
                                Error('The Lease Has Already been Cancelled');
                            end else

                                if Confirm('Do you want to Cancel the Leases?', false) = false then begin exit end;
                            repeat
                                //L."Next Bill Date":=TODAY;
                                //L."Last Bill Date":=TODAY;
                                L.Cancelled := true;
                                L.Modify;
                            /*
                              Unt.SETRANGE(Unt."Unit Code", "Unit Code");
                              IF Unt.FIND('-') THEN
                              Unt."Unit Status":=Unt."Unit Status"::Vacant;
                              Unt.MODIFY;
                             */
                            until L.Next = 0;
                        end;
                        CurrPage.Update();
                        Message('The Selected Lease have been Cancelled');

                    end;
                }
                separator(Action1102755059)
                {
                }
                action("Re-open Lease")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re-open Lease';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        //check whether the any document needs reopening
                        if Rec."No." = '' then begin
                            Error('No Lease Document to be Re-opened ');
                        end;

                        L.Reset;
                        L.SetFilter(L.Blocked, Format(false));
                        L.SetFilter(L.Commenced, Format(false));
                        L.SetFilter(L."Lease Commence Date", '<=' + Format(Today));
                        L.SetFilter(L.Select, Format(true));

                        if L.FindFirst then begin
                            if L.Cancelled = true then begin
                                if Confirm('Are You Sure you want to Re-open the Cancelled Lease', false) = false then begin exit end;
                                repeat
                                    L.Cancelled := false;
                                    //L."Next Bill Date":=TODAY;
                                    //L."Last Bill Date":=TODAY;
                                    L.Modify;
                                /*
                                  Unt.SETRANGE(Unt."Unit Code", "Unit Code");
                                  IF Unt.FIND('-') THEN
                                  Unt."Unit Status":=Unt."Unit Status"::Vacant;
                                  Unt.MODIFY;
                                 */
                                until L.Next = 0;
                                CurrPage.Update();
                                Message('The Selected Lease have been Re-opened');
                            end
                        end

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Blocked, Format(false));
        Rec.SetFilter(Commenced, Format(false));

        Rec.SetFilter("Lease Commence Date", '<=' + Format(Today));
    end;

    var
        L: Record Lease;
        Unt: Record Unit;
}

