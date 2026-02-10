page 52187161 "M-Banking Whitelist List"
{
    ApplicationArea = All;
    Caption = 'M-Banking Whitelist List';
    PageType = List;
    SourceTable = "M-Banking Whitelist App";
    UsageCategory = Lists;

    CardPageId = "M-Banking Whitelist App. Card";

    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    PromotedActionCategories = ',,,Bulk Actions';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Transactional Mobile No."; Rec."Transactional Mobile No.")
                {
                    ToolTip = 'Specifies the value of the Transactional Mobile No. field.', Comment = '%';
                }
                field("Full Names"; Rec."Full Names")
                {
                    ToolTip = 'Specifies the value of the Full Names field.', Comment = '%';
                }
                field("Primary Identification Type"; Rec."Primary Identification Type")
                {
                    ToolTip = 'Specifies the value of the Primary Identification Type field.', Comment = '%';
                }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ToolTip = 'Specifies the value of the Primary Identification field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Is Whitelisted"; Rec."Is Whitelisted")
                {
                    ToolTip = 'Specifies the value of the Is Whitelisted? field.', Comment = '%';
                    Editable = WhitelistEditable;
                }
                field("Whitelist Reference ID"; Rec."Whitelist Reference ID")
                {
                    ToolTip = 'Specifies the value of the Whitelist Reference ID field.', Comment = '%';
                    Editable = WhitelistEditable;
                }
                field("CRM Created By"; Rec."CRM Created By")
                {
                    ToolTip = 'Specifies the value of the CRM Created By field.', Comment = '%';
                }
                field("CRM Originating Branch"; Rec."CRM Originating Branch")
                {
                    ToolTip = 'Specifies the value of the CRM Originating Branch field.', Comment = '%';
                }
                field("CRM Notes"; Rec."CRM Notes")
                {
                    ToolTip = 'Specifies the value of the CRM Notes field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved/Rejected By field.', Comment = '%';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ToolTip = 'Specifies the value of the Approved/Rejected By field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Bulk)
            {
                // action(DownloadTemplate)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Download Template';
                //     // Visible = Rec.Status = Rec.Status::Open;
                //     Image = Download;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     trigger OnAction()
                //     var
                //         theApp: Record "M-Banking Whitelist App";
                //     begin
                //         // Rec.TestField(Status, Rec.Status::Open);

                //         theApp.Reset;
                //         theApp.Init();
                //         Xmlport.Run(Xmlport::"Mbanking Whitelist App.", false, false, theApp);
                //     end;
                // }
                // action(BulkUpdate)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Bulk Whitelist Update';
                //     // Visible = Rec.Status = Rec.Status::Open;
                //     Image = Form;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     trigger OnAction()
                //     begin
                //         // Rec.TestField(Status, Rec.Status::Open);
                //         Xmlport.Run(Xmlport::"Mbanking Whitelist App.", false, true);
                //     end;
                // }
                action(BulkUpdate)
                {
                    ApplicationArea = all;
                    Caption = 'Bulk Whitelist Update';
                    Visible = (Rec.Status = Rec.Status::Approved) and not(Rec."Is Whitelisted");
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        MBWApp: record "M-Banking Whitelist App";
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField("Is Whitelisted", false);

                        if Confirm('Are you sure you want to mark the selected records as whitelisted?') then begin
                            CurrPage.SetSelectionFilter(MBWApp);
                            MBWApp.Next;

                            if MBWApp.FindSet() then begin
                                repeat begin
                                    if MBWApp.Mark() then begin
                                        MBWApp."Is Whitelisted" := true;
                                        MBWApp.Modify(true);
                                    end;
                                end until MBWApp.Next() = 0;
                            end;
                        end else begin
                            Message('Exited successfully!');
                        end;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if (Rec.Status = Rec.Status::Approved) and not (Rec."Is Whitelisted") then begin
            WhitelistEditable := true;
        end;
    end;

    var
        WhitelistEditable: Boolean;
}
