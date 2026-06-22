// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186447 pageextension52186447 extends "Fixed Asset Card"
{
    PromotedActionCategories = ',,,,EDMS';

    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
            Editable = false;
            Visible = true;
        }
        modify("FA Location Code")
        {
            ApplicationArea = Basic;
            //Editable = False;
        }
        modify("Responsible Employee")
        {
            ApplicationArea = All;
            visible = false;
            // Do not use this field
        }
        modify(Description)
        {
            ApplicationArea = Basic;
            //Editable = false;
        }


        addafter("Serial No.")
        {

            field("Asset Tag"; Rec."Asset Tag")
            {
                ApplicationArea = Basic;
                ShowMandatory = true;
                //CharAllowed = 'AZ';
            }

            field("Old Asset Tag"; Rec."Old Asset Tag")
            {
                ApplicationArea = Basic;
            }
            field("Asset Location"; Rec."Asset Location")
            {
                ApplicationArea = Basic;
            }
            field("Asset Status"; Rec."Asset Status")
            { ApplicationArea = Basic; }
            field("Marked for Disposal"; Rec."Marked for Disposal")
            { ApplicationArea = Basic; }

            field("Acquisition Type"; Rec."Acquisition Type")
            {
                ApplicationArea = Basic;
            }
            field("Acquisition Date"; Rec."Acquisition Date")
            {
                ApplicationArea = Basic;
            }
            field("Lease Commence Date"; Rec."Lease Commence Date")
            {
                ApplicationArea = Basic;
            }
            field("Lease End Date"; Rec."Lease End Date")
            {
                ApplicationArea = Basic;
            }
            field("Remaining Lease"; RemainingLease)
            {
                Caption = 'Remaining Lease(Months)';
            }

            field("Employee Responsible"; Rec."Employee Responsible")
            {
                ApplicationArea = Basic;
                Caption = 'Responsible Employee';
                //Staff PF No.
            }
            field("Responsible Employee Name"; Rec."Responsible Employee Name")
            {
                Editable = false;
                //Staff Name
            }
            field("Branch"; Rec."Global Dimension 1 Code")
            {
                ToolTip = 'Specifies the value of the Branch field.';
            }
            field("Department"; Rec."Global Dimension 2 Code")
            {
                ToolTip = 'Specifies the value of the Department field.';
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
            }
            field("Created At"; Rec."Created at")
            {
                ToolTip = 'Specifies the value of the SystemCreatedAt field.';
            }
            field("Created By"; Rec."Created By")
            {
                ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                Editable = False;
            }
            field(Status; Rec.Status)
            {
                Editable = false;
            }
        }
        addafter(DepreciationMethod)
        {
            field("Straight Line %"; FADepreciationBook."Straight-Line %") { ApplicationArea = basic; }
            field("Expected Useful Life"; Rec."Expected Useful Life") { ApplicationArea = basic; }
        }
        addafter(Acquired)
        {
            field(Disposed; Rec.Disposed) { ApplicationArea = basic; }
        }
        modify("FA Class Code")
        {
            ApplicationArea = Basic;
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

    }

    actions
    {
        // modify("Insurance")
        // {
        //     //ApplicationArea = Basic;
        // }
        // addafter("Insurance")
        // {
        //     group("EDMS Integration")
        //     {
        //         action("Import")
        //         {
        //             ApplicationArea = All;
        //             Caption = 'Import File';
        //             Promoted = true;
        //             PromotedCategory = Category5;
        //             PromotedIsBig = true;
        //             Image = Import;

        //             trigger OnAction()
        //             var
        //                 Base64Convert: Codeunit "Base64 Convert";
        //                 TempBlob: Codeunit "Temp Blob";
        //                 InStr: InStream;

        //                 EDMSFunctions: Codeunit "EDMS Functions";
        //                 FileName: Text;
        //                 FileContentsB64: Text;

        //                 IDNumber: Text;
        //                 ApplicationType: Label 'MA'; // Member Application
        //                 PFNumber: Text;
        //             begin
        //                 if Rec."No." <> '' then begin
        //                     FileName := EDMSFunctions.PickEDMSFile(TempBlob);

        //                     TempBlob.CreateInStream(InStr);
        //                     FileContentsB64 := Base64Convert.ToBase64(InStr);

        //                     if FileContentsB64 <> '' then begin
        //                         // UploadToEDMS(Rec, FileName, FileContentsB64);
        //                     end;
        //                 end else begin
        //                     Error('Application No. is required for EDMS document upload');
        //                 end;
        //             end;
        //         }
        //         action("EDMS File List")
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Image = Documents;
        //             Promoted = true;
        //             PromotedCategory = Category5;
        //             PromotedIsBig = true;

        //             RunObject = page "EDMS Files List";
        //             RunPageLink = "Application No." = field("No.");
        //             // RunPageMode = Create;
        //         }
        //     }
        // }
    }
    procedure FnRestrictAccess()
    var
        StatusPermission: Record 52185687;
        ErrorOnRestrictViewTxt: label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        StatusPermission.Reset;
        StatusPermission.SetRange("User ID", UserId);
        StatusPermission.SetRange("Edit Fixed Asset", true);
        if not StatusPermission.Find('-') then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        FnRestrictAccess();
        if (rec."Lease End Date" <> 0D) then begin
            RemainingLease := round((rec."Lease End Date" - Today), 1, '<') / 30;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        FnRestrictAccess();
        if (rec."Lease End Date" <> 0D) then begin
            RemainingLease := round((rec."Lease End Date" - Today), 1, '<') / 30;
        end;
    end;

    var
        RemainingLease: Decimal;

}

