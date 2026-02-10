page 52186040 "Quotation Request Vendors"
{
    PageType = List;
    SourceTable = "Quotation Request Vendors";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Document No."; Rec."Requisition Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Rec.Email)
                {

                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print/Preview")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    PQH.SetRecFilter;
                    PQH.SetFilter(PQH."Document Type", '%1', Rec."Document Type");
                    PQH.SetFilter("No.", Rec."Requisition Document No.");

                    // repvend.SetTableView(PQH);
                    // repvend.Run;
                end;
            }
            action("Send Email to vendor")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = "Process";

                trigger OnAction()
                var
                    Vendor: record "Quotation Request Vendors";
                begin
                    Vendor.Reset;
                    Vendor.SetRange(vendor."Requisition Document No.", Rec."Requisition Document No.");
                    if Vendor.FindSet() then begin
                        repeat
                            Rec.TestField(Rec.Email);
                            SendEmailWithAttachment(rec."Email");
                        until Vendor.next = 0;
                    end;
                    Message('Request For Quotation  sent.');
                end;



            }
        }
    }

    var
        PQH: Record "Purchase Quote Header";
        ////here//repvend: Report "RFQ Report";
        QuotationRequestVendors: Record "Quotation Request Vendors";

    procedure SendEmailWithAttachment(var emailadress: Text[50])
    var
        ReportExample: Report "Member Detailed Statement";
        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters: Text;
        TxtRecipientsList: List of [Text];
    begin
        //ReportParameters := ReportExample.RunRequestPage();
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"RFQ Printout", ReportParameters, ReportFormat::Pdf, OutStr);
        TempBlob.CreateInStream(InStr);

        // TxtRecipientsList.Add(emailadress);
        EmailMsg.Create(emailadress, 'Subject-Request For Quotation', 'Please Provide Prices for the Items Specified');
        EmailMsg.AddAttachment('RFQ.pdf', 'PDF', InStr);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;
}

