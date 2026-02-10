#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185644 pageextension52185644 extends "Item Picture" 
{

    //Unsupported feature: Property Modification (PageType) on ""Item Picture"(Page 346)".

    layout
    {
        modify(Picture)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Picture(Control 1)".


        //Unsupported feature: Property Deletion (ShowCaption) on "Picture(Control 1)".

    }
    actions
    {

        //Unsupported feature: Property Modification (ActionContainerType) on "ActionContainer2(Action 2)".

        modify(TakePicture)
        {

            //Unsupported feature: Property Modification (Name) on "TakePicture(Action 3)".

            Caption = 'Take Picture';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on "TakePicture(Action 3)".

        }

        //Unsupported feature: Code Insertion (VariableCollection) on ""Take Picture"(Action 3).OnAction".

        //trigger (Variable: CameraOptions)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "TakePicture(Action 3).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            TakeNewPicture;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IF NOT CameraAvailable THEN
              EXIT;
            CameraOptions := CameraOptions.CameraOptions;
            CameraOptions.Quality := 100;
            CameraProvider.RequestPictureAsync(CameraOptions);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "TakePicture(Action 3)".

        modify(ImportPicture)
        {
            Visible = false;
        }
        modify(ExportFile)
        {
            Visible = false;
        }
        modify(DeletePicture)
        {
            Visible = false;
        }
    }

    var
       // CameraOptions: dotnet CameraOptions;


    //Unsupported feature: Property Modification (ExternalDataType) on "CameraProvider(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
        //Variable type has not been exported.

    //Unsupported feature: Variable Insertion (Variable: OutStream) (VariableCollection) on ""CameraProvider@1000::PictureAvailable"(EVENT 10)".



    //Unsupported feature: Code Modification on ""CameraProvider@1000::PictureAvailable"(EVENT 10)".

    //trigger "CameraProvider@1000::PictureAvailable"(EVENT 10)()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF (PictureName = '') OR (PictureFilePath = '') THEN
          EXIT;

        IF Picture.COUNT > 0 THEN
          IF NOT CONFIRM(OverrideImageQst) THEN BEGIN
            IF ERASE(PictureFilePath) THEN;
            EXIT;
          END;

        File.OPEN(PictureFilePath);
        File.CREATEINSTREAM(Instream);

        CLEAR(Picture);
        Picture.IMPORTSTREAM(Instream,PictureName);
        IF NOT MODIFY(TRUE) THEN
          INSERT(TRUE);

        File.CLOSE;
        IF ERASE(PictureFilePath) THEN;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF (PictureName = '') OR (PictureFilePath = '') THEN
          EXIT;
        #10..12
        Picture.CREATEOUTSTREAM(OutStream);
        COPYSTREAM(OutStream,Instream);
        MODIFY(TRUE);
        #17..19
        */
    //end;
}
