page 52186019 "Contract List"
{
    Caption = 'Grant List';
    //CardPageID = 39005823;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Jobs;
    SourceTableView = WHERE(Status = CONST(Contract),
                            "Approval Status" = FILTER(Open | "Pending Approval"));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Person Responsible"; Rec."Person Responsible")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Next Invoice Date"; Rec."Next Invoice Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Job Posting Group"; Rec."Job Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Links)
            {
                ApplicationArea = Basic, Suite;
               // Editable = false;
                Visible = true;
            }
            systempart(Control7; Notes)
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Grant")
            {
                Caption = '&Grant';
                action("<Page Proposal Card>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Page Proposal Card';
                    Image = EditLines;
                    // RunObject = Page Page39005856;
                    // RunPageLink = Field1 = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Job),
                                  "No." = FIELD("No.");
                }
                group(Dimensions)
                {

                    Caption = 'Dimensions';
                    action("<Page Grant Task Dimensions>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimensions-Single';
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimensions-&Multiple';

                        trigger OnAction()
                        var
                            Job: Record Jobs;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(Job);
                            //DefaultDimMultiple.SetMultiJob(Job);
                            DefaultDimMultiple.RunModal;
                        end;
                    }
                }
                action("<Page Grant Ledger Entries>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    // RunObject = Page Page39005819;
                    // RunPageLink = Field2 = FIELD("No.");
                    // RunPageView = SORTING(Field2, Field1000, Field64, Field3);
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Grant Task Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Grant Task Lines';

                    trigger OnAction()
                    begin
                        /*JTLines.SetJobNo("No.");
                        JTLines.RUN;
                        */

                    end;
                }
                action("<Page Grant Statistics>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page Page39005880;
                    // RunPageLink = Field1 = FIELD("No.");
                    ShortCutKey = 'F7';
                }
            }
        }
        area(processing)
        {
            action(cgfdg)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'G/L Account Card';
                RunObject = Page "G/L Account Card";
            }
        }
    }
}

