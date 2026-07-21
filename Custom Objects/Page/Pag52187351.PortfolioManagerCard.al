namespace AzimaBC.AzimaBC;

page 52187351 "Portfolio Manager Card"
{
    ApplicationArea = All;
    Caption = 'Portfolio Manager Card';
    PageType = Card;
    SourceTable = "Portfolio Manager";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                editable = rec.Transfered = false;
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Sales Representative"; Rec."Sales Representative")
                {
                    ToolTip = 'Specifies the value of the Sales Representative field.', Comment = '%';
                }
                field("Sales Rep Name"; Rec."Sales Rep Name")
                {
                    ToolTip = 'Specifies the value of the Sales Rep Name field.', Comment = '%';
                }
                field("No.of Members"; Rec."No.of Members")
                {
                    ToolTip = 'Specifies the value of the No.of Members field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Incoming Sales Rep"; Rec."Incoming Sales Rep")
                {
                }
                field("Incoming Rep Name"; Rec."Incoming Rep Name")
                {
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Transfered; Rec.Transfered)
                {
                    ToolTip = 'Specifies the value of the Transfered field.', Comment = '%';
                }
            }
            part("PortfolioManagementLines"; "Portfolio Management Lines")
            {
                editable = rec.Transfered = false;
                SubPageLink = "Header No" = field(No);
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenMembersPortfolio)
            {
                Caption = 'Generate Members Portfolio';
                Image = Trace;
                Enabled = Rec.Transfered = false;
                trigger OnAction()
                begin
                    rec.TestField(Transfered, false);
                    PortFolioMgtLines.reset();
                    PortFolioMgtLines.setrange("Header No", Rec.No);
                    PortFolioMgtLines.DeleteAll();
                    Members.reset();
                    Members.SetCurrentKey("No.");
                    members.SetLoadFields("No.", Name, "Employer Code", "Payroll/Staff No.", Gender, "Phone No.", Status, Subflag);
                    Members.SetFilter(Status, '%1|%2|%3', Members.Status::Active, Members.Status::Dormant, Members.Status::New);
                    Members.SetRange("Recruited By", Rec."Sales Representative");
                    if Members.FindSet() then begin
                        repeat
                            PortFolioMgtLines.Init;
                            PortFolioMgtLines."Header No" := Rec.No;
                            PortFolioMgtLines."Member No" := Members."No.";
                            PortFolioMgtLines.Name := Members.Name;
                            PortFolioMgtLines."Employer Code" := Members."Employer Code";
                            PortFolioMgtLines."PF Number" := Members."Payroll/Staff No.";
                            PortFolioMgtLines.Gender := Members.Gender;
                            PortFolioMgtLines."Primary Identification" := Members."Primary Identification";
                            PortFolioMgtLines."Registration Date" := Members."Registration Date";
                            PortFolioMgtLines."Phone No" := Members."Phone No.";
                            PortFolioMgtLines.Status := Members.Status;
                            PortFolioMgtLines."Sub Status" := Members.Subflag;
                            PortFolioMgtLines."Sales Rep code" := members."Recruited By";
                            PortFolioMgtLines.Insert();
                        until Members.Next() = 0;
                    end;
                end;
            }

            action(TransferToAX)
            {
                Caption = 'Transfer Portfolio';
                Image = Trace;
                Enabled = Rec.Transfered = false;
                trigger OnAction()
                begin
                    rec.TestField("Incoming Sales Rep");
                    if Confirm('Do you wish to transfer Portolio to the New Representative?', false) then begin
                        PortFolioMgtLines.reset();
                        PortFolioMgtLines.SetCurrentKey("Header No");
                        PortFolioMgtLines.SetFilter("Header No", '%1', Rec.No);
                        if PortFolioMgtLines.FindSet() then begin
                            repeat
                                if Members.get(PortFolioMgtLines."Member No") then begin
                                    Members."Recruited By" := rec."Incoming Sales Rep";
                                    Members."Recruited By Name" := rec."Incoming Rep Name";
                                    Members.Modify();
                                end;
                            until PortFolioMgtLines.next() = 0;
                        end
                        else
                            Error('There are no lines to transfer.');
                        rec.Transfered := true;
                        rec.Modify();
                    end;
                end;
            }

        }
    }
    var
        Members: record Members;
        PortFolioMgtLines: record "Portfolio Manager Lines";
}
