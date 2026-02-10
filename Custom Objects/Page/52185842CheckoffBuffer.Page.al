page 52185842 "Checkoff Buffer"
{
    PageType = List;
    SourceTable = "Checkoff Buffer";
    ApplicationArea = Basic, Suite;
    PromotedActionCategories = ',,,Consolidate Data';

    InsertAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Upload No."; Rec."Upload No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Payroll; Rec.Payroll)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field("Loan No"; Rec."Loan No")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field(Interest; Rec.Interest)
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Search Code"; Rec."Search Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Checkoff No"; Rec."Checkoff No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Savings Account"; Rec."Savings Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Credit Account"; Rec."Credit Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Other Comments"; Rec."Other Comments")
                {
                    Editable = false;
                }

                field("Upload Response"; Rec."Upload Response")
                {
                    Editable = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Record Found"; Rec."Record Found")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    //Editable:=false;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            // action("Validate Buffer")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Accounts;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     var
            //         MsgValidate: Label 'Validation Successful';
            //     begin
            //         PeriodicCheckoff.CheckoffValidate(Rec);
            //         MESSAGE(MsgValidate);
            //     end;
            // }
            action("Import Checkoff")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Checkoff Buffer";
            }
            // action("Consolidate Data")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = GetEntries;
            //     Promoted = true;
            //     PromotedCategory = Category4;

            //     trigger OnAction()
            //     begin
            //         PeriodicCheckoff.ConsolidateBuffer(Rec);
            //     end;
            // }
            action("Clear Buffer")
            {
                ApplicationArea = Basic, Suite;
                Image = DeleteAllBreakpoints;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to delete?', false) = false then
                        exit;
                    CheckoffH.Reset();
                    CheckoffH.SetRange("No.", Rec."Checkoff No");
                    if CheckoffH.Find('-') then begin
                        if CheckoffH.Status <> CheckoffH.Status::Open then
                            Error('Invalid option, status must be open.')
                        else begin
                            Rec.DeleteAll;
                            CheckoffLines.Reset();
                            CheckoffLines.SetRange("Checkoff Header", CheckoffH."No.");
                            CheckoffLines.DeleteAll;
                            Message('Entries deleted successfully');
                        end;
                    end;
                end;
            }
            action("Clear Non validated Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CheckoffBuff: record "Checkoff Buffer";
                begin
                    if Confirm('Are you sure you wish to delete?', false) = false then
                        exit;
                    CheckoffH.Reset();
                    CheckoffH.SetRange("No.", Rec."Checkoff No");
                    if CheckoffH.Find('-') then begin
                        if CheckoffH.Status <> CheckoffH.Status::Open then
                            Error('Invalid option, status must be open.')
                        else begin
                            CheckoffBuff.Reset();
                            CheckoffBuff.SetRange("Checkoff No", CheckoffH."No.");
                            CheckoffBuff.SetRange("Record Found", false);
                            CheckoffBuff.DeleteAll();
                            //Rec.DeleteAll;
                            CheckoffLines.Reset();
                            CheckoffLines.SetRange("Checkoff Header", CheckoffH."No.");
                            CheckoffLines.DeleteAll;
                            Message('Entries deleted successfully');
                        end;
                    end;
                end;
            }
        }
    }

    var
        PeriodicCheckoff: Codeunit "Periodic Activities";
        ListPlus: page 1507;
        CheckoffH: Record "Checkoff Header";
        CheckoffLines: Record "Checkoff Lines";
}

