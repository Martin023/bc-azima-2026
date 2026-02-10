page 52185628 "PR Rates & Ceilings"
{
    PageType = Card;
    SourceTable = "PR Vital Setup Info";

    layout
    {
        area(content)
        {
            group("Tax Relief")
            {
                Caption = 'Tax Relief';
                field("Setup Code"; Rec."Setup Code")
                {
                    ApplicationArea = Basic, Suite;
                    // Editable = false;
                }
                field(Control20; Rec."Tax Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Insurance Relief"; Rec."Insurance Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NHIF Relief"; Rec."NHIF Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max Relief"; Rec."Max Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Disbled Tax Limit"; Rec."Disbled Tax Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Relief Amount"; Rec."Minimum Relief Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("NSSF Contribution")
            {
                Caption = 'NSSF Contribution';
                field("NSSF Employee"; Rec."NSSF Employee")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NSSF Employer Factor"; Rec."NSSF Employer Factor")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("NSSF Based on"; Rec."NSSF Based on")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("New NSSF Rate %"; Rec."New NSSF Rate %")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(SHIF)
            {
                Caption = 'SHIF';
                field("NHIF Based on"; Rec."NHIF Based on")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Select one:';
                }
                field("SHIF Percentage%"; Rec."SHIF Percentage%")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SHIF Relief%"; Rec."SHIF Relief%")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Housing Levy Rate")
            {
                Caption = 'Housing Levy';
                field("Housing Levy"; Rec."Housing Levy")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Housing Levy Employer Factor"; Rec."Housing Levy Employer Factor")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Housing Levy Based on"; Rec."Housing Levy Based on")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Pension)
            {
                Caption = 'Pension';
                field("Max Pension Contribution"; Rec."Max Pension Contribution")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Mortgage)
            {
                Caption = 'Mortgage';
                field("Mortgage Relief"; Rec."Mortgage Relief")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mortgage Relief (Less from Taxable Pay)';
                }
                field("Mortgage Relief Percentage"; Rec."Mortgage Relief Percentage")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Owner Occupier Interest")
            {
                Caption = 'Owner Occupier Interest';
                field("OOI Deduction"; Rec."OOI Deduction")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Max Monthly Contribution';
                }
                field("OOI December"; Rec."OOI December")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'December deduction';
                }
            }
            group("Staff Loans")
            {
                Caption = 'Staff Loans';
                field("Loan Market Rate"; Rec."Loan Market Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Corporate Rate"; Rec."Loan Corporate Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Affordable Housing")
            {
                Caption = 'Affordable Housing';
                field("Affordable Housing Relief"; Rec."Affordable Housing Relief")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("AffordableH Relief%"; Rec."AffordableH Relief%")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Allowances)
            {
                Caption = 'Allowances';
                field("Acting Allowance Percentage"; Rec."Acting Allowance Percentage")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Acting Allowance Based On"; Rec."Acting Allowance Based On")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Acting Allowance Duration"; Rec."Acting Allowance Duration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Leave Allowance Percentage"; Rec."Leave Allowance Percentage")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Leave Allowance Based On"; Rec."Leave Allowance Based On")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Training Deduction Percentage"; Rec."Training Deduction Percentage")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Leave Allowance"; Rec."Max. Leave Allowance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary increment %"; Rec."Salary increment %")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Grade Allowance"; Rec."Grade Allowance")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Grade; rec.Grade)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }


    actions
    {
    }

    //[Scope('OnPrem')]
    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Edit Setup", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::"Edit HR Setups");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}

