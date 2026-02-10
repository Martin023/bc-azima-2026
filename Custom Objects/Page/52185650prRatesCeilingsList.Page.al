page 52185650 "prRates & Ceilings List"
{
    CardPageID = "PR Rates & Ceilings";
    PageType = List;
    SourceTable = "PR Vital Setup Info";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("Rates & Ceilings")
            {
                Caption = 'Rates & Ceilings';
                field("Setup Code"; Rec."Setup Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                group("Tax Reliefs")
                {
                    Caption = 'Tax Reliefs';
                    field("Tax Relief"; Rec."Tax Relief")
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
                    label(Control35)
                    {
                        CaptionClass = Text19076757;
                        ShowCaption = false;
                    }
                    field("Max Relief"; Rec."Max Relief")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    label(Control33)
                    {
                        CaptionClass = Text19058477;
                        ShowCaption = false;
                    }
                }
                group("N.S.S.F Contribution %")
                {
                    Caption = 'N.S.S.F Contribution %';
                    field("NSSF Employee"; Rec."NSSF Employee")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("NSSF Employer Factor"; Rec."NSSF Employer Factor")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("N.H.I.F/N.S.S.F Based On")
                {
                    Caption = 'N.H.I.F/N.S.S.F Based On';
                    field("NHIF Based on"; Rec."NHIF Based on")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NHIF Based On:';
                    }
                    field("NSSF Based on"; Rec."NSSF Based on")
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
                    label(Control24)
                    {
                        CaptionClass = Text19049626;
                        ShowCaption = false;
                    }
                    field("Tax On Excess Pension"; Rec."Tax On Excess Pension")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                group("Home Ownership Savings Plan")
                {
                    Caption = 'Home Ownership Savings Plan';
                    field("Mortgage Relief"; Rec."Mortgage Relief")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Less from Taxable Pay';
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
                    label(Control15)
                    {
                        CaptionClass = Text19080002;
                        ShowCaption = false;
                    }
                    field("Loan Corporate Rate"; Rec."Loan Corporate Rate")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    label(Control13)
                    {
                        CaptionClass = Text19080003;
                        ShowCaption = false;
                    }
                }
                group("Servants Benefits")
                {
                    Caption = 'Servants Benefits';
                    field("Security Day (U)"; Rec."Security Day (U)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Security Night (U)"; Rec."Security Night (U)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Ayah (U)"; Rec."Ayah (U)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Gardener (U)"; Rec."Gardener (U)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Security Day (R)"; Rec."Security Day (R)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Security Night (R)"; Rec."Security Night (R)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Ayah (R)"; Rec."Ayah (R)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Gardener (R)"; Rec."Gardener (R)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                group(Control3)
                {
                    ShowCaption = false;
                    field("Taxable Pay (Normal)"; Rec."Taxable Pay (Normal)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Taxable Pay (Agricultural)"; Rec."Taxable Pay (Agricultural)")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }
    }

    actions
    {
    }

    var
        Text19076757: Label '(%)';
        Text19058477: Label '(Personal+Insurance)';
        Text19049626: Label '(Pension(self)+Nssf)';
        Text19080001: Label '(%)';
        Text19080002: Label '(%)';
        Text19080003: Label '(%)';
}

