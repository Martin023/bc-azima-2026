page 52185602 "HR Perspective Setup List"
{
    PageType = List;
    SourceTable = "HR Perspectives Setup";
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    Caption = 'Performance Perspectives';
    CardPageID = "HR Perspective Setup Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Perspective No"; Rec."Perspective No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'No.';
                }
                field("Perspective Name"; Rec."Perspective Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Perspective Name';
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Description';
                }
                field("Scoring Method"; Rec."Scoring Method")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scoring Method';
                }
                field("Result Label"; Rec."Result Label")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Result Label';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active';
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action("Default Perspectives")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Default Perspectives';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create standard perspective categories';
                
                trigger OnAction()
                begin
                    CreateDefaultPerspectives();
                end;
            }
        }
    }
    
    local procedure CreateDefaultPerspectives()
    var
        PerspectiveSetup: Record "HR Perspectives Setup";
    begin
        if not Confirm('Create default perspectives (Financial, Customer Sales, Job Specific, Portfolio at Risk)?', true) then
            exit;
            
        if not PerspectiveSetup.IsEmpty then begin
            if not Confirm('Perspectives already exist. Continue adding defaults?', false) then
                exit;
        end;
        
        CreatePerspectiveIfNotExists('Financial Stewardship', 'Revenue, profit, cost management goals', PerspectiveSetup."Scoring Method"::Standard, 'Achieved');
        CreatePerspectiveIfNotExists('Customer Sales', 'Customer satisfaction, NPS, sales targets', PerspectiveSetup."Scoring Method"::Standard, 'Achieved');
        CreatePerspectiveIfNotExists('Training & Development', 'Employee training and skill development', PerspectiveSetup."Scoring Method"::Standard, 'Achieved');
        CreatePerspectiveIfNotExists('Internal Service Delivery', 'Process efficiency and service quality', PerspectiveSetup."Scoring Method"::Standard, 'Achieved');
        CreatePerspectiveIfNotExists('Job Specific Objectives', 'Role-specific performance goals', PerspectiveSetup."Scoring Method"::Standard, 'Achieved');
        CreatePerspectiveIfNotExists('Portfolio at Risk', 'Maintain PAR below acceptable threshold', PerspectiveSetup."Scoring Method"::Inverted, 'Actual PAR %');
        
        Message('Default perspectives created successfully');
        CurrPage.Update(false);
    end;
    
    local procedure CreatePerspectiveIfNotExists(PerspectiveName: Text[100]; Desc: Text[250]; ScoringMethod: Option; ResultLabel: Text[50])
    var
        PerspectiveSetup: Record "HR Perspectives Setup";
    begin
        PerspectiveSetup.Reset();
        PerspectiveSetup.SetRange("Perspective Name", PerspectiveName);
        if not PerspectiveSetup.IsEmpty then
            exit;
            
        PerspectiveSetup.Init();
        PerspectiveSetup."Perspective Name" := PerspectiveName;
        PerspectiveSetup.Description := Desc;
        PerspectiveSetup."Scoring Method" := ScoringMethod;
        PerspectiveSetup."Result Label" := ResultLabel;
        PerspectiveSetup.Active := true;
        PerspectiveSetup.Insert(true);
    end;
}