#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186799 "Quick Select SMS Header"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Quck Select.rdl';

    dataset
    {
        dataitem("Alerts Loan Lines"; "Alerts Loan Lines")
        {
            RequestFilterFields = "Loan No.", "Loan Product Type", "Days In Arrears", "Installments FallOff", "Process Case", "Mark For Attachment", "Create Attachment Header", "Source Unit", "Mobile Loan";
            column(Header_No_; "Header No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Alerts Loan Lines"."Process Case" := ProcessCase;
                if "Mark For Attachment" then
                    "Alerts Loan Lines"."Create Attachment Header" := CreateAttachmnetHeader;
                "Alerts Loan Lines".Modify();
            end;

            trigger OnPostDataItem()
            begin
                Message('Success');
            end;

            trigger OnPreDataItem()
            begin

            end;
        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(ProcessCase; ProcessCase)
                {
                    ToolTip = 'All cases in the repoert filter will take the value of process case that you have choosen here';
                }
                field(CreateAttachmnetHeader; CreateAttachmnetHeader)
                {
                    ToolTip = 'All cases in the repoert filter will take the value of create attachmnet header that you have choosen here';

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProcessCase: Boolean;
        CreateAttachmnetHeader: Boolean;
}
