page 52185745 "Standing Order List"
{
    CardPageID = "Standing Order";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Standing Order Header";
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval,Adjustments';
    UsageCategory = Lists;
    ApplicationArea = Basic;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Income Type"; Rec."Income Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
                ApplicationArea = Basic;
            }
            systempart(Control13; MyNotes)
            {
                ApplicationArea = Basic;
            }
            systempart(Control14; Links)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action("Process STO")
            // {
            //     ApplicationArea = Basic;
            //     Image = Process;
            //     Promoted = true;
            //     PromotedCategory = Process;

            //     trigger OnAction()
            //     var
            //         ProcessConfirm: Label 'Are you sure you want to Process this standing order?';
            //     begin
            //         Rec.TestField(Status, Rec.Status::Approved);
            //         if not Confirm(ProcessConfirm, true) then exit;

            //         REPORT.Run(Report::"Process STO", true, false, Rec);

            //         Message('This standing order has been Processed!');

            //     end;
            // }
            action("Process Periodic STO")
            {
                ApplicationArea = Basic;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Standing Order Processing";

                // trigger OnAction()
                // var
                //     ProcessConfirm: Label 'Are you sure you want to Process Periodic Standing Order?';
                // begin
                //     Rec.TestField(Status, Rec.Status::Approved);
                //     if not Confirm(ProcessConfirm, true) then exit;

                //     if rec."Income Type" = Rec."Income Type"::Periodic then begin
                //         REPORT.Run(Report::"Standing Order Processing", true, false, Rec);
                //     end;
                //     Message('Periodic Standing Orders have been Processed Successfully!');

                // end;
            }
            action("Close Cleared Loan STO")
            {
                ApplicationArea = Basic;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ProcessConfirm: Label 'Are you sure you want to Process this standing order?';
                    standingorder: record "Standing Order Header";
                    stolines: record "Standing Order Lines";
                    numberoflines: integer;
                    loans: record Loans;
                begin
                    standingorder.reset;
                    standingorder.SetRange(Status, standingorder.Status::Approved);
                    if standingorder.FindSet() then begin
                        repeat
                            stolines.reset;
                            stolines.SetRange("Document No.", standingorder."No.");
                            if stolines.FindFirst() then begin
                                numberoflines := stolines.Count;
                                if numberoflines = 1 then begin
                                    stolines.setrange("Destination Account Type", stolines."Destination Account Type"::Credit);
                                    if stolines.FindFirst() then begin
                                        if loans.get(stolines."Loan No.") then begin
                                            loans.CalcFields("Total Balance");
                                            if loans."Total Balance" <= 0 then begin
                                                standingorder.status := standingorder.Status::Stopped;
                                                standingorder."Stopped By" := UserId();
                                                standingorder."Date Stopped" := today();
                                                standingorder.Modify();
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until standingorder.Next() = 0;
                    end;
                    message('Standing orders succesfully stopped.')

                end;
            }
            action(HLoanswithoutSTO)
            {
                ApplicationArea = Basic;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Loans Without STO';
                trigger OnAction()
                var
                begin
                    Report.run(report::"Loans Without STO");
                end;

            }
        }
    }
}

