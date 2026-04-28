page 52186637 "ATM Return Card"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "ATM Return Table";
    PromotedActionCategories = 'New,Process,Report,Workflows, ,Request Approval';


    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("User Id"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Date Of Return"; Rec."Date Of Return")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Record Count"; Rec."Record Count")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Total Received"; Rec."Total Received")
                {
                    ApplicationArea = Basic, Suite;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;

                }
            }
            // part(Control17; "Dispatch ATM Lines")
            // {
            //     // SubPageLink = "Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Global Dimension 2 Code" = field("Global Dimension 2 Code"),
            //     //                                                  Status = filter(Pending);
            //     ApplicationArea = Basic;
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action22)
            {
                Caption = 'Dispatch';

                action(Return)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Process;


                    trigger OnAction()
                    begin
                        if rec.Status = rec.Status::Approved then begin
                            // ATMLines.Reset();
                            // // ATMLines.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            // // ATMLines.SetRange(Status, ATMLines.Status::Pending);
                            // // ATMLines.SetFilter("Date Of Dispatch", '<=%1', (CalcDate('<-6M>', Today)));
                            // // ATMLines.SetRange("To HQ", true);
                            // if ATMLines.Find('-') then begin
                            //     repeat
                            //         ATMLines.Status := ATMLines.Status::Returned;
                            //         ATMLines.Modify;
                            //     until ATMLines.Next = 0;
                            // end;
                        end;
                        CurrPage.Update;
                        MESSAGE('Cards Returned!!')
                    end;
                }

                action(Discard)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Process;


                    trigger OnAction()
                    var

                    begin
                        if rec.Status = rec.Status::Approved then begin
                            // ATMLines.Reset();
                            // // ATMLines.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            // // ATMLines.SetRange(Status, ATMLines.Status::Pending);
                            // // ATMLines.SetRange("To HQ", true);
                            // if ATMLines.Find('-') then begin
                            //     repeat
                            //         ATMLines.Status := ATMLines.Status::Discarded;
                            //         ATMLines.Modify;
                            //     until ATMLines.Next = 0;
                            //end;
                        end;
                        CurrPage.Update;
                        MESSAGE('Cards Discarded!!')
                    end;
                }

            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnAfterGetRecord()
    begin
        //SetControlAppearance;
        // UpdateControl;

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnInit()
    begin
        // UpdateControl;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        TransType: Boolean;
        AccType: Boolean;
        AccNo: Boolean;
        DocNo: Boolean;
        Rmarks: Boolean;
        Amnt: Boolean;
        EmployerC: Boolean;
        IncType: Boolean;
        Pdate: Boolean;
        SalaryLines: Record "Salary Lines";
        LastloanDate: Boolean;
    // ATMLines: Record "ATM Inventory";


}

