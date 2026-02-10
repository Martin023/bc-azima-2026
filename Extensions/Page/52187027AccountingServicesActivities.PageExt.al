#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187027 pageextension52187027 extends "Accounting Services Activities"
{
    layout
    {
        modify("My Incoming Documents")
        {
            ApplicationArea = Basic;
        }
        modify("Ongoing Sales Invoices")
        {
            ApplicationArea = Basic;
            // DrillDownPageID = "Mini Sales Invoice";
        }
        modify("Requests to Approve")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""My Incoming Documents"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ongoing Sales Invoices"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Requests to Approve"(Control 1)".

        modify("My User Tasks")
        {
            Visible = false;
        }
        modify("UserTaskManagement.GetMyPendingUserTasksCount")
        {
            Visible = false;
        }
    }
    actions
    {
        // modify("Camera(Control 8).CreateIncomingDocumentFromCamera")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Camera(Control 8).CreateIncomingDocumentFromCamera(Action 6)".

    }

    //Unsupported feature: Property Modification (ExternalDataType) on "Camera(Control 8).CreateIncomingDocumentFromCamera(Action 6).OnAction.CameraOptions(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Camera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Camera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (ExternalDataType) on "CameraProvider(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
    //Variable type has not been exported.

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
