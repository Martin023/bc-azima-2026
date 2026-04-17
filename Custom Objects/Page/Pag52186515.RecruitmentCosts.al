namespace mns.mns;

page 52186515 "Recruitment Costs"
{
    Caption = 'Recruitment Costs';
    PageType = List;
    SourceTable = "Recruitment Costs";
    ApplicationArea = Basic;
    UsageCategory = Lists;
   
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // SHOW REQUISITION NO. FOR RECRUITMENT COSTS
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Employee Requisition Number';
                    Visible = RequisitionVisible;
                }
                // SHOW TRAINING ID FOR COMPANY ACTIVITIES COSTS
                field("Training ID"; Rec."Training ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Training/Activity ID';
                    Visible = TrainingVisible;
                }
                field("Cost Item"; Rec."Cost Item")
                {
                   
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ToolTip = 'Select the cost item from HR Lookup Values';


                }
                field("Cost Item Description"; Rec."Cost Item Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Description of the cost item';
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    ToolTip = 'Enter the cost amount';
                }
            }
        }
    }

    actions
    {
    }
    
    trigger OnOpenPage()
    begin
        // DETERMINE WHICH FIELD TO SHOW BASED ON FILTER
        RequisitionVisible := Rec.GetFilter("Requisition No.") <> '';
        TrainingVisible := Rec.GetFilter("Training ID") <> '';
        
        // DEFAULT TO SHOWING REQUISITION IF NO FILTER
        if not RequisitionVisible and not TrainingVisible then
            RequisitionVisible := true;
    end;
    
    var
        RequisitionVisible: Boolean;
        TrainingVisible: Boolean;
}


