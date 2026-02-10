page 52187302 "Self Loan Application List"
{
    CardPageID = "Self Loan Application Card";
    DeleteAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Self Loan Application";
    UsageCategory = Lists;
    ApplicationArea = Basic;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field("Applicant Staff No."; Rec."Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "Credit Statistics")
            {
                ApplicationArea = Basic;
                SubPageLink = "Member No." = FIELD("Member No.");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {

        }
    }

    trigger OnAfterGetRecord()
    begin
        HREmp.Reset;
        if HREmp.Get(Rec."Applicant Staff No.") then begin
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            EmpName := 'n/a';
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        xRec.Reset;
        xRec.SetRange(xRec."Applicant User ID", UserId);
        xRec.SetRange(xRec.Status, xRec.Status::New);
        if xRec.Find('-') then
            Error('You still have a new leave application no' + ' ' + xRec."Application Code" + 'that needs to be utilized first');

        xRec.Reset;
        xRec.SetRange(xRec."Applicant User ID", UserId);
        xRec.SetRange(xRec.Status, xRec.Status::"Pending Approval");
        if xRec.Find('-') then
            Error('You your leave application no' + ' ' + xRec."Application Code" + 'is still  pending Approval. Kindy Contact the HR department to have it approved first')
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Applicant User ID", UserId);

    end;

    var
        EmpName: Text;
        HREmp: Record "HR Employees";

    //[Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        Rec.TestField("Loan Type");
        Rec.TestField("Requested Amount");
        Rec.TestField("Application Date");
    end;


    local procedure LastLineNo(): Integer
    var
        Buffer_2: Record "Buffer table";
    begin
        Buffer_2.Reset;
        if Buffer_2.FindLast then begin
            exit(Buffer_2."Counter Variable" + 1);
        end else begin
            exit(1);
        end;
    end;
}

