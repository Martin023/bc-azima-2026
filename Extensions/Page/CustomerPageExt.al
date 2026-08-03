pageextension 52187301 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        addafter("No.")
        {
            field("Old No."; Rec."Old No.")
            {
                ApplicationArea = All;
            }

        }
        addafter(Name)
        {
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = All;
                Caption = 'Account Type';
                ToolTip = 'Account Type';
            }
            group("Employer Details")
            {
                //Editable = Rec."Account Type" = Rec."Account Type"::Employer;
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                    Caption = 'Employer Code';
                    ToolTip = 'Employer Code';
                }
                field("Employer Name"; Rec."Employer Code Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employer Code Name';
                    ToolTip = 'Employer Code Name';
                }
            }
            field("Member Class Account Type"; Rec."Member Class Account Type")
            {
                ToolTip = 'This field is used to identify child hope accounts on member register, so that to graduate them to class A when its DUE';
            }
            field("Graduation To Class"; Rec."Graduation To Class")
            {
                ToolTip = 'This field will hold the value for whose members in the employer code subject to graduation will graduate to';
            }
            field("Checkoff Cuttoff Day"; Rec."Checkoff Cuttoff Day")
            {

            }
            field("Full deposit Guarantee"; Rec."Full deposit Guarantee")
            {
                ApplicationArea = All;
                Caption = 'Full Deposit Guarantee';
                ToolTip = 'Full Deposit Guarantee';
            }
            field("Employee Job Group"; Rec."Employee Job Group")
            {
                ApplicationArea = All;
                Caption = 'Employee Job Group';
                ToolTip = 'Employee Job Group';
            }
            field("Document Limit"; Rec."Document Limit")
            {
                ApplicationArea = All;
                Caption = 'Document Limit';
                ToolTip = 'Document Limit';
            }
            field("Advice method"; Rec."Advice Method")
            {
                ApplicationArea = All;
                Caption = 'Advice Method';
                ToolTip = 'Advice Method';
            }
            field("Loans Cleared"; Rec."Loans Cleared")
            {
                ApplicationArea = All;
                Caption = 'Loan clearence from checkoff';
                ToolTip = 'Loan clearence from checkoff.';
            }
            field("Internal Staff Employer"; Rec."Internal Staff Employer")
            {
                ApplicationArea = All;
                Caption = 'Internal Staff Employer';
                ToolTip = 'Internal Staff Employer';
            }

            field("Dont Charge Transactions"; Rec."Dont Charge Transactions")
            {
                ApplicationArea = All;
                Caption = 'Dont Charge Transactions';
            }
            field("Self Employed"; Rec."Self Employed")
            {
                ApplicationArea = All;
                Caption = 'Self Employed';
                ToolTip = 'Check this for all self employed members who want to join';
            }
            field("Signatory Specimen"; Rec."Signatory Specimen")
            {
                ApplicationArea = All;

            }
            field("Digit Custodian"; Rec."Digit Custodian")
            {
                ApplicationArea = All;
                Caption = 'Digit Custodian';
            }
            // field("Responsible Employee"; Rec."Responsible Employee")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Responsible Employee';
            //     ToolTip = 'Responsible Employee';
            //     Editable = not Rec."Digit Custodian";
            // }
            field("Responsible Employee Extension"; Rec."Responsible Employee Extension")
            {
                ApplicationArea = All;
                Caption = 'Relation Officer Type';
                ToolTip = 'Relation Officer Type';
            }
            field("Responsible Employee Name"; Rec."Responsible Employee Name")
            {
                ApplicationArea = All;
                Caption = 'Relation Officer';
                ToolTip = 'Relation Officer';
            }


        }
        addlast("Address & Contact")
        {
            group("Tenant Details")
            {
                field("Introduced By"; Rec."Introduced By")
                {
                    ApplicationArea = All;
                    Caption = 'Introduced By';
                    ToolTip = 'Introduced By';
                }
                field("Tenant Referees"; Rec."Tenant Referees")
                {
                    ApplicationArea = All;
                    Caption = 'Tenant Referees';
                    ToolTip = 'Tenant Referees';
                }
                field("Tenant Referees Phone"; Rec."Tenant Referees Phone")
                {

                }
                field("Type of Business"; Rec."Type of Business")
                {

                }
                field("KRA PIN"; Rec."KRA PIN")
                {

                }

            }
        }

        modify("No.")
        {
            ApplicationArea = All;
            Visible = TRUE;
        }
        addafter("Last Date Modified")
        {
            field("Last Transaction Date"; Rec."Last Transaction Date")
            {
                ApplicationArea = All;
                Visible = TRUE;
                Editable = FALSE;
            }
        }
    }

    actions
    {
        modify("Report Statement")
        {
            Visible = false;
        }
        addafter("S&ales")
        {
            action("Customer Report")
            {
                Caption = 'Customer Report';
                Image = Report2;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    Customer.SetRange("No.", Rec."No.");
                    Report.Run(52186801, true, false, Customer);
                end;
            }

            action("Signatory Specimen A")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Signatory Specimen';
                Image = CancelAttachment;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    FilePath: Text;
                    InstReam: InStream;
                begin
                    if UploadIntoStream('Select File .. ', '', '', FilePath, InstReam) then
                        UploadFile(InstReam, FilePath);
                end;
            }
            action("View PDF")
            {
                ApplicationArea = Basic, Suite;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    FilePath: Text;
                    InstReam: InStream;
                    Cust: Record Customer;
                begin
                    Cust.SetRange("No.", Rec."No.");
                    Page.Run(52186649, Cust);
                end;
            }
            action("Information Base")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Flagging/Information Base';
                Image = CancelAttachment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Loanee Information Base";
                RunPageLink = "Member No." = FIELD("No.");
            }
            action("Customer Statement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer Statement';
                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    Customer.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Customer Statement1", true, false, Customer);
                end;

            }



            action("Send SMS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send SMS';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Members: Record Members;
                    SendSMS: Codeunit SendSms;
                    Source: enum "SMS Source";
                    msg: Text[600];
                begin
                    Members.Reset();
                    Members.SetRange("Employer Code", Rec."No.");
                    if Members.FindSet() then begin
                        msg := 'Dear ' + Members.Name + ', Kindly note that your Employer has not remitted your salaries deductions to the sacco.';
                        SendSMS.SendSms(Source::Tenants, Members."Phone No.", msg, Format(Members."No."), '', true, 0, false, 'CBS', Format(Members."No."), 'CBS');
                    end;
                    Message('Sent Successfully!');
                end;
            }
        }

    }
    trigger OnOpenPage()
    begin
        //CheckMemberInfomation();
    end;

    procedure UploadFile(DocInstream: InStream; FileName: Text)
    var
        FileMngt: Codeunit "File Management";
        OutStream: OutStream;
    begin
        Rec."Signatory Specimen".CreateOutStream(OutStream);
        CopyStream(OutStream, DocInstream);
        Rec.Modify();
    end;


    procedure CheckMemberInfomation()
    var
        LoaneeInfomationBase: Record "Loanee Infomation Base";
    begin
        LoaneeInfomationBase.Reset();
        LoaneeInfomationBase.SetRange("Member No.", Rec."No.");
        LoaneeInfomationBase.SetFilter(Info, '<>%1', '');
        if LoaneeInfomationBase.Find('-') then begin
            repeat
                if (LoaneeInfomationBase."Expiry Date" = 0D) or (LoaneeInfomationBase."Expiry Date" > Today) then
                    Message(LoaneeInfomationBase.Info);
            until LoaneeInfomationBase.Next = 0;
        end;

    end;

}