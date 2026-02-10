#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187207 pageextension52187207 extends "User Card"
{
    layout
    {
        modify("User Security ID")
        {
            ApplicationArea = Basic;
        }
        modify("User Name")
        {
            ApplicationArea = Basic;
        }
        modify("Full Name")
        {
            ApplicationArea = Basic;
        }
        modify("License Type")
        {
            ApplicationArea = Basic;
        }
        modify(State)
        {
            ApplicationArea = Basic;
        }
        modify("Expiry Date")
        {
            ApplicationArea = Basic;
        }
        modify("Contact Email")
        {
            ApplicationArea = Basic;
        }

        modify("Windows Security ID")
        {
            ApplicationArea = Basic;
        }
        // modify("Windows User Name Desktop")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""Windows User Name Desktop"(Control 7)".

        //     ApplicationArea = Basic;
        // }
        modify(ACSStatus)
        {
            ApplicationArea = Basic;
        }
        modify("NAV Password Authentication")
        {
            Caption = 'Microsoft Dynamics NAV Password Authentication';
        }
        modify(Password)
        {
            ApplicationArea = Basic;
        }
        modify("Change Password")
        {
            ApplicationArea = Basic;
        }
        modify(WebServiceID)
        {
            ApplicationArea = Basic;
        }
        modify(WebServiceExpiryDate)
        {
            ApplicationArea = Basic;
        }
        modify("Authentication Email")
        {
            ApplicationArea = Basic;
        }
        modify(AuthenticationStatus)
        {
            ApplicationArea = Basic;
        }

        modify("Windows User Name")
        {
            Visible = true;
        }

        modify(ApplicationID)
        {
            Visible = true;
        }
        modify(MappedToExchangeIdentifier)
        {
            Visible = true;
        }


    }
    actions
    {
        modify(AcsSetup)
        {
            ApplicationArea = Basic;
        }
        modify(ChangePassword)
        {

            ApplicationArea = Basic;
        }
        modify(ChangeWebServiceAccessKey)
        {
            ApplicationArea = Basic;
        }

        modify(DeleteExchangeIdentifier)
        {
            Visible = false;
        }
        // modify(ActionGroup39)
        // {
        //     Visible = false;
        // }
        modify("Effective Permissions")
        {
            Visible = false;
        }
    }

    var
        UserSID: Text;


    trigger OnOpenPage()
    begin
        OnAccesRestrictView();
    end;

    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance.';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("Edit Setup", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::Administrator);
        if not ChangePermission.Find('-') then begin
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end;
    end;
}
