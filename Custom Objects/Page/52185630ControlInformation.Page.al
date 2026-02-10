page 52185630 "Control-Information"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Control-Information";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Company P.I.N"; Rec."Company P.I.N")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("N.S.S.F No."; Rec."N.S.S.F No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("N.H.I.F No"; Rec."N.H.I.F No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Company code"; Rec."Company code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Mission; Rec.Mission)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Vision; Rec.Vision)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Mission/Vision Link"; Rec."Mission/Vision Link")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Multiple Payroll"; Rec."Multiple Payroll")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Physical Address")
            {
                Caption = 'Physical Address';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Name';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Address';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Address 2';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Code/City';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Company)
            {
                Caption = 'Company';
                action(Committes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Committes';
                    //RunObject = Page Page52211;
                    Visible = false;
                }
                action("Board Of Directors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Board Of Directors';
                    //RunObject = Page Page52212;
                    Visible = false;
                }
                action("Rules & Regulations")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rules & Regulations';
                    //RunObject = Page Page52213;
                    Visible = false;
                }
                action("Company Activities")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Activities';
                    //RunObject = Page Page52226;
                }
                action("Base Calendar")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Base Calendar';
                    Image = Calendar;
                    RunObject = Page "Base Calendar Card";
                }
                action("Vendors & Service Providers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors & Service Providers';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
}

