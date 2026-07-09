page 52185553 "HR Leave Types Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HR Leave Types";


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Leave type";Rec."Leave type Enum")
                {
                    ShowMandatory=True;
                    Caption='Leave Type';
                    ApplicationArea=all;

                    
                }
                Field("Salary Grade";Rec."Salary Grade")
                {
                    
                }
                 field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = Basic;
                    
                }
               
                field("Unlimited Days"; Rec."Unlimited Days")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Non Working Days"; Rec."Inclusive of Non Working Days")
                {
                    ApplicationArea = Basic;
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                    ApplicationArea = Basic;
                }
                field("Is Annual Leave"; Rec."Is Annual Leave")
                {
                    ApplicationArea = Basic;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic;
                }
                field("Carry Forward Allowed"; Rec."Carry Forward Allowed")
                {
                    ApplicationArea = Basic;
                }
                group("Carry Forward")
                {
                    Caption = 'Carry Forward';
                    grid(Control2)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1)
                        {
                            ShowCaption = false;
                            field(Balance; Rec.Balance)
                            {
                                ApplicationArea = Basic;

                                trigger OnValidate()
                                begin

                                    fn_SetVisible;
                                end;
                            }
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        fn_SetVisible;
        OnViewCurrRec();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
            OnViewCurrRec();
    end;
    var

        CarryForwardVisible: Boolean;

    local procedure fn_SetVisible()
    begin
        //Dann - To hide fields to prevent setup errors and hide uneccessary fields
        CarryForwardVisible := false;
        case Rec.Balance of
            Rec.Balance::"Carry Forward":
                begin
                    CarryForwardVisible := true;
                end;
        end;
    end;


        procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserID);
        ChangePermission.SetRange("View Payroll", true);
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserID);
    end;
}

