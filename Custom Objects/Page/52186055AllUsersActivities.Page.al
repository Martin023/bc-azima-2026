page 52186055 "All Users Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup("My Approved Docs")
            {
                Caption = 'Member Personal Account';
                field("My Payment Vouchers"; Rec."My Payment Vouchers")
                {
                    Caption = 'Payment Vouchers';
                    ApplicationArea = Basic, Suite;
                }
                field("My Petty Cash Vouchers"; Rec."My Petty Cash Vouchers")
                {
                    Caption = 'Petty Cash Vouchers';
                    ApplicationArea = Basic, Suite;
                }
                field("My Staff Advance"; Rec."My Staff Advance")
                {
                    Caption = 'Staff Advance';
                    ApplicationArea = Basic, Suite;
                }
                field("My Imprest Request"; Rec."My Imprest Request")
                {
                    Caption = 'Travel Advance Requisition';
                    ApplicationArea = Basic, Suite;
                }
                field(Members; Rec.Members)
                {
                    Caption = 'Active Members';
                    image = People;
                }
                field("Member Withdrawal"; Rec."Member Withdrawal")
                {
                    image = Document;
                    trigger OnDrillDown()
                    var
                        MemberWithdrawal: Record "Member withdrawal Notice";
                    begin
                        MemberWithdrawal.Reset();
                        MemberWithdrawal.SetRange(MemberWithdrawal.Status, MemberWithdrawal.Status::Approved);
                        Page.Run(Page::"Approved Withdrawal Notice", MemberWithdrawal);
                    end;
                }
                field("Member Closure"; Rec."Member Closure")
                {

                }
                field("Share Capital"; Rec."Share Capital")
                {
                    Caption = 'Share Capital Transfer';
                    trigger OnDrillDown()
                    var
                        ShareCapital: Record "Share Capital Transfer Buffer";
                    begin
                        ShareCapital.Reset();
                        ShareCapital.SetRange(ShareCapital.Status, ShareCapital.Status::Approved);
                        ShareCapital.SetRange(ShareCapital.Transfered, true);
                        Page.Run(Page::"pending ShareCapital List", ShareCapital);

                    end;

                }
                field("Processed Checkoff"; Rec."Processed Checkoff")
                {

                }
                field(Loans; Rec.Loans)
                {
                    image = Document;
                }
                // field("My Staff Advance Surrender"; Rec."My Staff Advance Surrender")
                // {
                //     Caption = 'Staff Advance Liquidation';
                //     ApplicationArea = Basic, Suite;
                // }
                // field("My Imprest Surrender"; Rec."My Imprest Surrender")
                // {
                //     Caption = 'Travel Liquidation';
                //     ApplicationArea = Basic, Suite;
                // }
                // field("My Staff Claims"; Rec."My Staff Claims")
                // {
                //     Caption = 'Staff Claims';
                //     ApplicationArea = Basic, Suite;
                // }

                actions
                {
                    action("Edit Cash Receipt Journal")
                    {
                        Caption = 'Edit Cash Receipt Journal';
                        RunObject = Page "Cash Receipt Journal";
                        ApplicationArea = Basic, Suite;
                    }
                    action("New Sales Credit Memo")
                    {
                        Caption = 'New Sales Credit Memo';
                        RunObject = Page "Sales Credit Memo";
                        RunPageMode = Create;
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
            cuegroup(Control11)
            {
                Caption = 'Pending Posting';
                // field("Pending Imprest Request"; Rec."Pending Imprest Request")
                // {

                // }
                // field("Pending Imprest Surrender"; Rec."Pending Imprest Surrender")
                // {

                // }
                field("Pending Loans"; Rec."Pending Loans")
                {
                    // image = None;
                }
                field("Pending Member Closure"; Rec."Pending Member Closure")
                {

                }
                field("Pending Payment Vouchers"; Rec."Pending Payment Vouchers")
                {

                }
                field(" Pending  Share Capital"; Rec." Pending Share Capital")
                {
                    trigger OnDrillDown()
                    var
                        ShareCapital: Record "Share Capital Transfer Buffer";
                    begin
                        ShareCapital.Reset();
                        ShareCapital.SetRange(ShareCapital.Status, ShareCapital.Status::Approved);
                        ShareCapital.SetRange(ShareCapital.Transfered, false);
                        Page.Run(Page::"pending ShareCapital List", ShareCapital);

                    end;


                }
                field("Pending Processed Checkoff"; Rec."Pending Processed Checkoff")
                {

                }
                // field("Pending Staff Claims"; Rec."Pending Staff Claims")
                // {

                // }
                field("Pending Petty Cash Vouchers"; Rec."Pending Petty Cash Vouchers")
                {

                }
                field("Open Saving Variations"; Rec."Open/Pending Saving Variations")
                {
                    trigger OnDrillDown()
                    var
                        ProdVar: record "Product Variations";
                    begin
                        ProdVar.reset;
                        ProdVar.setfilter(Status, '%1|%2', ProdVar.Status::Open, ProdVar.Status::"Pending");
                        ProdVar.setrange(Posted, false);
                        Page.run(Page::"Savings Variations List", ProdVar);
                    end;

                }
                field("Open Loan Variations"; Rec."Open/Pending Loan Variations")
                {
                    trigger OnDrillDown()
                    var
                        ProdVar: record "Product Variations";
                    begin
                        ProdVar.reset;
                        ProdVar.setfilter(Status, '%1|%2', ProdVar.Status::Open, ProdVar.Status::"Pending");
                        ProdVar.setrange(Posted, false);
                        Page.run(Page::"Variations List", ProdVar);
                    end;
                }
            }

            // cuegroup(Control12)
            // {
            //     Caption = 'Dividends Processing';
            //     field("Running Dividends Process"; Rec."Running Div. Processes")
            //     {

            //     }
            //     field("Generated Dividends Entries"; Rec."Generated Div. Entries")
            //     {

            //     }
            // }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        rec.Reset;
        if not rec.Get(rec."Primary Key") then begin
            rec.Init;
            rec.Insert;
        end;

        rec.SetFilter("Overdue Date Filter", '<%1', WorkDate);
    end;
}

