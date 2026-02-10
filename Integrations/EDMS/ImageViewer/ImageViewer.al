controladdin "Image Viewer"
{
    Scripts = 'bc-kenpipe-2024/Integrations/EDMS/ImageViewer/script.js';
    StartupScript = 'bc-kenpipe-2024/Integrations/EDMS/ImageViewer/Startup.js';
    StyleSheets = 'bc-kenpipe-2024/Integrations/EDMS/ImageViewer/stylesheet.css';

    MinimumHeight = 400;
    MinimumWidth = 100;
    // MaximumHeight = 2000;
    // MaximumWidth = 4000;
    HorizontalStretch = true;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalShrink = true;

    event ControlAddinReady();
    procedure LoadImage(ImageDocument: Text)
    procedure SetVisible(IsVisible: Boolean)
}