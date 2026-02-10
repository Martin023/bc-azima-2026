#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186070 pageextension52186070 extends "Job Transfer Job Planning Line" 
{
    layout
    {
        modify(PostingDate)
        {
            ApplicationArea = Basic;
        }
        modify(JobJournalTemplateName)
        {
            ApplicationArea = Basic;
        }
        modify(JobJournalBatchName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PostingDate(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "JobJournalTemplateName(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "JobJournalBatchName(Control 5)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "InitializeValues(PROCEDURE 14)".


    //Unsupported feature: Property Deletion (Attributes) on "GetPostingDate(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "GetJobJournalTemplateName(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetJobJournalBatchName(PROCEDURE 4)".

}
