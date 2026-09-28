page 52186264 "Status Change Permssion."
{
    PageType = List;
    SourceTable = "Status Change Permissions.";
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Function"; Rec."Function")
                {
                    ApplicationArea = Basic;
                    OptionCaption = '<,View Payroll,View Employee Record,Edit User Setup,Edit Banking User Setup,Edit Credit Setup';
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Function Extended"; Rec."Function Extended")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Banking User Setup"; Rec."Edit Banking User Setup")
                {
                    ApplicationArea = Basic;
                }
                field("View Payroll"; Rec."View Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Payroll"; Rec."Edit Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("View Setup"; Rec."View Setup")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Setup"; Rec."Edit Setup")
                {
                    ApplicationArea = Basic;
                }
                field("Update Rejoining Member"; Rec."Update Rejoining Member")
                {
                    ApplicationArea = Basic;
                }
                field("View G/L Account"; Rec."View G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Edit  G/L Account"; Rec."Edit  G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Member Changes"; Rec."Edit Member Changes")
                {
                    ApplicationArea = Basic;
                }
                field("View Employee Record"; Rec."View Employee Record")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Employee Record"; Rec."Edit Employee Record")
                {
                    ApplicationArea = Basic;
                }
                field("Block account"; Rec."Block account")
                {
                    ApplicationArea = Basic;
                }
                field("Unblock Account"; Rec."Unblock Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Writting"; Rec."Cheque Writting")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Bank Card"; Rec."Edit Bank Card")
                {
                    ApplicationArea = Basic;
                }

                field("Upload Old Loans"; Rec."Upload Old Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Vendor"; Rec."Edit Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("View Edit"; Rec."View Edit")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Customer"; Rec."Edit Customer")
                {
                    ApplicationArea = Basic;
                }
                field("View Customer"; Rec."View Customer")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Journal"; Rec."Edit Journal")
                {
                    Caption = 'Post Journal/Reversal';
                    ApplicationArea = Basic;
                }
                field("Edit Fixed Asset"; Rec."Edit Fixed Asset")
                {
                    ApplicationArea = Basic;
                }
                field("View Next of Kin"; Rec."View Next of Kin")
                {
                    ApplicationArea = Basic;
                }
                field("Edit Next of Kin"; Rec."Edit Next of Kin")
                {
                    ApplicationArea = Basic;
                }
                field("View HR"; Rec."View HR")
                {
                    ApplicationArea = Basic;
                }
                field("Edit HR"; Rec."Edit HR")
                {
                    ApplicationArea = Basic;
                }
                field("Reset Notice Date"; Rec."Reset Notice Date")
                {
                    ApplicationArea = Basic;
                }
                field("Block Mobile Loan"; Rec."Block Mobile Loan")
                {
                    ApplicationArea = Basic;
                }
                field("View Funds Management Setup"; Rec."View Funds Management Setup")
                {
                    ApplicationArea = Basic;
                }
                field("Register ADM Attendance"; Rec."Register ADM Attendance")
                {
                    ApplicationArea = Basic;
                }
                field("Product Setup"; Rec."Product Setup")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Setup"; Rec."Appraisal Setup")
                {

                }
                field("Process Risk Claims"; Rec."Process Risk Claims")
                {

                }
                field("Mbanking - View"; Rec."Mbanking - View")
                {

                }
                field("Mbanking - Edit"; Rec."Mbanking - Edit")
                {

                }
                field("ATM - View"; Rec."ATM - View")
                {

                }
                field("Edit Div Advance"; Rec."Edit Div Advance")
                {

                }
                field("Recover Share & Entrance Fee"; Rec."Recover Share & Entrance Fee")
                {
                }
                field("View Staff Acc"; Rec."View Staff Acc")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //OnViewCurrRec();
    end;

    //[Scope('OnPrem')]
    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Edit Setup", true);
        ChangePermission.SetRange("Product Setup", true);
        ChangePermission.SetRange("Responsibility Centre", 'ICT');
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}

