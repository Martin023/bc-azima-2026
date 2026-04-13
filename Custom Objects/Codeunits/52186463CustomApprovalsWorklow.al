
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52186463 "Custom Approvals Codeunit"
{

    trigger OnRun()
    begin
        AddWorkflowEventsToLibrary
    end;

    var
        //changed
        WorkflowManagement: Codeunit "Workflow Management";
        UnsupportedRecordTypeErr: label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        NoWorkflowEnabledErr: label 'This record is not supported by related approval workflow.';
        OnSendPaymentApprovalRequestTxt: label 'Approval of a Payment is requested';
        //FA Reclass. Journal Line
        RunWorkflowOnSendFixedAssetReclassificationForApprovalCode: Label 'RUNWORKFLOWONSENDFIXEDASSETRECLASSJOURNALFORAPPROVAL';
        RunWorkflowOnCancelFixedAssetReclassificationForApprovalCode: Label 'RUNWORKFLOWONCANCELFIXEDASSETRECLASSJOURNALFORAPPROVAL';
        OnSendFixedAssetReclassificationApprovalRequestTxt: Label 'Approval of a Fixed Asset Reclassification is requested';
        OnCancelFixedAssetReclassificationApprovalRequestTxt: Label 'An Approval of a Fixed Asset Reclassification is canceled';

        // //         "----------------------"": 'Comment';
        RunWorkflowOnSendPaymentForApprovalCode: label 'RUNWORKFLOWONSENDPAYMENTFORAPPROVAL';
        RunWorkflowOnCancelPaymentForApprovalCode: label 'RUNWORKFLOWONCANCELPAYMENTFORAPPROVAL';
        OnCancelPaymentApprovalRequestTxt: label 'An Approval of a Payment is canceled';
        // //         "----------------------------"": 'Comment';
        RunWorkflowOnSendSkyVirtualMemberForApprovalCode: label 'RUNWORKFLOWONSENDSKYVIRTUALMEMBERFORAPPROVAL';
        RunWorkflowOnCancelSkyVirtualMemberForApprovalCode: label 'RUNWORKFLOWONCANCELSKYVIRTUALMEMBERFORAPPROVAL';
        OnCancelSkyVirtualMemberApprovalRequestTxt: label 'An Approval of a Sky Virtual Member is canceled';
        OnSendSkyVirtualMemberApprovalRequestTxt: label 'Approval of a Sky Virtual Member is requested';
        // //         "---------------------------------"": 'Comment';

        // //         "----------------------------"": 'Leave Allocation';
        RunWorkflowOnSendleaveallocationForApprovalCode: label 'RUNWORKFLOWONSENDLEAVEALLOCATIONRFORAPPROVAL';
        RunWorkflowOnCancelleaveallocationForApprovalCode: label 'RUNWORKFLOWONCANCELLEAVEALLOCATIONFORAPPROVAL';
        OnCancelleaveallocationApprovalRequestTxt: label 'An Approval of a leave allocation is canceled';
        OnSendleaveallocationApprovalRequestTxt: label 'Approval of a leave allocation is requested';
        // //         "---------------------------------"": 'Leave Allocation';
        //"Dividends Provision Header"
        RunWorkflowOnSendDividendsProvisionForApprovalCode: label 'RUNWORKFLOWONSENDDIVIDENDSPROVISIONRFORAPPROVAL';
        RunWorkflowOnCancelDividendsProvisionForApprovalCode: label 'RUNWORKFLOWONCANCELDIVIDENDSPROVISIONFORAPPROVAL';
        OnCancelDividendsProvisionApprovalRequestTxt: label 'An Approval of a Dividends provision is canceled';
        OnSendDividendsProvisionApprovalRequestTxt: label 'Approval of a Dividends provision is requested';
        //DIVIDENDSPROVISION



        //Planner
        RunWorkflowOnSendHrTrainingplannnerForApprovalCode: label 'RUNWORKFLOWONSENDHrTrainingplannerRFORAPPROVAL';
        RunWorkflowOnCancelHrTrainingplannerForApprovalCode: label 'RUNWORKFLOWONCANCELHrTrainingplannerFORAPPROVAL';
        OnCancelHrTrainingplannnerpprovalRequestTxt: label 'An Approval of a Hr Traning planner is cancelled';
        OnSendHrTrainingplannerApprovalRequestTxt: label ' An Approval of a Hr Training planner is requested';

        //Hr Planer

        OnSendInterbankApprovalRequestTxt: label 'Approval of a Interbank is requested';
        RunWorkflowOnSendInterbankForApprovalCode: label 'RUNWORKFLOWONSENDINTERBANKFORAPPROVAL';
        OnCancelInterbankApprovalRequestTxt: label 'An Approval of a Interbank is canceled';
        RunWorkflowOnCancelInterbankForApprovalCode: label 'RUNWORKFLOWONCANCELINTERBANKFORAPPROVAL';
        //Hr Company Activities
        OnSendHrCompanyActivityRequestTxt: label 'Approval of Hr Company Activity is requested';
        RunWorkflowOnSendHrCompanyActivityForApprovalCode: label 'RUNWORKFLOWONSENDHRCOMPANYACTIVITYFORAPPROVAL';
        OnCancelHrCompnyActivityRequestTxt: label 'An Approval of Hr Company Activity is canceled';
        RunWorkflowOnCancelHrCompanyActivityForApprovalCode: label 'RUNWORKFLOWONCANCELHRCOMPANYACTIVITYFORAPPROVAL';

        //Hr CompanyActivities
        //HR Driver
        OnSendDriverCreationApprovalRequestTxt: Label 'Approval of a Driver Creation is requested';
        RunWorkflowOnSendDriverCreationForApprovalCode: Label 'RUNWORKFLOWONSENDDRIVERCREATIONFORAPPROVAL';
        OnCancelDriverCreationApprovalRequestTxt: Label 'An Approval of a Driver Creation is canceled';
        RunWorkflowOnCancelDriverCreationForApprovalCode: Label 'RUNWORKFLOWONCANCELDriverCreationFORAPPROVAL';
        //HR Driver

        //staff Claim
        OnSendStaffClaimApprovalRequestTxt: label 'Approval of a Staff Claim is requested';
        RunWorkflowOnSendStaffClaimForApprovalCode: label 'RUNWORKFLOWONSENDSTAFFCLAIMFORAPPROVAL';
        OnCancelStaffClaimApprovalRequestTxt: label 'An Approval of a Staff Claim is canceled';
        RunWorkflowOnCancelStaffClaimForApprovalCode: label 'RUNWORKFLOWONCANCELSTAFFCLAIMFORAPPROVAL';
        //end of staff claim
        //HrInterviewExit
        OnSendHrInterviewExitApprovalRequestTxt: label 'Approval of a Hr Interview Exit is requested';
        RunWorkflowOnSendHrInterviewExitForApprovalCode: label 'RUNWORKFLOWONSENDHRINTERVIEWEXITFORAPPROVAL';
        OnCancelHrInterviewExitApprovalRequestTxt: label 'An Approval of a Hr Interview Exit is canceled';
        RunWorkflowOnCancelHrInterviewExitForApprovalCode: label 'RUNWORKFLOWONCANCELHRINTERVIEWEXITFORAPPROVAL';

        //Conference Room Creation
        OnSendConferenceRoomCreationApprovalRequestTxt: Label 'Approval of a Conference Room Creation is requested';
        RunWorkflowOnSendConferenceRoomCreationForApprovalCode: Label 'RUNWORKFLOWONSENDCONFERENCEROOMCREATIONFORAPPROVAL';
        OnCancelConferenceRoomCreationApprovalRequestTxt: Label 'An Approval of a Conference Room Creation is canceled';
        RunWorkflowOnCancelConferenceRoomCreationForApprovalCode: Label 'RUNWORKFLOWONCANCELCONFERENCEROOMCREATIONFORAPPROVAL';
        //Conference Room Creation
        //Accident
        OnSendAccidentCreationApprovalRequestTxt: Label 'Approval of Accident Creation is requested';
        RunWorkflowOnSendAccidentCreationForApprovalCode: Label 'RUNWORKFLOWONSENDACCIDENTCREATIONFORAPPROVAL';
        OnCancelAccidentCreationApprovalRequestTxt: Label 'An Approval of Accident Creation is canceled';
        RunWorkflowOnCancelAccidentCreationForApprovalCode: Label 'RUNWORKFLOWONCANCELACCIDENTCREATIONFORAPPROVAL';
        //Accident
        //Fuel
        OnSendFuelRegistrationForApprovalRequestTxt: Label 'Approval Of Fuel Registration is Requested';
        RunWorkFlowOnSendFuelRegistrationForApprovalCode: Label 'RUNWORKFLOWONSENDFUELREGISTRATIONFORAPPROVAL';
        OnCancelFuelRegistrationForApprovalRequestTxt: Label 'Approval Of Fuel Registration is Cancelled';
        RunWorkFlowOnCancelFuelRegistrationForApprovalCode: Label 'RUNWORKFLOWONCANCELFUELREGISTRATIONFORAPPROVAL';
        //Fule
        //PettyCash
        OnSendPettyCashApprovalRequestTxt: label 'Approval of Petty Cash is requested';
        RunWorkflowOnSendPettyCashForApprovalCode: label 'RUNWORKFLOWONSENDPETTYCASHFORAPPROVAL';
        OnCancelPettyCashApprovalRequestTxt: label 'An Approval of Petty Cash is canceled';
        RunWorkflowOnCancelPettyCashForApprovalCode: label 'RUNWORKFLOWONCANCELPETTYCASHFORAPPROVAL';
        //end of petty cash
        OnsendShareCapitalTransferApprovalTxt: Label 'An approval Request of Share capital Transfer  is requested';
        OnsendMoratoriumLoanforApprovalTxt: Label 'An Approval Request of Moratorium Loan is Requested';
        OnCancellMoratoriumLoanApprovalRequest: Label 'An approval Request of Moratorium Loan is cancelled';

        OncancelSharecapitaltransferApprovalRequest: Label 'An approval Request of Share capital Transfer is cancelled';

        RunworkflowOnsendSharecapitalTransferforapprovalCode: Label 'RUNWORKFLOWONSENdSHARECAPITALTRANSFERBUFFERFORAPPROVAL';
        //Parking Allocation
        RunWorkflowOnsendParkingApprovalRequestCode: Label 'RUNWORKFLOWONSENDPARKINGAPPROVALREQUESTCODE';
        OnSendParkingApprovalRequestTxt: Label 'An Approval Request for Parking is Requested';
        RunWorkflowOnCancelParkingApprovalRequestCode: Label 'RUNWORKFLOWONCANCELPARKINGAPPROVALREQUESTCODE';
        OnCancelParkingApprovalRequestTxt: Label 'An Approval Request for Parking is Cancelled';
        //Parking Allocation

        //Parking Creation
        RunWorkflowOnSendParkingCreationRequestApprovalCode: Label 'RUNWORKFLOWONSENDPARKINGCREATIONREQUESTFORAPPROVAL';
        OnSendParkingCreationRequestApprovalTxt: Label 'A Request to Approve Parking Creation';
        RunWorkflowOnCancelParkingCreationRequestApprovalCode: Label 'RUNWORKFLOWONCANCELPARKINGCREATIONREQUESTAPPROVAL';
        OnCancelParkingCreationRequestApprovalTxt: Label 'A request to Cancel Parking Creation';

        //Parking Creation

        //Motor Vehicle Requests
        RunworkflowOnsendMotorVehicleRequestforapprovalCode: Label 'RUNWORKFLOWONSENDMOTORVEHICLEREQUESTFORAPPROVAL';
        OnsendMotorVehicleRequestApprovalTxt: Label 'An approval Request of Motorvehicle request is requested';
        RunWorkflowOnCancelmotorvehiclerequestForApprovalCode: label 'RUNWORKFLOWONCANCELMOTORVEHICLEREQUESTFORAPPROVAL';
        OnCancelMotorVehicleRequestapprovalTxt: Label 'An Approval Request of motorvehicle reuqest is Cancelled';
        //Motor Vehicle Request
        //Key Creation
        RunworkflowOnsendKeyCreationRequestforapprovalCode: Label 'RUNWORKFLOWONSENDKEYCREATIONREQUESTFORAPPROVAL';
        OnsendKeyCreationRequestApprovalTxt: Label 'Approval of Key Creation request is requested';
        RunWorkflowOnCancelKeyCreationrequestForApprovalCode: label 'RUNWORKFLOWONCANCELKEYCREATIONREQUESTFORAPPROVAL';
        OnCancelKeyCreationRequestapprovalTxt: Label 'Approval of Key Creation request is Cancelled';
        //Key Creation
        //Key Request
        RunworkflowOnsendKeyRequestforapprovalCode: Label 'RUNWORKFLOWONSENDKEYREQUESTFORAPPROVAL';
        OnsendKeyRequestApprovalTxt: Label 'Approval of Key request is requested';
        RunWorkflowOnCancelKeyrequestForApprovalCode: label 'RUNWORKFLOWONCANCELKEYREQUESTFORAPPROVAL';
        OnCancelKeyRequestapprovalTxt: Label 'Approval of Key request is Cancelled';
        //Key Request

        //NomineeForm Request

        OnSendNomineeRequestFormApprovalRequestTxt: label 'An Approval of Nominee Request form  is requested';
        RunWorkflowOnSendNomineeRequestFormForApprovalCode: label 'RUNWORKFLOWONSENDNOMINEEREQUESTFORMFORAPPROVAL';
        OnCancelNomineeRequestFormApprovalRequestTxt: label 'An Approval of Nominee Request Form is canceled';
        RunWorkflowOnCancelNomineeRequestFormForApprovalCode: label 'RUNWORKFLOWONCANCELELNOMINEEREQUESTFORMFORAPPROVALCODE';


        //leave
        RunworkflowOnsendLeaveAllocationRequestforapprovalCode: Label 'RUNWORKFLOWONSENDLEAVEALLOCATIONREQUESTFORAPPROVAL';
        OnsendLeaveAllocationRequestApprovalTxt: Label 'An approval Request ofleave allocation request is requested';
        RunWorkflowOnCancelLeaveAllocationrequestForApprovalCode: label 'RUNWORKFLOWONCANCELLEAVEALLOCATIONREQUESTFORAPPROVAL';
        OnCancelLeaveAllocationRequestapprovalTxt: Label 'An Approval Request of leave allocation reuqest is Cancelled';
        //FOSA PV
        RunworkflowOnsendFOSAPVRequestforapprovalCode: Label 'RUNWORKFLOWONSENDFOSAPVREQUESTFORAPPROVAL';
        OnsendFOSAPVApprovalTxt: Label 'An approval Request of FOSA PV is requested';
        RunWorkflowOnCancelFOSAPVrequestForApprovalCode: label 'RUNWORKFLOWONCANCELFOSAPVREQUESTFORAPPROVAL';
        OnCancelFOSAPVRequestapprovalTxt: Label 'An Approval Request of FOSA PV is Cancelled';
        //Security Perfection
        RunWorkflowOnSendSecurityPefectionRequestforApprovalCode: Label 'RUNWORKFLOWONSENDSECURITYPEFECTIONFORAPPROVAL';
        OnSendSecurityPerfectionRequestApprovalTxt: Label 'An Approval of Security Perfection is requested';
        RunWworkflowOnCancelSecurityPerfectionRequestForApprovalCode: Label 'RUNWORKFLOWONCANCELSECURITYPERFECTIONREQUESTFORAPPROVAL';
        OnCancelSecurityPerfectionRequestApprovalTxt: Label 'An Approval of Security Perfection is Cancelled';

        //Security Perfection
        //Security Discharge
        RunWorkflowOnSendSecurityDischargeRequestforApprovalCode: Label 'RUNWORKFLOWONSENDSECURITYDISCHARGEFORAPPROVAL';
        OnSendSecurityDischargeRequestApprovalTxt: Label 'An Approval of Security Discharge is requested';
        RunWworkflowOnCancelSecurityDischargeRequestForApprovalCode: Label 'RUNWORKFLOWONCANCELSECURITYDISCHARGEREQUESTFORAPPROVAL';
        OnCancelSecurityDischargeRequestApprovalTxt: Label 'An Approval of Security Discharge is Cancelled';
        //Security Dischareg

        //Request For Customer Tenant Creation
        RunWorkflowOnSendCustomerRequestForApprovalCode: Label 'RUNWORKFLOWONSENDCUSTOMERREQUESTFORAPPROVAL';
        OnSendCustomerRequestForApprovalTxt: Label 'An Approval Request of Customer is Requested';
        RunWorkflowOnCancelCustomerRequestForApprovalCode: Label 'RUNWORKFLOWONCANCELCUSTOMERREQUESTFORAPPROVAL';
        OnCancelCustomerRequestForApprovalTxt: Label 'An Approval Request of Customer is Cancelled';

        //Request For Customer Tenant Creation
        //Company Vehicles Creation
        RunWorkflowOnSendCompanyVehiclesForApprovalCode: label 'RUNWORKFLOWONSENDCOMPANYVEHICLESFORAPPROVAL';
        OnSendCompanyVehiclesApprovalTxt: label 'An approval Request of Company Vehicles is requested';
        RunWorkflowOnCancelCompanyVehiclesForApprovalCode: label 'RUNWORKFLOWONCANCELCOMPANYVEHICLESFORAPPROVAL';
        OnCancelCompanyVehiclesApprovalTxt: label 'An Approval Request of Company Vehicles is Cancelled';

        //Company Vehicles Creation

        //--Conference Hall and Meeting Room Booking
        RunWorkflowOnSendConferenceBookingRequestForApprovalCode: label 'RUNWORKFLOWONSENDCONFERENCEBOOKINGREQUESTFORAPPROVAL';
        RunWorkflowOnSendConferenceBookingRequestForApprovalTxt: label 'Approval for Conference Booking is Requested';
        RunWorkflowOnCancelConferenceBookingRequestForApprovalCode: label 'RUNWORKFLOWONCANCELCOMFERENCEBOOKINGREQUESTFORAPPROVAL';
        RunWorkflowOnCancelConferenceBookingRequestForApprovalTxt: label 'Approval for Conference Booking is Canceled';
        //Conference Hall and meeting room Boking

        //Motor Vehicle Movemement
        RunWorkflowOnSendMotorVehicleMovementRequestforAprovalCode: Label 'RUNWORKFLOWONSENDMOTORVEHICLEMOVEMENTREQUESTFORAPPROVAL';
        RunWorkflowOnSendMotorVehicleMovementRequestforAprovalTxt: Label 'An Approval Workflow for Motor Vehicle Movment is Requested';
        RunWorkflowOnCancelMotorVehicleMovementRequestForApprovalCode: Label 'RUNWORKFLOWONCANCELMOTORVEHICLEMOVEMENTREQUESTFORAPPROVAL';
        RunWorkflowOnCancelMotorVehicleMovementRequestForApprovalTxt: Label 'An Approval Worrkflow For Motor Vehicle Request is Canceled';
        //Motor Vehicle Movement
        Runworkflowonsendmoratoriumloanforapprovalcode: Label 'RUNWORKFLOWONSENDMORATORIUMLOANFORAPPROVAL';

        Runworkflowoncancelsharecapitaltransferforapprovalcode: Label 'RUNWORKFLOWONCANCELLSHARECAPITALTRANSFERFORAPPROVAL';
        RunWorkflowoncancelmoratoriumloanforapprovalcode: Label 'RUNWORKFLOWONCANCELLMORATORIUMLOANFORAPPROVAL';
        //Refunds $ Account Transfer
        RunWorkflowOnSendRefundAccountTransferRequestforAprovalCode: Label 'RUNWORKFLOWONSENDRefundAccountTransferREQUESTFORAPPROVAL';
        RunWorkflowOnSendRefundAccountTransferRequestforAprovalTxt: Label 'An Approval Workflow for RefundAccountTransfer is Requested';
        RunWorkflowOnCancelRefundAccountTransferForApprovalCode: Label 'RUNWORKFLOWONCANCELRefundAccountTransferFORAPPROVAL';
        RunWorkflowOnCancelRefundAccountTransferForApprovalTxt: Label 'An Approval Worrkflow For RefundAccountTransfer is Canceled';

        //end of refunds $ account transfer
        OnSendStaffAdvanceApprovalRequestTxt: label 'Approval of a Staff Advance is requested';
        RunWorkflowOnSendStaffAdvanceForApprovalCode: label 'RUNWORKFLOWONSENDSTAFFADVANCEFORAPPROVAL';
        OnCancelStaffAdvanceApprovalRequestTxt: label 'An Approval of a Staff Advance is canceled';
        RunWorkflowOnCancelStaffAdvanceForApprovalCode: label 'RUNWORKFLOWONCANCELSTAFFADVANCEFORAPPROVAL';
        //staff welfare
        OnSendStaffWelfareApprovalRequestTxt: label 'Approval of a Staff Welfare is requested';
        RunWorkflowOnSendStaffWelfareForApprovalCode: label 'RUNWORKFLOWONSENDSTAFFWELFAREFORAPPROVAL';
        OnCancelStaffWelfareApprovalRequestTxt: label 'An Approval of a Staff Welfare is canceled';
        RunWorkflowOnCancelStaffWefareForApprovalCode: label 'RUNWORKFLOWONCANCELSTAFFWELFAREFORAPPROVAL';
        //variations
        OnSendloanVariationApprovalRequestTxt: label 'Approval of a Loan variation is requested';
        RunWorkflowOnSendloanVariationForApprovalCode: label 'RUNWORKFLOWONSENDLOANVariationFORAPPROVAL';
        OnCancelloanVariationApprovalRequestTxt: label 'An Approval of a  Loan Variation is canceled';
        RunWorkflowOnCancelloanVariationForApprovalCode: label 'RUNWORKFLOWONCANCELLOANVARIATIONFORAPPROVAL';
        //end of variations
        OnSendStaffAdvanceSurrenderApprovalRequestTxt: label 'Approval of a Staff Advance Surrender is requested';
        RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode: label 'RUNWORKFLOWONSENDSTAFFADVANCESURRENDERFORAPPROVAL';
        OnCancelStaffAdvanceSurrenderApprovalRequestTxt: label 'An Approval of a Staff Advance Surrender is canceled';
        RunWorkflowOnCancelStaffAdvanceSurrenderForApprovalCode: label 'RUNWORKFLOWONCANCELSTAFFADVANCESURRENDERFORAPPROVAL';
        OnSendStoreRequisitionApprovalRequestTxt: label 'Approval of a Store Requisition is requested';
        RunWorkflowOnSendStoreRequisitionForApprovalCode: label 'RUNWORKFLOWONSENDSTOREREQUISITIONFORAPPROVAL';
        OnCancelStoreRequisitionApprovalRequestTxt: label 'An Approval of a Store Requisition is canceled';
        RunWorkflowOnCancelStoreRequisitionForApprovalCode: label 'RUNWORKFLOWONCANCELSTOREREQUISITIONFORAPPROVAL';
        OnSendImprestApprovalRequestTxt: label 'Approval of a Imprest is requested';
        RunWorkflowOnSendImprestForApprovalCode: label 'RUNWORKFLOWONSENDIMPRESTFORAPPROVAL';
        OnCancelImprestApprovalRequestTxt: label 'An Approval of a Imprest is canceled';
        RunWorkflowOnCancelImprestForApprovalCode: label 'RUNWORKFLOWONCANCELIMPRESTFORAPPROVAL';
        OnSendImprestSurrenderApprovalRequestTxt: label 'Approval of a Imprest Surrender is requested';
        RunWorkflowOnSendImprestSurrenderForApprovalCode: label 'RUNWORKFLOWONSENDIMPRESTSURRENDERFORAPPROVAL';
        OnCancelImprestSurrenderApprovalRequestTxt: label 'An Approval of a Imprest Surrender is canceled';
        RunWorkflowOnCancelImprestSurrenderForApprovalCode: label 'RUNWORKFLOWONCANCELIMPRESTSURRENDERFORAPPROVAL';
        OnSendOvertimeApprovalRequestTxt: label 'Approval of a Overtime is requested';
        RunWorkflowOnSendOvertimeForApprovalCode: label 'RUNWORKFLOWONSENDOVERTIMEFORAPPROVAL';
        OnCancelOvertimeApprovalRequestTxt: label 'An Approval of a Overtime is canceled';
        RunWorkflowOnCancelOvertimeForApprovalCode: label 'RUNWORKFLOWONCANCELOVERTIMEFORAPPROVAL';
        OnSendBudgetApprovalRequestTxt: label 'Approval of a Budget is requested';
        RunWorkflowOnSendBudgetForApprovalCode: label 'RUNWORKFLOWONSENDBUDGETFORAPPROVAL';
        OnCancelBudgetApprovalRequestTxt: label 'An Approval of a Budget is canceled';
        RunWorkflowOnCancelBudgetForApprovalCode: label 'RUNWORKFLOWONCANCELBUDGETFORAPPROVAL';
        //Vote Transfer
        OnSendVoteApprovalRequestTxt: label 'Approval of a Vote Transfer is requested';
        RunWorkflowOnSendVoteForApprovalCode: label 'RUNWORKFLOWONSENDVOTEFORAPPROVAL';
        OnCancelVoteApprovalRequestTxt: label 'An Approval of a Vote is canceled';
        RunWorkflowOnCancelVoteForApprovalCode: label 'RUNWORKFLOWONCANCELVOTEFORAPPROVAL';
        //Vote Transfer
        OnSendWorkplanApprovalRequestTxt: label 'Approval of a Workplan is requested';
        RunWorkflowOnSendWorkplanForApprovalCode: label 'RUNWORKFLOWONSENDWORKPLANFORAPPROVAL';
        OnCancelWorkplanApprovalRequestTxt: label 'An Approval of a Workplan is canceled';
        RunWorkflowOnCancelWorkplanForApprovalCode: label 'RUNWORKFLOWONCANCELWORKPLANFORAPPROVAL';
        OnSendAssetTransferApprovalRequestTxt: label 'Approval of an Asset Transfer is requested';
        RunWorkflowOnSendAssetTransferForApprovalCode: label 'RUNWORKFLOWONSENDASSETTRANSFERFORAPPROVAL';
        OnCancelAssetTransferApprovalRequestTxt: label 'An Approval of an Asset Transfer is canceled';
        RunWorkflowOnCancelAssetTransferForApprovalCode: label 'RUNWORKFLOWONCANCELASSETTRANSFERFORAPPROVAL';
        "*************CORETEC": label 'SACCO***********************';
        OnSendCashierTRANSApprovalRequestTxt: label 'Approval of a Cashier Transaction is requested';
        RunWorkflowOnSendCashierTRANSForApprovalCode: label 'RUNWORKFLOWONSENDCASHIERTRANSFORAPPROVAL';
        OnCancelCashierTRANSApprovalRequestTxt: label 'An Approval of Cashier Transaction is canceled';
        RunWorkflowOnCancelCashierTRANSForApprovalCode: label 'RUNWORKFLOWONCANCELCASHIERTRANSFORAPPROVAL';
        OnSendSalaryTRANSApprovalRequestTxt: label 'Approval of Salary Transaction is requested';
        RunWorkflowOnSendSalaryTRANSForApprovalCode: label 'RUNWORKFLOWONSENDSALARYTRANSFORAPPROVAL';
        OnCancelSalaryTRANSApprovalRequestTxt: label 'An Approval of Salary Transaction is canceled';
        RunWorkflowOnCancelSalaryTRANSForApprovalCode: label 'RUNWORKFLOWONCANCELSALARYTRANSFORAPPROVAL';
        OnSendBankersCApprovalRequestTxt: label 'Approval of Bankers Cheque  is requested';
        RunWorkflowOnSendBankersCForApprovalCode: label 'RUNWORKFLOWONSENDBANKERSCSFORAPPROVAL';
        OnCancelBankersCApprovalRequestTxt: label 'An Approval of bankers Cheque is canceled';
        RunWorkflowOnCancelBankersCForApprovalCode: label 'RUNWORKFLOWONCANCELBANKERSCTRANSFORAPPROVAL';
        OnSendBankCApprovalRequestTxt: label 'Approval of Bank Cheque  is requested';
        RunWorkflowOnSendBankCForApprovalCode: label 'RUNWORKFLOWONSENDBANKCSFORAPPROVAL';
        OnCancelBankCApprovalRequestTxt: label 'An Approval of bank Cheque is canceled';
        RunWorkflowOnCancelBankCForApprovalCode: label 'RUNWORKFLOWONCANCELBANKCTRANSFORAPPROVAL';
        OnSendODApprovalRequestTxt: label 'Approval of Over Draft is requested';
        RunWorkflowOnSendODForApprovalCode: label 'RUNWORKFLOWONSENDODSFORAPPROVAL';
        OnCancelODApprovalRequestTxt: label 'An Approval of Over Draft Request is canceled';
        RunWorkflowOnCancelODForApprovalCode: label 'RUNWORKFLOWONCANCELODTRANSFORAPPROVAL';
        OnSendACTApprovalRequestTxt: label 'Approval of Transfer is requested';
        RunWorkflowOnSendACTForApprovalCode: label 'RUNWORKFLOWONSENDACTSFORAPPROVAL';
        OnCancelACTApprovalRequestTxt: label 'An Approval of Transfer Request is canceled';
        RunWorkflowOnCancelACTForApprovalCode: label 'RUNWORKFLOWONCANCELACTTRANSFORAPPROVAL';
        OnSendTREASApprovalRequestTxt: label 'Approval of Interteller Transfer is requested';
        RunWorkflowOnSendTREASForApprovalCode: label 'RUNWORKFLOWONSENDTREASSFORAPPROVAL';
        OnCancelTREASApprovalRequestTxt: label 'An Approval of Interteller Transfer Request is canceled';
        RunWorkflowOnCancelTREASForApprovalCode: label 'RUNWORKFLOWONCANCELTREASTRANSFORAPPROVAL';
        OnSendINVApprovalRequestTxt: label 'Approval of Treasury Investment is requested';
        RunWorkflowOnSendINVForApprovalCode: label 'RUNWORKFLOWONSENDINVFORAPPROVAL';
        OnCancelINVApprovalRequestTxt: label 'An Approval of Treasury Investment Request is canceled';
        RunWorkflowOnCancelINVForApprovalCode: label 'RUNWORKFLOWONCANCELINVFORAPPROVAL';
        OnSendCHQApprovalRequestTxt: label 'Approval of Bank Cheque Transaction is requested';
        RunWorkflowOnSendCHQForApprovalCode: label 'RUNWORKFLOWONSENDCHQFORAPPROVAL';
        OnCancelCHQApprovalRequestTxt: label 'An Approval of bank Cheque Transactions Request is canceled';
        RunWorkflowOnCancelCHQForApprovalCode: label 'RUNWORKFLOWONCANCELCHQFORAPPROVAL';
        OnSendDocExApprovalRequestTxt: label 'Approval of Document Exemptions Approvals is requested';
        RunWorkflowOnSendDocExForApprovalCode: label 'RUNWORKFLOWONSENDDOCEXFORAPPROVAL';
        OnCancelDocExApprovalRequestTxt: label 'An Approval of Document Exemption Request is canceled';
        RunWorkflowOnCancelDocExForApprovalCode: label 'RUNWORKFLOWONCANCELDOCEXFORAPPROVAL';
        // //         "="": 'Comment';
        OnSendMemberAppApprovalRequestTxt: label 'Approval of Member Application is requested';
        RunWorkflowOnSendMemberAppForApprovalCode: label 'RUNWORKFLOWONSENDMemberAppFORAPPROVAL';
        OnCancelMemberAppApprovalRequestTxt: label 'An Approval of Member Application is canceled';
        RunWorkflowOnCancelMemberAppForApprovalCode: label 'RUNWORKFLOWONCANCELMemberAppFORAPPROVAL';
        //Saving Account Application
        OnSendAccountAppApprovalRequestTxt: label 'Approval of Account Application is requested';
        RunWorkflowOnSendAccountAppForApprovalCode: label 'RUNWORKFLOWONSENDAccountAppFORAPPROVAL';
        OnCancelAccountAppApprovalRequestTxt: label 'An Approval of Account Application is canceled';
        RunWorkflowOnCancelAccountAppForApprovalCode: label 'RUNWORKFLOWONCANCELAccountAppFORAPPROVAL';
        //Saving Account Application

        //Loan Rescheduling
        OnSendLoanReschedulingApprovalRequestTxt: label 'Approval of Loan Rescheduling is requested';
        RunWorkflowOnSendLoanReschedulingForApprovalCode: label 'RUNWORKFLOWONSENDLoanReschedulingFORAPPROVAL';
        OnCancelLoanReschedulingApprovalRequestTxt: label 'An Approval of Loan Rescheduling is canceled';
        RunWorkflowOnCancelLoanReschedulingForApprovalCode: label 'RUNWORKFLOWONCANCELLoanReschedulingFORAPPROVAL';

        //Loan Rescheduling
        OnSendRTGSAppApprovalRequestTxt: label 'Approval of RTGS Application is requested';
        RunWorkflowOnSendRTGSAppForApprovalCode: label 'RUNWORKFLOWONSENDRTGSAppFORAPPROVAL';
        OnCancelRTGSAppApprovalRequestTxt: label 'An Approval of RTGS Application is canceled';
        RunWorkflowOnCancelRTGSAppForApprovalCode: label 'RUNWORKFLOWONCANCELRTGSAppFORAPPROVAL';
        OnSendSTOAppApprovalRequestTxt: label 'Approval of Standing Order Application is requested';
        RunWorkflowOnSendSTOAppForApprovalCode: label 'RUNWORKFLOWONSENDSTOAppFORAPPROVAL';
        OnCancelSTOAppApprovalRequestTxt: label 'An Approval of Standing Order Application is canceled';
        RunWorkflowOnCancelSTOAppForApprovalCode: label 'RUNWORKFLOWONCANCELSTOAppFORAPPROVAL';

        //Collateral Register
        OnSendSecurityRegisterApprovalRequestTxt: label 'Approval of Security Register Application is requested';
        RunWorkflowOnSendSecurityRegisterForApprovalCode: label 'RUNWORKFLOWONSENDSecurityRegisterFORAPPROVAL';
        OnCancelSecurityRegisterApprovalRequestTxt: label 'An Approval of Security Register Application is canceled';
        RunWorkflowOnCancelSecurityRegisterForApprovalCode: label 'RUNWORKFLOWONCANCELSecurityRegisterFORAPPROVAL';

        OnSendMortgageDocReleaseApprovalRequestTxt: label 'Approval of Mortgage Doc Release Application is requested';
        RunWorkflowOnSendMortgageDocReleaseForApprovalCode: label 'RUNWORKFLOWONSENDMortgageDocReleaseFORAPPROVAL';
        OnCancelMortgageDocReleaseApprovalRequestTxt: label 'An Approval of Mortgage Doc Release Application is canceled';
        RunWorkflowOnCancelMortgageDocReleaseForApprovalCode: label 'RUNWORKFLOWONCANCELMortgageDocReleaseFORAPPROVAL';
        // //         
        OnSendSTOCTLAppApprovalRequestTxt: label 'Approval of Standing Order Control Application is requested';
        RunWorkflowOnSendSTOCTLAppForApprovalCode: label 'RUNWORKFLOWONSENDSTOCTLAppFORAPPROVAL';
        OnCancelSTOCTLAppApprovalRequestTxt: label 'An Approval of Standing Order Control Application is canceled';
        RunWorkflowOnCancelSTOCTLAppForApprovalCode: label 'RUNWORKFLOWONCANCELSTOCTLAppFORAPPROVAL';
        // //         "..........."": 'Comment';
        OnSendDelegateAppApprovalRequestTxt: label 'Approval of Delegates Application is requested';
        RunWorkflowOnSendDelegatesAppForApprovalCode: label 'RUNWORKFLOWONSENDDelegatesAppFORAPPROVAL';
        RunWorkflowOnFixedDepositForApprovalCode: label 'Approval of Fixed Deposit is requested';
        OnCancelDelegatesAppApprovalRequestTxt: label 'An Approval of Delegates Application is canceled';
        RunWorkflowOnCancelDelegatesAppForApprovalCode: label 'RUNWORKFLOWONCANCELDelegatesAppFORAPPROVAL';
        // //         "---"": 'Comment';
        OnSendSalaryAgreementAppApprovalRequestTxt: label 'Approval of Salary Agreement Application is requested';
        RunWorkflowOnSendSalaryAgreementForApprovalCode: label 'RUNWORKFLOWONSENDSalaryAgreementFORAPPROVAL';
        OnCancelSalaryAgreementApprovalRequestTxt: label 'An Approval of SalaryAgreement Application is canceled';
        RunWorkflowOnCancelSalaryAgreementForApprovalCode: label 'RUNWORKFLOWONCANCELSalaryAgreementFORAPPROVAL';
        // //         "--"": 'Comment';

        OnSendPermissionRequisitionAppApprovalRequestTxt: label 'Approval of Permission Requisition Application is requested';
        RunWorkflowOnSendPermissionRequisitionForApprovalCode: label 'RUNWORKFLOWONSENDPERMISSIONREQUISITIONFORAPPROVAL';
        OnCancelPermissionRequisitionApprovalRequestTxt: label 'An Approval of Permission Requisition Application is canceled';

        RunWorkflowOnCancelPermissionRequisitionForApprovalCode: label 'RUNWORKFLOWONCANCELPERMISSIONREQUISITIONFORAPPROVAL';
        // //         "-----------"": 'Comment';
        OnSendLoanAppApprovalRequestTxt: label 'An Approval of Loan Application is requested';
        RunWorkflowOnSendLoanAppForApprovalCode: label 'RUNWORKFLOWONSENDLoanAppFORAPPROVAL';
        OnCancelLoanAppApprovalRequestTxt: label 'An Approval of Loan Application is canceled';
        RunWorkflowOnCancelLoanAppForApprovalCode: label 'RUNWORKFLOWONCANCELLoanAppFORAPPROVAL';
        RunWorkflowOnSendInterestBillingForApprovalCode: label 'RUNWORKFLOWONSENDInterestBillingFORAPPROVAL';
        OnCancelInterestBillingApprovalRequestTxt: label 'An Approval of Interest Billing is canceled';
        RunWorkflowOnCancelInterestBillingForApprovalCode: label 'RUNWORKFLOWONCANCELInterestBillingFORAPPROVAL';
        OnSendInterestBillingApprovalRequestTxt: label 'Approval of Interest Billing Application is requested';
        RunWorkflowOnSendSavingsInterestHeaderForApprovalCode: label 'RunWorkflowOnSendSavingsInterestHeaderFORAPPROVAL';
        OnSendSavingsInterestHeaderApprovalRequestTxt: label 'Approval of Savings Interest Header is requested';
        RunWorkflowOnCancelSavingsInterestHeaderForApprovalCode: label 'RUNWORKFLOWONCANCELSavingsInterestHeaderFORAPPROVAL';
        OnCancelSavingsInterestHeaderApprovalRequestTxt: label 'An Approval of Savings Interest Header is canceled';
        RunWorkflowOnSendEndYearTransferHeaderForApprovalCode: label 'RunWorkflowOnSendEndYearTransferHeaderFORAPPROVAL';
        OnSendEndYearTransferHeaderApprovalRequestTxt: label 'Approval of End Year Transfer Header is requested';
        RunWorkflowOnCancelEndYearTransferHeaderForApprovalCode: label 'RUNWORKFLOWONCANCELEndYearTransferHeaderFORAPPROVAL';
        OnCancelEndYearTransferHeaderApprovalRequestTxt: label 'An Approval of End Year Transfer Header is canceled';
        RunWorkflowOnSendATMApplicationsForApprovalCode: label 'RunWorkflowOnSendATMApplicationsFORAPPROVAL';
        OnSendATMApplicationsApprovalRequestTxt: label 'Approval of ATM Applications is requested';
        RunWorkflowOnCancelATMApplicationsForApprovalCode: label 'RUNWORKFLOWONCANCELATMApplicationsFORAPPROVAL';
        OnCancelATMApplicationsApprovalRequestTxt: label 'An Approval of ATM Applications is canceled';
        // //         "2222222222"": 'Comment';
        RunWorkflowOnSendATMLinkingApplicationsForApprovalCode: label 'RunWorkflowOnSendATMLinkingApplicationsFORAPPROVAL';
        OnSendATMLinkingApplicationsApprovalRequestTxt: label 'Approval of ATM Linking Applications is requested';
        RunWorkflowOnCancelATMLinkingApplicationsForApprovalCode: label 'RUNWORKFLOWONCANCELATMLinkingApplicationsFORAPPROVAL';
        OnCancelATMLinkingApplicationsApprovalRequestTxt: label 'An Approval of ATM Linking Applications is canceled';
        OnSendLoanBatchApprovalRequestTxt: label 'An Approval of Loan Batch is requested';
        RunWorkflowOnSendLoanBatchForApprovalCode: label 'RUNWORKFLOWONSENDLoanBatchAppFORAPPROVAL';
        OnCancelLoanBatchApprovalRequestTxt: label 'An Approval of Loan Batch is canceled';
        RunWorkflowOnCancelLoanBatchForApprovalCode: label 'RUNWORKFLOWONCANCELLoanBatchFORAPPROVAL';
        OnSendDividendRateAppApprovalRequestTxt: label 'Approval of Dividend Rate Application is requested';
        RunWorkflowOnSendDividendRateAppForApprovalCode: label 'RUNWORKFLOWONSENDDividendtRateAppFORAPPROVAL';
        OnCancelDividendRateAppApprovalRequestTxt: label 'An Approval of Dividend Rate Application is canceled';
        RunWorkflowOnCancelDividendRateAppForApprovalCode: label 'RUNWORKFLOWONCANCELDividendtRateAppFORAPPROVAL';
        OnSendMembershipClosureAppApprovalRequestTxt: label 'Approval of Membership Closure Application is requested';
        RunWorkflowOnSendMembershipClosureAppForApprovalCode: label 'RUNWORKFLOWONSEND Membership Closure AppFORAPPROVAL';
        OnCancelMembershipClosureAppApprovalRequestTxt: label 'An Approval of Membership Closure Application is canceled';
        RunWorkflowOnCancelMembershipClosureAppForApprovalCode: label 'RUNWORKFLOWONCANCEL Membership Closure AppFORAPPROVAL';
        OnsendsharecapitaltransferapprovalRequestTxt: label 'An approval of sharecapitail transfer is requested';
        OnCancellsharecapitalTransferapprovalRequestTxt: Label 'An approval of share capital transfer is Cancelled';
        OnSendGuarantorSubstitutionApprovalRequestTxt: label 'Approval of Guarantor Substitution Application is requested';
        RunWorkflowOnSendGuarantorSubstitutionAppForApprovalCode: label 'RUNWORKFLOWONSEND Guarantor Substitution AppFORAPPROVAL';
        OnCancelGuarantorSubstitutionAppApprovalRequestTxt: label 'An Approval of Guarantor Substitution Application is canceled';
        RunWorkflowOnCancelGuarantorSubstitutionAppForApprovalCode: label 'RUNWORKFLOWONCANCELGuarantor Substitution AppFORAPPROVAL';



        OnSendBondApprovalRequestTxt: label 'Approval of Bond is requested';
        RunWorkflowOnSendBondAppForApprovalCode: label 'RUNWORKFLOWONSEND Bond AppFORAPPROVAL';
        OnCancelBondAppApprovalRequestTxt: label 'An Approval of Bond Application is canceled';
        RunWorkflowOnCancelBondAppForApprovalCode: label 'RUNWORKFLOWONCANCEL Bond AppFORAPPROVAL';
        OnSendSinkFundApprovalRequestTxt: label 'Approval of Sink Fund is requested';
        RunWorkflowOnSendSinkFundAppForApprovalCode: label 'RUNWORKFLOWONSEND Sink Fund AppFORAPPROVAL';
        OnCancelSinkFundAppApprovalRequestTxt: label 'An Approval of Sink Fund Application is canceled';
        RunWorkflowOnCancelSinkFundAppForApprovalCode: label 'RUNWORKFLOWONCANCEL Sink Fund AppFORAPPROVAL';
        OnSendDelegateGroupsApplicationssApprovalRequestTxt: label 'Approval of Delegate Groups Applications is requested';
        RunWorkflowOnSendDelegateGroupsApplicationssForApprovalCode: label 'RUNWORKFLOWONSENDDelegateGroupsApplicationssFORAPPROVAL';
        OnCancelDelegateGroupsApplicationssApprovalRequestTxt: label 'An Approval of Delegate Groups Applications is canceled';
        RunWorkflowOnCancelDelegateGroupsApplicationssForApprovalCode: label 'RUNWORKFLOWONCANCELDelegate Groups ApplicationsFORAPPROVAL';
        OnSendDelegateGroupMemRetirementsApprovalRequestTxt: label 'Approval of Delegate Group Member Retirements is requested';
        RunWorkflowOnSendDelegateGroupMemRetirementsForApprovalCode: label 'RUNWORKFLOWONSENDDelegateGroupMemRetirementsFORAPPROVAL';
        OnCancelDelegateGroupMemRetirementsApprovalRequestTxt: label 'An Approval of Delegate Group Member Retirements is canceled';
        RunWorkflowOnCancelDelegateGroupMemRetirementsForApprovalCode: label 'RUNWORKFLOWONCANCELDelegateGroupMemRetirementsFORAPPROVAL';
        OnSendBDEManagementApprovalRequestTxt: label 'Approval of BDE Management is requested';
        RunWorkflowOnSendBDEManagementAppForApprovalCode: label 'RUNWORKFLOWONSEND BDE Management AppFORAPPROVAL';
        OnCancelBDEManagementAppApprovalRequestTxt: label 'An Approval of BDE Management Application is canceled';
        RunWorkflowOnCancelBDEManagementAppForApprovalCode: label 'RUNWORKFLOWONCANCEL BDE Management AppFORAPPROVAL';
        // //         "====Agency===="": 'Comment';
        OnSendAgentApplicationApprovalRequestTxt: label 'Approval of Agent Application is requested';
        RunWorkflowOnSendAgentApplicationForApprovalCode: label 'RUNWORKFLOWONSENDAgentApplicationFORAPPROVAL';
        OnCancelAgentApplicationApprovalRequestTxt: label 'An Approval of Agent Application is canceled';
        RunWorkflowOnCancelAgentApplicationForApprovalCode: label 'RUNWORKFLOWONCANCELAgentApplicationFORAPPROVAL';
        //employee requisition
        OnCancelEmployeeRequisitionAppApprovalRequestTxt: label 'An Approval of Employee Requisition Application is canceled';
        RunWorkflowOnCancelEmployeeRequisitionAppForApprovalCode: label 'RUNWORKFLOWONCANCEEmployeeRequisitionAppFORAPPROVAL';
        OnSendlEmployeeRequisitionAppApprovalRequestTxt: label 'Approval oflEmployee Requisition is requested';
        RunWorkflowOnSendEmployeeRequisitionAppForApprovalCode: label 'RUNWORKFLOWONSENDEmployeeRequisitionAppFORAPPROVAL';
        OnSendleaveAppApprovalRequestTxt: label 'Approval of leave Application is requested';
        RunWorkflowOnSendLeaveForApprovalCode: label 'RUNWORKFLOWONSENDleaveAppFORAPPROVAL';
        OnCancelleaveAppApprovalRequestTxt: label 'An Approval of leave Application is canceled';
        OnSendStaffLoanAppApprovalRequestTxt: label 'Approval of Staff Loan Application is requested';
        RunWorkflowOnSendStaffLoansForApprovalCode: label 'RUNWORKFLOWONSENDStaffLoanAppFORAPPROVAL';
        OnCancelStaffLoanAppApprovalRequestTxt: label 'An Approval of Staff Loan Application is canceled';
        RunWorkflowOnCancelStaffLoanAppForApprovalCode: label 'RUNWORKFLOWONCANCELStaffLoanAppFORAPPROVAL';
        RunWorkflowOnCancelleaveAppForApprovalCode: label 'RUNWORKFLOWONCANCELleaveAppFORAPPROVAL';
        OnSendTrainingAppApprovalRequestTxt: label 'Approval of Training Application is requested';
        RunWorkflowOnSendTrainingForApprovalCode: label 'RUNWORKFLOWONSENDTrainingAppFORAPPROVAL';
        OnCancelTrainingAppApprovalRequestTxt: label 'An Approval of Training Application is canceled';
        RunWorkflowOnCancelTrainingAppForApprovalCode: label 'RUNWORKFLOWONCANCELTrainingAppFORAPPROVAL';
        OnSendJobAppApprovalRequestTxt: label 'Approval of HR Job is requested';
        RunWorkflowOnSendJobAppForApprovalCode: label 'RUNWORKFLOWONSENDJOBAPPFORAPPROVAL';
        OnCancelJobAppApprovalRequestTxt: label 'An Approval of HR Job is canceled';
        RunWorkflowOnCancelJobAppForApprovalCode: label 'RUNWORKFLOWONCANCELJOBAPPFORAPPROVAL';
        //Job Applications
        OnSendJobApplicationApprovalRequestTxt: label 'Approval of HR Job Application is requested';
        RunWorkflowOnSendJobApplicationForApprovalCode: label 'RUNWORKFLOWONSENDJOBAPPLICATIONFORAPPROVAL';
        OnCancelJobApplicationApprovalRequestTxt: label 'An Approval of HR Job Application is canceled';
        RunWorkflowOnCancelJobApplicationForApprovalCode: label 'RUNWORKFLOWONCANCELJOBAPPLICATIONFORAPPROVAL';
        //Job Application end
        OnSendEmpTransferAppApprovalRequestTxt: label 'Approval of Employee Transfer is requested';
        RunWorkflowOnSendEmpTransferAppForApprovalCode: label 'RUNWORKFLOWONSENDEmpTransferAppFORAPPROVAL';
        OnCancelEmpTransferAppApprovalRequestTxt: label 'An Approval of Employee Transfer is canceled';
        RunWorkflowOnCancelEmpTransferAppForApprovalCode: label 'RUNWORKFLOWONCANCELEmpTransferAppFORAPPROVAL';
        OnSendPlannerAppApprovalRequestTxt: label 'Approval of leave Planner is requested';
        RunWorkflowOnSendPlannerAppForApprovalCode: label 'RUNWORKFLOWONSENDPlannerAppFORAPPROVAL';
        OnCancelPlannerAppApprovalRequestTxt: label 'An Approval of leave Planner is canceled';
        RunWorkflowOnCancelPlannerAppForApprovalCode: label 'RUNWORKFLOWONCANCELPlannerAppFORAPPROVAL';
        OnSendEmployeeAppApprovalRequestTxt: label 'Approval of Employee Application is requested';
        RunWorkflowOnSendEmployeeAppForApprovalCode: label 'RUNWORKFLOWONSENDEmployeeAppFORAPPROVAL';
        OnCancelEmployeeAppApprovalRequestTxt: label 'An Approval of Employee Application is canceled';
        RunWorkflowOnCancelEmployeeAppForApprovalCode: label 'RUNWORKFLOWONCANCELEmployeeAppFORAPPROVAL';
        OnSendInternReqAppApprovalRequestTxt: label 'Approval of Intern Requisition is requested';
        RunWorkflowOnSendInternReqAppForApprovalCode: label 'RUNWORKFLOWONSENDInternReqFORAPPROVAL';
        OnCancelInternReqAppApprovalRequestTxt: label 'An Approval of Intern Requisition is canceled';
        RunWorkflowOnCancelInternReqAppForApprovalCode: label 'RUNWORKFLOWONCANCELInternReqAppFORAPPROVAL';
        OnSendTransportAppApprovalRequestTxt: label 'Approval of Transport Requisition is requested';
        RunWorkflowOnSendTransportForApprovalCode: label 'RUNWORKFLOWONSENDTransportFORAPPROVAL';
        OnCancelTransportAppApprovalRequestTxt: label 'An Approval of Transport Requisition is canceled';
        RunWorkflowOnCancelTransportAppForApprovalCode: label 'RUNWORKFLOWONCANCELTransportAppFORAPPROVAL';
        OnSendMSACCOPINApprovalRequest: label 'Approval of MSACCO PIN Change Request';
        RunWorkflowOnSendMSACCOPINApprovalCode: label 'RUNWORKFLOWSENDMSACCOPINFORAPPROVAL';
        OnCancelMSACCOPINApprovalRequest: label 'An Approval of MSACCO PIN CHANGE is Cancelled';
        RunWorkflowOnCancelMSACCOPINRequestApprovalCode: label 'RUNWORKFLOWONCANCELMSACCOPINChangeFORAPPROVAL';
        OnSendMsaccoApplicationApprovalRequest: label 'Approval of MSACCO Application Request';
        RunWorkflowOnSendMsaccoApplicationApprovalCode: label 'RUNWORKFLOWSENDMSACCOAPPLICATIONFORAPPROVAL';
        OnCancelMsaccoAPPLICATIONApprovalRequest: label 'An Approval of MSACCO APPLICATION is Cancelled';
        RunWorkflowOnCancelMsaccoAPPLICATIONRequestApprovalCode: label 'RUNWORKFLOWONCANCELMSACCOAPPLICATIONFORAPPROVAL';
        OnSendMSACCOChangeApprovalRequest: label 'Approval of MSACCO Change Request';
        RunWorkflowOnSendMSACCOChangeApprovalCode: label 'RUNWORKFLOWSENDMSACCOCHANGEFORAPPROVAL';
        OnCancelMSACCOChangeApprovalRequest: label 'An Approval of MSACCO CHANGE is Cancelled';
        RunWorkflowOnCancelMSACCOChangeRequestApprovalCode: label 'RUNWORKFLOWONCANCELMSACCOCHANGEFORAPPROVAL';
        OnSendTNeedAppApprovalRequestTxt: label 'Approval of Training Need Application is requested';
        RunWorkflowOnSendTNeedForApprovalCode: label 'RUNWORKFLOWONSENDTNeedAppFORAPPROVAL';
        OnCancelTNeedAppApprovalRequestTxt: label 'An Approval of Training Need Application is canceled';
        RunWorkflowOnCanceTNeedAppForApprovalCode: label 'RUNWORKFLOWONCANCELTNeedAppFORAPPROVAL';
        RunWorkflowOnCancelTNeedAppForApprovalCode: label 'RUNWORKFLOWONCANCELTNeedAppFORAPPROVAL';
        OnSendDisciplinaryAppApprovalRequestTxt: label 'Approval of Disciplinary Application is requested';
        RunWorkflowOnSendDisciplinaryForApprovalCode: label 'RUNWORKFLOWONSENDDisciplinaryAppFORAPPROVAL';
        OnCancelDisciplinaryAppApprovalRequestTxt: label 'An Approval of Disciplinary Application is canceled';
        RunWorkflowOnCancelDisciplinaryAppForApprovalCode: label 'RUNWORKFLOWONCANCELDisciplinaryAppFORAPPROVAL';
        OnSendDisciplinaryAppealAppApprovalRequestTxt: label 'Approval of Disciplinary Appeal Application is requested';
        RunWorkflowOnSendDisciplinaryAppealForApprovalCode: label 'RUNWORKFLOWONSENDDisciplinaryAppealAppFORAPPROVAL';
        OnCancelDisciplinaryAppealAppApprovalRequestTxt: label 'An Approval of Disciplinary Appeal Application is canceled';
        RunWorkflowOnCancelDisciplinaryAppealAppForApprovalCode: label 'RUNWORKFLOWONCANCELDisciplinaryAppealAppFORAPPROVAL';
        OnSendDisciplinaryWithdrawalAppApprovalRequestTxt: label 'Approval of Disciplinary Withdrawal Application is requested';
        RunWorkflowOnSendDisciplinaryWithdrawalForApprovalCode: label 'RUNWORKFLOWONSENDDisciplinaryWithdrawalAppFORAPPROVAL';
        OnCancelDisciplinaryWithdrawalAppApprovalRequestTxt: label 'An Approval of Disciplinary Withdrawal Application is canceled';
        RunWorkflowOnCancelDisciplinaryWithdrawalAppForApprovalCode: label 'RUNWORKFLOWONCANCELDisciplinaryWithdrawalAppFORAPPROVAL';
        OnSendAppraisalAppealAppApprovalRequestTxt: label 'Approval of Appraisal Appeal Application is requested';
        RunWorkflowOnSendAppraisalAppealForApprovalCode: label 'RUNWORKFLOWONSENDAppraisalAppealAppFORAPPROVAL';
        OnCancelAppraisalAppealAppApprovalRequestTxt: label 'An Approval of Appraisal Appeal Application is canceled';
        RunWorkflowOnCancelAppraisalAppealAppForApprovalCode: label 'RUNWORKFLOWONCANCELAppraisalAppealAppFORAPPROVAL';

        OnSendCollatReturnApprovalRequestTxt: label 'Approval of Collateral Return Application is requested';
        RunWorkflowOnSendCollateReturnForApprovalCode: label 'RUNWORKFLOWONSENDCollatReturnFORAPPROVAL';
        OnCancelCollatReturnApprovalRequestTxt: label 'An Approval of Collateral Return Application is cancelled';
        RunWorkflowOnCancelCollatReturnForApprovalCode: label 'RUNWORKFLOWONCANCELCollateraReturnlFORAPPROVAL';


        //--------------Lease Application---------------------
        OnSendLeaseApprovalRequestTxt: label 'Approval of a Lease is requested';
        RunWorkflowOnSendLeaseForApprovalCode: label 'RUNWORKFLOWONSENDLEASEFORAPPROVAL';
        OnCancelLeaseApprovalRequestTxt: label 'An Approval of Lease is canceled';
        // OnCancelFixedDepositApprovalRequestTxt: Label 'An approval of Fixed Deposit is canceled';
        RunWorkflowOnCancelLeaseForApprovalCode: label 'RUNWORKFLOWONCANCELLEASEFORAPPROVAL';
        //-------------------Lease----------------------------------


        OnSendPropApprovalRequestTxt: label 'Approval of a Property is requested';
        RunWorkflowOnSendPropForApprovalCode: label 'RUNWORKFLOWONSENDPROPFORAPPROVAL';
        OnCancelPropApprovalRequestTxt: label 'An Approval of Property is canceled';
        RunWorkflowOnCancelPropForApprovalCode: label 'RUNWORKFLOWONCANCELPROPFORAPPROVAL';
        "***tfeed***": label 'gg';
        OnSendTFeedAppApprovalRequestTxt: label 'Approval of Training Feedback  is requested';
        RunWorkflowOnSendTFeedForApprovalCode: label 'RUNWORKFLOWONSENDTFeedAppFORAPPROVAL';
        OnCancelTFeedAppApprovalRequestTxt: label 'An Approval of Training Feedback Application is canceled';
        RunWorkflowOnCancelTFeedAppForApprovalCode: label 'RUNWORKFLOWONCANCELTFeedAPPFORAPPROVALCODE';
        OnSendInternAppApprovalRequestTxt: label 'Approval of Interns  is requested';
        RunWorkflowOnSendInternForApprovalCode: label 'RUNWORKFLOWONSENDInternAppFORAPPROVAL';
        OnCancelInternAppApprovalRequestTxt: label 'An Approval of Interns Application is canceled';
        RunWorkflowOnCancelInternAppForApprovalCode: label 'RUNWORKFLOWONCANCELInternAPPFORAPPROVALCODE';
        //         Contract": 'Comment';
        OnSendContractAppApprovalRequestTxt: label 'Approval of Contract  is requested';
        RunWorkflowOnSendContractForApprovalCode: label 'RUNWORKFLOWONSENDContractAppFORAPPROVAL';
        OnCancelContractAppApprovalRequestTxt: label 'An Approval of Contract Application is canceled';
        RunWorkflowOnCancelContractAppForApprovalCode: label 'RUNWORKFLOWONCANCELContractAPPFORAPPROVALCODE';
        //         Legal": 'Comment';
        OnSendLegalApprovalRequestTxt: label 'Approval of a Legal is requested';
        RunWorkflowOnSendLegalForApprovalCode: label 'RUNWORKFLOWONSENDLEGALFORAPPROVAL';
        OnCancelLegalApprovalRequestTxt: label 'An Approval of Legal is canceled';
        RunWorkflowOnCancelLegalForApprovalCode: label 'RUNWORKFLOWONCANCELLEGALFORAPPROVAL';
        //Appeal
        OnSendAppealAppApprovalRequestTxt: label 'Approval of Appeal  is requested';
        RunWorkflowOnSendAppealForApprovalCode: label 'RUNWORKFLOWONSENDAppealAppFORAPPROVAL';
        OnCancelAppealAppApprovalRequestTxt: label 'Approval of Appeal Application is canceled';
        RunWorkflowOnCancelAppealAppForApprovalCode: label 'RUNWORKFLOWONCANCELAppealAPPFORAPPROVALCODE';
        //         Surety": 'Comment';
        OnSendSuretyApprovalRequestTxt: label 'Approval of a Surety is requested';
        RunWorkflowOnSendSuretyForApprovalCode: label 'RUNWORKFLOWONSENDSuretyFORAPPROVAL';
        OnCancelSuretyApprovalRequestTxt: label 'An Approval of Suretyl is canceled';
        RunWorkflowOnCancelSuretyForApprovalCode: label 'RUNWORKFLOWONCANCELSuretyFORAPPROVAL';
        OnSendBoardPaymentApprovalRequestTxt: label 'Approval of Board Payment is requested';
        RunWorkflowOnSendBoardPaymentForApprovalCode: label 'RUNWORKFLOWONSENDBOARDPAYMENTFORAPPROVAL';
        OnCancelBoardPaymentApprovalRequestTxt: label 'An Approval of Board Payment is canceled';
        RunWorkflowOnCancelBoardPaymentForApprovalCode: label 'RUNWORKFLOWONCANCELBOARDPAYMENTFORAPPROVAL';
        OnSendSinkFundReportApprovalRequestTxt: label 'Approval of a Sink Fund Report is requested';
        RunWorkflowOnSendSinkFundReportForApprovalCode: label 'RUNWORKFLOWONSENDSINKFUNDREPORTFORAPPROVAL';
        OnCancelSinkFundReportApprovalRequestTxt: label 'An Approval of a Sink Fund Report is canceled';
        RunWorkflowOnCancelSinkFundReportForApprovalCode: label 'RUNWORKFLOWONCANCELSINKFUNDREPORTFORAPPROVAL';
        OnsendAGMDelegatePaymentApprovalRequestTxt: label 'Approval of AGM Delegate Payment is requested';
        RunWorkflowOAGMDelegatePaymentForApprovalCode: label 'RunWorkflowOAGMDelegatePaymentForApproval';
        OnCancelAGMDelegatePaymentApprovalRequestTxt: label 'An Approval of a AGM Delegate Payment is canceled';
        RunWorkflowOnCanceAGMDelegatePayentForApprovalCode: label 'RUNWORKFLOWONCANCELAGMDELEGATEPAYMENTFORAPPROVAL';

        //         clo": 'Comment';
        OnSendBankingAccountClosureApprovalRequestTxt: label 'Approval of a Banking Account Closure is requested';
        RunWorkflowOnSendBankingAccountClosureForApprovalCode: label 'RUNWORKFLOWONSENDBanking Account ClosureFORAPPROVAL';
        OnCancelBankingAccountClosureApprovalRequestTxt: label 'An Approval of a Banking Account Closure is canceled';
        RunWorkflowOnCancelBankingAccountClosureForApprovalCode: label 'RUNWORKFLOWONCANCELBanking Account ClosureFORAPPROVAL';
        //         dc": 'Comment';
        OnSendDelegatesRegionChangeApprovalRequestTxt: label 'Approval of Delegates Region Changet is requested';
        RunWorkflowOnSendDelegatesRegionChangeForApprovalCode: label 'RUNWORKFLOWONSENDDelegates Region ChangetFORAPPROVAL';
        OnCancelDelegatesRegionChangeApprovalRequestTxt: label 'An Approval of Delegates Region Change is canceled';
        RunWorkflowOnCancelDelegatesRegionChangeForApprovalCode: label 'RUNWORKFLOWONCANCELDelegatesRegionChangetFORAPPROVAL';
        //         DAA": 'Comment';
        "OnSendDelegateAGMUpdate ApprovalRequestTxt": label 'Approval of Delegate AGM Update is requested';
        RunWorkflowOnSendDelegateAGMUpdateForApprovalCode: label 'RUNWORKFLOWONSENDDelegate AGM UpdateFORAPPROVAL';
        "OnCancelDelegateAGMUpdate ApprovalRequestTxt": label 'An Approval of Delegate AGM Updatee is canceled';
        RunWorkflowOnCancelDelegateAGMUpdateForApprovalCode: label 'RUNWORKFLOWONCANCELDelegate AGM UpdateFORAPPROVAL';
        // SkyMbanking: Codeunit "Sky Mbanking";
        Auth: Record 52185476;
        Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,RTGS_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL;

        /*---------ELECTORAL ZONES-----": label '--------------------------------------------------*/
        OnSendElectoralZoneAppApprovalRequestTxt: label 'Approval of Electoral Zone  is requested';
        RunWorkflowOnSendElectoralZoneForApprovalCode: label 'RUNWORKFLOWONSENDELECTORALZONEAppFORAPPROVAL';
        OnCancelElectoralZoneAppApprovalRequestTxt: label 'An Approval of Electoral Zone Application is canceled';
        RunWorkflowOnCancelElectoralZoneAppForApprovalCode: label 'RUNWORKFLOWONCANCELELECTORALZONEAPPFORAPPROVALCODE';
        /*--------ELECTORAL ZONES-----": label '--------------------------------------------------'*/

        "---------HR Leave application-----": label '--------------------------------------------------';
        OnSendHrLeaveAdjustmentssAppApprovalRequestTxt: label 'Approval of Hr Leave Adjustments  is requested';
        RunWorkflowOnSendHrLeaveAdjustmentsForApprovalCode: label 'RUNWORKFLOWONSEND Hr Leave AdjustmentsAppFORAPPROVAL';
        OnCancelHrLeaveAdjustmentssAppApprovalRequestTxt: label 'An Approval of Hr Leave Adjustments Application is canceled';
        RunWorkflowOnCancelHrLeaveAdjustmentsAppForApprovalCode: label 'RUNWORKFLOWONCANCEL Hr Leave Adjustments APPFORAPPROVALCODE';
        "--------HRleave application-----": label '--------------------------------------------------';

        /*-------------------------------------Business Loans Account Application-------------------------------------*/
        OnSendBSLoansAccAppAppApprovalRequestTxt: label 'Approval of BS Loans Acc Application  is requested';
        RunWorkflowOnSendBSLoansAccAppForApprovalCode: label 'RUNWORKFLOWONSENDBSLOANSACCAPPAAPPFORAPPROVAL';
        OnCancelBSLoansAccAppAppApprovalRequestTxt: label 'An Approval of BS Loans Acc Application is canceled';
        RunWorkflowOnCancelBSLoansAccAppAppForApprovalCode: label 'RUNWORKFLOWONCANCELELBSLOANSACCAPPAPPFORAPPROVALCODE';
        /*-------------------------------------Business Loans Account Application-------------------------------------*/

        /*-------------------------------------Vendor-------------------------------------*/
        OnSendVendorApprovalRequestTxt: label 'Approval of Vendor requested';
        RunWorkflowOnSendVendorForApprovalCode: label 'RUNWORKFLOWONSENDVendorFORAPPROVAL';
        OnCancelVendorApprovalRequestTxt: label 'An Approval of Vendor is canceled';
        RunWorkflowOnCancelVendorForApprovalCode: label 'RUNWORKFLOWONCANCELVendorFORAPPROVAL';

        /*-------------------------------------Vendor-------------------------------------*/

        /*-------------------------------------System Edits-------------------------------------*/
        OnSendSystemEditsApprovalRequestTxt: label 'Approval of System Edits  is requested';
        RunWorkflowOnSendSystemEditsForApprovalCode: label 'RUNWORKFLOWONSEND SYSTEMEDITS FORAPPROVAL';
        OnCancelSystemEditsApprovalRequestTxt: label 'An Approval of System Edits is canceled';
        RunWorkflowOnCancelSystemEditsForApprovalCode: label 'RUNWORKFLOWONCANCELELSYSTEMEDITSFORAPPROVALCODE';
        /*-------------------------------------System Edits-------------------------------------*/
        //HrAppraisals
        OnSendHrAppraisalApprovalRequestTxt: label ' An Approval of Hr Appraisal  is requested';
        RunWorkflowOnSendHrAppraisalForApprovalCode: label 'RUNWORKFLOWONSENDHRAPPRAISALFORAPPROVAL';
        OnCancelHrAppraisalApprovalRequestTxt: label 'An Approval of Hr Appraisal is cancelled';
        RunWorkflowOnCancelHrAppraisalForApprovalCode: label 'RUNWORKFLOWONCANCELHRAPPRAISALFORAPPROVALCODE';

        //Hr Appraisals



        /*-------------------------------------Dependancy Applications-------------------------------------*/
        OnSendDependancyApplicationsApprovalRequestTxt: label 'Approval of Dependancy Applications  is requested';
        RunWorkflowOnSendDependancyApplicationsForApprovalCode: label 'RUNWORKFLOWONSENDDEPENDANCYAPPLICATIONSFORAPPROVAL';
        OnCancelDependancyApplicationsApprovalRequestTxt: label 'An Approval of Dependancy Applications is canceled';
        RunWorkflowOnCancelDependancyApplicationsForApprovalCode: label 'RUNWORKFLOWONCANCELELDEPENDANCYAPPLICATIONSFORAPPROVALCODE';
        /*-------------------------------------Dependancy Applications-------------------------------------*/

        /*-------------------------------------One Month Installment-------------------------------------*/
        OnSendOneMonthInstallmentApprovalRequestTxt: label 'Approval of One Month Installment  is requested';
        RunWorkflowOnSendOneMonthInstallmentForApprovalCode: label 'RUNWORKFLOWONSENDONEMONTHINSTALLMENTFORAPPROVAL';
        OnCancelOneMonthInstallmentApprovalRequestTxt: label 'An Approval of One Month Installment is canceled';
        RunWorkflowOnCancelOneMonthInstallmentForApprovalCode: label 'RUNWORKFLOWONCANCELELONEMONTHINSTALLMENTFORAPPROVALCODE';
        /*-------------------------------------One Month Installment-------------------------------------*/

        /*-------------------------------------Business Loan Clossure-------------------------------------*/
        OnSendBusinessLoanClossureApprovalRequestTxt: label 'Approval of Business Loan Clossure  is requested';
        RunWorkflowOnSendBusinessLoanClossureForApprovalCode: label 'RUNWORKFLOWONSENDBUSINESSLOANCLOSSUREFORAPPROVAL';
        OnCancelBusinessLoanClossureApprovalRequestTxt: label 'An Approval of Business Loan Clossure is canceled';
        RunWorkflowOnCancelBusinessLoanClossureForApprovalCode: label 'RUNWORKFLOWONCANCELELBUSINESSLOANCLOSSUREFORAPPROVALCODE';

        /*-------------------------------------Business Loan Clossure-------------------------------------*/


        /*-------------------------------------Business Loan Clossure-------------------------------------*/

        /*-------------------------------------System Reversal-------------------------------------*/
        OnSendBusinessSystemReversalApprovalRequestTxt: label 'Approval of System Reversal  is requested';
        RunWorkflowOnSendSystemReversalForApprovalCode: label 'RUNWORKFLOWONSENDSYSTEMREVERSALFORAPPROVAL';
        OnCancelSystemReversalApprovalRequestTxt: label 'An Approval of SystemReversal is canceled';
        RunWorkflowOnCancelSystemReversalForApprovalCode: label 'RUNWORKFLOWONCANCELSYSTEMREVERSALFORAPPROVALCODE';
        /*-------------------------------------User Creation-------------------------------------*/
        OnSendUserCreationApprovalRequestTxt: label 'Approval of user Ceation  is requested';
        RunWorkflowOnSendUserCreationForApprovalCode: label 'RUNWORKFLOWONSENDUSERCREATIONFORAPPROVAL';
        OnCancelUserCreationApprovalRequestTxt: label 'An Approval of User Creation is canceled';
        RunWorkflowOnCancelUserCreationForApprovalCode: label 'RUNWORKFLOWONCANCELUSERCREATIONFORAPPROVALCODE';
        /*-------------------------------------User Creation-------------------------------------*/

        /*-------------------------------------Product Creation-------------------------------------*/
        OnSendProductApprovalRequestTxt: label 'Approval of Product Creation  is requested';
        RunWorkflowOnSendProductForApprovalCode: label 'RUNWORKFLOWONSENDPRODUCTCREATIONFORAPPROVAL';
        OnCancelProductApprovalRequestTxt: label 'An Approval of Product Creation is canceled';
        RunWorkflowOnCancelProductForApprovalCode: label 'RUNWORKFLOWONCANCELPRODUCTCREATIONFORAPPROVALCODE';
        /*-------------------------------------Product Creation-------------------------------------*/

        /*-------------------------------------User Termination-------------------------------------*/
        OnSendTerminationApprovalRequestTxt: label 'Approval of Termination Request  is requested';
        RunWorkflowOnSendTerminationForApprovalCode: label 'RUNWORKFLOWONSENDTERMINATIONREQUESTFORAPPROVAL';
        OnCancelTerminationApprovalRequestTxt: label 'An Approval of Termination Request is canceled';
        RunWorkflowOnCancelTerminationForApprovalCode: label 'RUNWORKFLOWONCANCELTERMINATIONREQUESTFORAPPROVALCODE';
        /*-------------------------------------User Termination-------------------------------------*/


        /*-------------------------------------System Reversal-------------------------------------*/

        /*-------------------------------------Fixed Deposit Contracts-------------------------------------*/
        OnSendBusinessFixedDeposit2ContractsApprovalRequestTxt: label 'Approval of Fixed Deposit2 Contracts  is requested';
        RunWorkflowOnSendFixedDeposit2ContractsForApprovalCode: label 'RUNWORKFLOWONSENDFixedDeposit2ContractsFORAPPROVALcode';
        OnCancelFixedDepositContracts2ApprovalRequestTxt: label 'An Approval of Fixed Deposit2 Contracts is canceled';
        RunWorkflowOnCancelFixedDeposit2ContractsForApprovalCode: label 'RUNWORKFLOWONCANCELFixedDeposit2ContractsFORAPPROVALCODE';
        /*-------------------------------------Fixed Deposit Contracts-------------------------------------*/

        /*-------------------------------------Fixed Deposit Contracts-------------------------------------*/
        OnSendDMUCaseForwardingApprovalRequestTxt: label 'Approval of DMU Case Forwarding  is requested';
        RunWorkflowOnSendDMUCaseForwardingForApprovalCode: label 'RUNWORKFLOWONSENDDMUCASEFORWARDINGFORAPPROVALcode';
        OnCancelDMUCaseForwardingApprovalRequestTxt: label 'An Approval of DMU Case Forwarding is canceled';
        RunWorkflowOnCancelDMUCaseForwardingForApprovalCode: label 'RUNWORKFLOWONCANCELDMUCASEFORWARDINGFORAPPROVALCODE';
        /*-------------------------------------Fixed Deposit Contracts-------------------------------------*/

        /*-------------------------------------Dispatch ATM-------------------------------------*/
        OnSendDispatchATMApprovalRequestTxt: label 'Approval of Dispatch ATM  is requested';
        RunWorkflowOnSendDispatchATMForApprovalCode: label 'RUNWORKFLOWONSENDDISPATCHATMFORAPPROVALcode';
        OnCancelDispatchATMApprovalRequestTxt: label 'An Approval of Dispatch ATM is canceled';
        RunWorkflowOnCancelDispatchATMApprovalCode: label 'RUNWORKFLOWONCANCELDISPATCHATMFORAPPROVALCODE';
        /*-------------------------------------Dispatch ATM-------------------------------------*/

        /*-------------------------------------Loan Recovery Header-------------------------------------*/
        OnSendRecoveryHeaderApprovalRequestTxt: label 'Approval of Loan Recovery Header is requested';
        RunWorkflowOnSendRecoveryHeaderAppForApprovalCode: label 'RUNWORKFLOWONSEND Loan Recovery Header AppFORAPPROVAL';
        OnCancelRecoveryHeaderAppApprovalRequestTxt: label 'An Approval of Loan Recovery Header Application is canceled';
        RunWorkflowOnCancelRecoveryHeaderAppForApprovalCode: label 'RUNWORKFLOWONCANCEL Loan Recovery Header AppFORAPPROVAL';
        /*-------------------------------------Loan Recovery Header-------------------------------------*/

        /*-------------------------------------Loan Recovery Header II-------------------------------------*/
        OnSendRecoveryHeaderIIApprovalRequestTxt: label 'Approval of Loan Recovery Header II is requested';
        RunWorkflowOnSendRecoveryHeaderIIAppForApprovalCode: label 'RUNWORKFLOWONSEND Loan Recovery Header II AppFORAPPROVAL';
        OnCancelRecoveryHeaderIIAppApprovalRequestTxt: label 'An Approval of Loan Recovery Header II Application is canceled';
        RunWorkflowOnCancelRecoveryHeaderIIAppForApprovalCode: label 'RUNWORKFLOWONCANCEL Loan Recovery Header II AppFORAPPROVAL';
        /*-------------------------------------Loan Recovery Header II-------------------------------------*/

        /*-------------------------------------InvestInterestHeader-------------------------------------*/
        OnSendInvestInterestHeaderApprovalRequestTxt: label 'Approval of Investment Interest Header  is requested';
        RunWorkflowOnSendInvestInterestHeaderForApprovalCode: label 'RUNWORKFLOWONSEND INVESTINTERESTHEADER FORAPPROVAL';
        OnCancelInvestInterestHeaderApprovalRequestTxt: label 'An Approval of INVESTINTERESTHEADER is canceled';
        RunWorkflowOnCancelInvestInterestHeaderForApprovalCode: label 'RUNWORKFLOWONCANCELELINVESTINTERESTHEADERFORAPPROVALCODE';
        /*-------------------------------------InvestInterestHeader-------------------------------------*/


        /*-------------------------------------Withdrawal Notice-------------------------------------*/
        OnSendWithdrawalNoticeAppApprovalRequestTxt: label 'Approval of Withdrawal Notice is requested';
        RunWorkflowOnSendWithdrawalNoticeAppForApprovalCode: label 'RUNWORKFLOWONSEND Withdrawal Notice AppFORAPPROVAL';
        OnCancelWithdrawalNoticeAppApprovalRequestTxt: label 'An Approval of Withdrawal Notice is canceled';
        RunWorkflowOnCancelWithdrawalNoticeAppForApprovalCode: label 'RUNWORKFLOWONCANCEL Withdrawal Notice AppFORAPPROVAL';
        /*-------------------------------------Withdrawal Notice-------------------------------------*/

        //Board Pay
        OnSendBoardMemberPayApprovalRequestTxt: label 'Approval of a Board member pay is requested';
        RunWorkflowOnSendBoardMemberPayForApprovalCode: label 'RUNWORKFLOWONSENDBOARDMEMBERPAYFORAPPROVAL';
        OnCancelBoardMemberPayApprovalRequestTxt: label 'An Approval of a  Board Member pay is canceled';
        RunWorkflowOnCancelBoardMemberPayForApprovalCode: label 'RUNWORKFLOWONCANCELBOARDMEMBERPAYFORAPPROVAL';
        //BoardPAy

        /*"---------Delegate Officials-----": label '--------------------------------------------------';*/
        OnSendDelegateOfficialsAppApprovalRequestTxt: label 'Approval of Delegate Officials  is requested';
        RunWorkflowOnSendDelegateOfficialsForApprovalCode: label 'RUNWORKFLOWONSENDDELEGATEOFFICIALSAppFORAPPROVAL';
        OnCancelDelegateOfficialsAppApprovalRequestTxt: label 'An Approval of DelegateOfficials Application is canceled';
        RunWorkflowOnCancelDelegateOfficialsAppForApprovalCode: label 'RUNWORKFLOWONCANCELDELEGATEOFFICIALSAPPFORAPPROVALCODE';
        /*"--------Delegate Officials-----": label '--------------------------------------------------';*/


        /*"---------Delegate Minutes-----": label '--------------------------------------------------';*/
        OnsendDelegateMinutesApprovalRequestTxt: label 'Approval of Delegate Minutes is requested';
        RunWorkflowOnDelegateMinutesForApprovalCode: label 'RunWorkflowOnDelegateMinutesForApproval';
        OnCancelDelegateMinutesApprovalRequestTxt: label 'An Approval of a Delegate Minutes is canceled';
        RunWorkflowOnCancelDelegateMinutesForApprovalCode: label 'RUNWORKFLOWONCANCELDELEGATEMinutesFORAPPROVAL';
        /*"---------Delegate Minutes-----": label '--------------------------------------------------';*/

        /*"---------Delegate Payments-----": label '--------------------------------------------------';*/
        OnSendDelegatesPaymentApprovalRequestTxt: label 'Approval of Delegates Payment is requested';
        RunWorkflowOnSendDelegatesPaymentForApprovalCode: label 'RUNWORKFLOWONSENDDelegatesPaymentFORAPPROVAL';
        OnCancelDelegatesPaymentApprovalRequestTxt: label 'An Approval of Delegates Payment is canceled';
        RunWorkflowOnCancelDelegatesPaymentForApprovalCode: label 'RUNWORKFLOWONCANCELDelegatesPaymentFORAPPROVAL';
        /*"---------Delegate Payments-----": label '--------------------------------------------------';*/


        /*"---------Checkoff Header-----": label '--------------------------------------------------';*/
        OnSendCheckoffAppApprovalRequestTxt: label 'Approval of checkoff Application is requested';
        RunWorkflowOnSendCheckoffAppForApprovalCode: label 'RUNWORKFLOWONSENDCheckoffAppFORAPPROVAL';
        OnCancelCheckoffAppApprovalRequestTxt: label 'An Approval of Checkoff Application is canceled';
        RunWorkflowOnCancelCheckoffAppForApprovalCode: label 'RUNWORKFLOWONCANCELCheckoffAppFORAPPROVAL';
        /*"---------Checkoff Header-----": label '--------------------------------------------------';*/

        /*"---------SMS Alerts-----": label '--------------------------------------------------';*/
        OnSendAlertsHeaderAppApprovalRequestTxt: label 'Approval of Alerts Header Application is requested';
        RunWorkflowOnSendAlertsHeaderAppForApprovalCode: label 'RUNWORKFLOWONSENDALERTSHEADERAppFORAPPROVAL';
        OnCancelAlertsHeaderAppApprovalRequestTxt: label 'An Approval of AlertsHeader Application is canceled';
        RunWorkflowOnCancelAlertsHeaderAppForApprovalCode: label 'RUNWORKFLOWONCANCELALERTSHEADERAppFORAPPROVAL';
        //AccountAcc
        RunWorkflowOnSendAccountActivationForApprovalCode: label 'RUNWORKFLOWONSENDACCOUNTACTIVATIONFORAPPROVAL';
        RunWorkflowOnCancelAccountActivationForApprovalCode: label 'RUNWORKFLOWONCANCELACCOUNTACTIVATIONFORAPPROVAL';
        OnCancelAccountActivationApprovalRequestTxt: label 'An Approval of a account Activation is canceled';
        OnSendAccountActivationApprovalRequestTxt: label 'Approval of a account Activation is requested';


        //ContractRequ
        RunWorkflowOnSendContractRequestForApprovalCode: label 'RUNWORKFLOWONSENDCONTRACTREQUESTFORAPPROVAL';
        RunWorkflowOnCancelContractRequestForApprovalCode: label 'RUNWORKFLOWONCANCELCONTRACTREQUESTFORAPPROVAL';
        OnCancelContractRequestApprovalRequestTxt: label 'An Approval of a Contract Request is canceled';
        OnSendContractRequestApprovalRequestTxt: label 'Approval of a Contract Request is requested';
        //hrhearderOvertime
        RunWorkflowOnSendHROvertimeRequestForApprovalCode: label 'RUNWORKFLOWONSENDHROVERTIMEREQUESTFORAPPROVAL';
        RunWorkflowOnCancelHROvertimeRequestForApprovalCode: label 'RUNWORKFLOWONCANCELHROVERTIMEREQUESTFORAPPROVAL';
        OnCancelHROvertimeRequestApprovalRequestTxt: label 'An Approval of a Hr OverTime Header is canceled';
        OnSendHROvertimeRequestApprovalRequestTxt: label 'Approval of a Hr OverTime Header is requested';
        //TrasureyCheqApp
        RunWorkflowOnSendTreasuryChequeApplicationForApprovalCode: label 'RUNWORKFLOWONSENDTREASURYCHEQUEAPPLICATIONFORAPPROVAL';
        RunWorkflowOnCancelTreasuryChequeApplicationForApprovalCode: label 'RUNWORKFLOWONCANCELTREASURYCHEQUEAPPLICATIONFORAPPROVAL';
        OnCancelTreasuryChequeApplicationApprovalRequestTxt: label 'An Approval of a Treasury Cheque Application is canceled';
        OnSendTreasuryChequeApplicationApprovalRequestTxt: label 'Approval of a Treasury Cheque Application is requested';
        //InsuaranceClaims
        RunWorkflowOnSendInsuaranceClaimsForApprovalCode: label 'RUNWORKFLOWONSENDINSUARANCECLAIMSFORAPPROVAL';
        RunWorkflowOnCancelInsuaranceClaimsForApprovalCode: label 'RUNWORKFLOWONCANCELINSUARANCECLAIMSFORAPPROVAL';
        OnCancelInsuaranceClaimsApprovalRequestTxt: label 'An Approval of a Insuarance Claims is canceled';
        OnSendInsuaranceClaimsApprovalRequestTxt: label 'Approval of a Insuarance Claims is requested';
        //insuarance
        RunWorkflowOnSendAssetInsuarancesForApprovalCode: label 'RUNWORKFLOWONSENDASSETINSUARANCEFORAPPROVAL';
        RunWorkflowOnCancelAssetInsuaranceForApprovalCode: label 'RUNWORKFLOWONCANCELASSETINSUARANCEFORAPPROVAL';
        OnCancelAssetInsuaranceApprovalRequestTxt: label 'An Approval of a asset Insuarance is canceled';
        OnSendAssetInsuaranceApprovalRequestTxt: label 'Approval of asset Insuarance is requested';
        //mantainMachine
        RunWorkflowOnSendVehicleRepairForApprovalCode: label 'RUNWORKFLOWONSENDVEHICLEREPAIRFORAPPROVAL';
        RunWorkflowOnCancelVehicleRepairForApprovalCode: label 'RUNWORKFLOWONCANCELVEHICLEREPAIRFORAPPROVAL';
        OnCancelVehicleRepairApprovalRequestTxt: label 'n Approval of Vehicle Repair is Cancelled';
        OnSendVehicleRepairApprovalRequestTxt: label 'An Approval of Vehicle Repair is Requested ';
        //VehiclServicing
        RunWorkflowOnSendVehicleServicingForApprovalCode: label 'RUNWORKFLOWONSENDVEHICLESERVICINGFORAPPROVAL';
        RunWorkflowOnCancelVehicleServicingForApprovalCode: label 'RUNWORKFLOWONCANCELVEHICLESERVICINGFORAPPROVAL';
        OnCancelVehicleServicingApprovalRequestTxt: label 'n Approval of Vehicle Servicing is Cancelled';
        OnSendVehicleServicingApprovalRequestTxt: label 'An Approval of Vehicle Servicing is Requested ';
        //StockKeeping

        RunWorkflowOnSendStockKeepingForApprovalCode: label 'RUNWORKFLOWONSENDSTOCKKEEPINGFORAPPROVAL';
        RunWorkflowOnCancelStockKeepingForApprovalCode: label 'RUNWORKFLOWONCANCELSTOCKKEEPINGFORAPPROVAL';
        OnCancelStockKeepingApprovalRequestTxt: label 'n Approval of Stock Keeping is Cancelled';
        OnSendStockKeepingApprovalRequestTxt: label 'An Approval of Stock Keeping is Requested ';
        //WellfairAdvance
        RunWorkflowOnSendWellFareAdvanceForApprovalCode: label 'RUNWORKFLOWONSENDWELLFAREADVANCEFORAPPROVAL';
        RunWorkflowOnCancelWellFareAdvanceForApprovalCode: label 'RUNWORKFLOWONCANCELWELLFAREADVANCEFORAPPROVAL';
        OnCancelWellFareAdvanceApprovalRequestTxt: label 'Approval of WellFare Advance is Cancelled';
        OnSendWellFareAdvanceApprovalRequestTxt: label 'An Approval of WellFare Advance is Requested';
        //Clearance form
        RunWorkflowOnSendClearanceFormForApprovalCode: label 'RUNWORKFLOWONSENDCLEARANCEFORMFORAPPROVAL';
        RunWorkflowOnCanceClearanceFormForApprovalCode: label 'RUNWORKFLOWONCANCELCLEARANCEFORMFORAPPROVAL';
        OnCancelWellClearanceFormApprovalRequestTxt: label 'Approval of Clearance Form is Cancelled';
        OnSendClearanceFormApprovalRequestTxt: label 'An Approval of Clearance  Form is Requested';

        //BOSA Account Activation
        RunWorkflowOnSendBOSAAccountActivationForApprovalCode: label 'RUNWORKFLOWONSENDBOSAACCOUNTACTIVATIONFORAPPROVAL';
        RunWorkflowOnCancelBOSAAccountActivationForApprovalCode: label 'RUNWORKFLOWONCANCELBOSAACCOUNTACTIVATIONFORAPPROVAL';
        OnCancelBOSAAccountActivationApprovalRequestTxt: label 'An Approval of a BOSA Account Activation is canceled';
        OnSendBOSAAccountActivationApprovalRequestTxt: label 'Approval of BOSA Account Activation is requested';
        //BOSA Account Activation
        //Batchingprocess table

        RunWorkflowOnSendBatchingProcessTableForApprovalCode: label 'RUNWORKFLOWONSENDBATCHINGPROCESSTABLEFORAPPROVAL';
        RunWorkflowOnCancelBatchingProcessTableForApprovalCode: label 'RUNWORKFLOWONCANCELBATCHINGPROCESSTABLEFORAPPROVAL';
        OnCancelBatchingProcessTableApprovalRequestTxt: label 'An Approval of a Batching process Table is canceled';
        OnSendBatchingProcessTableApprovalRequestTxt: label 'Approval of Batching process Table is requested';

        //General SMS
        RunWorkflowOnSendGeneralSMSForApprovalCode: label 'RUNWORKFLOWONSENDGENERALSMSFORAPPROVAL';
        RunWorkflowOnCancelGeneralSMSForApprovalCode: label 'RUNWORKFLOWONCANCELGENERALSMSFORAPPROVAL';
        OnCancelGeneralSMSApprovalRequestTxt: label 'An Approval of a GENERAL SMS is canceled';
        OnSendGeneralSMSApprovalRequestTxt: label 'Approval of General SMS is requested';
        //General SMS

        /*-------------------------------------MKEY FORWARDING-------------------------------------*/
        OnSendMKeyApprovalRequestTxt: label 'Approval of MKey  is requested';
        RunWorkflowOnSendMKeyForApprovalCode: label 'RUNWORKFLOWONSENDMKEYFORAPPROVAL';
        OnCancelMKeyApprovalRequestTxt: label 'An Approval of MKey is canceled';
        RunWorkflowOnCancelMKeyForApprovalCode: label 'RUNWORKFLOWONCANCELELMKEYFORAPPROVALCODE';
        /*-------------------------------------MKEY FORWARDING-------------------------------------*/

        /*-------------------------------------Revenue Collection-------------------------------------*/
        OnSendRevenueCollectionApprovalRequestTxt: label 'Approval of Revenue Collection  is requested';
        RunWorkflowOnSendRevenueCollectionForApprovalCode: label 'RUNWORKFLOWONSENDREVENUECOLLECTIONFORAPPROVAL';
        OnCancelRevenueCollectionApprovalRequestTxt: label 'An Approval of Revenue Collection is canceled';
        RunWorkflowOnCancelRevenueCollectionForApprovalCode: label 'RUNWORKFLOWONCANCELELREVENUECOLLECTIONFORAPPROVALCODE';
        /*-------------------------------------Revenue Collection-------------------------------------*/

        /*-------------------------------------Bank Deposits-------------------------------------*/
        OnSendBankDepositApprovalRequestTxt: label 'Approval of Bank Deposit  is requested';
        RunWorkflowOnSendBankDepositForApprovalCode: label 'RUNWORKFLOWONSENDBANKDEPOSITFORAPPROVAL';
        OnCancelBankDepositApprovalRequestTxt: label 'An Approval of Bank Deposit is canceled';
        RunWorkflowOnCancelBankDepositForApprovalCode: label 'RUNWORKFLOWONCANCELELBANKDEPOSITFORAPPROVALCODE';
        /*-------------------------------------Bank Deposits-------------------------------------*/

        /*.....................................Group Member Update, Exit, Edit and Closure............................................*/
        OnSendGroupMemberUpdateEditandExitForApprovalCode: Label 'Approval of Group Member Update Exit Edit or Closure is Requested';
        RunWorkflowOnSendGroupMemberUpdateEditandExitForApprovalCode: Label 'RUNWORKFLOWONSENDGROUPMEMBERUPDATEFORAPPROVAL';
        OnCancelGroupMemberUpdateEditandExitForApprovalCode: Label 'Approval of Group Member Update Exit Edit or Closure is Canceled';
        RunWorkflowOnCancelGroupMemberUpdateEditandExitForApprovalCode: Label 'RUNWORKFLOWONCANCELGROUPMEMBERUPDATEFORAPPROVAL';


    procedure CheckApprovalsWorkflowEnabled(var Variant: Variant): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of

            Database::"Group Member Exit & Update":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendGroupMemberUpdateEditandExitForApprovalCode));
            Database::"Bank Deposit Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendBankDepositForApprovalCode));
            Database::"FA Reclass. Journal Line":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendFixedAssetReclassificationForApprovalCode));
            Database::"Revenue Collection":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendRevenueCollectionForApprovalCode));
            Database::"MKey Forwarding":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendMKeyForApprovalCode));
            Database::"General SMS Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendGeneralSMSForApprovalCode));
            Database::"Batching Process Table":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendBatchingProcessTableForApprovalCode));
            Database::"Clearance Form":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendClearanceFormForApprovalCode));
            Database::"Welfare Advance":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendWellFareAdvanceForApprovalCode));
            Database::"Stock Keeping":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendStockKeepingForApprovalCode));
            Database::"Vehicle Servicing Table":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendVehicleServicingForApprovalCode));
            Database::"Maintain Machne/Vehicles":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendVehicleRepairForApprovalCode));
            Database::Insurance:
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendAssetInsuarancesForApprovalCode));
            Database::"Insurance Claims":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendInsuaranceClaimsForApprovalCode));
            Database::"HR Training Planner":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendHrTrainingplannnerForApprovalCode));
            Database::"Treasury Cheque Application":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendTreasuryChequeApplicationForApprovalCode));

            Database::"Contract Request":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendContractRequestForApprovalCode));
            Database::"HR Overtime Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendHROvertimeRequestForApprovalCode));
            Database::"Account Activation":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendAccountActivationForApprovalCode));
            Database::"Key Request Table":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunworkflowOnsendKeyRequestforapprovalCode));
            Database::"Dividends Provision Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendDividendsProvisionForApprovalCode));
            Database::"HR Employee Exit Interviews":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendHrInterviewExitForApprovalCode));
            Database::"Nominee Form Request":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendNomineeRequestFormForApprovalCode));
            Database::"HR Appraisal Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendHrAppraisalForApprovalCode));
            Database::"HR Company Activities":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendHrCompanyActivityForApprovalCode));
            Database::"Office Keys List":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunworkflowOnsendKeyCreationRequestforapprovalCode));
            Database::"Appeals Table":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendAppealForApprovalCode));
            Database::"Securities Register":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendSecurityRegisterForApprovalCode));
            Database::"HR Fuel Management Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkFlowOnSendFuelRegistrationForApprovalCode));
            Database::"HR OSAccident":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendAccidentCreationForApprovalCode));
            Database::"Security Perfection":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendSecurityPefectionRequestforApprovalCode));
            Database::"SMS Alerts Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendAlertsHeaderAppForApprovalCode));
            Database::"Conference & Meeting Rooms-T":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendConferenceBookingRequestForApprovalCode));
            Database::"Conf & Meeting Rooms List":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendConferenceRoomCreationForApprovalCode));
            Database::"Parking List Table":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendParkingCreationRequestApprovalCode));
            Database::"HR Drivers":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendDriverCreationForApprovalCode));
            Database::"Company Vehicles":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendCompanyVehiclesForApprovalCode));

            Database::"Board members":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendBoardMemberPayForApprovalCode));
            Database::"Vendor":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendVendorForApprovalCode));
            Database::"Motor Vehicle Request":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunworkflowOnsendMotorVehicleRequestforapprovalCode));
            Database::"Security Discharge":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendSecurityDischargeRequestforApprovalCode));
            Database::"Investment Interest Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendInvestInterestHeaderForApprovalCode));
            Database::"Parking Space":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnsendParkingApprovalRequestCode));
            Database::"Fosa Payments Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunworkflowOnsendFOSAPVRequestforapprovalCode));
            Database::Customer:
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendCustomerRequestForApprovalCode));
            Database::"DMU Case Forwarding":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendDMUCaseForwardingForApprovalCode));
            Database::"Vehicle Movement":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendMotorVehicleMovementRequestforAprovalCode));
            Database::"Refund,Account Transfer Header":
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendRefundAccountTransferRequestforAprovalCode));
            Database::"Product Variations":

                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendloanVariationForApprovalCode));

            //Staff welfare
            Database::"Staff Welfare":

                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnSendStaffWelfareForApprovalCode));
            database::"Motor Vehicle Request":
                //Motor Vehicle Request
                exit(CheckApprovalsWorkflowEnabledCode(variant, RunworkflowOnsendMotorVehicleRequestforapprovalCode));
            database::"Delegates Minutes Header":

                exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnDelegateMinutesForApprovalCode));
            Database::"Fixed Deposit Contract":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RUNWORKFLOWONSENDFixedDeposit2ContractsFORAPPROVALcode));

            Database::"System Reversal":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSystemReversalForApprovalCode));
            //Product creation
            Database::"Product Factory":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendProductForApprovalCode));

            Database::"Business Loan Clossure":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBusinessLoanClossureForApprovalCode));
            //one month installment
            Database::"One Month Installment":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendOneMonthInstallmentForApprovalCode));
            //User Creation
            Database::"User Creation Requests":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendUserCreationForApprovalCode));
            //User Termination
            Database::"User Termination":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTerminationForApprovalCode));
            //Depandancy ApplicationsRunWorkflowOnSendProductCreationForApprovalCode
            Database::"Dependancies Applications":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDependancyApplicationsForApprovalCode));
            //Business Loans Account Application
            Database::"System Edits":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSystemEditsForApprovalCode));
            //Business Loans Account Application
            Database::"B/S Loan Account Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBSLoansAccAppForApprovalCode));
            //Electoral Zones
            Database::"Electoral Zones":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendElectoralZoneForApprovalCode));
            Database::"Moratorium Loan":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, Runworkflowonsendmoratoriumloanforapprovalcode));
            Database::"Share Capital Transfer Buffer":
                exit(CheckApprovalsWorkflowEnabledCode(variant, runworkflowonsendsharecapitaltransferforapprovalcode));
            //Hr leave Adjustments
            Database::"HR Leave Journal Line":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendHrLeaveAdjustmentsForApprovalCode));
            //Delegate Officials
            Database::"Delegate Officials":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegateOfficialsForApprovalCode));

            //Sky Virtual Registration
            Database::"Sky Virtual Member":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSkyVirtualMemberForApprovalCode));
            //Sky Virtual Registration


            Database::"SinkFund Report Information":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSinkFundReportForApprovalCode));
            // Database::"AGM Delegates Payment":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOAGMDelegatePaymentForApprovalCode));
            Database::"Payments Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPaymentForApprovalCode));
            //checkmember app cancell or send

            Database::"Member Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMemberAppForApprovalCode));

            // Database::"member application":
            //     exit(CheckApprovalsWorkflowEnabledCode(variant, RunWorkflowOnCancelMemberAppForApprovalCode));

            //Database::"Banking Account Closure":
            //exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBankingAccountClosureForApprovalCode));
            // Database::"Delegate Region Change":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegatesRegionChangeForApprovalCode));
            // Database::"Delegate AGM Update Header":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegateAGMUpdateForApprovalCode));
            Database::"Payments Header Board":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBoardPaymentForApprovalCode));

           
            Database::"InterBank Transfers":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendInterbankForApprovalCode));
            Database::"Staff Claims Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffClaimForApprovalCode));
            Database::"Staff Advance Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffAdvanceForApprovalCode));
            Database::"Staff Advance Surrender Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode));
            Database::"Imprest Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendImprestForApprovalCode));
            Database::"Imprest Surrender Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendImprestSurrenderForApprovalCode));
            Database::"Overtime Claim Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendOvertimeForApprovalCode));
            Database::"Store Requistion Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStoreRequisitionForApprovalCode));
            Database::"G/L Budget Name":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBudgetForApprovalCode));
            Database::"Vote Transfer":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendVoteForApprovalCode));
            Database::"Asset Transfer":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAssetTransferForApprovalCode));

            //Cashier Transactions
            Database::"Cashier Transactions":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCashierTRANSForApprovalCode));
            //Cashier Transactions
            // Database::"Document Exemptions Auth.":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDocExForApprovalCode));
            //Salary Transactions
            Database::"Salary Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSalaryTRANSForApprovalCode));
            //Salary Transactions

            //Bankers Cheques
            Database::"Bankers Cheque Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBankersCForApprovalCode));
            //Bankers Cheques

            //Bank Cheques
            Database::"Cheque Book Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBankCForApprovalCode));
            //Bank Cheques

            //Overdraft
            Database::"Over Draft Authorisation":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendODForApprovalCode));
            //Overdraft

            //Account Transfers
            Database::"Account Transfer Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendACTForApprovalCode));
            //Account Transfers

            //Inter Teller
            Database::"Treasury Cashier Transactions":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTREASForApprovalCode));
            //Inter Teller



            //Investment
            Database::"Investment Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendINVForApprovalCode));
            //Investment

            //Cheque Receipts
            Database::"Cheque Receipts":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCHQForApprovalCode));

            //Legal
            Database::Legal:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLegalForApprovalCode));

            //Surety Management
            Database::"Surety Management":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSuretyForApprovalCode));

            //Contract
            Database::Contracts:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendContractForApprovalCode));
            //Cheque Receipts
            //  Database::"Cheque Receipts Header":
            //    exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMemberAppForApprovalCode));
            //Salary Agreement
            Database::"Salary Agreement":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSalaryAgreementForApprovalCode)); //
                                                                                                                   //Account Application
            Database::"Savings Account Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAccountAppForApprovalCode)); //
                                                                                                              //Electronic Fund Transfer Application
            Database::"RTGS Transfer Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendRTGSAppForApprovalCode)); //
                                                                                                           //Standing Order Application
            Database::"Standing Order Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSTOAppForApprovalCode)); //
                                                                                                          //Standing Order Control Application
            Database::"Standing Order Control":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSTOCTLAppForApprovalCode)); //
                                                                                                             //Dividend Rate Application
            Database::"Dividend Simulation Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDividendRateAppForApprovalCode)); //

            //Product Factory Application
            //Database::"Product Factory":
            //exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPFAAppForApprovalCode)); //
            //Loans
            Database::Loans:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLoanAppForApprovalCode));

            //Collateral collection
            Database::"Securities Collection Register":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCollateReturnForApprovalCode)); //
                                                                                                                 //Loans batch
            Database::"Loan Disbursement Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLoanBatchForApprovalCode)); //
                                                                                                             //Interest Billing
            Database::"Interest Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendInterestBillingForApprovalCode)); //
                                                                                                                   //Savings Interest Header
            Database::"Savings Interest Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSavingsInterestHeaderForApprovalCode)); //
                                                                                                                         //End Year Transfer Header
            Database::"End Year Transfer Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendEndYearTransferHeaderForApprovalCode)); //
                                                                                                                         //ATM Applications
            Database::"ATM Applications":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendATMApplicationsForApprovalCode)); //
                                                                                                                   //ATM Linking Applications
            Database::"ATM Linking Applications":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendATMLinkingApplicationsForApprovalCode)); //
                                                                                                                          //Checkoff
            Database::"Checkoff Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendCheckoffAppForApprovalCode)); //
                                                                                                               //Membership closure
            Database::"Membership closure":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMembershipClosureAppForApprovalCode)); //
                                                                                                                        //Loan Reschedule
            Database::"Loan Rescheduling":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLoanReschedulingForApprovalCode)); //
                                                                                                                    //Withdrawal Notice
            Database::"Member withdrawal Notice":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendWithdrawalNoticeAppForApprovalCode)); //
                                                                                                                       //Guaraton Substitution
            Database::"Guarantors Substitution":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendGuarantorSubstitutionAppForApprovalCode)); //
                                                                                                                            //Guarantor Recovery
            Database::"Loan Recovery Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendRecoveryHeaderAppForApprovalCode));

            Database::"Loan Recovery Header II":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendRecoveryHeaderIIAppForApprovalCode));

            Database::Bond:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBondAppForApprovalCode)); //
                                                                                                           //Sink Fund
            Database::"BBF Requisation Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendSinkFundAppForApprovalCode)); //
                                                                                                               //Delegate Region Change
            Database::"Delegate Region Change":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegatesRegionChangeForApprovalCode)); //
                                                                                                                         //Delegate AGM Updates
            Database::"Delegate AGM Update Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegateAGMUpdateForApprovalCode)); //
                                                                                                                     //FOSA Account Closure
            Database::"Banking Account Closure":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBankingAccountClosureForApprovalCode)); //
                                                                                                                         //AGM Delegate Payment
            Database::"AGM Delegates Payment":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOAGMDelegatePaymentForApprovalCode));
            //BDE Management
            Database::"BDE Management Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBDEManagementAppForApprovalCode)); //
                                                                                                                    //Delegate Groups Applicationss
            Database::"Delegate Region Applicationss":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegateGroupsApplicationssForApprovalCode)); //
                                                                                                                               //Delegate Group Mem Retirements
            Database::"Delegate Region Mem Retirement":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegateGroupMemRetirementsForApprovalCode)); //
                                                                                                                               //Delegates Payment
            Database::"Delegates Payment":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDelegatesPaymentForApprovalCode)); //
                                                                                                                    //HR
                                                                                                                    //Employee Requisitions
            Database::"HR Employee Requisitions":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendEmployeeRequisitionAppForApprovalCode)); //

            //HR Leave Application
            Database::"HR Leave Application":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLeaveForApprovalCode)); //


            //HR Training Feedback
            Database::"HR Training Feedback Form":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTFeedForApprovalCode)); //

            //iNTERNS
            Database::"HR Interns":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendInternForApprovalCode)); //



            //HR Appraisal Appeal
            Database::"HR Appraissal Appeal":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAppraisalAppealForApprovalCode)); //

            //HR Disciplinary Appeal
            Database::"HRDisciplinary Appeal":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDisciplinaryAppealForApprovalCode)); //

            //HR Disciplinary Withdrawal
            Database::"HRDisciplinary Case Withdrawal":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDisciplinaryWithdrawalForApprovalCode)); //


            //HR Training App Header
            Database::"HR Training App Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTrainingForApprovalCode)); //
                                                                                                            //HR Training Needs
            Database::"HR Training Needs":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTNeedForApprovalCode)); //
                                                                                                         //HR Transport Requisition Head
            Database::"HR Transport Requisition Head":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTransportForApprovalCode)); //
                                                                                                             //HR Employee Transfer Header
            Database::"HR Employee Transfer Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendEmpTransferAppForApprovalCode)); //                                   
                                                                                                                  //HR Jobs
            Database::"HR Jobs":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendJobAppForApprovalCode)); //
                                                                                                          //job application
            Database::"HR Job Applications":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendJobApplicationForApprovalCode));
            //HR Leave Planner Header
            Database::"HR Leave Planner Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPlannerAppForApprovalCode)); //
                                                                                                              //HR Employees
            Database::"HR Employees":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendEmployeeAppForApprovalCode)); //
                                                                                                               //HR Interns Requisition
            Database::"HR Interns Requisition":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendInternReqAppForApprovalCode)); //
                                                                                                                //HR Leave Application
                                                                                                                // Database::"HR Leave Application":
                                                                                                                //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLeaveForApprovalCode)); //HR Training Needs
                                                                                                                //                                                                                              //end HR

            // //HR Training Feedback
            // Database::"HR Training Feedback Form":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendTFeedForApprovalCode));
            // //end HR

            // //HR Interns
            // Database::"HR Interns":
            //     exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendInternForApprovalCode)); //interns
            //                                                                                               //end HR

            //HR Disciplinary cases
            Database::"HR Disciplinary Cases NCA":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDisciplinaryForApprovalCode)); //

            //Staff loans
            Database::"prSalary Advance":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendStaffLoansForApprovalCode)); //RunWorkflowOnSendStaffLoansForApprovalCode
                                                                                                              //Permission Requisition
            Database::"Permission Requisition":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPermissionRequisitionForApprovalCode));
            // MSACCO
            Database::"M-SACCO Change PIN No":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMSACCOPINApprovalCode));

            Database::"M-SACCO Applications":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMsaccoApplicationApprovalCode));
            // MSACCO

            // Agency
            Database::"Agent Applications":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendAgentApplicationForApprovalCode));

            //Property Lease
            Database::Lease:
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendLeaseForApprovalCode));
            //Property Lease

            //Property
            Database::"Property Details":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendPropForApprovalCode));
            //Property
            Database::"Mortgage Loans Doc Release":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendMortgageDocReleaseForApprovalCode));


            Database::"Dispatch ATM Header":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendDispatchATMForApprovalCode));

            //BOSA Account Activation
            Database::"BOSA Account Activation":
                exit(CheckApprovalsWorkflowEnabledCode(Variant, RunWorkflowOnSendBOSAAccountActivationForApprovalCode));
            //BOSA Account Activation

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;


    procedure CheckApprovalsWorkflowEnabledCode(var Variant: Variant; CheckApprovalsWorkflowTxt: Text): Boolean
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        begin
            if not WorkflowManagement.CanExecuteWorkflow(Variant, CheckApprovalsWorkflowTxt) then
                Error(NoWorkflowEnabledErr);
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]

    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]

    procedure OnCancelDocApprovalRequest(var Variant: Variant)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkflowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        //GroupMemberEditandUpdate
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendGroupMemberUpdateEditandExitForApprovalCode, Database::"Group Member Exit & Update", OnSendGroupMemberUpdateEditandExitForApprovalCode, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelGroupMemberUpdateEditandExitForApprovalCode, Database::"Group Member Exit & Update", OnCancelGroupMemberUpdateEditandExitForApprovalCode, 0, false);
        //Bank Deposit
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendBankDepositForApprovalCode, Database::"Bank Deposit Header", OnSendBankDepositApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBankDepositForApprovalCode, Database::"Bank Deposit Header", OnCancelBankDepositApprovalRequestTxt, 0, false);
        //Fixed Asset Reclassification
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendFixedAssetReclassificationForApprovalCode, Database::"FA Reclass. Journal Line", OnSendFixedAssetReclassificationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelFixedAssetReclassificationForApprovalCode, Database::"FA Reclass. Journal Line", OnCancelFixedAssetReclassificationApprovalRequestTxt, 0, false);
        //Revenue Collection
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendRevenueCollectionForApprovalCode, Database::"Revenue Collection", RunWorkflowOnSendRevenueCollectionForApprovalCode, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRevenueCollectionForApprovalCode, Database::"Revenue Collection", OnCancelRevenueCollectionApprovalRequestTxt, 0, false);

        //MKey
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendMKeyForApprovalCode, Database::"Mkey Forwarding", RunWorkflowOnSendMKeyForApprovalCode, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMKeyForApprovalCode, Database::"Mkey Forwarding", OnCancelMKeyApprovalRequestTxt, 0, false);

        //General SMS
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendGeneralSMSForApprovalCode, Database::"General SMS Header", OnSendGeneralSMSApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelGeneralSMSForApprovalCode, Database::"General SMS Header", OnCancelGeneralSMSApprovalRequestTxt, 0, false);

        //Batchingprocess
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendBatchingProcessTableForApprovalCode, Database::"Batching Process Table", OnSendBatchingProcessTableApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBatchingProcessTableForApprovalCode, Database::"Batching Process Table", OnCancelBatchingProcessTableApprovalRequestTxt, 0, false);

        //ClearanceForm
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendClearanceFormForApprovalCode, Database::"Clearance Form", OnSendClearanceFormApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCanceClearanceFormForApprovalCode, Database::"Clearance Form", OnCancelWellClearanceFormApprovalRequestTxt, 0, false);

        //WellFareAdvance
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendWellFareAdvanceForApprovalCode, Database::"Welfare Advance", OnSendWellFareAdvanceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelWellFareAdvanceForApprovalCode, Database::"Welfare Advance", OnCancelWellFareAdvanceApprovalRequestTxt, 0, false);

        //sTOCKkEEPING
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendStockKeepingForApprovalCode, Database::"Stock Keeping", OnSendStockKeepingApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelStockKeepingForApprovalCode, Database::"Stock Keeping", OnCancelStockKeepingApprovalRequestTxt, 0, false);

        //vEHICLEservicing
        //VehicleRepar
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendVehicleServicingForApprovalCode, Database::"Vehicle Servicing Table", OnSendVehicleServicingApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelVehicleServicingForApprovalCode, Database::"Vehicle Servicing Table", OnCancelVehicleServicingApprovalRequestTxt, 0, false);

        //VehicleRepar
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendVehicleRepairForApprovalCode, Database::"Maintain Machne/Vehicles", OnSendVehicleRepairApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelVehicleRepairForApprovalCode, Database::"Maintain Machne/Vehicles", OnCancelVehicleRepairApprovalRequestTxt, 0, false);

        //insurance
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendAssetInsuarancesForApprovalCode, Database::Insurance, OnSendAssetInsuaranceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAssetInsuaranceForApprovalCode, Database::Insurance, OnCancelAssetInsuaranceApprovalRequestTxt, 0, false);

        //iNSURANCEClaims
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendInsuaranceClaimsForApprovalCode, Database::"Insurance Claims", OnSendInsuaranceClaimsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelInsuaranceClaimsForApprovalCode, Database::"Insurance Claims", OnCancelInsuaranceClaimsApprovalRequestTxt, 0, false);

        //Treasury
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendTreasuryChequeApplicationForApprovalCode, Database::"Treasury Cheque Application", OnSendTreasuryChequeApplicationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTreasuryChequeApplicationForApprovalCode, Database::"Treasury Cheque Application", OnCancelTreasuryChequeApplicationApprovalRequestTxt, 0, false);

        //BOSA Account Activation
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendBOSAAccountActivationForApprovalCode, Database::"BOSA Account Activation", OnSendBOSAAccountActivationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBOSAAccountActivationForApprovalCode, Database::"BOSA Account Activation", OnCancelBOSAAccountActivationApprovalRequestTxt, 0, false);

        //Overtime
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendHROvertimeRequestForApprovalCode, Database::"HR Overtime Header", OnSendHROvertimeRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelHROvertimeRequestForApprovalCode, Database::"HR Overtime Header", OnCancelHROvertimeRequestApprovalRequestTxt, 0, false);

        //ContraReq
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendContractRequestForApprovalCode, Database::"Contract Request", OnSendContractRequestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelContractRequestForApprovalCode, Database::"Contract Request", OnCancelContractRequestApprovalRequestTxt, 0, false);


        //AccounAcc
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendAccountActivationForApprovalCode, Database::"Account Activation", OnSendAccountActivationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAccountActivationForApprovalCode, Database::"Account Activation", OnCancelAccountActivationApprovalRequestTxt, 0, false);

        //Key Request
        WorkFlowEventHandling.AddEventToLibrary(RunworkflowOnsendKeyRequestforapprovalCode, Database::"Key Request Table", OnsendKeyRequestApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelKeyrequestForApprovalCode, Database::"Key Request Table", OnCancelKeyRequestapprovalTxt, 0, false);
        //Key Creation
        WorkFlowEventHandling.AddEventToLibrary(RunworkflowOnsendKeyCreationRequestforapprovalCode, Database::"Office Keys List", OnsendKeyCreationRequestApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelKeyCreationRequestforapprovalCode, Database::"Office Keys List", OnCancelKeyCreationRequestapprovalTxt, 0, false);
        //Appeals
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendAppealForApprovalCode, Database::"Appeals Table", OnSendAppealAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAppealAppForApprovalCode, Database::"Appeals Table", OnCancelAppealAppApprovalRequestTxt, 0, false);
        //Fuel
        //Securities
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnSendSecurityRegisterForApprovalCode, Database::"Securities Register", OnSendSecurityRegisterApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSecurityRegisterForApprovalCode, Database::"Securities Register", OnCancelSecurityRegisterApprovalRequestTxt, 0, false); //
                                                                                                                                                    //hrInterview

        // "Dividends Provision Header"
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDividendsProvisionForApprovalCode, Database::"Dividends Provision Header", OnSendDividendsProvisionApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDividendsProvisionForApprovalCode, Database::"Dividends Provision Header", OnCancelDividendsProvisionApprovalRequestTxt, 0, false);
        //hrcompanyActivity
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrInterviewExitForApprovalCode, Database::"HR Employee Exit Interviews", OnSendHrInterviewExitApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrInterviewExitForApprovalCode, Database::"HR Employee Exit Interviews", OnCancelHrInterviewExitApprovalRequestTxt, 0, false); //
                                                                                                                                                          //HrcompanyActivity
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendFuelRegistrationForApprovalCode, Database::"HR Fuel Management Header", OnSendFuelRegistrationForApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelFuelRegistrationForApprovalCode, Database::"HR Fuel Management Header", OnCancelFuelRegistrationForApprovalRequestTxt, 0, false);
        //Accidents
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendAccidentCreationForApprovalCode, Database::"HR OSAccident", OnSendAccidentCreationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAccidentCreationForApprovalCode, Database::"HR OSAccident", OnCancelAccidentCreationApprovalRequestTxt, 0, false);
        //SM Alerts
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendAlertsHeaderAppForApprovalCode, Database::"SMS Alerts Header", OnSendAlertsHeaderAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAlertsHeaderAppForApprovalCode, Database::"SMS Alerts Header", OnCancelAlertsHeaderAppApprovalRequestTxt, 0, false);

        //ConferenceRoomBooking
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendConferenceBookingRequestForApprovalCode, Database::"Conference & Meeting Rooms-T", RunWorkflowOnSendConferenceBookingRequestForApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelConferenceBookingRequestForApprovalCode, Database::"Conference & Meeting Rooms-T", RunWorkflowOnCancelConferenceBookingRequestForApprovalTxt, 0, false);
        //Conference Room Creation
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendConferenceRoomCreationForApprovalCode, Database::"Conf & Meeting Rooms List", OnSendConferenceRoomCreationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelConferenceRoomCreationForApprovalCode, Database::"Conf & Meeting Rooms List", OnCancelConferenceRoomCreationApprovalRequestTxt, 0, false);
        //Parking Creation
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendParkingCreationRequestApprovalCode, Database::"Parking List Table", OnSendParkingCreationRequestApprovalTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelParkingCreationRequestApprovalCode, Database::"Parking List Table", OnCancelParkingCreationRequestApprovalTxt, 0, false);
        //Perfection
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendSecurityPefectionRequestforApprovalCode, Database::"Security Perfection", OnSendSecurityPerfectionRequestApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWworkflowOnCancelSecurityPerfectionRequestForApprovalCode, Database::"Security Perfection", OnCancelSecurityPerfectionRequestApprovalTxt, 0, false);
        //Surety Management
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendSuretyForApprovalCode, Database::"Surety Management", OnSendSuretyApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSuretyForApprovalCode, Database::"Surety Management", OnCancelSuretyApprovalRequestTxt, 0, false);
        //HRDrivers
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendDriverCreationForApprovalCode, Database::"HR Drivers", OnSendDriverCreationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDriverCreationForApprovalCode, Database::"HR Drivers", OnCancelDriverCreationApprovalRequestTxt, 0, false);
        //CompanyVehicles
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendCompanyVehiclesForApprovalCode, Database::"Company Vehicles", OnSendCompanyVehiclesApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCompanyVehiclesForApprovalCode, Database::"Company Vehicles", OnCancelCompanyVehiclesApprovalTxt, 0, false);
        //Vend
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendVendorForApprovalCode, Database::Vendor, OnSendVendorApprovalRequestTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelVendorForApprovalCode, Database::Vendor, OnCancelVendorApprovalRequestTxt, 0, false);
        //BoardP

        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendBoardMemberPayForApprovalCode, Database::"Board members", OnSendBoardMemberPayApprovalRequestTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBoardMemberPayForApprovalCode, Database::"Board members", OnCancelBoardMemberPayApprovalRequestTxt, 0, false);
        //BoardPa
        //Security Discharge
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendSecurityDischargeRequestforApprovalCode, Database::"Security Discharge", OnSendSecurityDischargeRequestApprovalTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWworkflowOnCancelSecurityDischargeRequestForApprovalCode, Database::"Security Discharge", OnCancelSecurityDischargeRequestApprovalTxt, 0, false);
        //Investment Interest Header
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendInvestInterestHeaderForApprovalCode, Database::"Investment Interest Header", OnSendInvestInterestHeaderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelInvestInterestHeaderForApprovalCode, Database::"Investment Interest Header", OnCancelInvestInterestHeaderApprovalRequestTxt, 0, false);
        //Parking
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnsendParkingApprovalRequestCode, Database::"Parking Space", OnSendParkingApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelParkingApprovalRequestCode, Database::"Parking Space", OnCancelParkingApprovalRequestTxt, 0, false);

        //SecurityPerfection
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendSecurityPefectionRequestforApprovalCode, Database::"Security Perfection", OnSendSecurityPerfectionRequestApprovalTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWworkflowOnCancelSecurityPerfectionRequestForApprovalCode, Database::"Security Perfection", OnCancelSecurityPerfectionRequestApprovalTxt, 0, false);

        //Tenant Customer Creation
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCustomerRequestForApprovalCode, Database::Customer, OnSendCustomerRequestForApprovalTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCustomerRequestForApprovalCode, Database::Customer, OnCancelCustomerRequestForApprovalTxt, 0, false);
        //Dispatch ATM
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendDispatchATMForApprovalCode, Database::"Dispatch ATM Header", OnSendDispatchATMApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDispatchATMApprovalCode, Database::"Dispatch ATM Header", OnCancelDispatchATMApprovalRequestTxt, 0, false);

        //DMU Case Forwarding
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendDMUCaseForwardingForApprovalCode, Database::"DMU Case Forwarding", OnSendDMUCaseForwardingApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDMUCaseForwardingForApprovalCode, Database::"DMU Case Forwarding", OnCancelDMUCaseForwardingApprovalRequestTxt, 0, false);

        //Vehicle Request
        WorkFlowEventHandling.AddEventToLibrary(RunworkflowOnsendMotorVehicleRequestforapprovalCode, Database::"Motor Vehicle Request", OnsendMotorVehicleRequestApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelmotorvehiclerequestForApprovalCode, Database::"Motor Vehicle Request", OnCancelMotorVehicleRequestapprovalTxt, 0, false);

        //Vehicle Movement
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendMotorVehicleMovementRequestforAprovalCode, Database::"Vehicle Movement", RunWorkflowOnSendMotorVehicleMovementRequestforAprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelMotorVehicleMovementRequestForApprovalCode, Database::"Vehicle Movement", RunWorkflowOnCancelMotorVehicleMovementRequestForApprovalTxt, 0, false);
        //Refund $ Account Transfer
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendRefundAccountTransferRequestforAprovalCode, Database::"Refund,Account Transfer Header", RunWorkflowOnSendRefundAccountTransferRequestforAprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRefundAccountTransferForApprovalCode, Database::"Refund,Account Transfer Header", RunWorkflowOnCancelRefundAccountTransferForApprovalTxt, 0, false);

        //System Reversal
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendFixedDeposit2ContractsForApprovalCode, Database::"Fixed Deposit Contract", OnSendBusinessFixedDeposit2ContractsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelFixedDeposit2ContractsForApprovalCode, Database::"Fixed Deposit Contract", OnCancelFixedDepositContracts2ApprovalRequestTxt, 0, false);

        //System Reversal
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSystemReversalForApprovalCode, Database::"System Reversal", OnSendBusinessSystemReversalApprovalRequestTxt, 0, false);
        //Product Creation
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendProductForApprovalCode, Database::"Product Factory", OnSendProductApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelProductForApprovalCode, Database::"Product Factory", OnCancelProductApprovalRequestTxt, 0, false);
        //FOSA PV
        WorkFlowEventHandling.AddEventToLibrary(
       RunworkflowOnsendFOSAPVRequestforapprovalCode, Database::"Fosa Payments Header", OnsendFOSAPVApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnCancelFOSAPVrequestForApprovalCode, Database::"Fosa Payments Header", OnCancelFOSAPVRequestapprovalTxt, 0, false);
        //Overtime Claim
        //User Creation
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendUserCreationForApprovalCode, Database::"User Creation Requests", OnSendUserCreationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelUserCreationForApprovalCode, Database::"User Creation Requests", OnCancelUserCreationApprovalRequestTxt, 0, false);
        //delegate minutes
        WorkFlowEventHandling.AddEventToLibrary(
      RunWorkflowOnDelegateMinutesForApprovalCode, Database::"Delegates Minutes Header", OnsendDelegateMinutesApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDelegateMinutesForApprovalCode, Database::"Delegates Minutes Header", OnCancelDelegateMinutesApprovalRequestTxt, 0, false);

        //NomineeForm
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowOnSendNomineeRequestFormForApprovalCode, Database::"Nominee Form Request", OnSendNomineeRequestFormApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelNomineeRequestFormForApprovalCode, Database::"Nominee Form Request", OnCancelNomineeRequestFormApprovalRequestTxt, 0, false);

        //User Termination
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTerminationForApprovalCode, Database::"User Termination", OnSendTerminationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTerminationForApprovalCode, Database::"User Termination", OnCancelTerminationApprovalRequestTxt, 0, false);
        //staff welfare
        WorkFlowEventHandling.AddEventToLibrary(
     RunWorkflowOnSendStaffWelfareForApprovalCode, Database::"Staff Welfare", OnSendStaffWelfareApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffWefareForApprovalCode, Database::"Staff Welfare", OnCancelStaffWelfareApprovalRequestTxt, 0, false);


        //Business Loan Clossure
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBusinessLoanClossureForApprovalCode, Database::"Business Loan Clossure", OnSendBusinessLoanClossureApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBusinessLoanClossureForApprovalCode, Database::"One Month Installment", OnCancelBusinessLoanClossureApprovalRequestTxt, 0, false);
        //variations
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendloanVariationForApprovalCode, Database::"Product Variations", OnSendloanVariationApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelloanVariationForApprovalCode, Database::"Product Variations", OnCancelloanVariationApprovalRequestTxt, 0, false);



        //One Month Installment
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendOneMonthInstallmentForApprovalCode, Database::"One Month Installment", OnSendOneMonthInstallmentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelOneMonthInstallmentForApprovalCode, Database::"One Month Installment", OnCancelOneMonthInstallmentApprovalRequestTxt, 0, false);
        //Hr Appraisals
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrAppraisalForApprovalCode, Database::"HR Appraisal Header", OnSendHrAppraisalApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrAppraisalForApprovalCode, Database::"HR Appraisal Header", OnCancelHrAppraisalApprovalRequestTxt, 0, false);


        //Depandancy Applications
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDependancyApplicationsForApprovalCode, Database::"Dependancies Applications", OnSendDependancyApplicationsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDependancyApplicationsForApprovalCode, Database::"Dependancies Applications", OnCancelDependancyApplicationsApprovalRequestTxt, 0, false);

        //System Edits
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnsendSystemEditsForApprovalCode, Database::"System Edits", OnSendSystemEditsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSystemEditsForApprovalCode, Database::"System Edits", OnCancelSystemEditsApprovalRequestTxt, 0, false);

        //Business Loans Account Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBSLoansAccAppForApprovalCode, Database::"B/S Loan Account Application", OnSendBSLoansAccAppAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBSLoansAccAppAppForApprovalCode, Database::"Sky Virtual Member", OnCancelBSLoansAccAppAppApprovalRequestTxt, 0, false);

        //Sky Virtual Member
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSkyVirtualMemberForApprovalCode, Database::"Sky Virtual Member", OnSendSkyVirtualMemberApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSkyVirtualMemberForApprovalCode, Database::"Sky Virtual Member", OnCancelSkyVirtualMemberApprovalRequestTxt, 0, false);

        //Moratorium LOan
        WorkFlowEventHandling.AddEventToLibrary(
        Runworkflowonsendmoratoriumloanforapprovalcode, database::"Moratorium Loan", OnsendMoratoriumLoanforApprovalTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowoncancelmoratoriumloanforapprovalcode, database::"Moratorium Loan", OnCancellMoratoriumLoanApprovalRequest, 0, false);


        WorkFlowEventHandling.AddEventToLibrary(RunworkflowOnsendsharecapitaltransferforapprovalCode, database::"Share Capital Transfer Buffer", onsendsharecapitaltransferapprovalrequesttxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(Runworkflowoncancelsharecapitaltransferforapprovalcode, database::"Share Capital Transfer Buffer", OnCancellsharecapitaltransferapprovalRequestTxt, 0, false);
        //Sky Virtual Member
        //Hr Leave Managent
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendHrLeaveAdjustmentsForApprovalCode, Database::"HR Leave Journal Line", OnSendHrLeaveAdjustmentssAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelHrLeaveAdjustmentsAppForApprovalCode, Database::"HR Leave Journal Line", OnCancelHrLeaveAdjustmentssAppApprovalRequestTxt, 0, false);
        //Hr Leave Managent
        //Electoral Zones
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendElectoralZoneForApprovalCode, Database::"Electoral Zones", OnSendElectoralZoneAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelElectoralZoneAppForApprovalCode, Database::"Electoral Zones", OnCancelElectoralZoneAppApprovalRequestTxt, 0, false);
        //Electoral Zones

        //Delegate Officials
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendDelegateOfficialsForApprovalCode, Database::"Delegate Officials", OnSendDelegateOfficialsAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDelegateOfficialsAppForApprovalCode, Database::"Delegate Officials", OnCancelDelegateOfficialsAppApprovalRequestTxt, 0, false);
        //Delegate Officials


        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendBankingAccountClosureForApprovalCode, Database::"Banking Account Closure", OnSendBankingAccountClosureApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBankingAccountClosureForApprovalCode, Database::"Banking Account Closure", OnCancelBankingAccountClosureApprovalRequestTxt, 0, false);


        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendDelegateAGMUpdateForApprovalCode, Database::"Delegate AGM Update Header", "OnSendDelegateAGMUpdate ApprovalRequestTxt", 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDelegateAGMUpdateForApprovalCode, Database::"Delegate AGM Update Header", "OnCancelDelegateAGMUpdate ApprovalRequestTxt", 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendDelegatesRegionChangeForApprovalCode, Database::"Delegate Region Change", OnSendDelegatesRegionChangeApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelDelegatesRegionChangeForApprovalCode, Database::"Delegate Region Change", OnCancelDelegatesRegionChangeApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnSendSinkFundReportForApprovalCode, Database::"SinkFund Report Information", OnSendSinkFundReportApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSinkFundReportForApprovalCode, Database::"SinkFund Report Information", OnCancelSinkFundReportApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOAGMDelegatePaymentForApprovalCode, Database::"AGM Delegates Payment", OnsendAGMDelegatePaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCanceAGMDelegatePayentForApprovalCode, Database::"AGM Delegates Payment", OnCancelAGMDelegatePaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPaymentForApprovalCode, Database::"Payments Header", OnSendPaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPaymentForApprovalCode, Database::"Payments Header", OnCancelPaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBoardPaymentForApprovalCode, Database::"Payments Header Board", OnSendBoardPaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBoardPaymentForApprovalCode, Database::"Payments Header Board", OnCancelBoardPaymentApprovalRequestTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendInterbankForApprovalCode, Database::"InterBank Transfers", OnSendInterbankApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelInterbankForApprovalCode, Database::"InterBank Transfers", OnCancelInterbankApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffClaimForApprovalCode, Database::"Staff Claims Header", OnSendStaffClaimApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffClaimForApprovalCode, Database::"Staff Claims Header", OnCancelStaffClaimApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffAdvanceForApprovalCode, Database::"Staff Advance Header", OnSendStaffAdvanceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffAdvanceForApprovalCode, Database::"Staff Advance Header", OnCancelStaffAdvanceApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode, Database::"Staff Advance Surrender Header", OnSendStaffAdvanceSurrenderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffAdvanceSurrenderForApprovalCode, Database::"Staff Advance Surrender Header", OnCancelStaffAdvanceSurrenderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendImprestForApprovalCode, Database::"Imprest Header", OnSendImprestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelImprestForApprovalCode, Database::"Imprest Header", OnCancelImprestApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendImprestSurrenderForApprovalCode, Database::"Imprest Surrender Header", OnSendImprestSurrenderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelImprestSurrenderForApprovalCode, Database::"Imprest Surrender Header", OnCancelImprestSurrenderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStoreRequisitionForApprovalCode, Database::"Store Requistion Header", OnSendStoreRequisitionApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStoreRequisitionForApprovalCode, Database::"Store Requistion Header", OnCancelStoreRequisitionApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendOvertimeForApprovalCode, Database::"Overtime Claim Header", OnSendOvertimeApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelOvertimeForApprovalCode, Database::"Overtime Claim Header", OnCancelOvertimeApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBudgetForApprovalCode, Database::"G/L Budget Name", OnSendBudgetApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBudgetForApprovalCode, Database::"G/L Budget Name", OnCancelBudgetApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendVoteForApprovalCode, Database::"Vote Transfer", OnSendVoteApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelVoteForApprovalCode, Database::"Vote Transfer", OnCancelVoteApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAssetTransferForApprovalCode, Database::"Asset Transfer", OnSendAssetTransferApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAssetTransferForApprovalCode, Database::"Asset Transfer", OnCancelAssetTransferApprovalRequestTxt, 0, false);

        //Cashier Transactions
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendCashierTRANSForApprovalCode, Database::"Cashier Transactions", OnSendCashierTRANSApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelCashierTRANSForApprovalCode, Database::"Cashier Transactions", OnCancelCashierTRANSApprovalRequestTxt, 0, false);
        //Cashier Transactions
        //Hrtrainplan
        WorkFlowEventHandling.AddEventToLibrary(
     RunWorkflowOnSendHrTrainingplannnerForApprovalCode, Database::"HR Training Planner", OnSendHrTrainingplannerApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrTrainingplannerForApprovalCode, Database::"HR Training Planner", OnCancelHrTrainingplannnerpprovalRequestTxt, 0, false);


        //Property Lease
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLeaseForApprovalCode, Database::Lease, OnSendLeaseApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLeaseForApprovalCode, Database::Lease, OnCancelLeaseApprovalRequestTxt, 0, false);
        //Property Lease


        //Property
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPropForApprovalCode, Database::"Property Details", OnSendPropApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPropForApprovalCode, Database::"Property Details", OnCancelPropApprovalRequestTxt, 0, false);
        //Property
        //Salary TransactionsF
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSalaryTRANSForApprovalCode, Database::"Salary Header", OnSendSalaryTRANSApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSalaryTRANSForApprovalCode, Database::"Salary Header", OnCancelSalaryTRANSApprovalRequestTxt, 0, false);
        //Salary Transactions

        //bankers Cheque
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBankersCForApprovalCode, Database::"Bankers Cheque Application", OnSendBankersCApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBankersCForApprovalCode, Database::"Bankers Cheque Application", OnCancelBankersCApprovalRequestTxt, 0, false);
        //bankers Cheque

        //bank Cheque
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBankCForApprovalCode, Database::"Cheque Book Application", OnSendBankCApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBankCForApprovalCode, Database::"Cheque Book Application", OnCancelBankCApprovalRequestTxt, 0, false);
        //bank Cheque

        //Overdraft
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendODForApprovalCode, Database::"Over Draft Authorisation", OnSendODApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelODForApprovalCode, Database::"Over Draft Authorisation", OnCancelODApprovalRequestTxt, 0, false);
        //Overdraft

        //Account Transfers
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendACTForApprovalCode, Database::"Account Transfer Header", OnSendACTApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelACTForApprovalCode, Database::"Account Transfer Header", OnCancelACTApprovalRequestTxt, 0, false);
        //Account Transfers

        //Inter Teller
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTREASForApprovalCode, Database::"Treasury Cashier Transactions", OnSendTREASApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTREASForApprovalCode, Database::"Treasury Cashier Transactions", OnCancelTREASApprovalRequestTxt, 0, false);
        //Inter Teller


        //Investments
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendINVForApprovalCode, Database::"Investment Header", OnSendINVApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelINVForApprovalCode, Database::"Investment Header", OnCancelINVApprovalRequestTxt, 0, false);
        //Investments

        //Cheque Receipts
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendCHQForApprovalCode, Database::"Cheque Receipts", OnSendCHQApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelCHQForApprovalCode, Database::"Cheque Receipts", OnCancelCHQApprovalRequestTxt, 0, false);
        //Cheque Receipts

        //Member Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMemberAppForApprovalCode, Database::"Member Application", OnSendMemberAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMemberAppForApprovalCode, Database::"Member Application", OnCancelMemberAppApprovalRequestTxt, 0, false); //

        //Salary Agreement
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSalaryAgreementForApprovalCode, Database::"Salary Agreement", OnSendSalaryAgreementAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSalaryAgreementForApprovalCode, Database::"Salary Agreement", OnCancelSalaryAgreementApprovalRequestTxt, 0, false);//

        //Account Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAccountAppForApprovalCode, Database::"Savings Account Application", OnSendAccountAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAccountAppForApprovalCode, Database::"Savings Account Application", OnCancelAccountAppApprovalRequestTxt, 0, false); //
        //Electronic Fund Transfer Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendRTGSAppForApprovalCode, Database::"RTGS Transfer Header", OnSendRTGSAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelRTGSAppForApprovalCode, Database::"RTGS Transfer Header", OnCancelRTGSAppApprovalRequestTxt, 0, false); //
        //Standing Order Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSTOAppForApprovalCode, Database::"Standing Order Header", OnSendSTOAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSTOAppForApprovalCode, Database::"Standing Order Header", OnCancelSTOAppApprovalRequestTxt, 0, false); //
        //Standing Order Stoppage Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSTOCTLAppForApprovalCode, Database::"Standing Order Control", OnSendSTOCTLAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSTOCTLAppForApprovalCode, Database::"Standing Order Control", OnCancelSTOCTLAppApprovalRequestTxt, 0, false); //
        //Dividend Rate Application
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDividendRateAppForApprovalCode, Database::"Dividend Simulation Header", OnSendDividendRateAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDividendRateAppForApprovalCode, Database::"Dividend Simulation Header", OnCancelDividendRateAppApprovalRequestTxt, 0, false);
        //Loans
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLoanAppForApprovalCode, Database::Loans, OnSendLoanAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLoanAppForApprovalCode, Database::Loans, OnCancelLoanAppApprovalRequestTxt, 0, false);

        //Collateral security Register

        //Collaterals collection
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendCollateReturnForApprovalCode, Database::"Securities Collection Register", OnSendCollatReturnApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelCollatReturnForApprovalCode, Database::"Securities Collection Register", OnCancelCollatReturnApprovalRequestTxt, 0, false); //
        //Loan Batches
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLoanBatchForApprovalCode, Database::"Loan Disbursement Header", OnSendLoanBatchApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLoanBatchForApprovalCode, Database::"Loan Disbursement Header", OnCancelLoanBatchApprovalRequestTxt, 0, false); //

        ////INTEREST BILLING
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendInterestBillingForApprovalCode, Database::"Interest Header", OnSendInterestBillingApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelInterestBillingForApprovalCode, Database::"Interest Header", OnCancelInterestBillingApprovalRequestTxt, 0, false); //

        ////Savings Interest Header
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSavingsInterestHeaderForApprovalCode, Database::"Savings Interest Header", OnSendSavingsInterestHeaderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSavingsInterestHeaderForApprovalCode, Database::"Savings Interest Header", OnCancelSavingsInterestHeaderApprovalRequestTxt, 0, false); //
        //End Year Transfer Header
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendEndYearTransferHeaderForApprovalCode, Database::"End Year Transfer Header", OnSendEndYearTransferHeaderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelEndYearTransferHeaderForApprovalCode, Database::"End Year Transfer Header", OnCancelEndYearTransferHeaderApprovalRequestTxt, 0, false); //

        //ATM Applications
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendATMApplicationsForApprovalCode, Database::"ATM Applications", OnSendATMApplicationsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelATMApplicationsForApprovalCode, Database::"ATM Applications", OnCancelATMApplicationsApprovalRequestTxt, 0, false); //
        //ATM Linking Applications
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendATMLinkingApplicationsForApprovalCode, Database::"ATM Linking Applications", OnSendATMLinkingApplicationsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelATMLinkingApplicationsForApprovalCode, Database::"ATM Linking Applications", OnCancelATMLinkingApplicationsApprovalRequestTxt, 0, false); //
        //Checkoff
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendCheckoffAppForApprovalCode, Database::"Checkoff Header", OnSendCheckoffAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelCheckoffAppForApprovalCode, Database::"Checkoff Header", OnCancelCheckoffAppApprovalRequestTxt, 0, false); //

        //Guarantor Substitution
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendGuarantorSubstitutionAppForApprovalCode, Database::"Guarantors Substitution", OnSendGuarantorSubstitutionApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelGuarantorSubstitutionAppForApprovalCode, Database::"Guarantors Substitution", OnCancelGuarantorSubstitutionAppApprovalRequestTxt, 0, false); //


        //Membership Closure
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMembershipClosureAppForApprovalCode, Database::"Membership closure", OnSendMembershipClosureAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMembershipClosureAppForApprovalCode, Database::"Membership closure", OnCancelMembershipClosureAppApprovalRequestTxt, 0, false); //

        //Loan Rescheduling
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLoanReschedulingForApprovalCode, Database::"Loan Rescheduling", OnSendLoanReschedulingApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLoanReschedulingForApprovalCode, Database::"Loan Rescheduling", OnCancelLoanReschedulingApprovalRequestTxt, 0, false); //

        //Withrawal Notice
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendWithdrawalNoticeAppForApprovalCode, Database::"Member withdrawal Notice", OnSendWithdrawalNoticeAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelWithdrawalNoticeAppForApprovalCode, Database::"Member withdrawal Notice", OnCancelWithdrawalNoticeAppApprovalRequestTxt, 0, false); //

        //Loan Recovery
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendRecoveryHeaderAppForApprovalCode, Database::"Loan Recovery Header", OnSendRecoveryHeaderApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelRecoveryHeaderAppForApprovalCode, Database::"Loan Recovery Header", OnCancelRecoveryHeaderAppApprovalRequestTxt, 0, false);

        //Loan Recovery
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendRecoveryHeaderIIAppForApprovalCode, Database::"Loan Recovery Header II", OnSendRecoveryHeaderIIApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelRecoveryHeaderIIAppForApprovalCode, Database::"Loan Recovery Header II", OnCancelRecoveryHeaderIIAppApprovalRequestTxt, 0, false);

        //Bond
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBondAppForApprovalCode, Database::Bond, OnSendBondApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBondAppForApprovalCode, Database::Bond, OnCancelBondAppApprovalRequestTxt, 0, false); //

        //Sink Funds
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSinkFundAppForApprovalCode, Database::"BBF Requisation Header", OnSendSinkFundApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSinkFundAppForApprovalCode, Database::"BBF Requisation Header", OnCancelSinkFundAppApprovalRequestTxt, 0, false); //

        //Delegate Region Change
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDelegatesRegionChangeForApprovalCode, Database::"Delegate Region Change", OnSendDelegatesRegionChangeApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDelegatesRegionChangeForApprovalCode, Database::"Delegate Region Change", OnCancelDelegatesRegionChangeApprovalRequestTxt, 0, false); //

        //Delegate AGM Update
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDelegateAGMUpdateForApprovalCode, Database::"Delegate AGM Update Header", "OnSendDelegateAGMUpdate ApprovalRequestTxt", 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDelegateAGMUpdateForApprovalCode, Database::"Delegate AGM Update Header", "OnCancelDelegateAGMUpdate ApprovalRequestTxt", 0, false); //

        //Fosa AccountClosure
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBankingAccountClosureForApprovalCode, Database::"Banking Account Closure", OnSendBankingAccountClosureApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBankingAccountClosureForApprovalCode, Database::"Banking Account Closure", OnCancelBankingAccountClosureApprovalRequestTxt, 0, false); //

        //AGM Delegates Payemnts
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOAGMDelegatePaymentForApprovalCode, Database::"AGM Delegates Payment", OnsendAGMDelegatePaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCanceAGMDelegatePayentForApprovalCode, Database::"AGM Delegates Payment", OnCancelAGMDelegatePaymentApprovalRequestTxt, 0, false); //


        //BDE Management
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendBDEManagementAppForApprovalCode, Database::"BDE Management Header", OnSendBDEManagementApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelBDEManagementAppForApprovalCode, Database::"BDE Management Header", OnCancelBDEManagementAppApprovalRequestTxt, 0, false); //
        //
        //Delegate Groups Applicationss
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDelegateGroupsApplicationssForApprovalCode, Database::"Delegate Region Applicationss", OnSendDelegateGroupsApplicationssApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDelegateGroupsApplicationssForApprovalCode, Database::"Delegate Region Applicationss", OnCancelDelegateGroupsApplicationssApprovalRequestTxt, 0, false); //
        //Delegate Group Mem Retirements
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDelegateGroupMemRetirementsForApprovalCode, Database::"Delegate Region Mem Retirement", OnSendDelegateGroupMemRetirementsApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDelegateGroupMemRetirementsForApprovalCode, Database::"Delegate Region Mem Retirement", OnCancelDelegateGroupMemRetirementsApprovalRequestTxt, 0, false); //
        //Delegates Payment
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDelegatesPaymentForApprovalCode, Database::"Delegates Payment", OnSendDelegatesPaymentApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDelegatesPaymentForApprovalCode, Database::"Delegates Payment", OnCancelDelegatesPaymentApprovalRequestTxt, 0, false); //
        //HR
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendEmployeeRequisitionAppForApprovalCode, Database::"HR Employee Requisitions", OnSendlEmployeeRequisitionAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelEmployeeRequisitionAppForApprovalCode, Database::"HR Employee Requisitions", OnCancelEmployeeRequisitionAppApprovalRequestTxt, 0, false); //
        //leave
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLeaveForApprovalCode, Database::"HR Leave Application", OnSendleaveAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelleaveAppForApprovalCode, Database::"HR Leave Application", OnCancelleaveAppApprovalRequestTxt, 0, false); //
                                                                                                                                     /// sharks corrections

        //Training Feedback
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTFeedForApprovalCode, Database::"HR Training Feedback Form", OnSendTFeedAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTFeedAppForApprovalCode, Database::"HR Training Feedback Form", OnCancelTFeedAppApprovalRequestTxt, 0, false); //

        //Interns
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendInternForApprovalCode, Database::"HR Interns", OnSendInternAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelInternAppForApprovalCode, Database::"HR Interns", OnCancelInternAppApprovalRequestTxt, 0, false); //

        //Appraisal Appeal
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAppraisalAppealForApprovalCode, Database::"HR Appraissal Appeal", OnSendAppraisalAppealAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAppraisalAppealAppForApprovalCode, Database::"HR Appraissal Appeal", OnCancelAppraisalAppealAppApprovalRequestTxt, 0, false); //


        //Disciplinary Appeal
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDisciplinaryAppealForApprovalCode, Database::"HRDisciplinary Appeal", OnSendDisciplinaryAppealAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDisciplinaryAppealAppForApprovalCode, Database::"HRDisciplinary Appeal", OnCancelDisciplinaryAppealAppApprovalRequestTxt, 0, false); //

        //Disciplinary Withdrawal
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDisciplinaryWithdrawalForApprovalCode, Database::"HRDisciplinary Case Withdrawal", OnSendDisciplinaryWithdrawalAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDisciplinaryWithdrawalAppForApprovalCode, Database::"HRDisciplinary Case Withdrawal", OnCancelDisciplinaryWithdrawalAppApprovalRequestTxt, 0, false); //

        //Disciplinary
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendDisciplinaryForApprovalCode, Database::"HR Disciplinary Cases NCA", OnSendDisciplinaryAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelDisciplinaryAppForApprovalCode, Database::"HR Disciplinary Cases NCA", OnCancelDisciplinaryAppApprovalRequestTxt, 0, false); //

        //staff loans
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendStaffLoansForApprovalCode, Database::"prSalary Advance", OnSendStaffLoanAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelStaffLoanAppForApprovalCode, Database::"prSalary Advance", OnCancelStaffLoanAppApprovalRequestTxt, 0, false); //

        //Training Need
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTNeedForApprovalCode, Database::"HR Training Needs", OnSendTNeedAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTNeedAppForApprovalCode, Database::"HR Training Needs", OnCancelTNeedAppApprovalRequestTxt, 0, false); //

        //training
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTrainingForApprovalCode, Database::"HR Training App Header", OnSendTrainingAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTrainingAppForApprovalCode, Database::"HR Training App Header", OnCancelTrainingAppApprovalRequestTxt, 0, false); //
        //Transport
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendTransportForApprovalCode, Database::"HR Transport Requisition Head", OnSendTransportAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelTransportAppForApprovalCode, Database::"HR Transport Requisition Head", OnCancelTransportAppApprovalRequestTxt, 0, false); //
        //EmpTransfer
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendEmpTransferAppForApprovalCode, Database::"HR Employee Transfer Header", OnSendEmpTransferAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelEmpTransferAppForApprovalCode, Database::"HR Employee Transfer Header", OnCancelEmpTransferAppApprovalRequestTxt, 0, false); //

        //Jobs
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendJobAppForApprovalCode, Database::"HR Jobs", OnSendJobAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelJobAppForApprovalCode, Database::"HR Jobs", OnCancelJobAppApprovalRequestTxt, 0, false); //
                                                                                                                    //Job Application

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendJobApplicationForApprovalCode, Database::"HR Job Applications", OnSendJobApplicationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelJobApplicationForApprovalCode, Database::"HR Job Applications", OnCancelJobApplicationApprovalRequestTxt, 0, false); //
        //Planner
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPlannerAppForApprovalCode, Database::"HR Leave Planner Header", OnSendPlannerAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPlannerAppForApprovalCode, Database::"HR Leave Planner Header", OnCancelPlannerAppApprovalRequestTxt, 0, false); //

        //HR Employees  DATABASE::"HR Employees":
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendEmployeeAppForApprovalCode, Database::"HR Employees", OnSendEmployeeAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelEmployeeAppForApprovalCode, Database::"HR Employees", OnCancelEmployeeAppApprovalRequestTxt, 0, false); //

        //HR Interns Requisition  DATABASE::"HR Interns Requisition":
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendInternReqAppForApprovalCode, Database::"HR Interns Requisition", OnSendInternReqAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelInternReqAppForApprovalCode, Database::"HR Interns Requisition", OnCancelInternReqAppApprovalRequestTxt, 0, false); //

        //HR End
        // MSACCO

        // MSACCO PIN Change DATABASE::"M-SACCO Change PIN No":

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMSACCOPINApprovalCode, Database::"M-SACCO Change PIN No", OnSendMSACCOPINApprovalRequest, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMSACCOPINRequestApprovalCode, Database::"M-SACCO Change PIN No", OnCancelMSACCOPINApprovalRequest, 0, false); //

        // MSACCO Applications DATABASE::"M-SACCO Applications":

        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMsaccoApplicationApprovalCode, Database::"M-SACCO Applications", OnSendMsaccoApplicationApprovalRequest, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMsaccoAPPLICATIONRequestApprovalCode, Database::"M-SACCO Applications", OnCancelMsaccoAPPLICATIONApprovalRequest, 0, false); //

        // Agency Agent Applications
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendAgentApplicationForApprovalCode, Database::"Agent Applications", OnSendAgentApplicationApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelAgentApplicationForApprovalCode, Database::"Agent Applications", OnCancelAgentApplicationApprovalRequestTxt, 0, false); //

        // legal
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendLegalForApprovalCode, Database::Legal, OnSendLegalApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelLegalForApprovalCode, Database::Legal, OnCancelLegalApprovalRequestTxt, 0, false); //

        // Surety Management
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendSuretyForApprovalCode, Database::"Surety Management", OnSendSuretyApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelSuretyForApprovalCode, Database::"Surety Management", OnCancelSuretyApprovalRequestTxt, 0, false); //

        // Contract
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendContractForApprovalCode, Database::Contracts, OnSendContractAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelContractAppForApprovalCode, Database::Contracts, OnCancelContractAppApprovalRequestTxt, 0, false); //
                                                                                                                              //HRcpmany
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendHrCompanyActivityForApprovalCode, Database::"HR Company Activities", OnSendHrCompanyActivityRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelHrCompanyActivityForApprovalCode, Database::"HR Company Activities", OnCancelHrCompnyActivityRequestTxt, 0, false); //


        // Permission Requisition
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendPermissionRequisitionForApprovalCode, Database::"Permission Requisition", OnSendPermissionRequisitionAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelPermissionRequisitionForApprovalCode, Database::"Permission Requisition", OnCancelPermissionRequisitionApprovalRequestTxt, 0, false); //
                                                                                                                                                                 //Employee Requisition
        WorkFlowEventHandling.AddEventToLibrary(
       RunWorkflowOnSendEmployeeRequisitionAppForApprovalCode, Database::"HR Employee Requisitions", OnSendlEmployeeRequisitionAppApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelEmployeeRequisitionAppForApprovalCode, Database::"HR Employee Requisitions", OnCancelEmployeeRequisitionAppApprovalRequestTxt, 0, false); //

        // Mortgage Doc Release
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnSendMortgageDocReleaseForApprovalCode, Database::"Mortgage Loans Doc Release", OnSendMortgageDocReleaseApprovalRequestTxt, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
        RunWorkflowOnCancelMortgageDocReleaseForApprovalCode, Database::"Mortgage Loans Doc Release", OnCancelMortgageDocReleaseApprovalRequestTxt, 0, false);
    end;

    local procedure RunWorkflowOnSendApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Codeunit", 'OnSendDocForApproval', '', false, false)]

    procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Group Member Exit & Update":
                WorkflowManagement.HandleEvent(OnSendGroupMemberUpdateEditandExitForApprovalCode, Variant);
            Database::"Bank Deposit Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBankDepositForApprovalCode, Variant);
            Database::"FA Reclass. Journal Line":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendFixedAssetReclassificationForApprovalCode, Variant);
            Database::"Revenue Collection":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRevenueCollectionForApprovalCode, Variant);
            Database::"MKey Forwarding":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMKeyForApprovalCode, Variant);
            Database::"General SMS Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendGeneralSMSForApprovalCode, Variant);
            Database::"Batching Process Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBatchingProcessTableForApprovalCode, Variant);
            Database::"Clearance Form":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendClearanceFormForApprovalCode, Variant);
            Database::"Welfare Advance":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendWellFareAdvanceForApprovalCode, Variant);
            Database::"Stock Keeping":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStockKeepingForApprovalCode, Variant);
            Database::"Vehicle Servicing Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendVehicleServicingForApprovalCode, Variant);
            Database::"Maintain Machne/Vehicles":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendVehicleRepairForApprovalCode, Variant);
            Database::Insurance:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAssetInsuarancesForApprovalCode, Variant);
            Database::"Insurance Claims":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInsuaranceClaimsForApprovalCode, Variant);
            Database::"Treasury Cheque Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTreasuryChequeApplicationForApprovalCode, Variant);
            Database::"BOSA Account Activation":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBOSAAccountActivationForApprovalCode, Variant);
            Database::"HR Overtime Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHROvertimeRequestForApprovalCode, Variant);
            Database::"Contract Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendContractRequestForApprovalCode, Variant);
            Database::"Account Activation":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAccountActivationForApprovalCode, Variant);
            Database::"Key Request Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendKeyRequestForApprovalCode, Variant);
            Database::"Dividends Provision Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDividendsProvisionForApprovalCode, Variant);
            Database::"HR Employee Exit Interviews":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrInterviewExitForApprovalCode, Variant);
            Database::"HR Training Planner":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrTrainingplannnerForApprovalCode, Variant);
            Database::"Nominee Form Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendNomineeRequestFormForApprovalCode, Variant);
            Database::"HR Appraisal Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrAppraisalForApprovalCode, Variant);
            Database::"Office Keys List":
                WorkflowManagement.HandleEvent(RunworkflowOnsendKeyCreationRequestforapprovalCode, Variant);
            Database::"HR Company Activities":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrCompanyActivityForApprovalCode, Variant);
            Database::"Securities Register":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSecurityRegisterForApprovalCode, variant);
            Database::"Appeals Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAppealForApprovalCode, Variant);
            Database::"HR Fuel Management Header":
                WorkflowManagement.HandleEvent(RunWorkFlowOnSendFuelRegistrationForApprovalCode, Variant);
            Database::"HR OSAccident":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAccidentCreationForApprovalCode, Variant);
            Database::"Conference & Meeting Rooms-T":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendConferenceBookingRequestForApprovalCode, Variant);
            Database::"SMS Alerts Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAlertsHeaderAppForApprovalCode, Variant);
            Database::"Conf & Meeting Rooms List":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendConferenceRoomCreationForApprovalCode, Variant);
            Database::"Parking List Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendParkingCreationRequestApprovalCode, Variant);
            Database::"HR Drivers":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDriverCreationForApprovalCode, Variant);
            Database::"Company Vehicles":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCompanyVehiclesForApprovalCode, Variant);
            Database::Vendor:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendVendorForApprovalCode, Variant);
            Database::"Board members":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBoardMemberPayForApprovalCode, Variant);
            Database::"Security Discharge":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSecurityDischargeRequestforApprovalCode, Variant);
            Database::"Investment Interest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInvestInterestHeaderForApprovalCode, Variant);
            Database::"Parking Space":
                WorkflowManagement.HandleEvent(RunWorkflowOnsendParkingApprovalRequestCode, Variant);
            Database::"Fosa Payments Header":
                WorkflowManagement.HandleEvent(RunworkflowOnsendFOSAPVRequestforapprovalCode, Variant);
            Database::"Security Perfection":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSecurityPefectionRequestforApprovalCode, Variant);
            Database::Customer:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCustomerRequestForApprovalCode, Variant);
            Database::"Dispatch ATM Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDispatchATMForApprovalCode, Variant);
            Database::"DMU Case Forwarding":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDMUCaseForwardingForApprovalCode, Variant);
            Database::"Motor Vehicle Request":
                WorkflowManagement.HandleEvent(RunworkflowOnsendMotorVehicleRequestforapprovalCode, Variant);
            Database::"Vehicle Movement":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMotorVehicleMovementRequestforAprovalCode, Variant);
            Database::"Delegates Minutes Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnDelegateMinutesForApprovalCode, Variant);
            Database::"Refund,Account Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRefundAccountTransferRequestforAprovalCode, Variant);
            Database::"Staff Welfare":
                WorkflowManagement.handleEvent(RunworkflowOnsendStaffWelfareforapprovalCode, Variant);
            Database::"Fixed Deposit Contract":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendFixedDeposit2ContractsForApprovalCode, Variant);
            Database::"System Reversal":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSystemReversalForApprovalCode, Variant);
            Database::"Product Variations":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendloanVariationForApprovalCode, Variant);
            Database::"Product Factory":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendProductForApprovalCode, Variant);
            Database::"User Creation Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendUserCreationForApprovalCode, Variant);
            Database::"user termination":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTerminationForApprovalCode, Variant);
            Database::"Business Loan Clossure":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBusinessLoanClossureForApprovalCode, Variant);
            Database::"One Month Installment":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendOneMonthInstallmentForApprovalCode, Variant);
            Database::"Dependancies Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDependancyApplicationsForApprovalCode, Variant);
            Database::"System Edits":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSystemEditsForApprovalCode, Variant);
            Database::"B/S Loan Account Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBSLoansAccAppForApprovalCode, Variant);
            Database::"Electoral Zones":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendElectoralZoneForApprovalCode, Variant);
            Database::"Moratorium Loan":
                WorkflowManagement.HandleEvent(Runworkflowonsendmoratoriumloanforapprovalcode, variant);
            Database::"Share Capital Transfer Buffer":
                WorkflowManagement.HandleEvent(RunworkflowOnsendsharecapitalTransferforapprovalCode, variant);
            Database::"Delegate Officials":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegateOfficialsForApprovalCode, Variant);
            Database::"Sky Virtual Member":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSkyVirtualMemberForApprovalCode, Variant);
            Database::"HR Leave Journal Line":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendHrLeaveAdjustmentsForApprovalCode, Variant);
            //Database::"Banking Account Closure":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendBankingAccountClosureForApprovalCode, Variant);
            // Database::"Delegate AGM Update Header":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegateAGMUpdateForApprovalCode, Variant);
            // Database::"Delegate Region Change":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegatesRegionChangeForApprovalCode, Variant);
            Database::"SinkFund Report Information":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSinkFundReportForApprovalCode, Variant);
            // Database::"AGM Delegates Payment":
            //     WorkflowManagement.HandleEvent(RunWorkflowOAGMDelegatePaymentForApprovalCode, Variant);
            Database::"Payments Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentForApprovalCode, Variant);
            Database::"Payments Header Board":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBoardPaymentForApprovalCode, Variant);           
            Database::"InterBank Transfers":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInterbankForApprovalCode, Variant);
            Database::"Staff Claims Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffClaimForApprovalCode, Variant);
            Database::"Staff Advance Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffAdvanceForApprovalCode, Variant);
            Database::"Staff Advance Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffAdvanceSurrenderForApprovalCode, Variant);
            Database::"Imprest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestForApprovalCode, Variant);
            Database::"Imprest Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestSurrenderForApprovalCode, Variant);
            Database::"Store Requistion Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStoreRequisitionForApprovalCode, Variant);
            Database::"Overtime Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendOvertimeForApprovalCode, Variant);
            Database::"G/L Budget Name":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBudgetForApprovalCode, Variant);
           
            Database::"Vote Transfer":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendVoteForApprovalCode, Variant);
            Database::"Asset Transfer":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAssetTransferForApprovalCode, Variant);

            //Cashier Transactions
            Database::"Cashier Transactions":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCashierTRANSForApprovalCode, Variant);
            //end Cashier Transactions
            //Property Lease
            Database::Lease:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaseForApprovalCode, Variant);
            //end Property Lease
            //Property
            Database::"Property Details":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPropForApprovalCode, Variant);
            //end Property
            // Database::"Document Exemptions Auth.":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendDocExForApprovalCode, Variant);

            //Salary Transactions
            Database::"Salary Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSalaryTRANSForApprovalCode, Variant);
            //Salary Transactions

            //bankers Cheque
            Database::"Bankers Cheque Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBankersCForApprovalCode, Variant);
            //bankers Cheque

            //bank Cheque
            Database::"Cheque Book Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBankCForApprovalCode, Variant);
            //bank Cheque

            //Overdraft
            Database::"Over Draft Authorisation":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendODForApprovalCode, Variant);
            //Overdraft

            //Account Transfers
            Database::"Account Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendACTForApprovalCode, Variant);
            //Account Transfers

            //Inter Teller
            Database::"Treasury Cashier Transactions":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTREASForApprovalCode, Variant);
            //Inter Teller

            //Investments
            Database::"Investment Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendINVForApprovalCode, Variant);
            //Investments

            //Cheque receipts
            Database::"Cheque Receipts":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCHQForApprovalCode, Variant);
            //Cheque receipts

            //Member Application
            Database::"Member Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberAppForApprovalCode, Variant);

            //Salary Agreement
            Database::"Salary Agreement":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSalaryAgreementForApprovalCode, Variant); //
            //Account Application
            Database::"Savings Account Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAccountAppForApprovalCode, Variant); //
            //Electronic Fund Transfer Application
            Database::"RTGS Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRTGSAppForApprovalCode, Variant); //
            //Standing Order Application
            Database::"Standing Order Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSTOAppForApprovalCode, Variant); //
            //Standing Order Control Application
            Database::"Standing Order Control":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSTOCTLAppForApprovalCode, Variant); //
            //Dividend Rate Application
            Database::"Dividend Simulation Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDividendRateAppForApprovalCode, Variant); //

            //Product Factory Application
            //Database::"Product Factory":
            //WorkflowManagement.HandleEvent(RunWorkflowOnSendPFAAppForApprovalCode, Variant); //
            //Loans
            Database::Loans:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanAppForApprovalCode, Variant); //
                                                                                                  //Collateral
                                                                                                  //Collateral collection

            Database::"Securities Collection Register":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCollateReturnForApprovalCode, Variant); //

            //Loan batch
            Database::"Loan Disbursement Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanBatchForApprovalCode, Variant); //

            //INTEREST BILLING
            Database::"Interest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInterestBillingForApprovalCode, Variant); //
                                                                                                          //Savings Interest Header
            Database::"Savings Interest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSavingsInterestHeaderForApprovalCode, Variant); //
                                                                                                                //End Year Transfer Header
            Database::"End Year Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEndYearTransferHeaderForApprovalCode, Variant); //

            //ATM Applications
            Database::"ATM Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendATMApplicationsForApprovalCode, Variant); //
                                                                                                          //ATM Linking Applications
            Database::"ATM Linking Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendATMLinkingApplicationsForApprovalCode, Variant); //
                                                                                                                 //Checkoff
            Database::"Checkoff Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendCheckoffAppForApprovalCode, Variant); //
                                                                                                      //Membership Closure
            Database::"Membership closure":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipClosureAppForApprovalCode, Variant); //
                                                                                                               //Loan Rescheduling
            Database::"Loan Rescheduling":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanReschedulingForApprovalCode, Variant);

            // Database::"Document Exemptions Auth.":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnSendDocExForApprovalCode, Variant);

            //Withdrawal Notice
            Database::"Member withdrawal Notice":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendWithdrawalNoticeAppForApprovalCode, Variant); //

            //Guarantor Substitution
            Database::"Guarantors Substitution":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorSubstitutionAppForApprovalCode, Variant); //

            //Loan Recovery
            Database::"Loan Recovery Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRecoveryHeaderAppForApprovalCode, Variant);

            //Loan Recovery II
            Database::"Loan Recovery Header II":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendRecoveryHeaderIIAppForApprovalCode, Variant);

            Database::Bond:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBondAppForApprovalCode, Variant); //

            //Sink Fund
            Database::"BBF Requisation Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSinkFundAppForApprovalCode, Variant); //


            //Delegate Region Change
            Database::"Delegate Region Change":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegatesRegionChangeForApprovalCode, Variant); //

            //Delegate AGM Update
            Database::"Delegate AGM Update Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegateAGMUpdateForApprovalCode, Variant); //

            //Fosa Account Closure
            Database::"Banking Account Closure":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBankingAccountClosureForApprovalCode, Variant); //

            //AGM Delegate Payment
            Database::"AGM Delegates Payment":
                WorkflowManagement.HandleEvent(RunWorkflowOAGMDelegatePaymentForApprovalCode, Variant); //


            //BDE Management
            Database::"BDE Management Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendBDEManagementAppForApprovalCode, Variant); //

            //Delegate Groups Applicationss
            Database::"Delegate Region Applicationss":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegateGroupsApplicationssForApprovalCode, Variant); //
                                                                                                                      //Delegate Group Mem Retirements
            Database::"Delegate Region Mem Retirement":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegateGroupMemRetirementsForApprovalCode, Variant); //
                                                                                                                      //Delegates Payment
            Database::"Delegates Payment":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDelegatesPaymentForApprovalCode, Variant); //

            //HR
            //EmployeeRequisition
            Database::"HR Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEmployeeRequisitionAppForApprovalCode, Variant); //

            //leave
            Database::"HR Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveForApprovalCode, Variant); //

            //Training Feedback
            Database::"HR Training Feedback Form":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTFeedForApprovalCode, Variant); //

            //Interns
            Database::"HR Interns":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInternForApprovalCode, Variant); //


            //Appraisal appeal
            Database::"HR Appraissal Appeal":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAppraisalAppealForApprovalCode, Variant); //

            //Disciplinary appeal
            Database::"HRDisciplinary Appeal":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDisciplinaryAppealForApprovalCode, Variant); //

            //Disciplinary withdrawal
            Database::"HRDisciplinary Case Withdrawal":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDisciplinaryWithdrawalForApprovalCode, Variant); //

            //Disciplinary
            Database::"HR Disciplinary Cases NCA":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDisciplinaryForApprovalCode, Variant); //

            //Staff Loan
            Database::"prSalary Advance":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffLoansForApprovalCode, Variant); //
                                                                                                     //Guarantor

            //training
            Database::"HR Training App Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTrainingForApprovalCode, Variant); //

            //Training Need
            Database::"HR Training Needs":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTNeedForApprovalCode, Variant); //


            //Transport
            Database::"HR Transport Requisition Head":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendTransportForApprovalCode, Variant); //

            //EmpTransfer
            Database::"HR Employee Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpTransferAppForApprovalCode, Variant); //


            //Jobs
            Database::"HR Jobs":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendJobAppForApprovalCode, Variant); //
            //Job APPLICATION
            Database::"HR Job Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendJobApplicationForApprovalCode, Variant);


            //legal
            Database::Legal:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendLegalForApprovalCode, Variant); //

            //Surety Management
            Database::"Surety Management":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendSuretyForApprovalCode, Variant); //

            //Contracts
            Database::Contracts:
                WorkflowManagement.HandleEvent(RunWorkflowOnSendContractForApprovalCode, Variant); //

            //Permission Requisition
            Database::"Permission Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPermissionRequisitionForApprovalCode, Variant); //


            //Planner
            Database::"HR Leave Planner Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendPlannerAppForApprovalCode, Variant); //

            //HR Employees  DATABASE::"HR Employees":
            Database::"HR Employees":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendEmployeeAppForApprovalCode, Variant); //

            //HR Interns Requisition  DATABASE::"HR Interns Requisition":
            Database::"HR Interns Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendInternReqAppForApprovalCode, Variant); //

            //HR End

            // MSACCO

            // M-SACCO Change PIN No  DATABASE::"M-SACCO Change PIN No":
            Database::"M-SACCO Change PIN No":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMSACCOPINApprovalCode, Variant); //

            // M-SACCO Applications DATABASE::"M-SACCO Applications":
            Database::"M-SACCO Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMsaccoApplicationApprovalCode, Variant); //

            // Agency DATABASE::"Agent Applications":
            Database::"Agent Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendAgentApplicationForApprovalCode, Variant);

            //Mortgage Release Doc
            Database::"Mortgage Loans Doc Release":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendMortgageDocReleaseForApprovalCode, Variant); //

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals Codeunit", 'OnCancelDocApprovalRequest', '', false, false)]

    procedure RunWorkflowOnCancelApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Group Member Exit & Update":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelGroupMemberUpdateEditandExitForApprovalCode, Variant);
            Database::"Bank Deposit Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankDepositForApprovalCode, Variant);
            Database::"FA Reclass. Journal Line":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelFixedAssetReclassificationForApprovalCode, Variant);
            Database::"Revenue Collection":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRevenueCollectionForApprovalCode, Variant);
            Database::"MKey Forwarding":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMKeyForApprovalCode, Variant);
            Database::"General SMS Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelGeneralSMSForApprovalCode, Variant);
            Database::"Batching Process Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBatchingProcessTableForApprovalCode, Variant);
            Database::"Clearance Form":
                WorkflowManagement.HandleEvent(RunWorkflowOnCanceClearanceFormForApprovalCode, Variant);
            Database::"Staff Welfare":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffWefareForApprovalCode, Variant);
            Database::"Welfare Advance":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelWellFareAdvanceForApprovalCode, Variant);
            Database::"Stock Keeping":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStockKeepingForApprovalCode, Variant);
            Database::"Vehicle Servicing Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelVehicleServicingForApprovalCode, Variant);
            Database::"Maintain Machne/Vehicles":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelVehicleRepairForApprovalCode, Variant);
            Database::Insurance:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAssetInsuaranceForApprovalCode, Variant);
            Database::"Insurance Claims":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInsuaranceClaimsForApprovalCode, Variant);
            Database::"Treasury Cheque Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTreasuryChequeApplicationForApprovalCode, Variant);
            Database::"BOSA Account Activation":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBOSAAccountActivationForApprovalCode, Variant);
            Database::"HR Overtime Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHROvertimeRequestForApprovalCode, Variant);
            Database::"Contract Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelContractRequestForApprovalCode, Variant);
            Database::"Account Activation":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAccountActivationForApprovalCode, Variant);
            Database::"Key Request Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelKeyrequestForApprovalCode, Variant);
            Database::"Dividends Provision Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDividendsProvisionForApprovalCode, Variant);
            Database::"HR Employee Exit Interviews":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrInterviewExitForApprovalCode, Variant);
            Database::"Nominee Form Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelNomineeRequestFormForApprovalCode, Variant);
            Database::"HR Training Planner":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrTrainingplannerForApprovalCode, variant);
            Database::"HR Appraisal Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrAppraisalForApprovalCode, Variant);
            Database::"HR Company Activities":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrCompanyActivityForApprovalCode, Variant);
            Database::"Office Keys List":
                WorkflowManagement.HandleEvent(RunworkflowOnsendKeyCreationRequestforapprovalCode, Variant);
            Database::"Appeals Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAppealAppForApprovalCode, Variant);
            Database::"HR Fuel Management Header":
                WorkflowManagement.HandleEvent(RunWorkFlowOnCancelFuelRegistrationForApprovalCode, Variant);
            Database::"HR OSAccident":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAccidentCreationForApprovalCode, Variant);
            Database::"SMS Alerts Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAlertsHeaderAppForApprovalCode, Variant);
            Database::"Securities Register":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSecurityRegisterForApprovalCode, Variant);
            Database::"Conference & Meeting Rooms-T":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelConferenceBookingRequestForApprovalCode, Variant);
            Database::"Conf & Meeting Rooms List":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelConferenceRoomCreationForApprovalCode, Variant);
            Database::"Parking List Table":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelParkingCreationRequestApprovalCode, Variant);
            Database::"HR Drivers":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDriverCreationForApprovalCode, Variant);
            Database::"Company Vehicles":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCompanyVehiclesForApprovalCode, Variant);
            Database::Vendor:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelVendorForApprovalCode, Variant);
            Database::"Delegates Minutes Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegateMinutesForApprovalCode, variant);

            Database::"Security Discharge":
                WorkflowManagement.HandleEvent(RunWworkflowOnCancelSecurityDischargeRequestForApprovalCode, variant);
            Database::"Board members":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBoardMemberPayForApprovalCode, Variant);
            Database::"Investment Interest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInvestInterestHeaderForApprovalCode, Variant);
            Database::"Parking Space":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelParkingApprovalRequestCode, Variant);
            Database::"Fosa Payments Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelFOSAPVrequestForApprovalCode, Variant);
            Database::"Security Perfection":
                WorkflowManagement.HandleEvent(RunWworkflowOnCancelSecurityPerfectionRequestForApprovalCode, Variant);
            Database::Customer:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCustomerRequestForApprovalCode, Variant);
            Database::"Dispatch ATM Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDispatchATMApprovalCode, Variant);
            Database::"DMU Case Forwarding":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDMUCaseForwardingForApprovalCode, Variant);
            Database::"Fixed Deposit Contract":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelFixedDeposit2ContractsForApprovalCode, Variant);
            Database::"System Reversal":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSystemReversalForApprovalCode, Variant);
            Database::"Product Factory":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelProductForApprovalCode, Variant);
            Database::"User Creation Requests":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelUserCreationForApprovalCode, Variant);
            Database::"User Termination":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTerminationForApprovalCode, Variant);
            Database::"Business Loan Clossure":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBusinessLoanClossureForApprovalCode, Variant);
            Database::"One Month Installment":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelOneMonthInstallmentForApprovalCode, Variant);
            Database::"Dependancies Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDependancyApplicationsForApprovalCode, Variant);
            Database::"System Edits":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSystemEditsForApprovalCode, Variant);
            Database::"Vehicle Movement":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMotorVehicleMovementRequestForApprovalCode, Variant);
            Database::"Motor Vehicle Request":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelmotorvehiclerequestForApprovalCode, Variant);
            Database::"B/S Loan Account Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBSLoansAccAppAppForApprovalCode, Variant);
            Database::"Electoral Zones":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelElectoralZoneAppForApprovalCode, Variant);
            database::"Share Capital Transfer Buffer":
                WorkflowManagement.HandleEvent(Runworkflowoncancelsharecapitaltransferforapprovalcode, variant);
            database::"Moratorium loan":
                WorkflowManagement.HandleEvent(RunWorkflowoncancelmoratoriumloanforapprovalcode, variant);
            Database::"Delegate Officials":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegateOfficialsAppForApprovalCode, Variant);
            //hr leave/kelvin
            Database::"HR Leave Journal Line":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelHrLeaveAdjustmentsAppForApprovalCode, Variant);
            Database::"Sky Virtual Member":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSkyVirtualMemberForApprovalCode, Variant);
            // Database::"Banking Account Closure":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankingAccountClosureForApprovalCode, Variant);
            Database::"SinkFund Report Information":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSinkFundReportForApprovalCode, Variant);
            // Database::"Delegate Region Change":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegatesRegionChangeForApprovalCode, Variant);
            // Database::"Delegate AGM Update Header":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegateAGMUpdateForApprovalCode, Variant);
            Database::"Payments Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentForApprovalCode, Variant);
            Database::"Payments Header Board":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBoardPaymentForApprovalCode, Variant);
           
            Database::"Guarantors Substitution":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorSubstitutionAppForApprovalCode, Variant);

            Database::"InterBank Transfers":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInterbankForApprovalCode, Variant);
            Database::"Staff Claims Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffClaimForApprovalCode, Variant);
            Database::"Staff Advance Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffAdvanceForApprovalCode, Variant);
            Database::"Staff Advance Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffAdvanceSurrenderForApprovalCode, Variant);
            Database::"Imprest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestForApprovalCode, Variant);
            Database::"Imprest Surrender Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestSurrenderForApprovalCode, Variant);
            Database::"Store Requistion Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStoreRequisitionForApprovalCode, Variant);
            Database::"Overtime Claim Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelOvertimeForApprovalCode, Variant);
            Database::"G/L Budget Name":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBudgetForApprovalCode, Variant);
            Database::"Vote Transfer":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelVoteForApprovalCode, Variant);
            Database::"Asset Transfer":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAssetTransferForApprovalCode, Variant);
            //Cashier Transaction
            Database::"Cashier Transactions":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCashierTRANSForApprovalCode, Variant);
            //Cashier Transaction
            //Property Lease
            Database::Lease:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaseForApprovalCode, Variant);
            //Property Lease
            //Property
            Database::"Property Details":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPropForApprovalCode, Variant);
            //Property
            //Salary Transaction
            Database::"Salary Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSalaryTRANSForApprovalCode, Variant);
            //Salary Transaction

            //Bankers Cheque
            Database::"Bankers Cheque Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankersCForApprovalCode, Variant);
            //Bankers Cheque

            //Bank Cheque
            Database::"Cheque Book Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankCForApprovalCode, Variant);
            //Bank Cheque
            // Database::"Document Exemptions Auth.":
            //     WorkflowManagement.HandleEvent(RunWorkflowOnCancelDocExForApprovalCode, Variant);

            //Overdraft
            Database::"Over Draft Authorisation":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelODForApprovalCode, Variant);
            //Overdraft

            //Account Transfer
            Database::"Account Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelACTForApprovalCode, Variant);
            //Account Transfer
            // job Application
            Database::"HR Job Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelJobApplicationForApprovalCode, Variant);

            //Inter Teller
            Database::"Treasury Cashier Transactions":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTREASForApprovalCode, Variant);
            //Inter Teller

            //Investments
            Database::"Investment Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelINVForApprovalCode, Variant);
            //Investments

            //Cheque receipts
            Database::"Cheque Receipts":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCHQForApprovalCode, Variant);
            //Cheque receipts

            //Member Application
            Database::"Member Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberAppForApprovalCode, Variant); //

            //Salary Agreement
            Database::"Salary Agreement":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSalaryAgreementForApprovalCode, Variant); //
                                                                                                            //Account Application
            Database::"Savings Account Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAccountAppForApprovalCode, Variant); //
                                                                                                       //Electronic Fund Transfer Application
            Database::"RTGS Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRTGSAppForApprovalCode, Variant); //
                                                                                                    //Standing Order Application
            Database::"Standing Order Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSTOAppForApprovalCode, Variant); //
                                                                                                   //Standing Order Control Application
            Database::"Standing Order Control":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSTOCTLAppForApprovalCode, Variant); //
                                                                                                      //Dividend Rate Application
            Database::"Dividend Simulation Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnSendDividendRateAppForApprovalCode, Variant);
            Database::Loans:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanAppForApprovalCode, Variant); //
                                                                                                    //Collateral


            //Loan batch
            Database::"Loan Disbursement Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanBatchForApprovalCode, Variant); //

            //Collateral collection
            Database::"Securities Collection Register":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCollatReturnForApprovalCode, Variant); //

            //INTEREST BILLING
            Database::"Interest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInterestBillingForApprovalCode, Variant); //
                                                                                                            //Savings Interest Header
            Database::"Savings Interest Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSavingsInterestHeaderForApprovalCode, Variant); //
                                                                                                                  //End Year Transfer Header
            Database::"End Year Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelEndYearTransferHeaderForApprovalCode, Variant); //

            //ATM Applications
            Database::"ATM Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelATMApplicationsForApprovalCode, Variant); //
                                                                                                            //ATM Linking Applications
            Database::"ATM Linking Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelATMLinkingApplicationsForApprovalCode, Variant); //
                                                                                                                   //Checkoff
            Database::"Checkoff Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelCheckoffAppForApprovalCode, Variant); //
                                                                                                        //Membership Closure
            Database::"Membership closure":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipClosureAppForApprovalCode, Variant); //
                                                                                                                 //Loan Rescheduling
            Database::"Loan Rescheduling":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanReschedulingForApprovalCode, Variant); //
                                                                                                             //Withdrawal Notice
            Database::"Member withdrawal Notice":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelWithdrawalNoticeAppForApprovalCode, Variant); //
                                                                                                                //Guarantor Substitution
                                                                                                                //Loan Recovery
            Database::"Loan Recovery Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRecoveryHeaderAppForApprovalCode, Variant);

            Database::"Loan Recovery Header II":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelRecoveryHeaderIIAppForApprovalCode, Variant);

            //Bond
            Database::Bond:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBondAppForApprovalCode, Variant); //

            //Sink Fund
            Database::"BBF Requisation Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSinkFundAppForApprovalCode, Variant); //

            //Delegate Region Change
            Database::"Delegate Region Change":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegatesRegionChangeForApprovalCode, Variant); //

            //Delegate AGM Update
            Database::"Delegate AGM Update Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegateAGMUpdateForApprovalCode, Variant); //

            //Fosa Account Closure
            Database::"Banking Account Closure":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankingAccountClosureForApprovalCode, Variant); //


            //BDE Management
            Database::"BDE Management Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelBDEManagementAppForApprovalCode, Variant); //

            //Delegate Groups Applicationss
            Database::"Delegate Region Applicationss":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegateGroupsApplicationssForApprovalCode, Variant); //
                                                                                                                        //Delegate Group Mem Retirements
            Database::"Delegate Region Mem Retirement":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegateGroupMemRetirementsForApprovalCode, Variant); //
                                                                                                                        //Delegates Payment
            Database::"Delegates Payment":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDelegatesPaymentForApprovalCode, Variant); //

            //HR
            //EmployeeRequisition
            Database::"HR Employee Requisitions":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmployeeRequisitionAppForApprovalCode, Variant); //

            //leave
            Database::"HR Leave Application":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelleaveAppForApprovalCode, Variant); //

            //Training Feedback
            Database::"HR Training Feedback Form":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTFeedAppForApprovalCode, Variant); //

            //Interns
            Database::"HR Interns":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInternAppForApprovalCode, Variant); //

            //Appraisal Appeal
            Database::"HR Appraissal Appeal":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAppraisalAppealAppForApprovalCode, Variant); //

            //Disciplinary appeal
            Database::"HRDisciplinary Appeal":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDisciplinaryAppealAppForApprovalCode, Variant); //

            //Disciplinary Withdrawal
            Database::"HRDisciplinary Case Withdrawal":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDisciplinaryWithdrawalAppForApprovalCode, Variant); //

            //Disciplinary
            Database::"HR Disciplinary Cases NCA":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelDisciplinaryAppForApprovalCode, Variant); //

            //StaffLoan
            Database::"prSalary Advance":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffLoanAppForApprovalCode, Variant); //

            //training
            Database::"HR Training App Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTrainingAppForApprovalCode, Variant); //

            //Training Need
            Database::"HR Training Needs":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTNeedAppForApprovalCode, Variant); //


            //Transport
            Database::"HR Transport Requisition Head":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransportAppForApprovalCode, Variant); //

            //EmpTransfer
            Database::"HR Employee Transfer Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmpTransferAppForApprovalCode, Variant); //


            //Jobs
            Database::"HR Jobs":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelJobAppForApprovalCode, Variant); //

            //Planner
            Database::"HR Leave Planner Header":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPlannerAppForApprovalCode, Variant); //

            //legal
            Database::Legal:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelLegalForApprovalCode, Variant); //

            //legal

            Database::"Surety Management":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelSuretyForApprovalCode, Variant); //

            //Contract
            Database::Contracts:
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelContractAppForApprovalCode, Variant); //
                                                                                                        //Permission Requisition
            Database::"Permission Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelPermissionRequisitionForApprovalCode, Variant); //


            //HR Employees  DATABASE::"HR Employees":
            Database::"HR Employees":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmployeeAppForApprovalCode, Variant); //

            //HR Interns Requisition  DATABASE::"HR Interns Requisition":
            Database::"HR Interns Requisition":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelInternReqAppForApprovalCode, Variant); //
                                                                                                         //HR End

            // MSACCO

            //M-SACCO Change PIN No DATABASE::"M-SACCO Change PIN No":
            Database::"M-SACCO Change PIN No":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMSACCOPINRequestApprovalCode, Variant); //

            //M-SACCO Applications DATABASE::"M-SACCO Applications":
            Database::"M-SACCO Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMsaccoAPPLICATIONRequestApprovalCode, Variant); //

            //M-SACCO Applications DATABASE::"M-SACCO Applications":
            Database::"Agent Applications":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelAgentApplicationForApprovalCode, Variant); //


            //Mortgage Release Doc
            Database::"Mortgage Loans Doc Release":
                WorkflowManagement.HandleEvent(RunWorkflowOnCancelMortgageDocReleaseForApprovalCode, Variant); //

            //FDC

            // Database::"Fixed Deposit Contract":
            // WorkflowManagement.HandleEvent(RunWorkflowOnCancelMortgageDocReleaseForApprovalCode, Variant);

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end;
    end;

    //for approvals mgnt


    //Handle responses kkaimor

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpendocument', '', false, false)]
    local procedure OnOpendocument(RecRef: RecordRef; var Handled: Boolean)

    var
        BankDeposits: Record "Bank Deposit Header";
        ConferenceCreation: Record "Conf & Meeting Rooms List";
        CompanyVehicles: Record "Company Vehicles";

        VehicleMovement: Record "Vehicle Movement";
        VehicleRequest: Record "Motor Vehicle Request";
        //ConferenceAndMeetingRooms: Record "Conference & Meeting Rooms-T";
        SecuritiesReg: Record "Securities Register";
        memberAppli: Record "Member Application";
        loansApp: Record loans;
        MClosure: Record "Membership closure";
        BankAccClossure: Record "Banking Account Closure";
        CashierTransactions: Record "Cashier Transactions";
        ShareTransfer: record "Share Capital Transfer Buffer";
        Loanrescheduling: Record "Loan Rescheduling";
        MoratoriumLoan: Record "Moratorium Loan";
        BSLoansAccApp: Record "B/S Loan Account Application";
        DependancyApplications: Record "Dependancies Applications";
        OneMonthInstallments: Record "One Month Installment";
        BusinessLoanClossure: Record "Business Loan Clossure";
        FDContract: Record "Fixed Deposit Contract";
        SystemReversal: Record "System Reversal";
        UserCreation: Record "User Creation Requests";
        UserTermination: Record "User Termination";
        ProductFactory: Record "Product Factory";
        FixedDepositContracts: Record "Fixed Deposit Contract";
        sinkfund: Record "SinkFund Report Information";
        DMUCaseForwarding: Record "DMU Case Forwarding";
        DispatchATM: Record "Dispatch ATM Header";
        RefundTransfer: Record "Refund,Account Transfer Header";
        Legal: Record Legal;
        VariationsRec: Record "Product Variations";

        Minutes: Record "Delegates Minutes Header";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        StaffWelfare: Record "Staff Welfare";
        Customer: Record Customer;
        SecurityPerfection: Record "Security Perfection";
        Application: record "Hr Job Applications";
        ParkingSpace: Record "Parking Space";
        InvHeader: Record "Investment Header";
        HrEmployee: Record "HR Employees";
        Jobs: Record "Hr Jobs";
        EmpRequisitions: record "HR Employee Requisitions";
        FOSAPV: RECORD "Fosa Payments Header";
        Disciplinary: record "HR Disciplinary Cases NCA";
        disciplinarywithdrawal: record "HRDisciplinary Case Withdrawal";
        DiscAppeal: Record "HRDisciplinary Appeal";
        BoardMemberpay: Record "Board members";


        DelegateOfficials: Record "Delegate Officials";

        Overtime: Record "Overtime Claim Header";
        InvestInterestHeader: Record "Investment Interest Header";


        ElectoralZones: Record "Electoral Zones";

        MemberWithdrawalNotice: Record "Member withdrawal Notice";
        SecurityDischarge: Record "Security Discharge";
        DelegatesPayment: Record "Delegates Payment";
        //HRLeaveJournalLine: Record HR Leave Journal Line;
        Leave: Record "HR Leave Application";
        ImprestRequisition: Record "Imprest Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        StaffClaim: Record "Staff Claims Header";
        Vendor: Record Vendor;
        TraiApp: Record "HR Training App Header";
        trainneeds: record "HR Training Needs";
        feedback: record "HR Training Feedback Form";
        HRDrivers: Record "HR Drivers";
        PropertyDetails: Record "Property Details";
        Lease: Record Lease;
        Surety: Record "Surety Management";
        ParkingCreation: Record "Parking List Table";
        CheckoffHeader: Record "Checkoff Header";
        ConferenceBooking: Record "Conference & Meeting Rooms-T";
        SMSAlerts: Record "SMS Alerts Header";
        Salary: record "Salary Header";
        Contracts: Record Contracts;
        TrCash: Record "Treasury Cashier Transactions";
        Accidents: Record "HR OSAccident";
        Fuel: Record "HR Fuel Management Header";
        SystemEdits: Record "System Edits";
        Appeals: Record "Appeals Table";
        KeyCreation: Record "Office Keys List";
        KeyRequest: Record "Key Request Table";
        BnkChq: Record "Bankers Cheque Application";
        STO: Record "Standing Order Header";
        RTGS: Record "RTGS Transfer Header";
        ACCTrans: Record "Account Transfer Header";
        ATMApp: Record "ATM Applications";
        ATMLink: Record "ATM Linking Applications";
        AccInterest: Record "Savings Interest Header";
        EndYearTrans: Record "End Year Transfer Header";
        PermissionReq: Record "Permission Requisition";
        SAccountAppl: Record "Savings Account Application";
        HrcompanyActivity: Record "HR Company Activities";
        HrAppraisal: Record "HR Appraisal Header";
        NomineeRequest: Record "Nominee Form Request";
        GuarantorsSubstitution: Record "Guarantors Substitution";
        LoanBatch: Record "Loan Disbursement Header";
        HrTPlanning: Record "HR Training Planner";
        HrExitInterview: Record "HR Employee Exit Interviews";
        InterBankTr: Record "InterBank Transfers";
        StoreReque: Record "Store Requistion Header";
        DivProvission: Record "Dividends Provision Header";
        AssetTrans: Record "Asset Transfer";
        AccountAct: Record "Account Activation";
        ContractReq: Record "Contract Request";
        HrOverTimeHD: record "HR Overtime Header";
        CollectREg: record "Securities Collection Register";
        TreasuryApp: Record "Treasury Cheque Application";
        ClaimsInsuarance: record "Insurance Claims";
        HrleaveJournalLine: record "HR Leave Journal Line";
        AssetInsuarance: Record Insurance;
        VehicleRepair: Record "Maintain Machne/Vehicles";
        VehicleServi: Record "Vehicle Servicing Table";
        StockKeeping: Record "Stock Keeping";
        WellFareAdvance: Record "Welfare Advance";
        StaffWellfare: Record "Staff Welfare";
        ClearanceForm: Record "Clearance Form";
        BOSAAccActive: Record "BOSA Account Activation";
        Batchingprocess: Record "Batching Process Table";
        GeneralSMSHeader: Record "General SMS Header";
        MKey: Record "MKey Forwarding";
        RevenueCollection: Record "Revenue Collection";
        FAReclassificationJournal: Record "FA Reclass. Journal Line";
        VoteTransfer: Record "Vote Transfer";
        GroupUpdate: Record "Group Member Exit & Update";

    begin
        case RecRef.number of
            Database::"Group Member Exit & Update":
                begin
                    RecRef.SetTable(GroupUpdate);
                    GroupUpdate.Validate(Status, GroupUpdate.Status::Open);
                    GroupUpdate.Modify(True);
                    Handled := True;
                end;
            Database::"Bank Deposit Header":
                begin
                    RecRef.SetTable(BankDeposits);
                    BankDeposits.Validate(Status, BankDeposits.Status::Open);
                    BankDeposits.modify(true);
                    Handled := true;
                end;
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(VoteTransfer);
                    VoteTransfer.Validate(Status, VoteTransfer.Status::Open);
                    VoteTransfer.modify(true);
                    Handled := true;
                end;
            Database::"FA Reclass. Journal Line":
                begin
                    RecRef.SetTable(FAReclassificationJournal);
                    FAReclassificationJournal.Validate(Status, FAReclassificationJournal.Status::Open);
                    FAReclassificationJournal.modify(true);
                    Handled := true;
                end;
            Database::"Revenue Collection":
                begin
                    RecRef.SetTable(RevenueCollection);
                    RevenueCollection.Validate(Status, RevenueCollection.Status::Open);
                    RevenueCollection.modify(true);
                    Handled := true;
                end;
            Database::"Mkey Forwarding":
                begin
                    RecRef.SetTable(MKey);
                    MKey.Validate(Status, MKey.Status::Open);
                    MKey.modify(true);
                    Handled := true;
                end;
            Database::"General SMS Header":
                begin
                    RecRef.SetTable(GeneralSMSHeader);
                    GeneralSMSHeader.Validate(Status, GeneralSMSHeader.Status::Open);
                    GeneralSMSHeader.modify(true);
                    Handled := true;
                end;
            Database::"Batching Process Table":
                begin
                    RecRef.SetTable(Batchingprocess);
                    Batchingprocess.Validate(Status, Batchingprocess.Status::Open);
                    Batchingprocess.modify(true);
                    Handled := true;
                end;
            Database::"Clearance Form":
                begin
                    RecRef.SetTable(ClearanceForm);
                    ClearanceForm.Validate(Status, ClearanceForm.Status::Open);
                    ClearanceForm.modify(true);
                    Handled := true;
                end;
            Database::"Staff Welfare":
                begin
                    RecRef.SetTable(StaffWellfare);
                    StaffWellfare.Validate(Status, StaffWellfare.Status::Open);
                    StaffWellfare.modify(true);
                    Handled := true;
                end;
            Database::"Welfare Advance":
                begin
                    RecRef.SetTable(WellFareAdvance);
                    WellFareAdvance.Validate(Status, WellFareAdvance.Status::Open);
                    WellFareAdvance.modify(true);
                    Handled := true;
                end;
            Database::"Stock Keeping":
                begin
                    RecRef.SetTable(StockKeeping);
                    StockKeeping.Validate(Status, StockKeeping.Status::Open);
                    StockKeeping.modify(true);
                    Handled := true;
                end;
            Database::"Vehicle Servicing Table":
                begin
                    RecRef.SetTable(VehicleServi);
                    VehicleServi.Validate(Status, VehicleServi.Status::Open);
                    VehicleServi.modify(true);
                    Handled := true;
                end;
            Database::"Maintain Machne/Vehicles":
                begin
                    RecRef.SetTable(VehicleRepair);
                    VehicleRepair.Validate(Status, VehicleRepair.Status::Open);
                    VehicleRepair.modify(true);
                    Handled := true;
                end;
            Database::Insurance:
                begin
                    RecRef.SetTable(AssetInsuarance);
                    AssetInsuarance.Validate(Status, AssetInsuarance.Status::Open);
                    AssetInsuarance.modify(true);
                    Handled := true;
                end;
            Database::"HR Leave Journal Line":
                begin
                    RecRef.SetTable(HrleaveJournalLine);
                    HrleaveJournalLine.Validate(Status, HrleaveJournalLine.Status::Open);
                    HrleaveJournalLine.modify(true);
                    Handled := true;
                end;
            Database::"Insurance Claims":
                begin
                    RecRef.SetTable(ClaimsInsuarance);
                    ClaimsInsuarance.Validate(Status, ClaimsInsuarance.Status::Open);
                    ClaimsInsuarance.modify(true);
                    Handled := true;
                end;
            Database::"Treasury Cheque Application":
                begin
                    RecRef.SetTable(TreasuryApp);
                    TreasuryApp.Validate(Status, TreasuryApp.Status::Open);
                    TreasuryApp.modify(true);
                    Handled := true;
                end;
            Database::"BOSA Account Activation":
                begin
                    RecRef.SetTable(BOSAAccActive);
                    BOSAAccActive.Validate(Status, BOSAAccActive.Status::Open);
                    BOSAAccActive.modify(true);
                    Handled := true;
                end;
            Database::"Securities Collection Register":
                begin
                    RecRef.SetTable(CollectREg);
                    CollectREg.Validate(Status, CollectREg.Status::Open);
                    CollectREg.modify(true);
                    Handled := true;
                end;
            Database::"HR Overtime Header":
                begin
                    RecRef.SetTable(HrOverTimeHD);
                    HrOverTimeHD.Validate(Status, HrOverTimeHD.Status::New);
                    HrOverTimeHD.modify(true);
                    Handled := true;
                end;
            Database::"Contract Request":
                begin
                    RecRef.SetTable(ContractReq);
                    ContractReq.Validate(Status, ContractReq.Status::Open);
                    ContractReq.modify(true);
                    Handled := true;
                end;
            Database::"Account Activation":
                begin
                    RecRef.SetTable(AccountAct);
                    AccountAct.Validate(Status, AccountAct.Status::Open);
                    AccountAct.modify(true);
                    Handled := true;
                end;
            Database::"End Year Transfer Header":
                begin
                    RecRef.SetTable(EndYearTrans);
                    EndYearTrans.Validate(Status, EndYearTrans.Status::Open);
                    EndYearTrans.modify(true);
                    Handled := true;
                end;
            Database::"Asset Transfer":
                begin
                    RecRef.SetTable(AssetTrans);
                    AssetTrans.Validate(Status, AssetTrans.Status::New);
                    AssetTrans.modify(true);
                    Handled := true;
                end;
            Database::"Dividends Provision Header":
                begin
                    RecRef.SetTable(DivProvission);
                    DivProvission.Validate(Status, DivProvission.Status::Open);
                    DivProvission.modify(true);
                    Handled := true;
                end;
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreReque);
                    StoreReque.Validate(Status, StoreReque.Status::Open);
                    StoreReque.modify(true);
                    Handled := true;
                end;
            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTr);
                    InterBankTr.Validate(Status, InterBankTr.Status::Pending);
                    InterBankTr.modify(true);
                    Handled := true;
                end;
            Database::"HR Employee Exit Interviews":
                begin
                    RecRef.SetTable(HrExitInterview);
                    HrExitInterview.Validate(Status, HrExitInterview.Status::Open);
                    HrExitInterview.modify(true);
                    Handled := true;
                end;
            Database::"HR Training Planner":
                begin
                    RecRef.SetTable(HrTPlanning);
                    HrTPlanning.Validate(Status, HrTPlanning.Status::Open);
                    HrTPlanning.modify(true);
                    Handled := true;
                end;
            Database::"Loan Disbursement Header":
                begin
                    RecRef.SetTable(LoanBatch);
                    LoanBatch.Validate(Status, LoanBatch.Status::Open);
                    LoanBatch.modify(true);
                    Handled := true;
                end;
            Database::"Guarantors Substitution":
                begin
                    RecRef.SetTable(GuarantorsSubstitution);
                    GuarantorsSubstitution.Validate(Status, GuarantorsSubstitution.Status::Open);
                    GuarantorsSubstitution.modify(true);
                    Handled := true;
                end;
            Database::"Nominee Form Request":
                begin
                    RecRef.SetTable(NomineeRequest);
                    NomineeRequest.Validate(Status, NomineeRequest.Status::Open);
                    NomineeRequest.modify(true);
                    Handled := true;
                end;
            Database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(HrAppraisal);
                    HrAppraisal.Validate(Status, HrAppraisal.Status::Open);
                    HrAppraisal.modify(true);
                    Handled := true;
                end;
            Database::"HR Company Activities":
                begin
                    RecRef.SetTable(HrcompanyActivity);
                    HrcompanyActivity.Validate(Status, HrcompanyActivity.Status::New);
                    HrcompanyActivity.modify(true);
                    Handled := true;
                end;
            Database::"Savings Account Application":
                begin
                    RecRef.SetTable(SAccountAppl);
                    SAccountAppl.Validate(Status, SAccountAppl.Status::Open);
                    SAccountAppl.modify(true);
                    Handled := true;
                end;
            Database::"Savings Interest Header":
                begin
                    RecRef.SetTable(AccInterest);
                    AccInterest.Validate(Status, AccInterest.Status::Open);
                    AccInterest.modify(true);
                    Handled := true;
                end;
            Database::"Securities Register":
                begin
                    RecRef.SetTable(SecuritiesReg);
                    SecuritiesReg.Validate(Status, SecuritiesReg.Status::Open);
                    SecuritiesReg.modify(true);
                    Handled := true;
                end;


            Database::"Permission Requisition":
                begin
                    RecRef.SetTable(PermissionReq);
                    PermissionReq.Validate(Status, PermissionReq.Status::Open);
                    PermissionReq.modify(true);
                    Handled := true;
                end;

            Database::"ATM Linking Applications":
                begin
                    RecRef.SetTable(ATMLink);
                    ATMLink.Validate(Status, ATMLink.Status::Open);
                    ATMLink.modify(true);
                    Handled := true;
                end;
            Database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMApp);
                    ATMApp.Validate(Status, ATMApp.Status::Open);
                    ATMApp.modify(true);
                    Handled := true;
                end;
            Database::"Account Transfer Header":
                begin
                    RecRef.SetTable(ACCTrans);
                    ACCTrans.Validate(Status, ACCTrans.Status::Open);
                    ACCTrans.modify(true);
                    Handled := true;
                end;
            Database::"RTGS Transfer Header":
                begin
                    RecRef.SetTable(RTGS);
                    RTGS.Validate(Status, RTGS.Status::Open);
                    RTGS.modify(true);
                    Handled := true;
                end;
            Database::"Standing Order Header":
                begin
                    RecRef.SetTable(STO);
                    STO.Validate(Status, STO.Status::Open);
                    STO.modify(true);
                    Handled := true;
                end;
            Database::"Key Request Table":
                begin
                    RecRef.SetTable(KeyRequest);
                    KeyRequest.Validate(Status, KeyRequest.Status::Open);
                    KeyRequest.modify(true);
                    Handled := true;
                end;
            Database::"Office Keys List":
                begin
                    RecRef.SetTable(KeyCreation);
                    KeyCreation.Validate(Status, KeyCreation.Status::Open);
                    KeyCreation.modify(true);
                    Handled := true;
                end;
            Database::"Appeals Table":
                begin
                    RecRef.SetTable(Appeals);
                    Appeals.Validate(Status, Appeals.Status::New);
                    Appeals.modify(true);
                    Handled := true;
                end;

            Database::"HR Fuel Management Header":
                begin
                    RecRef.SetTable(Fuel);
                    Fuel.Validate(Status, Accidents.Status::Open);
                    Fuel.modify(true);
                    Handled := true;
                end;
            Database::"HR OSAccident":
                begin
                    RecRef.SetTable(Accidents);
                    Accidents.Validate(Status, Accidents.Status::Open);
                    Accidents.modify(true);
                    Handled := true;
                end;

            Database::"System Edits":
                begin
                    RecRef.settable(SystemEdits);
                    SystemEdits.validate(status, SystemEdits.Status::Open);
                    SystemEdits.Modify(true);
                    Handled := true;
                end;
            Database::Contracts:
                begin
                    RecRef.settable(Contracts);
                    Contracts.validate(status, Contracts.Status::New);
                    Contracts.modify(true);
                    Handled := true;
                end;
            Database::"Security Perfection":
                begin
                    recref.settable(SecurityPerfection);
                    SecurityPerfection.validate(status, SecurityPerfection.Status::Open);
                    SecurityPerfection.modify(true);
                    Handled := true;
                end;
            database::"SMS Alerts Header":
                begin
                    recref.settable(SMSAlerts);
                    SMSAlerts.validate(status, SMSAlerts.Status::Open);
                    SMSAlerts.modify(true);
                    Handled := true;
                end;
            database::"Conference & Meeting Rooms-T":
                begin
                    recref.settable(ConferenceBooking);
                    ConferenceBooking.validate(status, ConferenceBooking.Status::Open);
                    ConferenceBooking.modify(true);
                    Handled := true;
                end;
            database::"Conf & Meeting Rooms List":
                begin
                    recref.settable(ConferenceCreation);
                    ConferenceCreation.validate(status, ConferenceCreation.Status::Open);
                    ConferenceCreation.modify(true);
                    Handled := true;
                end;
            database::"Checkoff Header":
                begin
                    recref.settable(CheckoffHeader);
                    CheckoffHeader.validate(status, CheckoffHeader.Status::Open);
                    CheckoffHeader.modify(true);
                    Handled := true;
                end;
            database::"Parking List Table":
                begin
                    recref.settable(ParkingCreation);
                    ParkingCreation.validate(status, ParkingCreation.Status::Open);
                    ParkingCreation.modify(true);
                    Handled := true;
                end;
            database::"Surety Management":
                begin
                    RecRef.settable(Surety);
                    Surety.validate(status, Surety.Status::Open);
                    Surety.modify(true);
                    Handled := true;
                end;
            database::Lease:
                begin
                    RecRef.settable(Lease);
                    Lease.validate(status, Lease.Status::Open);
                    Lease.modify(true);
                    Handled := true;
                end;
            database::"Property Details":
                begin
                    RecRef.settable(PropertyDetails);
                    PropertyDetails.validate(status, PropertyDetails.Status::Open);
                    PropertyDetails.modify(true);
                    Handled := true;
                end;
            database::"HR Drivers":
                begin
                    recref.settable(HRDrivers);
                    HRDrivers.validate(status, HRDrivers.Status::Open);
                    HRDrivers.modify(true);
                    Handled := true;
                end;
            database::"Company Vehicles":
                begin
                    recref.settable(CompanyVehicles);
                    CompanyVehicles.validate(status, CompanyVehicles.Status::Open);
                    CompanyVehicles.modify(true);
                    Handled := true;
                end;

            database::Vendor:
                begin
                    recref.settable(Vendor);
                    Vendor.validate(status, Vendor.Status::New);
                    Vendor.modify(true);
                    Handled := true;
                end;
            database::"Board members":
                begin
                    recref.settable(BoardMemberpay);
                    BoardMemberpay.validate(status, BoardMemberpay.Status::Open);
                    BoardMemberpay.modify(true);
                    Handled := true;
                end;
            database::"Delegates Payment":
                begin
                    recref.settable(DelegatesPayment);
                    DelegatesPayment.validate(status, DelegatesPayment.Status::Open);
                    DelegatesPayment.modify(true);
                    Handled := true;
                end;
            database::"Staff Claims Header":
                begin
                    recref.settable(StaffClaim);
                    StaffClaim.validate(status, StaffClaim.Status::Pending);
                    StaffClaim.modify(true);
                end;
            database::"Delegate Officials":
                begin
                    recref.settable(DelegateOfficials);
                    DelegateOfficials.validate(status, DelegateOfficials.Status::Open);
                    DelegateOfficials.modify(true);
                    Handled := true;
                end;
            database::"Security Discharge":
                begin
                    recref.settable(SecurityDischarge);
                    SecurityDischarge.validate(status, SecurityDischarge.Status::Open);
                    SecurityDischarge.modify(true);
                    Handled := true;
                end;
            database::"Product Variations":
                begin
                    recref.settable(VariationsRec);
                    VariationsRec.validate(status, VariationsRec.Status::Open);
                    VariationsRec.modify(true);
                    Handled := true;
                end;
            database::"Electoral Zones":
                begin
                    recref.settable(ElectoralZones);
                    ElectoralZones.validate(status, ElectoralZones.Status::Open);
                    ElectoralZones.modify(true);
                    Handled := true;
                end;
            database::"Investment Header":
                begin
                    recref.settable(InvHeader);
                    InvHeader.validate(status, InvHeader.Status::Open);
                    InvHeader.modify(true);
                    Handled := true;

                end;
            database::"Member withdrawal Notice":
                begin
                    recref.settable(MemberWithdrawalNotice);
                    MemberWithdrawalNotice.validate(status, MemberWithdrawalNotice.Status::Open);
                    MemberWithdrawalNotice.modify(true);
                    Handled := true;
                end;
            database::"Investment Interest Header":
                begin
                    recref.settable(InvestInterestHeader);
                    InvestInterestHeader.validate(status, InvestInterestHeader.Status::Open);
                    InvestInterestHeader.modify(true);
                    Handled := true;
                end;
            database::"Parking Space":
                begin
                    recref.settable(ParkingSpace);
                    ParkingSpace.validate(status, ParkingSpace.Status::Open);
                    ParkingSpace.modify(true);
                    Handled := true;
                end;
            database::"Fosa Payments Header":
                begin
                    recref.settable(FOSAPV);
                    FOSAPV.validate(status, FOSAPV.Status::Open);
                    FOSAPV.modify(true);
                    Handled := true;
                end;
            database::"Security Perfection":
                begin
                    recref.settable(SecurityPerfection);
                    SecurityPerfection.validate(status, SecurityPerfection.Status::Open);
                    SecurityPerfection.modify(true);
                    Handled := true;
                end;
            database::Customer:
                begin
                    recref.settable(Customer);
                    Customer.validate(status, Customer.Status::New);
                    Customer.modify(true);
                    Handled := true;
                end;
            database::"Loan Recovery Header":
                begin
                    recref.settable(LoanRecoveryHeader);
                    LoanRecoveryHeader.validate(status, LoanRecoveryHeader.Status::Open);
                    LoanRecoveryHeader.modify(true);
                    Handled := true;
                end;
            database::"Loan Recovery Header II":
                begin
                    recref.settable(LoanRecoveryHeaderII);
                    LoanRecoveryHeaderII.validate(status, LoanRecoveryHeaderII.Status::Open);
                    LoanRecoveryHeaderII.modify(true);
                    Handled := true;
                end;
            database::Legal:
                begin
                    recref.settable(Legal);
                    Legal.validate(status, Legal.Status::Open);
                    Legal.modify(true);
                    Handled := true;
                end;
            database::"HR Jobs":
                begin
                    recref.settable(Jobs);
                    Jobs.validate(status, Jobs.Status::Open);
                    Jobs.modify(true);
                    Handled := true;
                end;
            database::"Overtime Claim Header":
                begin
                    recref.settable(Overtime);
                    Overtime.validate(status, Overtime.Status::Open);
                    Overtime.modify(true);
                    Handled := true;
                end;
            database::"Hr Job Applications":
                begin
                    recref.settable(Application);
                    Application.validate(status, Application.Status::Application);
                    Application.modify(true);
                    Handled := true;
                end;


            database::"Delegates Minutes Header":
                begin
                    recref.settable(Minutes);
                    // Minutes.validate(status, Minutes.Status::Open);
                    Minutes.modify(true);
                    Handled := true;
                end;
            database::"Dispatch ATM Header":
                begin
                    recref.settable(DispatchATM);
                    DispatchATM.validate(status, DispatchATM.Status::Open);
                    DispatchATM.modify(true);

                    Handled := true;
                end;
            database::"Staff Welfare":
                begin
                    recref.settable(StaffWelfare);
                    StaffWelfare.validate(status, StaffWelfare.Status::Open);
                    StaffWelfare.modify(true);

                    Handled := true;
                end;

            database::"SinkFund Report Information":
                begin
                    recref.settable(sinkfund);
                    sinkfund.validate(status, sinkfund.Status::Open);
                    sinkfund.modify(true);
                    Handled := true;
                end;

            database::"System Reversal":
                begin
                    recref.settable(SystemReversal);
                    SystemReversal.validate(status, SystemReversal.Status::Open);
                    SystemReversal.modify(true);

                    Handled := true;
                end;
            database::"Product Factory":
                begin
                    recref.settable(ProductFactory);
                    ProductFactory.validate(status, ProductFactory.Status::Open);
                    ProductFactory.modify(true);
                    Handled := true;
                end;
            database::"User Creation Requests":
                begin
                    recref.settable(UserCreation);
                    UserCreation.validate(status, UserCreation.Status::Open);
                    UserCreation.modify(true);
                    Handled := true;
                end;
            database::"User Termination":
                begin
                    recref.settable(UserTermination);
                    UserTermination.validate(status, UserTermination.Status::Open);
                    UserTermination.modify(true);
                    Handled := true;
                end;

            // database::"Company Vehicles":
            //     begin
            //         recref.settable(CompanyVehicles);
            //         CompanyVehicles.validate(status, CompanyVehicles.Status::Open);
            //         CompanyVehicles.modify(true);

            //         Handled := true;
            //     end;
            database::"Vehicle Movement":
                begin
                    recref.settable(VehicleMovement);
                    VehicleMovement.validate(status, VehicleMovement.Status::Open);
                    VehicleMovement.modify(true);
                    Handled := true;
                end;

            database::"Motor Vehicle Request":
                begin
                    recref.settable(VehicleRequest);
                    VehicleRequest.validate(status, VehicleRequest.Status::Open);
                    VehicleRequest.modify(true);
                    Handled := true;
                end;


            database::"Business Loan Clossure":
                begin
                    recref.settable(BusinessLoanClossure);
                    BusinessLoanClossure.validate(status, BusinessLoanClossure.Status::Open);
                    BusinessLoanClossure.modify(true);
                    Handled := true;
                end;
            database::"One Month Installment":
                begin
                    recref.settable(OneMonthInstallments);
                    OneMonthInstallments.validate(status, OneMonthInstallments.Status::Open);
                    OneMonthInstallments.modify(true);
                    Handled := true;
                end;
            database::"Dependancies Applications":
                begin
                    recref.settable(DependancyApplications);
                    DependancyApplications.validate(status, DependancyApplications.Status::Open);
                    DependancyApplications.modify(true);
                    Handled := true;
                end;
            database::"B/S Loan Account Application":
                begin
                    recref.settable(BSLoansAccApp);
                    BSLoansAccApp.validate(status, BSLoansAccApp.Status::Open);
                    BSLoansAccApp.modify(true);
                    Handled := true;

                end;
            Database::"Company Vehicles":
                begin
                    recref.settable(CompanyVehicles);
                    CompanyVehicles.validate(status, CompanyVehicles.Status::Open);
                    CompanyVehicles.modify(true);
                    Handled := true
                end;
            database::Loans:
                begin
                    recref.settable(loansApp);
                    loansApp.validate(status, loansApp.Status::Open);
                    loansApp.modify(true);
                    Handled := true;

                end;
            Database::"Moratorium Loan":
                begin
                    recref.settable(MoratoriumLoan);
                    MoratoriumLoan.validate(status, MoratoriumLoan.Status::Open);
                    MoratoriumLoan."Created By" := UserId;
                    MoratoriumLoan.modify(true);
                    Handled := true;

                end;
            Database::"Loan Rescheduling":
                begin
                    recref.settable(Loanrescheduling);
                    Loanrescheduling.validate(status, Loanrescheduling.Status::Open);
                    Loanrescheduling.modify(true);
                    Handled := true;
                end;
        end;
        case RecRef.number of
            database::"Share Capital Transfer Buffer":
                begin
                    recref.settable(sharetransfer);
                    sharetransfer.validate(status, sharetransfer.Status::Open);
                    sharetransfer.modify(true);
                    Handled := true;

                end;
            database::"Membership closure":
                begin
                    recref.settable(MClosure);
                    MClosure.Validate(Status, MClosure.status::Open);
                    MClosure.modify(true);
                    Handled := true;
                end;
            database::"Banking Account Closure":
                begin
                    recref.settable(BankAccClossure);
                    BankAccClossure.Validate(Status, BankAccClossure.status::Open);
                    BankAccClossure.modify(true);
                    Handled := true;
                end;
            database::"Cashier Transactions":
                begin
                    recref.settable(CashierTransactions);
                    CashierTransactions.Validate(Status, CashierTransactions.status::Open);
                    CashierTransactions.modify(true);
                    Handled := true;
                end;
            database::"Treasury Cashier Transactions":
                begin
                    recref.settable(TrCash);
                    TrCash.Validate(Status, TrCash.status::Open);
                    TrCash.modify(true);
                    Handled := true;
                end;
            database::"Refund,Account Transfer Header":
                begin
                    recref.settable(RefundTransfer);
                    RefundTransfer.validate(status, RefundTransfer.Status::Open);
                    RefundTransfer.modify(true);

                    Handled := true;
                end;
            database::"Fixed Deposit Contract":
                begin
                    recref.settable(FixedDepositContracts);
                    FixedDepositContracts.Validate(Status, FixedDepositContracts.status::Open);
                    FixedDepositContracts.modify(true);
                    Handled := true;
                end;
            database::"HR Employees":
                begin
                    recref.settable(HrEmployee);
                    HrEmployee.Validate(Status, HrEmployee.status::New);
                    HrEmployee.modify(true);
                    Handled := true;
                end;
            database::"HR Employee Requisitions":
                begin
                    recref.settable(EmpRequisitions);
                    EmpRequisitions.Validate("Approval Status", EmpRequisitions."Approval Status"::Open);
                    EmpRequisitions.modify(true);
                    Handled := true;
                end;
            database::"HR Leave Application":
                begin
                    recref.settable(Leave);
                    Leave.Validate(status, Leave.Status::New);
                    Leave.modify(true);
                    Handled := true;
                end;

            // database::"HR Leave Journal Line":
            // begin
            //     recref.settable(HRLeaveJournalLine);
            //     HRLeaveJournalLine.Validate(Status, HRLeaveJournalLine.Status::Open);
            //     HRLeaveJournalLine.modify(true);
            //     Handled := true;
            // end;
            database::"Imprest Header":
                begin
                    recref.settable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.status::Pending);
                    ImprestRequisition.modify(true);
                    Handled := true;
                end;
            database::"Imprest Surrender Header":
                begin
                    recref.settable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::Pending);
                    ImprestSurrender.modify(true);
                    Handled := true;
                end;
            database::"HR Disciplinary Cases NCA":
                begin
                    recref.settable(Disciplinary);
                    Disciplinary.Validate(Status, Disciplinary.Status::"Pending Approval");
                    Disciplinary.modify(true);
                    Handled := true;
                end;
            database::"HRDisciplinary Case Withdrawal":
                begin
                    recref.settable(disciplinarywithdrawal);
                    disciplinarywithdrawal.Validate(Status, disciplinarywithdrawal.Status::"Pending Approval");
                    disciplinarywithdrawal.modify(true);
                    Handled := true;
                end;
            database::"HRDisciplinary Appeal":
                begin
                    recref.settable(DiscAppeal);
                    DiscAppeal.Validate(Status, DiscAppeal.Status::"Pending Approval");
                    DiscAppeal.modify(true);
                    Handled := true;
                end;
            database::"HR Training App Header":
                begin
                    recref.settable(TraiApp);
                    TraiApp.Validate(Status, TraiApp.Status::"Pending Approval");
                    TraiApp.modify(true);
                    Handled := true;
                end;
            database::"HR Training Needs":
                begin
                    recref.settable(trainneeds);
                    trainneeds.Validate(Status, trainneeds.Status::"Pending Approval");
                    trainneeds.modify(true);
                    Handled := true;
                end;
            database::"HR Training Feedback Form":
                begin
                    recref.settable(feedback);
                    feedback.Validate(Status, feedback.Status::"Pending Approval");
                    feedback.modify(true);
                    Handled := true;
                end;
            database::"Salary Header":
                begin
                    recref.settable(Salary);
                    Salary.Validate(Status, Salary.Status::Open);
                    Salary.modify(true);
                    Handled := true;
                end;
            database::"Bankers Cheque Application":
                begin
                    recref.settable(BnkChq);
                    BnkChq.Validate(Status, BnkChq.Status::Open);
                    BnkChq.modify(true);
                    Handled := true;
                end;
            Database::"Member Application":
                begin
                    RecRef.settable(memberAppli);
                    memberAppli.Validate(Status, memberAppli.Status::Open);
                    memberAppli.modify(true);
                    Handled := true;

                end;


        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'onSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        memberApp: Record "Member Application";
        Loanapp: Record Loans;
        MClosure: Record "Membership closure";
        apprv: Record "Approval Entry";
        BankAccClossure: Record "Banking Account Closure";
        CashierTransactions: Record "Cashier Transactions";
        Sharetransfer: Record "Share Capital Transfer Buffer";
        Loanrescheduling: Record "Loan Rescheduling";
        MoratoriumLoan: Record "Moratorium Loan";
        BSLoansAccApp: Record "B/S Loan Account Application";
        SystemEdits: Record "System Edits";
        DependancyApplications: Record "Dependancies Applications";
        ACTransfer: Record "Account Transfer Header";
        PettyCash: Record "Payments Header";
        OneMonthInstallments: Record "One Month Installment";
        BusinessLoanClossure: Record "Business Loan Clossure";
        FDContract: Record "Fixed Deposit Contract";
        SecuritiesReg: Record "Securities Register";
        SystemReversal: Record "System Reversal";
        Sinkfund: Record "SinkFund Report Information";
        CompanyVehicles: Record "Company Vehicles";
        VehicleMovement: Record "Vehicle Movement";
        VehicleRequest: Record "Motor Vehicle Request";
        ConferenceAndMeetingRooms: Record "Conference & Meeting Rooms-T";
        DMUCaseForwarding: Record "DMU Case Forwarding";
        UserCreation: Record "User Creation Requests";
        UserTermination: Record "User Termination";
        ProductFactory: Record "Product Factory";
        DispatchATM: Record "Dispatch ATM Header";
        RefundTransfer: Record "Refund,Account Transfer Header";
        Legal: record Legal;

        InterestHeader: Record "Interest Header";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        Customer: Record Customer;
        SecurityPerfection: Record "Security Perfection";
        Application: Record "HR Job Applications";
        Overtime: Record "Overtime Claim Header";
        ParkingSpace: Record "Parking Space";
        InvestInterestHeader: Record "Investment Interest Header";
        InvHeader: Record "Investment Header";
        Jobs: record "Hr Jobs";
        FOSAPV: record "Fosa Payments Header";
        VariationsRec: Record "Product Variations";

        MemberWithdrawalNotice: Record "Member withdrawal Notice";

        SecurityDischarge: Record "Security Discharge";

        ElectoralZones: Record "Electoral Zones";
        DelegateOfficials: Record "Delegate Officials";
        HrEmployee: Record "HR Employees";
        EmpRequisitions: record "HR Employee Requisitions";

        Minutes: Record "Delegates Minutes Header";
        DelegatesPayment: Record "Delegates Payment";
        HRLeaveJournalLine: Record "HR Leave Journal Line";
        Leave: Record "HR Leave Application";
        ImprestRequisition: Record "Imprest Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        StaffClaim: Record "Staff Claims Header";
        Vendor: Record Vendor;
        Disciplinary: Record "HR Disciplinary Cases NCA";
        disciplinarywithdrawal: record "HRDisciplinary Case Withdrawal";
        DiscAppeal: Record "HRDisciplinary Appeal";

        TraiApp: Record "HR Training App Header";
        trainneeds: record "HR Training Needs";
        feedback: record "HR Training Feedback Form";
        BoardMemberPay: Record "Board members";

        HRDrivers: Record "HR Drivers";
        PropertyDetails: Record "Property Details";
        Lease: Record Lease;
        Surety: Record "Surety Management";
        ParkingCreation: Record "Parking List Table";
        CheckoffHeader: Record "Checkoff Header";
        ConferenceCreation: Record "Conf & Meeting Rooms List";
        ConferenceBooking: Record "Conference & Meeting Rooms-T";
        SMSAlerts: Record "SMS Alerts Header";
        Salary: record "Salary Header";
        Contracts: Record Contracts;
        TrCash: Record "Treasury Cashier Transactions";
        Accidents: Record "HR OSAccident";
        Fuel: Record "HR Fuel Management Header";
        Appeals: Record "Appeals Table";
        KeyCreation: Record "Office Keys List";
        KeyRequest: Record "Key Request Table";
        BnkChq: Record "Bankers Cheque Application";
        STO: Record "Standing Order Header";
        RTGS: Record "RTGS Transfer Header";
        ATMApp: Record "ATM Applications";
        ATMLink: Record "ATM Linking Applications";
        AccInterest: Record "Savings Interest Header";
        EndYearTrans: Record "End Year Transfer Header";
        PermissionReq: Record "Permission Requisition";
        SAccountAppl: Record "Savings Account Application";
        HrcompanyActivity: Record "HR Company Activities";
        HrAppraisal: Record "HR Appraisal Header";
        NomineeRequest: Record "Nominee Form Request";
        GuarantorsSubstitution: Record "Guarantors Substitution";
        LoanBatch: Record "Loan Disbursement Header";
        HrTPlanning: Record "HR Training Planner";
        HrExitInterview: Record "HR Employee Exit Interviews";
        InterBankTr: Record "InterBank Transfers";
        StoreReque: Record "Store Requistion Header";
        DivProvission: Record "Dividends Provision Header";
        AssetTra: Record "Asset Transfer";
        AccountAct: Record "Account Activation";
        ContractReq: Record "Contract Request";
        HrOverTimeHR: record "HR Overtime Header";
        CollectReg: Record "Securities Collection Register";
        TreasureApp: Record "Treasury Cheque Application";
        InsuaranceClaims: record "Insurance Claims";
        AssetInsuarance: Record Insurance;
        MovementRepair: Record "Maintain Machne/Vehicles";
        VehicleServi: Record "Vehicle Servicing Table";
        StockKeeping: Record "Stock Keeping";
        WellFareAdvace: record "Welfare Advance";
        StaffWellfare: Record "Staff Welfare";
        ClearanceForm: Record "Clearance Form";
        BOSAAccActive: Record "BOSA Account Activation";
        BatchingProcess: Record "Batching Process Table";
        GeneralSMSHeader: Record "General SMS Header";
        MKey: Record "MKey Forwarding";
        RevenueCollection: Record "Revenue Collection";
        FAReclassificationJournal: Record "FA Reclass. Journal Line";
        VoteTransfer: Record "Vote Transfer";
        BankDeposit: Record "Bank Deposit Header";
        GroupUpdate: Record "Group Member Exit & Update";
    begin

        case RecRef.number of
            Database::"Group Member Exit & Update":
                begin
                    RecRef.SetTable(GroupUpdate);
                    GroupUpdate.Validate(Status, GroupUpdate.Status::Pending);
                    GroupUpdate.Modify(True);
                    Variant := GroupUpdate;
                    IsHandled := True;
                end;
            Database::"Bank Deposit Header":
                begin
                    RecRef.SetTable(BankDeposit);
                    BankDeposit.Validate(Status, BankDeposit.Status::Pending);
                    BankDeposit.Modify(true);
                    Variant := BankDeposit;
                    IsHandled := true;
                end;
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(VoteTransfer);
                    VoteTransfer.Validate(Status, VoteTransfer.Status::"Pending Approval");
                    VoteTransfer.Modify(true);
                    Variant := VoteTransfer;
                    IsHandled := true;
                end;
            Database::"FA Reclass. Journal Line":
                begin
                    RecRef.SetTable(FAReclassificationJournal);
                    FAReclassificationJournal.Validate(Status, FAReclassificationJournal.Status::Pending);
                    FAReclassificationJournal.Modify(true);
                    Variant := FAReclassificationJournal;
                    IsHandled := true;
                end;
            Database::"Revenue Collection":
                begin
                    RecRef.SetTable(RevenueCollection);
                    RevenueCollection.Validate(Status, RevenueCollection.Status::Pending);
                    RevenueCollection.Modify(true);
                    Variant := RevenueCollection;
                    IsHandled := true;
                end;
            Database::"MKey Forwarding":
                begin
                    RecRef.SetTable(MKey);
                    MKey.Validate(Status, MKey.Status::Pending);
                    MKey.Modify(true);
                    Variant := MKey;
                    IsHandled := true;
                end;
            Database::"General SMS Header":
                begin
                    RecRef.SetTable(GeneralSMSHeader);
                    GeneralSMSHeader.Validate(Status, GeneralSMSHeader.Status::Pending);
                    GeneralSMSHeader.Modify(true);
                    Variant := GeneralSMSHeader;
                    IsHandled := true;
                end;
            Database::"Batching Process Table":
                begin
                    RecRef.SetTable(BatchingProcess);
                    BatchingProcess.Validate(Status, BatchingProcess.Status::Pending);
                    BatchingProcess.Modify(true);
                    Variant := BatchingProcess;
                    IsHandled := true;
                end;
            Database::"Clearance Form":
                begin
                    RecRef.SetTable(ClearanceForm);
                    ClearanceForm.Validate(Status, ClearanceForm.Status::Pending);
                    ClearanceForm.Modify(true);
                    Variant := ClearanceForm;
                    IsHandled := true;
                end;
            Database::"Staff Welfare":
                begin
                    RecRef.SetTable(StaffWellfare);
                    StaffWellfare.Validate(Status, StaffWellfare.Status::"Pending Approval");
                    StaffWellfare.Modify(true);
                    Variant := StaffWellfare;
                    IsHandled := true;
                end;
            Database::"Welfare Advance":
                begin
                    RecRef.SetTable(WellFareAdvace);
                    WellFareAdvace.Validate(Status, WellFareAdvace.Status::Pending);
                    WellFareAdvace.Modify(true);
                    Variant := WellFareAdvace;
                    IsHandled := true;
                end;
            Database::"Stock Keeping":
                begin
                    RecRef.SetTable(StockKeeping);
                    StockKeeping.Validate(Status, StockKeeping.Status::Pending);
                    StockKeeping.Modify(true);
                    Variant := StockKeeping;
                    IsHandled := true;
                end;
            Database::"Vehicle Servicing Table":
                begin
                    RecRef.SetTable(VehicleServi);
                    VehicleServi.Validate(Status, VehicleServi.Status::Pending);
                    VehicleServi.Modify(true);
                    Variant := VehicleServi;
                    IsHandled := true;
                end;
            Database::"Maintain Machne/Vehicles":
                begin
                    RecRef.SetTable(MovementRepair);
                    MovementRepair.Validate(Status, MovementRepair.Status::Pending);
                    MovementRepair.Modify(true);
                    Variant := MovementRepair;
                    IsHandled := true;
                end;
            Database::Insurance:
                begin
                    RecRef.SetTable(AssetInsuarance);
                    AssetInsuarance.Validate(Status, AssetInsuarance.Status::Pending);
                    AssetInsuarance.Modify(true);
                    Variant := AssetInsuarance;
                    IsHandled := true;
                end;
            Database::"HR Leave Journal Line":
                begin
                    RecRef.SetTable(HRLeaveJournalLine);
                    HRLeaveJournalLine.Validate(Status, HRLeaveJournalLine.Status::"Pending Approval");
                    HRLeaveJournalLine.Modify(true);
                    Variant := HRLeaveJournalLine;
                    IsHandled := true;
                end;
            Database::"Insurance Claims":
                begin
                    RecRef.SetTable(InsuaranceClaims);
                    InsuaranceClaims.Validate(Status, InsuaranceClaims.Status::Pending);
                    InsuaranceClaims.Modify(true);
                    Variant := InsuaranceClaims;
                    IsHandled := true;
                end;
            Database::"Treasury Cheque Application":
                begin
                    RecRef.SetTable(TreasureApp);
                    TreasureApp.Validate(Status, TreasureApp.Status::"Pending Approval");
                    TreasureApp.Modify(true);
                    Variant := TreasureApp;
                    IsHandled := true;
                end;
            Database::"BOSA Account Activation":
                begin
                    RecRef.SetTable(BOSAAccActive);
                    BOSAAccActive.Validate(Status, BOSAAccActive.Status::Pending);
                    BOSAAccActive.Modify(true);
                    Variant := BOSAAccActive;
                    IsHandled := true;
                end;
            Database::"Securities Collection Register":
                begin
                    RecRef.SetTable(CollectReg);
                    CollectReg.Validate(Status, CollectReg.Status::Pending);
                    CollectReg.Modify(true);
                    Variant := CollectReg;
                    IsHandled := true;
                end;
            Database::"HR Overtime Header":
                begin
                    RecRef.SetTable(HrOverTimeHR);
                    HrOverTimeHR.Validate(Status, HrOverTimeHR.Status::"Pending Approval");
                    HrOverTimeHR.Modify(true);
                    Variant := HrOverTimeHR;
                    IsHandled := true;
                end;
            Database::"Contract Request":
                begin
                    RecRef.SetTable(ContractReq);
                    ContractReq.Validate(Status, ContractReq.Status::Pending);
                    ContractReq.Modify(true);
                    Variant := ContractReq;
                    IsHandled := true;
                end;
            Database::"Account activation":
                begin
                    RecRef.SetTable(AccountAct);
                    AccountAct.Validate(Status, AccountAct.Status::Pending);
                    AccountAct.Modify(true);
                    Variant := AccountAct;
                    IsHandled := true;
                end;
            Database::"End Year Transfer Header":
                begin
                    RecRef.SetTable(EndYearTrans);
                    EndYearTrans.Validate(Status, EndYearTrans.Status::"Pending Approval");
                    EndYearTrans.Modify(true);
                    Variant := EndYearTrans;
                    IsHandled := true;
                end;
            Database::"Asset Transfer":
                begin
                    RecRef.SetTable(AssetTra);
                    AssetTra.Validate(Status, AssetTra.Status::"Pending Approval");
                    AssetTra.Modify(true);
                    Variant := AssetTra;
                    IsHandled := true;
                end;
            Database::"Dividends Provision Header":
                begin
                    RecRef.SetTable(DivProvission);
                    DivProvission.Validate(Status, DivProvission.Status::"Pending Approval");
                    DivProvission.Modify(true);
                    Variant := DivProvission;
                    IsHandled := true;
                end;
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreReque);
                    StoreReque.Validate(Status, StoreReque.Status::"Pending Approval");
                    StoreReque.Modify(true);
                    Variant := StoreReque;
                    IsHandled := true;
                end;
            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTr);
                    InterBankTr.Validate(Status, InterBankTr.Status::"Pending Approval");
                    InterBankTr.Modify(true);
                    Variant := InterBankTr;
                    IsHandled := true;
                end;
            Database::"HR Employee Exit Interviews":
                begin
                    RecRef.SetTable(HrExitInterview);
                    HrExitInterview.Validate(Status, HrExitInterview.Status::"Pending Approval");
                    HrExitInterview.Modify(true);
                    Variant := HrExitInterview;
                    IsHandled := true;
                end;
            Database::"HR Training Planner":
                begin
                    RecRef.SetTable(HrTPlanning);
                    HrTPlanning.Validate(Status, HrTPlanning.Status::"Pending Approval");
                    HrTPlanning.Modify(true);
                    Variant := HrTPlanning;
                    IsHandled := true;
                end;
            Database::"Loan Disbursement Header":
                begin
                    RecRef.SetTable(LoanBatch);
                    LoanBatch.Validate(Status, LoanBatch.Status::Pending);
                    LoanBatch.Modify(true);
                    Variant := LoanBatch;
                    IsHandled := true;
                end;
            Database::"Guarantors Substitution":
                begin
                    RecRef.SetTable(GuarantorsSubstitution);
                    GuarantorsSubstitution.Validate(Status, GuarantorsSubstitution.Status::Pending);
                    GuarantorsSubstitution.Modify(true);
                    Variant := GuarantorsSubstitution;
                    IsHandled := true;
                end;
            Database::"Nominee Form Request":
                begin
                    RecRef.SetTable(NomineeRequest);
                    NomineeRequest.Validate(Status, NomineeRequest.Status::Pending);
                    NomineeRequest.Modify(true);
                    Variant := NomineeRequest;
                    IsHandled := true;
                end;
            Database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(HrAppraisal);
                    HrAppraisal.Validate(Status, HrAppraisal.Status::"Pending Approval");
                    HrAppraisal.Modify(true);
                    Variant := HrAppraisal;
                    IsHandled := true;
                end;
            Database::"HR Company Activities":
                begin
                    RecRef.SetTable(HrcompanyActivity);
                    HrcompanyActivity.Validate(Status, HrcompanyActivity.Status::"Pending Approval");
                    HrcompanyActivity.Modify(true);
                    Variant := HrcompanyActivity;
                    IsHandled := true;
                end;
            Database::"Savings Account Application":
                begin
                    RecRef.SetTable(SAccountAppl);
                    SAccountAppl.Validate(Status, SAccountAppl.Status::Pending);
                    SAccountAppl.Modify(true);
                    Variant := SAccountAppl;
                    IsHandled := true;
                end;
            Database::"Securities Register":
                begin
                    RecRef.SetTable(SecuritiesReg);
                    SecuritiesReg.Validate(Status, SecuritiesReg.Status::Pending);
                    SecuritiesReg.Modify(true);
                    Variant := SecuritiesReg;
                    IsHandled := true;
                end;
            Database::"Savings Interest Header":
                begin
                    RecRef.SetTable(AccInterest);
                    AccInterest.Validate(Status, AccInterest.Status::"Pending Approval");
                    AccInterest.Modify(true);
                    Variant := AccInterest;
                    IsHandled := true;
                end;
            Database::"ATM Linking Applications":
                begin
                    RecRef.SetTable(ATMLink);
                    ATMLink.Validate(Status, ATMLink.Status::"Pending Approval");
                    ATMLink.Modify(true);
                    Variant := ATMLink;
                    IsHandled := true;
                end;
            Database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMApp);
                    ATMApp.Validate(Status, ATMApp.Status::"Pending Approval");
                    ATMApp.Modify(true);
                    Variant := ATMApp;
                    IsHandled := true;
                end;
            Database::"RTGS Transfer Header":
                begin
                    RecRef.SetTable(RTGS);
                    RTGS.Validate(Status, RTGS.Status::Pending);
                    RTGS.Modify(true);
                    Variant := RTGS;
                    IsHandled := true;
                end;
            Database::"Standing Order Header":
                begin
                    RecRef.SetTable(STO);
                    STO.Validate(Status, STO.Status::Pending);
                    STO.Modify(true);
                    Variant := STO;
                    IsHandled := true;
                end;
            Database::"Key Request Table":
                begin
                    RecRef.SetTable(KeyRequest);
                    KeyRequest.Validate(Status, KeyRequest.Status::Pending);
                    KeyRequest.Modify(true);
                    Variant := KeyRequest;
                    IsHandled := true;
                end;
            Database::"Bankers Cheque Application":
                begin
                    RecRef.SetTable(BnkChq);
                    BnkChq.Validate(Status, BnkChq.Status::"Pending Approval");
                    BnkChq.Modify(true);
                    Variant := BnkChq;
                    IsHandled := true;
                end;
            Database::"Office Keys List":
                begin
                    RecRef.SetTable(KeyCreation);
                    KeyCreation.Validate(Status, KeyCreation.Status::Pending);
                    KeyCreation.Modify(true);
                    Variant := KeyCreation;
                    IsHandled := true;
                end;
            Database::"Appeals Table":
                begin
                    RecRef.SetTable(Appeals);
                    Appeals.Validate(Status, Appeals.Status::"Pending Approval");
                    Appeals.Modify(true);
                    Variant := Appeals;
                    IsHandled := true;
                end;

            Database::"HR Fuel Management Header":
                begin
                    RecRef.SetTable(Fuel);
                    Fuel.Validate(Status, Fuel.Status::Pending);
                    Fuel.Modify(true);
                    Variant := Fuel;
                    IsHandled := true;
                end;
            Database::"HR OSAccident":
                begin
                    RecRef.SetTable(Accidents);
                    Accidents.Validate(Status, Accidents.Status::Pending);
                    Accidents.Modify(true);
                    Variant := Accidents;
                    IsHandled := true;
                end;
            Database::Contracts:
                begin
                    RecRef.settable(Contracts);
                    Contracts.validate(Status, Contracts.Status::"Pending Approval");
                    Contracts.Modify(true);
                    Variant := Contracts;
                    IsHandled := true;
                end;
            Database::"Treasury Cashier Transactions":
                begin
                    RecRef.settable(TrCash);
                    TrCash.validate(Status, TrCash.Status::Pending);
                    TrCash.Modify(true);
                    Variant := TrCash;
                    IsHandled := true;
                end;
            database::"SMS Alerts Header":
                begin
                    recref.settable(SMSAlerts);
                    SMSAlerts.validate(Status, SMSAlerts.Status::Pending);
                    SMSAlerts.modify(true);
                    Variant := SMSAlerts;
                    IsHandled := true;
                end;
            database::"Conference & Meeting Rooms-T":
                begin
                    recref.settable(ConferenceBooking);
                    ConferenceBooking.validate(Status, ConferenceBooking.Status::Pending);
                    ConferenceBooking.modify(true);
                    Variant := ConferenceBooking;
                    IsHandled := true;
                end;
            database::"Conf & Meeting Rooms List":
                begin
                    recref.settable(ConferenceCreation);
                    ConferenceCreation.validate(Status, ConferenceCreation.Status::Pending);
                    ConferenceCreation.modify(true);
                    Variant := ConferenceCreation;
                    IsHandled := true;
                end;
            database::"Checkoff Header":
                begin
                    recref.settable(CheckoffHeader);
                    CheckoffHeader.validate(Status, CheckoffHeader.Status::Pending);
                    CheckoffHeader.modify(true);
                    Variant := CheckoffHeader;
                    IsHandled := true;
                end;
            database::"Parking List Table":
                begin
                    recref.settable(ParkingCreation);
                    ParkingCreation.validate(Status, ParkingCreation.Status::Pending);
                    ParkingCreation.modify(true);
                    Variant := ParkingCreation;
                    IsHandled := true;
                end;
            database::"Surety Management":
                begin
                    RecRef.settable(Surety);
                    Surety.validate(Status, Surety.Status::Pending);
                    Surety.Modify(true);
                    Variant := Surety;
                    IsHandled := true;
                end;
            database::Lease:
                begin
                    RecRef.SetTable(Lease);
                    Lease.Validate(Status, Lease.Status::"Pending");
                    Lease.Modify(true);
                    Variant := Lease;
                    IsHandled := true;
                end;
            database::"Property Details":
                begin
                    RecRef.SetTable(PropertyDetails);
                    PropertyDetails.Validate(Status, PropertyDetails.Status::"Pending Approval");
                    PropertyDetails.Modify(true);
                    Variant := PropertyDetails;
                    IsHandled := true;

                end;
            database::"HR Drivers":
                begin
                    recref.settable(HRDrivers);
                    HRDrivers.validate(Status, HRDrivers.Status::Pending);
                    HRDrivers.modify(true);
                    Variant := HRDrivers;
                    IsHandled := true;
                end;

            database::"Company Vehicles":
                begin
                    recref.settable(CompanyVehicles);
                    CompanyVehicles.validate(Status, CompanyVehicles.Status::"Pending Approval");
                    CompanyVehicles.modify(true);
                    Variant := CompanyVehicles;
                    IsHandled := true;
                end;
            database::Vendor:
                begin
                    recref.settable(Vendor);
                    Vendor.validate(Status, Vendor.Status::"Pending Approval");
                    Vendor.modify(true);
                    Variant := Vendor;
                    IsHandled := true;
                end;
            database::"Board members":
                begin
                    recref.settable(BoardMemberPay);
                    BoardMemberPay.validate(Status, BoardMemberPay.status::Pending);
                    BoardMemberPay.modify(true);
                    Variant := BoardMemberPay;
                    IsHandled := true;
                end;

            database::"Delegates Payment":
                begin
                    recref.settable(DelegatesPayment);
                    DelegatesPayment.validate(Status, DelegatesPayment.Status::Pending);
                    DelegatesPayment.modify(true);
                    Variant := DelegatesPayment;
                    IsHandled := true;
                end;
            database::"Delegate Officials":
                begin
                    recref.settable(DelegateOfficials);
                    DelegateOfficials.validate(Status, DelegateOfficials.Status::Pending);
                    DelegateOfficials.modify(true);
                    Variant := DelegateOfficials;
                    IsHandled := true;
                end;
            database::"Delegates Minutes Header":
                begin
                    recref.settable(Minutes);
                    Minutes.validate(Status, Minutes.Status::Pending);
                    Minutes.modify(true);
                    Variant := Minutes;
                    IsHandled := true;
                end;
            database::"Product Variations":
                begin
                    recref.settable(VariationsRec);
                    VariationsRec.validate(Status, VariationsRec.Status::"Pending");
                    VariationsRec.modify(true);
                    Variant := VariationsRec;
                    IsHandled := true;
                end;
            database::"Security Discharge":
                begin
                    recref.settable(SecurityDischarge);
                    SecurityDischarge.validate(Status, SecurityDischarge.Status::Pending);
                    SecurityDischarge.modify(true);
                    Variant := SecurityDischarge;
                    IsHandled := true;
                end;
            //database::"Member withdrawal Notice":

            database::"Electoral Zones":
                begin
                    recref.settable(ElectoralZones);
                    ElectoralZones.Validate(Status, ElectoralZones.Status::Pending);
                    ElectoralZones.modify(true);
                    Variant := ElectoralZones;
                    IsHandled := true;
                end;
            database::"Staff Claims Header":
                begin
                    recref.settable(StaffClaim);
                    StaffClaim.Validate(Status, StaffClaim.Status::"Pending Approval");
                    StaffClaim.modify(true);
                    Variant := StaffClaim;
                    IsHandled := true;
                end;
            database::"Member withdrawal Notice":

                begin
                    recref.settable(MemberWithdrawalNotice);
                    MemberWithdrawalNotice.Validate(Status, MemberWithdrawalNotice.Status::Pending);
                    MemberWithdrawalNotice.modify(true);
                    Variant := MemberWithdrawalNotice;
                    IsHandled := true;
                end;
            database::"Investment Header":
                begin
                    recref.settable(InvHeader);
                    InvHeader.Validate(Status, InvHeader.Status::"Pending Approval");
                    InvHeader.modify(true);
                    Variant := InvHeader;
                    IsHandled := true;
                end;
            database::"Investment Interest Header":
                begin
                    recref.settable(InvestInterestHeader);
                    InvestInterestHeader.Validate(Status, InvestInterestHeader.Status::"Pending Approval");
                    InvestInterestHeader.modify(true);
                    Variant := InvestInterestHeader;
                    IsHandled := true;
                end;
            database::"Parking Space":
                begin
                    recref.settable(ParkingSpace);
                    ParkingSpace.Validate(Status, ParkingSpace.Status::Pending);
                    ParkingSpace.modify(true);
                    Variant := ParkingSpace;
                    IsHandled := true;
                end;
            database::"Fosa Payments Header":
                begin
                    recref.settable(FOSAPV);
                    FOSAPV.Validate(Status, FOSAPV.Status::Pending);
                    FOSAPV.modify(true);
                    Variant := FOSAPV;
                    IsHandled := true;
                end;
            database::"Security Perfection":
                begin
                    recref.settable(SecurityPerfection);
                    SecurityPerfection.Validate(Status, SecurityPerfection.Status::"Pending");
                    SecurityPerfection.modify(true);
                    Variant := SecurityPerfection;
                    IsHandled := true;
                end;
            database::Customer:
                begin
                    recref.settable(Customer);
                    Customer.Validate(Status, Customer.Status::"Pending Approval");
                    Customer.modify(true);
                    Variant := Customer;
                    IsHandled := true;
                end;
            database::"HR Job Applications":
                begin
                    recref.settable(Application);
                    Application.Validate(Status, Application.Status::Shortlisted);
                    Application.modify(true);
                    Variant := Application;
                    IsHandled := true;
                end;
            Database::"Interest Header":
                begin
                    recref.settable(InterestHeader);
                    InterestHeader.Validate(Status, InterestHeader.Status::"Pending Approval");
                    InterestHeader.modify(true);
                    Variant := InterestHeader;
                    IsHandled := true;

                end;
            database::"Loan Recovery Header":
                begin
                    recref.settable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Validate(Status, LoanRecoveryHeader.Status::Pending);
                    LoanRecoveryHeader.modify(true);
                    Variant := LoanRecoveryHeader;
                    IsHandled := true;
                end;
            database::"Loan Recovery Header II":
                begin
                    recref.settable(LoanRecoveryHeaderII);
                    LoanRecoveryHeaderII.Validate(Status, LoanRecoveryHeaderII.Status::Pending);
                    LoanRecoveryHeaderII.modify(true);
                    Variant := LoanRecoveryHeaderII;
                    IsHandled := true;
                end;
            database::"Overtime Claim Header":
                begin
                    recref.settable(Overtime);
                    Overtime.Validate(Status, Overtime.Status::"Pending Approval");
                    Overtime.modify(true);
                    Variant := Overtime;
                    IsHandled := true;
                end;
            database::Legal:
                begin
                    recref.settable(Legal);
                    Legal.Validate(Status, Legal.Status::Pending);
                    Legal.modify(true);
                    Variant := Legal;
                    IsHandled := true;
                end;
            database::"Dispatch ATM Header":
                begin
                    recref.settable(DispatchATM);
                    DispatchATM.Validate(Status, DispatchATM.Status::Pending);
                    DispatchATM.modify(true);
                    Variant := DispatchATM;
                    IsHandled := true;
                end;

            database::"Refund,Account Transfer Header":
                begin
                    recref.settable(RefundTransfer);
                    RefundTransfer.validate(status, RefundTransfer.Status::Pending);
                    RefundTransfer.modify(true);
                    Variant := RefundTransfer;
                    IsHandled := true;
                end;
            database::"Vehicle Movement":
                begin
                    recref.settable(VehicleMovement);
                    VehicleMovement.Validate(Status, VehicleMovement.Status::Pending);
                    VehicleMovement.modify(true);
                    Variant := VehicleMovement;
                    IsHandled := true;
                end;
            database::"Motor Vehicle Request":
                begin
                    recref.settable(VehicleRequest);
                    VehicleRequest.Validate(Status, VehicleRequest.Status::Pending);
                    VehicleRequest.modify(true);
                    Variant := VehicleRequest;
                    IsHandled := true;
                end;

            // Database::"Conference & Meeting Rooms-T":
            //     begin
            //         recref.settable(ConferenceAndMeetingRooms);
            //         ConferenceAndMeetingRooms.Validate(Status, ConferenceAndMeetingRooms.Status::Pending);
            //         ConferenceAndMeetingRooms.modify(true);
            //         Variant := ConferenceAndMeetingRooms;
            //         IsHandled := true;
            //     end;


            database::"System Reversal":
                begin
                    recref.settable(SystemReversal);
                    SystemReversal.Validate(Status, SystemReversal.Status::Pending);
                    SystemReversal.modify(true);
                    Variant := SystemReversal;
                    IsHandled := true;
                end;
            Database::"Product Factory":
                begin
                    recref.settable(ProductFactory);
                    ProductFactory.Validate(Status, ProductFactory.Status::Pending);
                    ProductFactory."Last Updated By" := UserId;
                    ProductFactory.modify(true);
                    Variant := ProductFactory;
                    IsHandled := true;
                end;
            database::"User Creation Requests":
                begin
                    recref.settable(UserCreation);
                    UserCreation.Validate(Status, UserCreation.Status::Pending);
                    UserCreation.modify(true);
                    Variant := UserCreation;
                    IsHandled := true;
                end;
            database::"User Termination":
                begin
                    recref.settable(UserTermination);
                    UserTermination.Validate(Status, UserTermination.Status::Pending);
                    UserTermination.modify(true);
                    Variant := UserTermination;
                    IsHandled := true;
                end;
            //bbf $ risk claims
            database::"SinkFund Report Information":
                begin
                    recref.settable(Sinkfund);
                    sinkfund.Validate(Status, sinkfund.Status::Pending);
                    sinkfund.modify(true);
                    Variant := sinkfund;
                    IsHandled := true;



                end;
            // database::"Company Vehicles":
            //     begin
            //         recref.settable(CompanyVehicles);
            //         CompanyVehicles.Validate(Status, CompanyVehicles.Status::Pending);
            //         CompanyVehicles.modify(true);
            //         Variant := CompanyVehicles;
            //         IsHandled := true;

            //     end;
            // Database::"Vehicle Movement":
            //     begin
            //         recref.settable(VehicleMovement);
            //         VehicleMovement.Validate(Status, VehicleMovement.Status::Pending);
            //         VehicleMovement.modify(true);
            //         Variant := VehicleMovement;
            //         IsHandled := true;

            //     end;
            // database::"Conference & Meeting Rooms-T":
            //     begin
            //         recref.settable(ConferenceAndMeetingRooms);
            //         ConferenceAndMeetingRooms.Validate(Status, ConferenceAndMeetingRooms.Status::Pending);
            //         ConferenceAndMeetingRooms.modify(true);
            //         Variant := ConferenceAndMeetingRooms;
            //         IsHandled := true;

            //     end;
            database::"Business Loan Clossure":
                begin
                    recref.settable(BusinessLoanClossure);
                    BusinessLoanClossure.Validate(Status, BusinessLoanClossure.Status::Pending);
                    BusinessLoanClossure.modify(true);
                    Variant := BusinessLoanClossure;
                    IsHandled := true;

                end;
            database::"One Month Installment":
                begin
                    recref.settable(OneMonthInstallments);
                    OneMonthInstallments.Validate(Status, OneMonthInstallments.Status::Pending);
                    OneMonthInstallments.modify(true);
                    Variant := OneMonthInstallments;
                    IsHandled := true;

                end;
            database::"Dependancies Applications":
                begin
                    recref.settable(DependancyApplications);
                    DependancyApplications.Validate(Status, DependancyApplications.Status::Pending);
                    DependancyApplications.modify(true);
                    Variant := DependancyApplications;
                    IsHandled := true;

                end;
            database::"System Edits":
                begin
                    recref.settable(SystemEdits);
                    SystemEdits.Validate(Status, SystemEdits.Status::Pending);
                    SystemEdits.modify(true);
                    Variant := SystemEdits;
                    IsHandled := true;

                end;
            database::"Payments Header":
                begin
                    recref.settable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
                    PettyCash.modify(true);
                    Variant := PettyCash;
                    IsHandled := true;
                end;


            Database::"Account Transfer Header":
                begin
                    recref.settable(ACTransfer);
                    ACTransfer.Validate(Status, ACTransfer.Status::"Pending Approval");
                    ACTransfer.modify(true);
                    Variant := ACTransfer;
                    IsHandled := true;

                end;
            database::"B/S Loan Account Application":
                begin
                    recref.settable(BSLoansAccApp);
                    BSLoansAccApp.Validate(Status, BSLoansAccApp.Status::Pending);
                    BSLoansAccApp.modify(true);
                    Variant := BSLoansAccApp;
                    IsHandled := true;

                end;
            database::"member application":
                begin
                    recref.settable(memberApp);
                    memberApp.Validate(Status, memberApp.Status::Pending);
                    memberApp.modify(true);
                    Variant := memberApp;
                    IsHandled := true;

                end;
            Database::"Moratorium Loan":
                begin
                    recref.settable(MoratoriumLoan);
                    MoratoriumLoan.Validate(Status, MoratoriumLoan.Status::Pending);
                    MoratoriumLoan.modify(true);
                    Variant := MoratoriumLoan;
                    IsHandled := true;

                end;
            database::"Loan Rescheduling":
                begin
                    recref.settable(Loanrescheduling);
                    Loanrescheduling.Validate(Status, Loanrescheduling.Status::Pending);
                    Loanrescheduling.modify(true);
                    Variant := Loanrescheduling;
                    IsHandled := true;

                end;
            database::"Share Capital Transfer Buffer":
                begin
                    recref.settable(Sharetransfer);
                    sharetransfer.Validate(Status, Sharetransfer.Status::Pending);
                    sharetransfer.modify(true);
                    Variant := sharetransfer;
                    IsHandled := true;

                end;
        end;
        case RecRef.number of
            database::loans:
                begin
                    recref.settable(Loanapp);
                    if Loanapp."Override Loan Qualification" = true then begin
                        if not confirm('This is an exceptional Loan, do you wish to approve? More information on the comment section.') then
                            exit;
                    end;
                    Loanapp.Validate(Status, Loanapp.Status::Pending);
                    Loanapp."Loan Appraised By" := UserId;
                    Loanapp."Approval Date" := Today;
                    Loanapp."SMS Sent" := true;
                    Loanapp.modify(true);
                    Variant := Loanapp;
                    IsHandled := true;
                end;
            database::"Membership closure":
                begin
                    recref.settable(MClosure);
                    MClosure.Validate(Status, MClosure.Status::Pending);
                    MClosure.modify(true);
                    Variant := MClosure;
                    IsHandled := true;
                end;
            database::"Banking Account Closure":
                begin
                    recref.settable(BankAccClossure);
                    BankAccClossure.Validate(Status, BankAccClossure.Status::Pending);
                    BankAccClossure.modify(true);
                    Variant := BankAccClossure;
                    IsHandled := true;
                end;
            database::"Cashier Transactions":
                begin
                    recref.settable(CashierTransactions);
                    CashierTransactions.Validate(Status, CashierTransactions.Status::"Pending Approval");
                    CashierTransactions.modify(true);
                    Variant := CashierTransactions;
                    IsHandled := true;
                end;
            database::"Fixed Deposit Contract":
                begin
                    recref.settable(FDContract);
                    FDContract.Validate(Status, FDContract.Status::Pending);
                    FDContract."Fixed Deposit Status" := FDContract."Fixed Deposit Status"::Active;
                    FDContract.modify(true);
                    Variant := FDContract;
                    IsHandled := true;
                end;
            //HR Employee
            Database::"HR Employees":
                begin
                    recref.settable(HrEmployee);
                    HrEmployee.Validate(Status, HrEmployee.Status::"Pending Approval");
                    HrEmployee.modify(true);
                    Variant := HrEmployee;
                    IsHandled := true;
                end;
            //hr jobs
            Database::"HR Jobs":
                begin
                    recref.settable(Jobs);
                    Jobs.Validate(Status, Jobs.Status::"Pending Approval");
                    Jobs.modify(true);
                    Variant := Jobs;
                    IsHandled := true;
                end;
            Database::"HR Employee Requisitions":
                begin
                    recref.settable(EmpRequisitions);
                    EmpRequisitions.Validate("Approval Status", EmpRequisitions."Approval Status"::"Pending Approval");
                    EmpRequisitions.modify(true);
                    Variant := EmpRequisitions;
                    IsHandled := true;
                end;
            Database::"Imprest Header":
                begin
                    recref.settable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.Status::"Pending Approval");
                    ImprestRequisition.modify(true);
                    Variant := ImprestRequisition;
                    IsHandled := true;
                end;
            Database::"Imprest Surrender Header":
                begin
                    recref.settable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.modify(true);
                    Variant := ImprestSurrender;
                    IsHandled := true;
                end;
            Database::"HR Disciplinary Cases NCA":
                begin
                    recref.settable(Disciplinary);
                    Disciplinary.Validate(Status, Disciplinary.Status::"Pending Approval");
                    Disciplinary.modify(true);
                    Variant := Disciplinary;
                    IsHandled := true;
                end;
            Database::"HRDisciplinary Appeal":
                begin
                    recref.settable(DiscAppeal);
                    DiscAppeal.Validate(Status, DiscAppeal.Status::"Pending Approval");
                    DiscAppeal.modify(true);
                    Variant := DiscAppeal;
                    IsHandled := true;
                end;
            Database::"HRDisciplinary Case Withdrawal":
                begin
                    recref.settable(disciplinarywithdrawal);
                    disciplinarywithdrawal.Validate(Status, disciplinarywithdrawal.Status::"Pending Approval");
                    disciplinarywithdrawal.modify(true);
                    Variant := disciplinarywithdrawal;
                    IsHandled := true;
                end;
            Database::"HR Training Feedback Form":
                begin
                    recref.settable(feedback);
                    feedback.Validate(Status, feedback.Status::"Pending Approval");
                    feedback.modify(true);
                    Variant := feedback;
                    IsHandled := true;
                end;
            Database::"HR Training Needs":
                begin
                    recref.settable(trainneeds);
                    trainneeds.Validate(Status, trainneeds.Status::"Pending Approval");
                    trainneeds.modify(true);
                    Variant := trainneeds;
                    IsHandled := true;
                end;
            Database::"HR Training App Header":
                begin
                    recref.settable(TraiApp);
                    TraiApp.Validate(Status, TraiApp.Status::"Pending Approval");
                    TraiApp.modify(true);
                    Variant := TraiApp;
                    IsHandled := true;
                end;
            Database::"HR Leave Application":
                begin
                    recref.settable(Leave);
                    Leave.Validate(status, Leave.status::"Pending Approval");
                    Leave.modify(true);
                    Variant := Leave;
                    IsHandled := true;
                end;
            Database::"Salary Header":
                begin
                    recref.settable(Salary);
                    Salary.Validate(status, Salary.status::Pending);
                    Salary.modify(true);
                    Variant := Salary;
                    IsHandled := true;
                end;
            // Database::"Treasury Cashier Transactions":
            //     begin
            //         recref.settable(TrCash);
            //         TrCash.Validate(status, TrCash.status::Pending);
            //         TrCash.modify(true);
            //         Variant := TrCash;
            //         IsHandled := true;
            //     end;
            Database::"Permission Requisition":
                begin
                    recref.settable(PermissionReq);
                    PermissionReq.Validate(status, PermissionReq.status::"Pending Approval");
                    PermissionReq.modify(true);
                    Variant := PermissionReq;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; workflowstepInstance: Record "Workflow Step Instance")
    var
        VehicleRequest: Record "Motor Vehicle Request";
        VehicleMovement: Record "Vehicle Movement";
        Member: record "Member Application";
        LoanApp: Record Loans;
        SecuritiesReg: Record "Securities Register";
        DependancyApplications: Record "Dependancies Applications";
        BankAccClossure: Record "Banking Account Closure";
        CashierTransactions: Record "Cashier Transactions";
        Sharetransfer: Record "Share Capital Transfer Buffer";
        Loanrescheduling: Record "Loan Rescheduling";
        MoratoriumLoan: Record "Moratorium Loan";
        BSLoansAccApp: Record "B/S Loan Account Application";
        SystemEdits: Record "System Edits";
        Mclosure: Record "Membership closure";
        ACTransfer: Record "Account Transfer Header";
        PettyCash: Record "Payments Header";
        OneMonthInstallments: Record "One Month Installment";
        BusinessLoanClossure: Record "Business Loan Clossure";
        ConferenceAndMeetingRooms: Record "Conference & Meeting Rooms-T";
        FixedDepositContract: Record "Fixed Deposit Contract";
        sinkfund: Record "SinkFund Report Information";

        SystemReversal: Record "System Reversal";
        DMUCaseForwarding: Record "DMU Case Forwarding";
        UserCreation: Record "User Creation Requests";
        UserTermination: Record "User Termination";
        ProductFactory: Record "Product Factory";
        DispatchATM: Record "Dispatch ATM Header";
        RefundTransfer: Record "Refund,Account Transfer Header";
        Legal: Record Legal;
        VariationsRec: Record "Product Variations";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        StaffWelfare: Record "Staff Welfare";
        InterestHeader: Record "Interest Header";
        Customer: Record Customer;
        SecurityPerfection: Record "Security Perfection";
        Application: record "HR Job Applications";
        InvHeader: Record "Investment Header";
        Jobs: record "HR Jobs";
        Overtime: Record "Overtime Claim Header";
        StaffClaim: Record "Staff Claims Header";
        TraiApp: Record "HR Training App Header";
        trainneeds: record "HR Training Needs";
        feedback: record "HR Training Feedback Form";
        //Overtime:Record "Overtime Claim Header";
        ParkingSpace: Record "Parking Space";
        InvestInterestHeader: Record "Investment Interest Header";
        EmpRequisitions: record "HR Employee Requisitions";
        Disciplinary: record "HR Disciplinary Cases NCA";
        FOSAPV: record "Fosa Payments Header";
        disciplinarywithdrawal: record "HRDisciplinary Case Withdrawal";
        DiscAppeal: Record "HRDisciplinary Appeal";
        MemberWithdrawalNotice: Record "Member withdrawal Notice";
        SecurityDischarge: Record "Security Discharge";
        ElectoralZones: Record "Electoral Zones";
        DelegateOfficials: Record "Delegate Officials";
        HrEmployee: Record "HR Employees";
        Minutes: Record "Delegates Minutes Header";
        DelegatesPayment: Record "Delegates Payment";
        HRLeaveJournalLine: Record "HR Leave Journal Line";
        Leave: Record "HR Leave Application";
        ImprestRequisition: Record "Imprest Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        Vendor: Record Vendor;
        HRDrivers: Record "HR Drivers";
        PropertyDetails: Record "Property Details";
        Lease: Record Lease;
        Surety: Record "Surety Management";
        CompanyVehicles: Record "Company Vehicles";
        BoardMemberPay: Record "Board members";
        ParkingCreation: Record "Parking List Table";
        CheckoffHeader: Record "Checkoff Header";
        ConferenceCreation: Record "Conf & Meeting Rooms List";
        ConferenceBooking: Record "Conference & Meeting Rooms-T";
        SMSAlerts: Record "SMS Alerts Header";
        Salary: record "Salary Header";
        Contracts: Record Contracts;
        Accidents: Record "HR OSAccident";
        Fuel: Record "HR Fuel Management Header";
        Appeals: Record "Appeals Table";
        KeyCreation: Record "Office Keys List";
        KeyRequest: Record "Key Request Table";
        BnkChq: Record "Bankers Cheque Application";
        TrTrans: Record "Treasury Cashier Transactions";
        STO: Record "Standing Order Header";
        RTGS: Record "RTGS Transfer Header";
        ATMApp: Record "ATM Applications";
        ATMLink: Record "ATM Linking Applications";
        AccInterest: Record "Savings Interest Header";
        EndYearTrans: Record "End Year Transfer Header";
        PermissionReq: Record "Permission Requisition";
        SAccountAppl: Record "Savings Account Application";
        HrcompanyActivity: Record "HR Company Activities";
        HrAppraisal: Record "HR Appraisal Header";
        NomineeRequest: Record "Nominee Form Request";
        GuarantorsSubstitution: Record "Guarantors Substitution";
        LoanBatch: Record "Loan Disbursement Header";
        HrTPlanning: Record "HR Training Planner";
        HrExitInterview: record "HR Employee Exit Interviews";
        InterBankTr: Record "InterBank Transfers";
        StoreRequ: Record "Store Requistion Header";
        Divprovision: Record "Dividends Provision Header";
        AssetTrn: Record "Asset Transfer";
        AccountAct: Record "Account Activation";
        ContractReq: Record "Contract Request";
        HrOverTime: Record "HR Overtime Header";
        Collectreg: Record "Securities Collection Register";
        TreasuryApp: Record "Treasury Cheque Application";
        InsuaranceClaims: record "Insurance Claims";
        AssetInsuarance: Record Insurance;
        VehicleRepa: Record "Maintain Machne/Vehicles";
        VehicleServic: Record "Vehicle Servicing Table";
        StockKeeping: Record "Stock Keeping";
        WellFareAdvance: record "Welfare Advance";
        ClearanceForm: Record "Clearance Form";
        BOSAAccActive: Record "BOSA Account Activation";
        BatchingProcess: Record "Batching Process Table";
        GeneralSMSHeader: Record "General SMS Header";
        MKey: Record "MKey Forwarding";
        RevenueCollection: Record "Revenue Collection";
        FAReclassificationJournal: Record "FA Reclass. Journal Line";
        VoteTransfer: Record "Vote Transfer";
        BankDeposit: Record "Bank Deposit Header";
        GroupUpdate: Record "Group Member Exit & Update";
    begin
        case RecRef.number of
            Database::"Group Member Exit & Update":
                begin
                    RecRef.SetTable(GroupUpdate);
                    ApprovalEntryArgument."Document No." := GroupUpdate."No.";
                end;
            Database::"Bank Deposit Header":
                begin
                    RecRef.SetTable(BankDeposit);
                    ApprovalEntryArgument."Document No." := BankDeposit."No.";
                end;
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(VoteTransfer);
                    ApprovalEntryArgument."Document No." := FORMAT(VoteTransfer.No);
                end;
            Database::"FA Reclass. Journal Line":
                begin
                    RecRef.SetTable(FAReclassificationJournal);
                    ApprovalEntryArgument."Document No." := FORMAT(FAReclassificationJournal."Line No.");
                end;
            Database::"Revenue Collection":
                begin
                    RecRef.SetTable(RevenueCollection);
                    ApprovalEntryArgument."Document No." := RevenueCollection."No.";
                end;
            Database::"MKey Forwarding":
                begin
                    RecRef.SetTable(MKey);
                    ApprovalEntryArgument."Document No." := MKey."No.";
                end;
            Database::"General SMS Header":
                begin
                    RecRef.SetTable(GeneralSMSHeader);
                    ApprovalEntryArgument."Document No." := GeneralSMSHeader."No.";
                end;
            Database::"Batching Process Table":
                begin
                    RecRef.SetTable(BatchingProcess);
                    ApprovalEntryArgument."Document No." := BatchingProcess."No.";
                end;
            Database::"Clearance Form":
                begin
                    RecRef.SetTable(ClearanceForm);
                    ApprovalEntryArgument."Document No." := ClearanceForm."Clearance No";
                end;
            Database::"Welfare Advance":
                begin
                    RecRef.SetTable(WellFareAdvance);
                    ApprovalEntryArgument."Document No." := WellFareAdvance.No;
                end;
            Database::"Stock Keeping":
                begin
                    RecRef.SetTable(StockKeeping);
                    ApprovalEntryArgument."Document No." := StockKeeping.No;
                end;
            Database::"Vehicle Servicing Table":
                begin
                    RecRef.SetTable(VehicleServic);
                    ApprovalEntryArgument."Document No." := VehicleServic."No.";
                end;
            Database::"Maintain Machne/Vehicles":
                begin
                    RecRef.SetTable(VehicleRepa);
                    ApprovalEntryArgument."Document No." := VehicleRepa."No.";
                end;
            Database::Insurance:
                begin
                    RecRef.SetTable(AssetInsuarance);
                    ApprovalEntryArgument."Document No." := AssetInsuarance."No.";
                end;
            Database::"Insurance Claims":
                begin
                    RecRef.SetTable(InsuaranceClaims);
                    ApprovalEntryArgument."Document No." := InsuaranceClaims."Claim No.";
                end;
            Database::"Treasury Cheque Application":
                begin
                    RecRef.SetTable(TreasuryApp);
                    ApprovalEntryArgument."Document No." := TreasuryApp."No.";
                end;
            Database::"BOSA Account Activation":
                begin
                    RecRef.SetTable(BOSAAccActive);
                    ApprovalEntryArgument."Document No." := BOSAAccActive.No;
                end;
            Database::"Securities Collection Register":
                begin
                    RecRef.SetTable(Collectreg);
                    ApprovalEntryArgument."Document No." := Collectreg."No.";
                end;
            Database::"HR Overtime Header":
                begin
                    RecRef.SetTable(HrOverTime);
                    ApprovalEntryArgument."Document No." := HrOverTime."Application Code";
                end;
            Database::"Contract Request":
                begin
                    RecRef.SetTable(ContractReq);
                    ApprovalEntryArgument."Document No." := ContractReq."No.";
                end;
            Database::"Account activation":
                begin
                    RecRef.SetTable(AccountAct);
                    ApprovalEntryArgument."Document No." := AccountAct.No;
                end;
            Database::"End Year Transfer Header":
                begin
                    RecRef.SetTable(EndYearTrans);
                    ApprovalEntryArgument."Document No." := EndYearTrans."No.";
                end;
            Database::"Asset Transfer":
                begin
                    RecRef.SetTable(AssetTrn);
                    ApprovalEntryArgument."Document No." := AssetTrn."No.";
                end;
            Database::"Dividends Provision Header":
                begin
                    RecRef.SetTable(Divprovision);
                    ApprovalEntryArgument."Document No." := Divprovision."No.";
                end;
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequ);
                    ApprovalEntryArgument."Document No." := StoreRequ."No.";
                end;
            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTr);
                    ApprovalEntryArgument."Document No." := InterBankTr.No;
                end;
            Database::"HR Employee Exit Interviews":
                begin
                    RecRef.SetTable(HrExitInterview);
                    ApprovalEntryArgument."Document No." := HrExitInterview."Exit Interview No";
                end;
            Database::"HR Training Planner":
                begin
                    RecRef.SetTable(HrTPlanning);
                    ApprovalEntryArgument."Document No." := HrTPlanning."No";
                end;
            Database::"Loan Disbursement Header":
                begin
                    RecRef.SetTable(LoanBatch);
                    ApprovalEntryArgument."Document No." := LoanBatch."No.";
                end;
            Database::"Guarantors Substitution":
                begin
                    RecRef.SetTable(GuarantorsSubstitution);
                    ApprovalEntryArgument."Document No." := GuarantorsSubstitution."No.";
                end;
            Database::"Nominee Form Request":
                begin
                    RecRef.SetTable(NomineeRequest);
                    ApprovalEntryArgument."Document No." := NomineeRequest."No.";
                end;
            Database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(HrAppraisal);
                    ApprovalEntryArgument."Document No." := HrAppraisal."Appraisal No";
                end;
            Database::"HR Company Activities":
                begin
                    RecRef.SetTable(HrcompanyActivity);
                    ApprovalEntryArgument."Document No." := HrcompanyActivity.Code;
                end;
            Database::"Savings Account Application":
                begin
                    RecRef.SetTable(SAccountAppl);
                    ApprovalEntryArgument."Document No." := SAccountAppl."No.";
                end;
            Database::"Securities Register":
                begin
                    RecRef.SetTable(SecuritiesReg);
                    ApprovalEntryArgument."Document No." := SecuritiesReg."No.";
                end;
            Database::"Savings Interest Header":
                begin
                    RecRef.SetTable(AccInterest);
                    ApprovalEntryArgument."Document No." := AccInterest."No.";
                end;
            Database::"ATM Linking Applications":
                begin
                    RecRef.SetTable(ATMLink);
                    ApprovalEntryArgument."Document No." := ATMLink."No.";
                end;
            Database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMApp);
                    ApprovalEntryArgument."Document No." := ATMApp."No.";
                end;
            Database::"Account Transfer Header":
                begin
                    RecRef.SetTable(ACTransfer);
                    ApprovalEntryArgument."Document No." := ACTransfer.No;
                end;
            Database::"RTGS Transfer Header":
                begin
                    RecRef.SetTable(RTGS);
                    ApprovalEntryArgument."Document No." := RTGS."No.";
                end;
            Database::"Standing Order Header":
                begin
                    RecRef.SetTable(STO);
                    ApprovalEntryArgument."Document No." := STO."No.";
                end;
            Database::"Bankers Cheque Application":
                begin
                    RecRef.SetTable(BnkChq);
                    ApprovalEntryArgument."Document No." := BnkChq."No.";
                end;
            Database::"Treasury Cashier Transactions":
                begin
                    RecRef.SetTable(TrTrans);
                    ApprovalEntryArgument."Document No." := TrTrans.No;
                end;
            Database::"Key Request Table":
                begin
                    RecRef.SetTable(KeyRequest);
                    ApprovalEntryArgument."Document No." := KeyRequest."No.";
                end;
            Database::"Office Keys List":
                begin
                    RecRef.SetTable(KeyCreation);
                    ApprovalEntryArgument."Document No." := KeyCreation."No.";
                end;
            Database::"Appeals Table":
                begin
                    RecRef.SetTable(Appeals);
                    ApprovalEntryArgument."Document No." := Appeals."No.";
                end;
            Database::"HR Fuel Management Header":
                begin
                    RecRef.SetTable(Fuel);
                    ApprovalEntryArgument."Document No." := Fuel."No.";
                end;
            Database::"HR OSAccident":
                begin
                    RecRef.SetTable(Accidents);
                    ApprovalEntryArgument."Document No." := Accidents."Accident No.";
                end;
            database::Contracts:
                begin
                    RecRef.settable(Contracts);
                    ApprovalEntryArgument."Document No." := Contracts."Contract No";
                end;
            database::"SMS Alerts Header":
                begin
                    RecRef.settable(SMSAlerts);
                    ApprovalEntryArgument."Document No." := SMSAlerts."No.";
                end;
            database::"Conference & Meeting Rooms-T":
                begin
                    RecRef.settable(ConferenceBooking);
                    ApprovalEntryArgument."Document No." := ConferenceBooking."No.";
                end;
            database::"Conf & Meeting Rooms List":
                begin
                    RecRef.settable(ConferenceCreation);
                    ApprovalEntryArgument."Document No." := ConferenceCreation."No.";
                end;
            database::"Checkoff Header":
                begin
                    RecRef.settable(CheckoffHeader);
                    ApprovalEntryArgument."Document No." := CheckoffHeader."No.";
                end;
            database::"Parking List Table":
                begin
                    RecRef.settable(ParkingCreation);
                    ApprovalEntryArgument."Document No." := ParkingCreation."No";
                end;
            database::"Surety Management":
                begin
                    RecRef.settable(Surety);
                    ApprovalEntryArgument."Document No." := Surety."Surety No";
                end;
            database::Lease:
                begin
                    RecRef.SetTable(Lease);
                    ApprovalEntryArgument."Document No." := Lease."No.";
                end;
            database::"Property Details":
                begin
                    RecRef.SetTable(PropertyDetails);
                    ApprovalEntryArgument."Document No." := PropertyDetails."No.";
                end;
            database::"HR Drivers":
                begin
                    RecRef.Settable(HRDrivers);
                    ApprovalEntryArgument."Document No." := HRDrivers."No.";
                end;
            database::"Company Vehicles":
                begin
                    RecRef.Settable(CompanyVehicles);
                    ApprovalEntryArgument."Document No." := CompanyVehicles."Registration No.";
                end;
            database::Vendor:
                begin
                    RecRef.Settable(Vendor);
                    ApprovalEntryArgument."Document No." := Vendor."No.";
                end;
            Database::"Board members":
                begin
                    RecRef.Settable(BoardMemberPay);
                    ApprovalEntryArgument."Document No." := BoardMemberPay."No.";
                end;
            database::"Delegates Payment":
                begin
                    RecRef.Settable(DelegatesPayment);
                    ApprovalEntryArgument."Document No." := DelegatesPayment.Code;
                end;
            database::"Delegates Minutes Header":
                begin
                    RecRef.Settable(Minutes);
                    ApprovalEntryArgument."Document No." := Minutes.Code;
                end;
            database::"Delegate Officials":
                begin
                    RecRef.Settable(DelegateOfficials);
                    ApprovalEntryArgument."Document No." := DelegateOfficials."Member Number";
                end;
            database::"Security Discharge":
                begin
                    RecRef.Settable(SecurityDischarge);
                    ApprovalEntryArgument."Document No." := SecurityDischarge."No.";
                end;
            database::"Product Variations":
                begin
                    RecRef.Settable(VariationsRec);
                    ApprovalEntryArgument."Document No." := VariationsRec."No.";
                end;

            //database::"Member withdrawal Notice":

            database::"Electoral Zones":
                begin
                    RecRef.settable(ElectoralZones);
                    ApprovalEntryArgument."Document No." := ElectoralZones.Code;
                end;
            database::"Member withdrawal Notice":

                begin
                    RecRef.settable(MemberWithdrawalNotice);
                    ApprovalEntryArgument."Document No." := MemberWithdrawalNotice."No.";
                end;
            database::"Investment Header":
                begin
                    RecRef.settable(InvHeader);
                    ApprovalEntryArgument."Document No." := InvHeader."Investment No";
                end;
            database::"Investment Interest Header":
                begin
                    RecRef.settable(InvestInterestHeader);
                    ApprovalEntryArgument."Document No." := InvestInterestHeader."No.";
                end;
            database::"Parking Space":
                begin
                    RecRef.settable(ParkingSpace);
                    ApprovalEntryArgument."Document No." := ParkingSpace."No.";
                end;
            database::"Fosa Payments Header":
                begin
                    RecRef.settable(FOSAPV);
                    ApprovalEntryArgument."Document No." := FOSAPV."No.";
                end;
            database::"Security Perfection":
                begin
                    RecRef.SetTable(SecurityPerfection);
                    ApprovalEntryArgument."Document No." := SecurityPerfection."No.";
                end;
            database::Customer:
                begin
                    RecRef.SetTable(Customer);
                    ApprovalEntryArgument."Document No." := Customer."No.";
                end;

            database::"Overtime Claim Header":
                begin
                    RecRef.SetTable(Overtime);
                    ApprovalEntryArgument."Document No." := Overtime."Claim No";
                end;
            database::"HR Job Applications":

                begin
                    RecRef.SetTable(Application);
                    ApprovalEntryArgument."Document No." := Application."Job Application No.";
                end;
            database::"Interest Header":
                begin
                    RecRef.SetTable(InterestHeader);
                    ApprovalEntryArgument."Document No." := InterestHeader."No.";
                end;
            database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    ApprovalEntryArgument."Document No." := LoanRecoveryHeader."No.";
                end;
            database::"Loan Recovery Header II":
                begin
                    RecRef.SetTable(LoanRecoveryHeaderII);
                    ApprovalEntryArgument."Document No." := LoanRecoveryHeaderII."No.";
                end;
            database::Legal:
                begin
                    RecRef.SetTable(Legal);
                    ApprovalEntryArgument."Document No." := Legal."No.";
                end;

            database::"Staff Welfare":
                begin
                    RecRef.SetTable(StaffWelfare);
                    ApprovalEntryArgument."Document No." := StaffWelfare."No";
                end;
            database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaim);
                    ApprovalEntryArgument."Document No." := StaffClaim."No.";
                end;
            Database::"Dispatch ATM Header":
                begin
                    RecRef.SetTable(DispatchATM);
                    ApprovalEntryArgument."Document No." := DispatchATM."No.";
                end;
            Database::"DMU Case Forwarding":
                begin
                    RecRef.SetTable(DMUCaseForwarding);
                    ApprovalEntryArgument."Document No." := DMUCaseForwarding."No.";
                end;
            Database::"Refund,Account Transfer Header":
                begin
                    RecRef.SetTable(RefundTransfer);
                    ApprovalEntryArgument."Document No." := RefundTransfer."No";
                end;
            Database::"Motor Vehicle Request":
                begin
                    RecRef.SetTable(VehicleRequest);
                    ApprovalEntryArgument."Document No." := VehicleRequest."No.";
                end;
            database::"Vehicle Movement":
                begin
                    RecRef.SetTable(VehicleMovement);
                    ApprovalEntryArgument."Document No." := VehicleMovement."No.";
                end;
            Database::"System Reversal":
                begin
                    RecRef.SetTable(SystemReversal);
                    ApprovalEntryArgument."Document No." := SystemReversal."No.";

                end;
            Database::"User Creation Requests":
                begin
                    RecRef.SetTable(UserCreation);
                    ApprovalEntryArgument."Document No." := UserCreation."Request ID";
                end;
            Database::"User Termination":
                begin
                    RecRef.SetTable(UserTermination);
                    ApprovalEntryArgument."Document No." := UserTermination."Request ID";
                end;
            Database::"Product Factory":
                begin
                    RecRef.SetTable(ProductFactory);
                    ApprovalEntryArgument."Document No." := ProductFactory."Product ID";
                end;
            Database::"Business Loan Clossure":
                begin
                    RecRef.SetTable(BusinessLoanClossure);
                    ApprovalEntryArgument."Document No." := BusinessLoanClossure."No.";
                end;

            Database::"Vehicle Movement":
                begin
                    RecRef.SetTable(VehicleMovement);
                    ApprovalEntryArgument."Document No." := VehicleMovement."No.";
                end;
            // Database::"Conference & Meeting Rooms-T":
            //     begin
            //         RecRef.SetTable(ConferenceAndMeetingRooms);
            //         ApprovalEntryArgument."Document No." := ConferenceAndMeetingRooms."No.";
            //     end;
            Database::"One Month Installment":
                begin
                    RecRef.SetTable(OneMonthInstallments);
                    ApprovalEntryArgument."Document No." := OneMonthInstallments."Record No.";
                end;

            Database::"Dependancies Applications":
                begin
                    RecRef.SetTable(DependancyApplications);
                    ApprovalEntryArgument."Document No." := DependancyApplications."No.";
                end;
        end;
        case RecRef.number of
            Database::"System Edits":
                begin
                    RecRef.SetTable(SystemEdits);
                    ApprovalEntryArgument."Document No." := SystemEdits."No.";
                end;
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PettyCash);
                    ApprovalEntryArgument."Document No." := PettyCash."No.";
                end;
            Database::"Account Transfer Header":
                begin
                    RecRef.SetTable(ACTransfer);
                    ApprovalEntryArgument."Document No." := ACTransfer."No";
                end;
            Database::"B/S Loan Account Application":
                begin
                    RecRef.SetTable(BSLoansAccApp);
                    ApprovalEntryArgument."Document No." := BSLoansAccApp."No.";
                end;

            Database::"Member Application":
                begin
                    RecRef.SetTable(Member);
                    ApprovalEntryArgument."Document No." := Member."No.";
                end;
            Database::"Moratorium Loan":
                begin
                    RecRef.SetTable(MoratoriumLoan);
                    ApprovalEntryArgument."Document No." := MoratoriumLoan."M-Num";
                end;


            Database::"Loan Rescheduling":
                begin
                    RecRef.SetTable(Loanrescheduling);
                    ApprovalEntryArgument."Document No." := Loanrescheduling."No.";
                end;
            Database::"Share Capital Transfer Buffer":
                begin
                    RecRef.SetTable(Sharetransfer);
                    ApprovalEntryArgument."Document No." := sharetransfer."Document No";
                end;
            Database::Loans:
                begin
                    RecRef.SetTable(LoanApp);
                    ApprovalEntryArgument."Document No." := LoanApp."Loan No.";
                end;
            Database::"Membership closure":
                begin
                    RecRef.SetTable(Mclosure);
                    ApprovalEntryArgument."Document No." := Mclosure."No.";
                end;
            Database::"Banking Account Closure":
                begin
                    RecRef.SetTable(BankAccClossure);
                    ApprovalEntryArgument."Document No." := BankAccClossure.No;
                end;
            Database::"Cashier Transactions":
                begin
                    RecRef.SetTable(CashierTransactions);
                    ApprovalEntryArgument."Document No." := CashierTransactions.No;
                end;
            Database::"Fixed Deposit Contract":
                begin
                    RecRef.SetTable(FixedDepositContract);
                    ApprovalEntryArgument."Document No." := FixedDepositContract."No.";
                end;
            Database::"HR Employees":
                begin
                    RecRef.SetTable(HrEmployee);
                    ApprovalEntryArgument."Document No." := HrEmployee."No.";
                end;
            Database::"SinkFund Report Information":
                begin
                    RecRef.SetTable(sinkfund);
                    ApprovalEntryArgument."Document No." := sinkfund.No;
                end;
            Database::"Hr Jobs":
                begin
                    RecRef.SetTable(Jobs);
                    ApprovalEntryArgument."Document No." := Jobs."Job ID";
                end;
            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(EmpRequisitions);
                    ApprovalEntryArgument."Document No." := EmpRequisitions."Job ID";
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ApprovalEntryArgument."Document No." := ImprestRequisition."No.";
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ApprovalEntryArgument."Document No." := ImprestSurrender.No;
                end;
            Database::"HR Disciplinary Cases NCA":
                begin
                    RecRef.SetTable(Disciplinary);
                    ApprovalEntryArgument."Document No." := Disciplinary."Case Number";
                end;
            Database::"HRDisciplinary Case Withdrawal":
                begin
                    RecRef.SetTable(disciplinarywithdrawal);
                    ApprovalEntryArgument."Document No." := disciplinarywithdrawal."No.";
                end;
            Database::"HRDisciplinary Appeal":
                begin
                    RecRef.SetTable(DiscAppeal);
                    ApprovalEntryArgument."Document No." := DiscAppeal."No.";
                end;
            Database::"HR Training App Header":
                begin
                    RecRef.SetTable(TraiApp);
                    ApprovalEntryArgument."Document No." := TraiApp."Application No";
                end;
            Database::"HR Training Needs":
                begin
                    RecRef.SetTable(trainneeds);
                    ApprovalEntryArgument."Document No." := trainneeds.Code;
                end;
            Database::"HR Training Feedback Form":
                begin
                    RecRef.SetTable(feedback);
                    ApprovalEntryArgument."Document No." := feedback."Document No";
                end;



            Database::"HR Leave Journal Line":
                begin
                    RecRef.SetTable(HRLeaveJournalLine);
                    ApprovalEntryArgument."Document No." := HRLeaveJournalLine."Journal Batch Name";
                end;

            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    ApprovalEntryArgument."Document No." := Leave."Application Code";
                end;
            Database::"Salary Header":
                begin
                    RecRef.SetTable(Salary);
                    ApprovalEntryArgument."Document No." := Salary.No;
                end;

            Database::"Permission Requisition":
                begin
                    RecRef.SetTable(PermissionReq);
                    ApprovalEntryArgument."Document No." := PermissionReq.No;
                end;


        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: boolean)
    var

        MemberApp: Record "Member Application";
        SecuritiesReg: Record "Securities Register";
        LoansApp: Record Loans;
        MClosure: Record "Membership closure";
        DependancyApplications: Record "Dependancies Applications";
        BankAccClossure: Record "Banking Account Closure";
        CashierTransactions: Record "Cashier Transactions";
        Sharetransfer: Record "Share Capital Transfer Buffer";
        Loanrescheduling: Record "Loan Rescheduling";
        MoratoriumLoan: Record "Moratorium Loan";
        BSLoansAccApp: Record "B/S Loan Account Application";
        SystemEdits: Record "System Edits";
        LoanCheckoff: Record "Checkoff Header";
        ACTransfer: Record "Account Transfer Header";
        TCashier: Record "Treasury Cashier Transactions";
        IntHead: Record "Savings Interest Header";
        EndInt: Record "End Year Transfer Header";
        HrJob: Record "HR Jobs";
        HREMP: Record "HR Employees";
        PettyCash: Record "Payments Header";
        IMPHEADER: Record "Imprest Header";
        STO: Record "Standing Order Header";
        SalHead: Record "Salary Header";
        OneMonthInstallments: Record "One Month Installment";
        BusinessLoanClossure: Record "Business Loan Clossure";
        VehicleMovement: Record "Vehicle Movement";
        ChqBk: Record "Cheque Book Application";
        CQRecpt: Record "Cheque Receipts";
        BnkCQ: Record "Bankers Cheque Application";
        ATMAPP: Record "ATM Applications";
        ATMLNK: Record "ATM Linking Applications";
        IMPSURRHEADER: Record "Imprest Surrender Header";
        OD: Record "Over Draft Authorisation";
        FDC: Record "Fixed Deposit Contract";
        SystemReversal: Record "System Reversal";
        UserCreation: Record "User Creation Requests";
        UserTermination: Record "User Termination";
        ProductFactory: Record "Product Factory";
        sinkfund: Record "SinkFund Report Information";
        VehicleRequest: Record "Motor Vehicle Request";
        //ConferenceAndMeetingRooms: Record "Conference & Meeting Rooms-T";
        DMUCaseForwarding: Record "DMU Case Forwarding";
        ElectoralZone: Record "Electoral Zones";
        DispatchATM: Record "Dispatch ATM Header";
        RefundTransfer: Record "Refund,Account Transfer Header";
        Legal: Record Legal;
        VariationsRec: Record "Product Variations";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        AGMDelegatesPayment: Record "AGM Delegates Payment";
        StaffWelfare: Record "Staff Welfare";
        InterestHeader: Record "Interest Header";
        Customer: Record Customer;
        SecurityPerfection: Record "Security Perfection";
        Application: Record "Hr Job Applications";
        EmpRequisitions: record "HR Employee Requisitions";
        Overtime: Record "Overtime Claim Header";
        InvHeader: Record "Investment Header";
        //Application:Record "Hr Job Applications";
        //Overtime: Record "Overtime Claim Header";
        ParkingSpace: Record "Parking Space";
        InvestInterestHeader: Record "Investment Interest Header";
        StaffClaim: Record "Staff Claims Header";
        disciplinary: record "HR Disciplinary Cases NCA";
        FOSAPV: Record "Fosa Payments Header";
        MemberWithdrawalNotice: Record "Member withdrawal Notice";
        DelegateOfficials: Record "Delegate Officials";
        Minutes: Record "Delegates Minutes Header";
        DelegatesPayment: Record "Delegates Payment";
        disciplinarywithdrawal: record "HRDisciplinary Case Withdrawal";
        DiscAppeal: Record "HRDisciplinary Appeal";
        TraiApp: Record "HR Training App Header";
        trainneeds: record "HR Training Needs";
        feedback: record "HR Training Feedback Form";
        SecurityDischarge: Record "Security Discharge";
        Vendor: Record Vendor;
        CompanyVehicles: Record "Company Vehicles";
        BoardMemberPay: Record "Board members";
        HRLeaveJournalLine: Record "HR Leave Journal Line";
        Leave: Record "HR Leave Application";
        HRDrivers: Record "HR Drivers";
        PropertyDetails: Record "Property Details";
        Lease: Record Lease;
        Surety: Record "Surety Management";
        ParkingCreation: Record "Parking List Table";
        ConferenceCreation: Record "Conf & Meeting Rooms List";
        ConferenceBooking: Record "Conference & Meeting Rooms-T";
        SMSAlerts: Record "SMS Alerts Header";
        Contracts: Record Contracts;
        Accidents: Record "HR OSAccident";
        Fuel: Record "HR Fuel Management Header";
        Appeals: Record "Appeals Table";
        KeyCreation: Record "Office Keys List";
        KeyRequest: Record "Key Request Table";
        TrTrans: Record "Treasury Cashier Transactions";
        BnkChq: Record "Bankers Cheque Application";
        RTGS: Record "RTGS Transfer Header";
        ATMLink: Record "ATM Linking Applications";
        PermissionReq: Record "Permission Requisition";
        SAccountAppl: Record "Savings Account Application";
        HrcompanyActivity: Record "HR Company Activities";
        HrAppraisal: Record "HR Appraisal Header";
        NomineeRequest: Record "Nominee Form Request";
        GuarantorsSubstitution: Record "Guarantors Substitution";
        LoanBatch: Record "Loan Disbursement Header";
        GeneralSetup: Record "General Set-Up";
        RegistrationProcess: Codeunit "Registration Process";
        HrTPlanning: record "HR Training Planner";
        HrExitInterview: Record "HR Employee Exit Interviews";
        InterBankTr: Record "InterBank Transfers";
        StoreReq: Record "Store Requistion Header";
        Divprovision: Record "Dividends Provision Header";
        AssetTra: Record "Asset Transfer";
        AccountAct: Record "Account Activation";
        ContractReq: Record "Contract Request";
        HrOverTime: Record "HR Overtime Header";
        Workflowusergroup: Record "Workflow User Group Member";
        CollectionReg: Record "Securities Collection Register";
        TreasuryApp: Record "Treasury Cheque Application";
        InsuaranceClaims: record "Insurance Claims";
        AssetInsuarance: Record Insurance;
        VehicleRepar: Record "Maintain Machne/Vehicles";
        VehicleServic: Record "Vehicle Servicing Table";
        Stockkeeping: Record "Stock Keeping";
        wellfareAdvance: record "Welfare Advance";
        ClearanceForm: Record "Clearance Form";
        DependancyAppCard: page "Dependancies Applications Card";
        BOSAAccActive: Record "BOSA Account Activation";
        BatchingProcess: Record "Batching Process Table";
        VehicleMovement1: Record "Vehicle Movement";
        GeneralSMSHeader: Record "General SMS Header";
        MKey: Record "MKey Forwarding";
        RevenueCollection: Record "Revenue Collection";
        FAReclassificationJournal: Record "FA Reclass. Journal Line";
        VoteTransfer: Record "Vote Transfer";
        BankDeposit: Record "Bank Deposit Header";
        GroupUpdate: Record "Group Member Exit & Update";

    begin
        case RecRef.Number of
            Database::"Group Member Exit & Update":
                begin
                    RecRef.SetTable(GroupUpdate);
                    GroupUpdate.Validate(Status, GroupUpdate.Status::Approved);
                    GroupUpdate.Modify(True);
                    Handled := True;
                end;
            Database::"Bank Deposit Header":
                begin
                    RecRef.SetTable(BankDeposit);
                    BankDeposit.Validate(Status, BankDeposit.Status::Approved);
                    BankDeposit.modify(true);
                    Handled := true;
                end;
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(VoteTransfer);
                    VoteTransfer.Validate(Status, VoteTransfer.Status::Approved);
                    VoteTransfer.modify(true);
                    Handled := true;
                end;
            Database::"FA Reclass. Journal Line":
                begin
                    RecRef.SetTable(FAReclassificationJournal);
                    FAReclassificationJournal.Validate(Status, FAReclassificationJournal.Status::Approved);
                    FAReclassificationJournal.modify(true);
                    Handled := true;
                end;
            Database::"Revenue Collection":
                begin
                    RecRef.SetTable(RevenueCollection);
                    RevenueCollection.Validate(Status, RevenueCollection.Status::Approved);
                    RevenueCollection.modify(true);
                    Handled := true;
                end;
            Database::"MKey Forwarding":
                begin
                    RecRef.SetTable(MKey);
                    MKey.Validate(Status, MKey.Status::Approved);
                    MKey.modify(true);
                    Handled := true;
                end;
            Database::"General SMS Header":
                begin
                    RecRef.SetTable(GeneralSMSHeader);
                    GeneralSMSHeader.Validate(Status, GeneralSMSHeader.Status::Approved);
                    GeneralSMSHeader.modify(true);
                    Handled := true;
                end;

            Database::"Batching Process Table":
                begin
                    RecRef.SetTable(BatchingProcess);
                    BatchingProcess.Validate(Status, BatchingProcess.Status::Approved);
                    BatchingProcess.modify(true);
                    Handled := true;
                end;
            Database::"Clearance Form":
                begin
                    RecRef.SetTable(ClearanceForm);
                    ClearanceForm.Validate(Status, ClearanceForm.Status::Approved);
                    ClearanceForm.modify(true);
                    Handled := true;
                end;
            Database::"Welfare Advance":
                begin
                    RecRef.SetTable(wellfareAdvance);
                    wellfareAdvance.Validate(Status, wellfareAdvance.Status::Approved);
                    wellfareAdvance.modify(true);
                    Handled := true;
                end;
            Database::"Stock Keeping":
                begin
                    RecRef.SetTable(Stockkeeping);
                    Stockkeeping.Validate(Status, Stockkeeping.Status::Approved);
                    Stockkeeping.modify(true);
                    Handled := true;
                end;
            Database::"Vehicle Servicing Table":
                begin
                    RecRef.SetTable(VehicleServic);
                    VehicleServic.Validate(Status, VehicleServic.Status::Approved);
                    VehicleServic.modify(true);
                    Handled := true;
                end;
            Database::"Maintain Machne/Vehicles":
                begin
                    RecRef.SetTable(VehicleRepar);
                    VehicleRepar.Validate(Status, VehicleRepar.Status::Approved);
                    VehicleRepar.modify(true);
                    Handled := true;
                end;
            Database::Insurance:
                begin
                    RecRef.SetTable(AssetInsuarance);
                    AssetInsuarance.Validate(Status, AssetInsuarance.Status::Approved);
                    AssetInsuarance.modify(true);
                    Handled := true;
                end;
            Database::"Insurance Claims":
                begin
                    RecRef.SetTable(InsuaranceClaims);
                    InsuaranceClaims.Validate(Status, InsuaranceClaims.Status::Approved);
                    InsuaranceClaims.modify(true);
                    Handled := true;
                end;
            Database::"Treasury Cheque Application":
                begin
                    RecRef.SetTable(TreasuryApp);
                    TreasuryApp.Validate(Status, TreasuryApp.Status::Approved);
                    TreasuryApp.modify(true);
                    Handled := true;
                end;
            Database::"BOSA Account Activation":
                begin
                    RecRef.SetTable(BOSAAccActive);
                    BOSAAccActive.Validate(Status, BOSAAccActive.Status::Approved);
                    BOSAAccActive.modify(true);
                    Handled := true;
                end;
            Database::"Securities Collection Register":
                begin
                    RecRef.SetTable(CollectionReg);
                    CollectionReg.Validate(Status, CollectionReg.Status::Approved);
                    CollectionReg.modify(true);
                    Handled := true;
                end;
            Database::"HR Overtime Header":
                begin
                    RecRef.SetTable(HrOverTime);
                    HrOverTime.Validate(Status, HrOverTime.Status::Approved);
                    HrOverTime.modify(true);
                    Handled := true;
                end;
            Database::"Contract Request":
                begin
                    RecRef.SetTable(ContractReq);
                    ContractReq.Validate(Status, ContractReq.Status::Approved);
                    ContractReq.modify(true);
                    Handled := true;
                end;
            Database::"Account activation":
                begin
                    RecRef.SetTable(AccountAct);
                    AccountAct.Validate(Status, AccountAct.Status::Approved);
                    AccountAct.modify(true);
                    Handled := true;
                end;
            Database::"ATM Linking Applications":
                begin
                    RecRef.SetTable(ATMLink);
                    ATMLink.Validate(Status, ATMLink.Status::Approved);
                    ATMLink.modify(true);
                    Handled := true;
                end;
            Database::"Asset Transfer":
                begin
                    RecRef.SetTable(AssetTra);
                    AssetTra.Validate(Status, AssetTra.Status::Approved);
                    AssetTra.modify(true);
                    Handled := true;
                    AssetTra.validate(Status);
                end;
            Database::"Dividends Provision Header":
                begin
                    RecRef.SetTable(Divprovision);
                    Divprovision.Validate(Status, Divprovision.Status::Approved);
                    Divprovision.modify(true);
                    Handled := true;
                end;
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreReq);
                    StoreReq.Validate(Status, StoreReq.Status::Released);
                    StoreReq.modify(true);
                    Handled := true;
                end;
            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTr);
                    InterBankTr.Validate(Status, InterBankTr.Status::Approved);
                    InterBankTr."Approved By" := UserId;
                    InterBankTr.modify(true);
                    Handled := true;
                end;
            Database::"HR Employee Exit Interviews":
                begin
                    RecRef.SetTable(HrExitInterview);
                    HrExitInterview.Validate(Status, HrExitInterview.Status::Approved);
                    HrExitInterview.modify(true);
                    Handled := true;
                end;
            Database::"HR Training Planner":
                begin
                    RecRef.SetTable(HrTPlanning);
                    HrTPlanning.Validate(Status, HrTPlanning.Status::Approved);
                    HrTPlanning.modify(true);
                    Handled := true;
                end;
            Database::"Loan Disbursement Header":
                begin
                    RecRef.SetTable(LoanBatch);
                    LoanBatch.Validate(Status, LoanBatch.Status::Approved);
                    LoanBatch.modify(true);
                    Handled := true;
                end;
            Database::"Guarantors Substitution":
                begin
                    RecRef.SetTable(GuarantorsSubstitution);
                    GuarantorsSubstitution.Validate(Status, GuarantorsSubstitution.Status::Approved);
                    GuarantorsSubstitution."Approved By" := UserId;
                    GuarantorsSubstitution."Approved Date" := CurrentDateTime;
                    GuarantorsSubstitution.modify(true);
                    Handled := true;
                end;
            Database::"Nominee Form Request":

                begin
                    RecRef.SetTable(NomineeRequest);
                    NomineeRequest.Validate(Status, NomineeRequest.Status::Approved);
                    NomineeRequest.modify(true);
                    Handled := true;
                end;
            Database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(HrAppraisal);
                    HrAppraisal.Validate(Status, HrAppraisal.Status::Approved);
                    HrAppraisal.modify(true);
                    Handled := true;
                end;
            Database::"HR Company Activities":
                begin
                    RecRef.SetTable(HrcompanyActivity);
                    HrcompanyActivity.Validate(Status, HrcompanyActivity.Status::Approved);
                    HrcompanyActivity.modify(true);
                    Handled := true;
                end;
            Database::"Savings Account Application":
                begin
                    RecRef.SetTable(SAccountAppl);
                    SAccountAppl.Validate(Status, SAccountAppl.Status::Approved);
                    SAccountAppl.modify(true);
                    Handled := true;
                end;
            Database::"Securities Register":
                begin
                    RecRef.SetTable(SecuritiesReg);
                    SecuritiesReg.Validate(Status, SecuritiesReg.Status::Approved);
                    SecuritiesReg.modify(true);
                    Handled := true;
                end;
            Database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMAPP);
                    ATMAPP.Validate(Status, ATMAPP.Status::Approved);
                    ATMAPP.modify(true);
                    Handled := true;
                end;
            Database::"RTGS Transfer Header":
                begin
                    RecRef.SetTable(RTGS);
                    RTGS.Validate(Status, RTGS.Status::Approved);
                    RTGS.modify(true);
                    Handled := true;
                end;
            Database::"Standing Order Header":
                begin
                    RecRef.SetTable(STO);
                    STO.Validate(Status, STO.Status::Approved);
                    STO.modify(true);
                    Handled := true;
                end;
            Database::"Bankers Cheque Application":
                begin
                    RecRef.SetTable(BnkChq);
                    BnkChq.Validate(Status, BnkChq.Status::Approved);
                    BnkChq.modify(true);
                    Handled := true;
                end;
            // Database::"Treasury Cashier Transactions":
            //     begin
            //         RecRef.SetTable(TrTrans);
            //         TrTrans.Validate(Status, TrTrans.Status::Approved);
            //         TrTrans.modify(true);
            //         Handled := true;
            //     end;
            Database::"Key Request Table":
                begin
                    RecRef.SetTable(KeyRequest);
                    KeyRequest.Validate(Status, KeyRequest.Status::Approved);
                    KeyRequest.modify(true);
                    Handled := true;
                end;
            Database::"Office Keys List":
                begin
                    RecRef.SetTable(KeyCreation);
                    KeyCreation.Validate(Status, KeyCreation.Status::Approved);
                    KeyCreation.modify(true);
                    Handled := true;
                end;
            Database::"Appeals Table":
                begin
                    RecRef.SetTable(Appeals);
                    Appeals.Validate(Status, Appeals.Status::Approved);
                    Appeals.modify(true);
                    Handled := true;
                end;
            Database::"HR Fuel Management Header":
                begin
                    RecRef.SetTable(Fuel);
                    Fuel.Validate(Status, Fuel.Status::Approved);
                    Fuel.modify(true);
                    Handled := true;
                end;
            Database::"HR OSAccident":
                begin
                    RecRef.SetTable(Accidents);
                    Accidents.Validate(Status, Accidents.Status::Approved);
                    Accidents.modify(true);
                    Handled := true;
                end;
            database::Contracts:
                begin
                    RecRef.settable(Contracts);
                    Contracts.Validate(Status, Contracts.Status::Approved);
                    Contracts.modify(true);
                    Handled := true;
                end;
            database::"SMS Alerts Header":
                begin
                    RecRef.settable(SMSAlerts);
                    SMSAlerts.Validate(Status, SMSAlerts.Status::Approved);
                    SMSAlerts.modify(true);
                    Handled := true;
                end;
            database::"Conference & Meeting Rooms-T":
                begin
                    RecRef.settable(ConferenceBooking);
                    ConferenceBooking.Validate(Status, ConferenceBooking.Status::Approved);
                    ConferenceBooking.modify(true);
                    Handled := true;
                    // ConferenceBooking.InsertToBookingPlanner(ConferenceBooking);
                    //ConferenceBooking.GetBookingDetailsForCalendar(ConferenceBooking);
                end;
            database::"Conf & Meeting Rooms List":
                begin
                    RecRef.settable(ConferenceCreation);
                    ConferenceCreation.Validate(Status, ConferenceCreation.Status::Approved);
                    ConferenceCreation.modify(true);
                    Handled := true;
                end;
            database::"Parking List Table":
                begin
                    RecRef.settable(ParkingCreation);
                    ParkingCreation.Validate(Status, ParkingCreation.Status::Approved);
                    ParkingCreation.modify(true);
                    Handled := true;
                end;
            database::"Surety Management":
                begin
                    RecRef.settable(Surety);
                    Surety.Validate(Status, Surety.Status::Approved);
                    Surety.modify(true);
                    Handled := true;
                end;
            database::Lease:
                begin
                    RecRef.SetTable(Lease);
                    Lease.Validate(Status, Lease.Status::Approved);
                    Lease.modify(true);
                    Handled := true;
                end;

            database::"Property Details":
                begin
                    RecRef.SetTable(PropertyDetails);
                    PropertyDetails.Validate(Status, PropertyDetails.Status::Approved);
                    PropertyDetails.modify(true);
                    Handled := true;
                end;
            database::"HR Drivers":
                begin
                    RecRef.SetTable(HRDrivers);
                    HRDrivers.Validate(Status, HRDrivers.Status::Approved);
                    HRDrivers.modify(true);
                    Handled := true;
                end;
            database::"Company Vehicles":
                begin
                    RecRef.SetTable(CompanyVehicles);
                    CompanyVehicles.Validate(Status, CompanyVehicles.Status::Approved);
                    CompanyVehicles.modify(true);
                    Handled := true;
                end;
            Database::Vendor:
                begin
                    RecRef.SetTable(Vendor);
                    Vendor.Validate(Status, Vendor.Status::Approved);
                    Vendor.modify(true);
                    Handled := true;
                end;
            Database::"Board members":
                begin
                    RecRef.SetTable(BoardMemberPay);
                    BoardMemberPay.Validate(Status, BoardMemberPay.Status::Approved);
                    BoardMemberPay.modify(true);
                    Handled := true;
                end;
            database::"Delegates Payment":
                begin
                    recref.settable(DelegatesPayment);
                    DelegatesPayment.validate(status, DelegatesPayment.Status::Approved);
                    DelegatesPayment.modify(true);
                    Handled := true;
                end;

            database::"Delegates Minutes Header":
                begin
                    recref.settable(Minutes);
                    Minutes.validate(status, Minutes.Status::Approved);
                    Minutes.modify(true);
                    Handled := true;
                end;
            database::"Delegate Officials":
                begin
                    recref.settable(DelegateOfficials);
                    DelegateOfficials.validate(status, DelegateOfficials.Status::Approved);
                    DelegateOfficials.modify(true);
                    Handled := true;
                end;
            database::"Product Variations":
                begin
                    recref.settable(VariationsRec);
                    VariationsRec.validate(status, VariationsRec.Status::Approved);
                    VariationsRec.modify(true);
                    Handled := true;
                end;
            database::"Security Discharge":
                begin
                    recref.settable(SecurityDischarge);
                    SecurityDischarge.validate(status, SecurityDischarge.Status::Approved);
                    SecurityDischarge.modify(true);
                    Handled := true;
                end;
            //database::"Member withdrawal Notice":

            database::"Member withdrawal Notice":

                begin
                    recref.settable(MemberWithdrawalNotice);
                    MemberWithdrawalNotice.validate(status, MemberWithdrawalNotice.Status::Approved);
                    MemberWithdrawalNotice.modify(true);
                    Handled := true;
                end;
            database::"Investment Header":
                begin
                    recref.settable(InvHeader);
                    InvHeader.validate(status, InvHeader.Status::Approved);
                    InvHeader.modify(true);
                    Handled := true;
                end;
            database::"Investment Interest Header":
                begin
                    recref.settable(InvestInterestHeader);
                    InvestInterestHeader.validate(status, InvestInterestHeader.Status::Approved);
                    InvestInterestHeader.modify(true);
                    Handled := true;
                end;
            database::"Parking Space":
                begin
                    recref.settable(ParkingSpace);
                    ParkingSpace.validate(status, ParkingSpace.Status::Approved);
                    ParkingSpace.modify(true);
                    Handled := true;
                end;
            database::"Fosa Payments Header":
                begin
                    recref.settable(FOSAPV);
                    FOSAPV.validate(status, FOSAPV.Status::Approved);
                    FOSAPV.modify(true);
                    Handled := true;
                end;
            database::"Security Perfection":
                begin
                    RecRef.SetTable(SecurityPerfection);
                    SecurityPerfection.Validate(Status, SecurityPerfection.Status::Approved);
                    SecurityPerfection.modify(true);
                    Handled := true;
                end;
            database::Customer:
                begin
                    recref.settable(Customer);
                    Customer.validate(status, Customer.Status::Approved);
                    Customer.modify(true);
                    Handled := true;
                end;
            database::"Hr Job Applications":
                begin
                    recref.settable(Application);
                    Application.validate(status, Application.Status::Approved);
                    Application.modify(true);
                    Handled := true;
                end;
            database::"Interest Header":
                begin
                    recref.settable(InterestHeader);
                    InterestHeader.validate(status, InterestHeader.Status::Approved);
                    InterestHeader.modify(true);
                    Handled := true;
                end;
            database::"Loan Recovery Header":
                begin
                    recref.settable(LoanRecoveryHeader);
                    LoanRecoveryHeader.validate(status, LoanRecoveryHeader.Status::Approved);
                    LoanRecoveryHeader.modify(true);
                    Handled := true;
                end;
            database::"Loan Recovery Header II":
                begin
                    recref.settable(LoanRecoveryHeaderII);
                    LoanRecoveryHeaderII.validate(status, LoanRecoveryHeaderII.Status::Approved);
                    LoanRecoveryHeaderII.modify(true);
                    Handled := true;
                end;
            database::Legal:
                begin
                    recref.settable(Legal);
                    Legal.validate(status, Legal.Status::Approved);
                    Legal.modify(true);
                    Handled := true;
                end;
            database::"Overtime Claim Header":
                begin
                    recref.settable(Overtime);
                    Overtime.validate(status, Overtime.Status::Approved);
                    Overtime.modify(true);
                    Handled := true;
                end;
            database::"Staff Welfare":
                begin
                    recref.settable(StaffWelfare);
                    StaffWelfare.validate(status, StaffWelfare.Status::Approved);
                    StaffWelfare.modify(true);
                    Handled := true;
                end;

            database::"Dispatch ATM Header":
                begin
                    recref.settable(DispatchATM);
                    DispatchATM.validate(status, DispatchATM.Status::Approved);
                    DispatchATM.modify(true);

                    Handled := true;
                end;


            Database::"AGM Delegates Payment":
                begin
                    RecRef.SetTable(AGMDelegatesPayment);
                    AGMDelegatesPayment.Validate(Status, AGMDelegatesPayment.Status::Approved);
                    AGMDelegatesPayment.modify(true);
                    Handled := true;
                end;


            database::"System Reversal":
                begin
                    RecRef.SetTable(SystemReversal);
                    SystemReversal.Validate(Status, SystemReversal.status::Approved);
                    SystemReversal."Approved by User ID" := UserId;
                    SystemReversal."Approved date" := Today;
                    SystemReversal.modify(true);
                    Handled := true;
                end;
            database::"Refund,Account Transfer Header":
                begin
                    RecRef.SetTable(RefundTransfer);
                    RefundTransfer.Validate(Status, RefundTransfer.status::Approved);
                    RefundTransfer.modify(true);
                    Handled := true;
                end;
            database::"Electoral Zones":
                begin
                    RecRef.SetTable(ElectoralZone);
                    ElectoralZone.Validate(Status, ElectoralZone.status::Approved);
                    ElectoralZone.modify(true);
                    Handled := true;
                end;
            database::"Product Factory":
                begin
                    RecRef.SetTable(ProductFactory);
                    ProductFactory.Validate(Status, ProductFactory.status::Active);
                    ProductFactory."Approved By" := USERID;
                    ProductFactory.modify(true);
                    Handled := true;
                end;
            database::"User Creation Requests":
                begin
                    RecRef.SetTable(UserCreation);
                    UserCreation.Validate(Status, UserCreation.status::Approved);
                    UserCreation.modify(true);
                    Handled := true;
                end;
            database::"User Termination":
                begin
                    RecRef.SetTable(UserTermination);
                    UserTermination.Validate(Status, UserTermination.status::Approved);
                    UserTermination.modify(true);
                    Handled := true;
                end;


            database::"SinkFund Report Information":
                begin
                    recref.settable(sinkfund);
                    sinkfund.validate(status, sinkfund.Status::Approved);
                    sinkfund.modify(true);
                    Handled := true;
                end;

            // database::"Company Vehicles":
            //     begin
            //         RecRef.SetTable(CompanyVehicles);
            //         CompanyVehicles.Validate(Status, CompanyVehicles.status::Approved);
            //         CompanyVehicles.modify(true);
            //         Handled := true;
            //     end;
            database::"Vehicle Movement":
                begin
                    RecRef.SetTable(VehicleMovement);
                    VehicleMovement.Validate(Status, VehicleMovement.status::Approved);
                    VehicleMovement."Movement Status" := VehicleMovement."Movement Status"::"In-Progress";
                    VehicleMovement.modify(true);
                    Handled := true;
                    //VehicleMovement1.AssignDriversAndVehiclesToMovement(VehicleMovement);
                end;
            // database::"Conference & Meeting Rooms-T":
            //     begin
            //         RecRef.SetTable(ConferenceAndMeetingRooms);
            //         ConferenceAndMeetingRooms.Validate(Status, ConferenceAndMeetingRooms.status::Approved);
            //         ConferenceAndMeetingRooms.modify(true);
            //         Handled := true;
            //     end;
            database::"Motor Vehicle Request":
                begin
                    recref.settable(VehicleRequest);
                    VehicleRequest.Validate(Status, VehicleRequest.Status::Approved);
                    VehicleRequest.modify(true);
                    Handled := true;
                    VehicleRequest.AssignDriversAndVehiclesToMovement(VehicleRequest);
                end;


            database::"Business Loan Clossure":
                begin
                    RecRef.SetTable(BusinessLoanClossure);
                    BusinessLoanClossure.Validate(Status, BusinessLoanClossure.status::Approved);
                    BusinessLoanClossure.modify(true);
                    Handled := true;
                end;
            database::"One Month Installment":
                begin
                    RecRef.SetTable(OneMonthInstallments);
                    OneMonthInstallments.Validate(Status, OneMonthInstallments.status::Approved);
                    OneMonthInstallments.modify(true);
                    Handled := true;
                end;
            database::"Dependancies Applications":
                begin
                    RecRef.SetTable(DependancyApplications);
                    DependancyApplications.Validate(Status, DependancyApplications.status::Approved);
                    Handled := true;

                    GeneralSetup.get();
                    if GeneralSetup."AutoCompletion on approval" = true then begin
                        DependancyApplications.TestField(Created, false);
                        DependancyAppCard.PostNextofKIN(DependancyApplications);
                        DependancyApplications.Created := true;
                        Message('Updated successfully');
                    end;
                    DependancyApplications.modify(true);
                end;
            database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(IMPSURRHEADER);
                    IMPSURRHEADER.Validate(Status, IMPSURRHEADER.status::Approved);
                    IMPSURRHEADER.modify(true);
                    Handled := true;
                end;
            database::"System Edits":
                begin
                    RecRef.SetTable(SystemEdits);
                    SystemEdits.Validate(Status, SystemEdits.status::Approved);
                    SystemEdits.modify(true);
                    Handled := true;
                end;
            database::"Imprest Header":
                begin
                    RecRef.SetTable(IMPHeader);
                    IMPHeader.Validate(Status, IMPHeader.status::Approved);
                    IMPHeader."Approved By" := UserId;
                    IMPHeader.modify(true);

                    Handled := true;
                end;
            database::"Payments Header":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.status::Approved);
                    PettyCash."Approved By" := UserId;
                    PettyCash.modify(true);
                    Handled := true;
                end;
            database::"HR Employees":
                begin
                    RecRef.SetTable(HREMP);
                    HREMP.Validate(Status, HREMP.status::Active);
                    HREMP.modify(true);
                    Handled := true;
                end;
            database::"HR Jobs":
                begin
                    RecRef.SetTable(HrJob);
                    HrJob.Validate(Status, HrJob.status::Approved);
                    HrJob.modify(true);
                    Handled := true;
                end;
            database::"Account Transfer Header":
                begin
                    RecRef.SetTable(ACTransfer);
                    ACTransfer.Validate(Status, ACTransfer.status::Approved);
                    ACTransfer.modify(true);
                    Handled := true;
                end;
            database::"Checkoff Header":
                begin
                    RecRef.SetTable(LoanCheckoff);
                    LoanCheckoff.Validate(Status, LoanCheckoff.status::Approved);
                    LoanCheckoff.modify(true);
                    Handled := true;
                end;
            Database::"Company Vehicles":
                begin
                    RecRef.SetTable(VehicleRequest);
                    VehicleRequest.Validate(Status, VehicleRequest.status::Approved);
                    VehicleRequest.modify(true);
                    Handled := true;

                end;
            database::"B/S Loan Account Application":
                begin
                    RecRef.SetTable(BSLoansAccApp);
                    BSLoansAccApp.Validate(Status, BSLoansAccApp.status::Approved);
                    BSLoansAccApp.modify(true);
                    Handled := true;
                end;
            database::"Member Application":
                begin
                    // Workflowusergroup.reset;
                    // Workflowusergroup.SetRange("User Name",);
                    // if workflowusergroup.FindFirst() then
                    // error('You cannot approve a record you initiated');

                    RecRef.SetTable(MemberApp);
                    MemberApp.Validate(Status, MemberApp.status::Approved);
                    MemberApp.modify(true);
                    Handled := true;
                    GeneralSetup.get();
                    if GeneralSetup."AutoCompletion on approval" = true then
                        RegistrationProcess.MemberRegistration(MemberApp, true);


                end;
            Database::"Moratorium Loan":
                begin
                    RecRef.SetTable(MoratoriumLoan);
                    MoratoriumLoan.Validate(Status, MoratoriumLoan.status::Approved);
                    MoratoriumLoan."Approved By" := UserId;
                    MoratoriumLoan.modify(true);
                    Handled := true;
                end;


            database::"Loan Rescheduling":
                begin
                    RecRef.SetTable(Loanrescheduling);
                    Loanrescheduling.Validate(Status, Loanrescheduling.status::Approved);
                    Loanrescheduling."Approved By" := UserId;
                    Loanrescheduling.modify(true);
                    Handled := true;
                end;


            database::"Share Capital Transfer Buffer":
                begin
                    RecRef.SetTable(sharetransfer);
                    Sharetransfer.Validate(Status, Sharetransfer.status::Approved);
                    sharetransfer.modify(true);
                    Handled := true;
                end;

            database::loans:
                begin
                    RecRef.SetTable(LoansApp);
                    if LoansApp."Override Loan Qualification" = true then begin
                        if not confirm('This is an exceptional Loan, do you wish to approve? More information on the comment section.') then
                            exit;
                    end;
                    LoansApp.Validate(Status, LoansApp.status::Approved);
                    if LoansApp."Commercial Buyoff" = true then
                        Message('You are approving a Commercial Loan');

                    LoansApp."Approved By" := UserId;
                    LoansApp."Approval Date" := Today;
                    LoansApp.modify(true);

                    Handled := true;
                end;
            database::"Membership closure":
                begin
                    RecRef.SetTable(MClosure);
                    MClosure.Validate(Status, MClosure.status::Approved);
                    MClosure.modify(true);
                    Handled := true;
                end;
            database::"Banking Account Closure":
                begin
                    RecRef.SetTable(BankAccClossure);
                    BankAccClossure.Validate(Status, BankAccClossure.status::Approved);
                    BankAccClossure.modify(true);
                    Handled := true;
                end;
            database::"Cashier Transactions":
                begin
                    RecRef.SetTable(CashierTransactions);
                    CashierTransactions.Validate(Status, CashierTransactions.status::Approved);
                    CashierTransactions.modify(true);
                    Handled := true;
                end;
            database::"Treasury Cashier Transactions":
                begin
                    RecRef.SetTable(TCashier);
                    TCashier.Validate(Status, TCashier.status::Approved);
                    TCashier.modify(true);
                    Handled := true;
                end;
            database::"Savings Interest Header":
                begin
                    RecRef.SetTable(IntHead);
                    IntHead.Validate(Status, IntHead.status::Approved);
                    IntHead.modify(true);
                    Handled := true;
                end;
            database::"End Year Transfer Header":
                begin
                    RecRef.SetTable(EndInt);
                    EndInt.Validate(Status, EndInt.status::Approved);
                    EndInt.modify(true);
                    Handled := true;
                end;
            database::"Standing Order Header":
                begin
                    RecRef.SetTable(STO);
                    STO.Validate(Status, STO.status::Approved);
                    STO.modify(true);
                    Handled := true;
                end;
            database::"Salary Header":
                begin
                    RecRef.SetTable(SalHead);
                    SalHead.Validate(Status, SalHead.status::Approved);
                    SalHead.modify(true);
                    Handled := true;
                end;
            database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChqBk);
                    ChqBk.Validate(Status, ChqBk.status::Approved);
                    ChqBk.modify(true);
                    Handled := true;
                end;
            database::"Cheque Receipts":
                begin
                    RecRef.SetTable(CQRecpt);
                    CQRecpt.Validate(Status, CQRecpt.status::Approved);
                    CQRecpt.modify(true);
                    Handled := true;
                end;
            database::"Bankers Cheque Application":
                begin
                    RecRef.SetTable(BnkCQ);
                    BnkCQ.Validate(Status, BnkCQ.status::Approved);
                    BnkCQ.modify(true);
                    Handled := true;
                end;
            database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMAPP);
                    ATMAPP.Validate(Status, ATMAPP.status::Approved);
                    ATMAPP.modify(true);
                    Handled := true;
                end;
            database::"ATM Linking Applications":
                begin
                    RecRef.SetTable(ATMLNK);
                    ATMLNK.Validate(Status, ATMLNK.status::Approved);
                    ATMLNK.modify(true);
                    Handled := true;
                end;
            database::"Over Draft Authorisation":
                begin
                    RecRef.SetTable(OD);
                    OD.Validate(Status, OD.status::Approved);
                    OD.modify(true);
                    Handled := true;
                end;
            database::"Fixed Deposit Contract":
                begin
                    RecRef.SetTable(FDC);
                    FDC.Validate(Status, FDC.status::Approved);
                    FDC."Fixed Deposit Status" := FDC."Fixed Deposit Status"::Active;
                    FDC.modify(true);
                    Handled := true;
                end;
            //employee requisition
            database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(EmpRequisitions);
                    EmpRequisitions.Validate("Approval Status", EmpRequisitions."Approval Status"::Approved);
                    EmpRequisitions.modify(true);
                    Handled := true;
                end;

            database::"HR Leave Journal Line":
                begin
                    RecRef.SetTable(HRLeaveJournalLine);
                    HRLeaveJournalLine.Validate(Status, HRLeaveJournalLine.Status::Approved);
                    HRLeaveJournalLine.modify(true);
                    Handled := true;
                end;

            database::"HR Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    leave.Validate(Status, Leave.Status::Approved);
                    leave.modify(true);
                    Handled := true;
                end;

            database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaim);
                    StaffClaim.Validate(Status, StaffClaim.Status::Approved);
                    StaffClaim.modify(true);
                    Handled := true;
                end;
            database::"HR Disciplinary Cases NCA":
                begin
                    RecRef.SetTable(disciplinary);
                    disciplinary.Validate(Status, disciplinary.Status::Approved);
                    disciplinary.modify(true);
                    Handled := true;
                end;
            database::"HRDisciplinary Case Withdrawal":
                begin
                    RecRef.SetTable(disciplinarywithdrawal);
                    disciplinarywithdrawal.Validate(Status, disciplinarywithdrawal.Status::Approved);
                    disciplinarywithdrawal.modify(true);
                    Handled := true;
                end;
            database::"HRDisciplinary Appeal":
                begin
                    RecRef.SetTable(DiscAppeal);
                    DiscAppeal.Validate(Status, DiscAppeal.Status::Approved);
                    DiscAppeal.modify(true);
                    Handled := true;
                end;
            database::"HR Training Feedback Form":
                begin
                    RecRef.SetTable(feedback);
                    feedback.Validate(Status, feedback.Status::Approved);
                    feedback.modify(true);
                    Handled := true;
                end;
            database::"HR Training Needs":
                begin
                    RecRef.SetTable(trainneeds);
                    trainneeds.Validate(Status, trainneeds.Status::Approved);
                    trainneeds.modify(true);
                    Handled := true;
                end;
            database::"HR Training App Header":
                begin
                    RecRef.SetTable(TraiApp);
                    TraiApp.Validate(Status, TraiApp.Status::Approved);
                    TraiApp.modify(true);
                    Handled := true;
                end;
            database::"Permission Requisition":
                begin
                    RecRef.SetTable(PermissionReq);
                    PermissionReq.Validate(Status, PermissionReq.Status::Approved);
                    PermissionReq."Approved By" := userid;
                    PermissionReq."Date Approved" := today;
                    PermissionReq."Time Approved" := Time;
                    PermissionReq.modify(true);
                    Handled := true;
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        MemberApp: Record "Member Application";
        LoanApp: Record loans;
        Recref: recordref;
        MClosure: Record "Membership closure";
        DependancyApplications: Record "Dependancies Applications";
        BankAccClossure: Record "Banking Account Closure";
        CashierTransactions: Record "Cashier Transactions";
        LoanRescheduling: Record "Loan Rescheduling";
        MoratoriumLoan: Record "Moratorium Loan";
        BSLoansAccApp: Record "B/S Loan Account Application";
        SystemEdits: Record "System Edits";
        LoanCheckoff: Record "Checkoff Header";
        ACTransfer: Record "Account Transfer Header";
        HrJob: Record "HR Jobs";
        HREMP: Record "HR Employees";
        PettyCash: Record "Payments Header";
        Sharetransfer: Record "Share Capital Transfer Buffer";
        OneMonthInstallments: Record "One Month Installment";
        BusinessLoanClossure: Record "Business Loan Clossure";
        SystemReversal: Record "System Reversal";
        SecuritiesReg: Record "Securities Register";
        sinkfund: Record "SinkFund Report Information";
        CompanyVehicles: Record "Company Vehicles";
        VehicleMovement: Record "Vehicle Movement";
        //ConferenceAndMeetingRooms: Record "Conference & Meeting Rooms-T";
        UserCreation: Record "User Creation Requests";
        UserTermination: Record "User Termination";
        ProductFactory: Record "Product Factory";
        VehicleRequest: Record "Motor Vehicle Request";
        DMUCaseForwarding: Record "DMU Case Forwarding";
        DispatchATM: Record "Dispatch ATM Header";
        RefundTransfer: Record "Refund,Account Transfer Header";
        Legal: Record Legal;
        InterestHeader: Record "Interest Header";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        Customer: Record Customer;
        SecurityPerfection: Record "Security Perfection";
        Application: Record "HR Job Applications";
        ParkingSpace: Record "Parking Space";
        Overtime: record "Overtime Claim Header";
        InvHeader: Record "Investment Header";
        EmpRequisitions: record "HR Employee Requisitions";
        VariationsRec: Record "Product Variations";
        Disciplinary: Record "HR Disciplinary Cases NCA";
        FOSAPV: Record "Fosa Payments Header";
        SAccountAppl: Record "Savings Account Application";
        InvestInterestHeader: Record "Investment Interest Header";
        MemberWithdrawalNotice: Record "Member withdrawal Notice";
        SecurityDischarge: Record "Security Discharge";
        StaffClaim: Record "Staff Claims Header";
        ElectoralZones: Record "Electoral Zones";
        DelegateOfficials: Record "Delegate Officials";
        Minutes: Record "Delegates Minutes Header";
        DelegatesPayment: Record "Delegates Payment";
        HRLeaveJournalLine: record "hr leave journal line";
        ImprestRequisition: Record "Imprest Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        disciplinarywithdrawal: record "HRDisciplinary Case Withdrawal";
        DiscAppeal: Record "HRDisciplinary Appeal";
        TraiApp: Record "HR Training App Header";
        feedback: record "HR Training Feedback Form";
        Vendor: Record Vendor;
        HRDrivers: Record "HR Drivers";
        ProprtyDetails: Record "Property Details";
        Lease: Record Lease;
        Surety: Record "Surety Management";
        BoardMemberPay: Record "Board members";
        trainneeds: Record "HR Training Needs";
        ParkingCreation: Record "Parking List Table";
        ConferenceCreation: Record "Conf & Meeting Rooms List";
        ConferenceBooking: Record "Conference & Meeting Rooms-T";
        SMSAlerts: Record "SMS Alerts Header";
        Salary: Record "Salary Header";
        Contracts: Record Contracts;
        Accidents: Record "HR OSAccident";
        Fuel: Record "HR Fuel Management Header";
        Appeals: Record "Appeals Table";
        KeyCreation: Record "Office Keys List";
        KeyRequest: Record "Key Request Table";
        TrTrans: Record "Treasury Cashier Transactions";
        BnkChq: Record "Bankers Cheque Application";
        STO: Record "Standing Order Header";
        RTGS: Record "RTGS Transfer Header";
        ATMApp: Record "ATM Applications";
        ATMLink: Record "ATM Linking Applications";
        FDC: Record "Fixed Deposit Contract";
        AccInterest: Record "Savings Interest Header";
        EndYearTrans: Record "End Year Transfer Header";
        PermissionReq: Record "Permission Requisition";
        HrcompanyActivity: Record "HR Company Activities";
        HrAppraisal: Record "HR Appraisal Header";
        NomineeRequest: Record "Nominee Form Request";
        GuarantorsSubstitution: Record "Guarantors Substitution";
        LoanBatch: Record "Loan Disbursement Header";
        HrTPlanning: record "HR Training Planner";
        HrExitInterview: Record "HR Employee Exit Interviews";
        InterBankTr: record "InterBank Transfers";
        storeRequ: Record "Store Requistion Header";
        DivProvision: Record "Dividends Provision Header";
        Assetrans: Record "Asset Transfer";
        AccountAct: Record "Account Activation";
        ContractReq: Record "Contract Request";
        HrOverTime: Record "HR Overtime Header";
        CollectionReg: Record "Securities Collection Register";
        TreasuryApp: record "Treasury Cheque Application";
        InsuaranceClaims: record "Insurance Claims";
        AssetInsuarance: Record Insurance;
        VehicleRepa: Record "Maintain Machne/Vehicles";
        VehicleServ: Record "Vehicle Servicing Table";
        Stockkeeping: Record "Stock Keeping";
        wellfareAdvance: Record "Welfare Advance";
        Staffwellfare: Record "Staff Welfare";
        Clearanceform: Record "Clearance Form";
        leave: Record "HR Leave Application";
        BOSAAccActive: Record "BOSA Account Activation";
        Batchingprocess: Record "Batching Process Table";
        GeneralSMSHeader: Record "General SMS Header";
        MKey: Record "MKey Forwarding";
        RevenueCollection: Record "Revenue Collection";
        FAReclassificationJournal: Record "FA Reclass. Journal Line";
        VoteTransfer: Record "Vote Transfer";
        BankDeposit: record "Bank Deposit Header";
        GroupUpdate: Record "Group Member Exit & Update";

    begin
        case ApprovalEntry."Table ID" of
            Database::"Group Member Exit & Update":
                begin
                    if GroupUpdate.Get(ApprovalEntry."Document No.") then begin
                        GroupUpdate.Validate(Status, GroupUpdate.Status::Rejected);
                        GroupUpdate.Modify(True);
                    end;
                end;

            Database::"Bank Deposit Header":
                begin
                    if BankDeposit.Get(ApprovalEntry."Document No.") then begin
                        BankDeposit.validate(status, BankDeposit.status::Rejected);
                        BankDeposit.Modify(true);
                    end;
                end;
            Database::"Vote Transfer":
                begin
                    if VoteTransfer.Get(ApprovalEntry."Document No.") then begin
                        VoteTransfer.validate(status, VoteTransfer.status::Rejected);
                        VoteTransfer.Modify(true);
                    end;
                end;
            Database::"FA Reclass. Journal Line":
                begin
                    if FAReclassificationJournal.Get(ApprovalEntry."Document No.") then begin
                        FAReclassificationJournal.validate(status, FAReclassificationJournal.status::Rejected);
                        FAReclassificationJournal.Modify(true);
                    end;
                end;
            Database::"Revenue Collection":
                begin
                    if RevenueCollection.Get(ApprovalEntry."Document No.") then begin
                        RevenueCollection.validate(status, RevenueCollection.status::Rejected);
                        RevenueCollection.Modify(true);
                    end;
                end;
            Database::"MKey Forwarding":
                begin
                    if MKey.Get(ApprovalEntry."Document No.") then begin
                        MKey.validate(status, MKey.status::Rejected);
                        MKey.Modify(true);
                    end;
                end;
            Database::"General SMS Header":
                begin
                    if GeneralSMSHeader.Get(ApprovalEntry."Document No.") then begin
                        GeneralSMSHeader.validate(status, GeneralSMSHeader.status::Rejected);
                        GeneralSMSHeader.Modify(true);
                    end;
                end;
            Database::"HR Leave Application":
                begin
                    if leave.Get(ApprovalEntry."Document No.") then begin
                        leave.validate(status, leave.status::Rejected);
                        leave.Modify(true);
                    end;
                end;
            Database::"Clearance Form":
                begin
                    if Clearanceform.Get(ApprovalEntry."Document No.") then begin
                        Clearanceform.validate(status, Clearanceform.status::Rejected);
                        Clearanceform.Modify(true);
                    end;
                end;
            Database::"Staff Welfare":
                begin
                    if Staffwellfare.Get(ApprovalEntry."Document No.") then begin
                        Staffwellfare.validate(status, Staffwellfare.status::Rejected);
                        Staffwellfare.Modify(true);
                    end;
                end;
            Database::"Welfare Advance":
                begin
                    if wellfareAdvance.Get(ApprovalEntry."Document No.") then begin
                        wellfareAdvance.validate(status, wellfareAdvance.status::Rejected);
                        wellfareAdvance.Modify(true);
                    end;
                end;
            Database::"Stock Keeping":
                begin
                    if Stockkeeping.Get(ApprovalEntry."Document No.") then begin
                        Stockkeeping.validate(status, Stockkeeping.status::Rejected);
                        Stockkeeping.Modify(true);
                    end;
                end;
            Database::"Vehicle Servicing Table":
                begin
                    if VehicleServ.Get(ApprovalEntry."Document No.") then begin
                        VehicleServ.validate(status, VehicleServ.status::Rejected);
                        VehicleServ.Modify(true);
                    end;
                end;
            Database::"Maintain Machne/Vehicles":
                begin
                    if VehicleRepa.Get(ApprovalEntry."Document No.") then begin
                        VehicleRepa.validate(status, VehicleRepa.status::Rejected);
                        VehicleRepa.Modify(true);
                    end;
                end;
            Database::Insurance:
                begin
                    if AssetInsuarance.Get(ApprovalEntry."Document No.") then begin
                        AssetInsuarance.validate(status, AssetInsuarance.status::Rejected);
                        AssetInsuarance.Modify(true);
                    end;
                end;
            Database::"Insurance Claims":
                begin
                    if InsuaranceClaims.Get(ApprovalEntry."Document No.") then begin
                        InsuaranceClaims.validate(status, InsuaranceClaims.status::Rejected);
                        InsuaranceClaims.Modify(true);
                    end;
                end;
            Database::"Treasury Cheque Application":
                begin
                    if TreasuryApp.Get(ApprovalEntry."Document No.") then begin
                        TreasuryApp.validate(status, TreasuryApp.status::Rejected);
                        TreasuryApp.Modify(true);
                    end;
                end;
            Database::"BOSA Account Activation":
                begin
                    if BOSAAccActive.Get(ApprovalEntry."Document No.") then begin
                        BOSAAccActive.validate(status, BOSAAccActive.status::Rejected);
                        BOSAAccActive.Modify(true);
                    end;
                end;
            Database::"Securities Collection Register":
                begin
                    if CollectionReg.Get(ApprovalEntry."Document No.") then begin
                        CollectionReg.validate(status, CollectionReg.status::Rejected);
                        CollectionReg.Modify(true);
                    end;
                end;
            Database::"HR Overtime Header":
                begin
                    if HrOverTime.Get(ApprovalEntry."Document No.") then begin
                        HrOverTime.validate(status, HrOverTime.status::Rejected);
                        HrOverTime.Modify(true);
                    end;
                end;
            Database::"Contract Request":
                begin
                    if ContractReq.Get(ApprovalEntry."Document No.") then begin
                        ContractReq.validate(status, ContractReq.status::Rejected);
                        ContractReq.Modify(true);
                    end;
                end;
            Database::"Account activation":
                begin
                    if AccountAct.Get(ApprovalEntry."Document No.") then begin
                        AccountAct.validate(status, AccountAct.status::Rejected);
                        AccountAct.Modify(true);
                    end;
                end;
            Database::"End Year Transfer Header":
                begin
                    if EndYearTrans.Get(ApprovalEntry."Document No.") then begin
                        EndYearTrans.validate(status, EndYearTrans.status::Rejected);
                        EndYearTrans.Modify(true);
                    end;
                end;
            Database::"Asset Transfer":
                begin
                    if Assetrans.Get(ApprovalEntry."Document No.") then begin
                        Assetrans.validate(status, Assetrans.status::Rejected);
                        Assetrans.Modify(true);
                    end;
                end;
            Database::"Dividends Provision Header":
                begin
                    if DivProvision.Get(ApprovalEntry."Document No.") then begin
                        DivProvision.validate(status, DivProvision.status::Rejected);
                        DivProvision.Modify(true);
                    end;
                end;
            Database::"Store Requistion Header":
                begin
                    if storeRequ.Get(ApprovalEntry."Document No.") then begin
                        storeRequ.validate(status, storeRequ.status::Cancelled);
                        storeRequ.Modify(true);
                    end;
                end;
            Database::"InterBank Transfers":
                begin
                    if InterBankTr.Get(ApprovalEntry."Document No.") then begin
                        InterBankTr.validate(status, InterBankTr.status::Cancelled);
                        InterBankTr.Modify(true);
                    end;
                end;
            Database::"HR Employee Exit Interviews":
                begin
                    if HrExitInterview.Get(ApprovalEntry."Document No.") then begin
                        HrExitInterview.validate(status, HrExitInterview.status::Rejected);
                        HrExitInterview.Modify(true);
                    end;
                end;
            Database::"HR Training Planner":
                begin
                    if HrTPlanning.Get(ApprovalEntry."Document No.") then begin
                        HrTPlanning.validate(status, HrTPlanning.status::Rejected);
                        HrTPlanning.Modify(true);
                    end;
                end;
            Database::"Loan Disbursement Header":
                begin
                    if LoanBatch.Get(ApprovalEntry."Document No.") then begin
                        LoanBatch.validate(status, LoanBatch.status::Rejected);
                        LoanBatch.Modify(true);
                    end;
                end;
            Database::"Guarantors Substitution":
                begin
                    if GuarantorsSubstitution.Get(ApprovalEntry."Document No.") then begin
                        GuarantorsSubstitution.validate(status, GuarantorsSubstitution.status::Rejected);
                        GuarantorsSubstitution."Rejected By" := UserId;
                        GuarantorsSubstitution.Modify(true);
                    end;
                end;
            Database::"Nominee Form Request":
                begin
                    if NomineeRequest.Get(ApprovalEntry."Document No.") then begin
                        NomineeRequest.validate(status, NomineeRequest.status::Rejected);
                        NomineeRequest.Modify(true);
                    end;

                end;
            Database::"HR Appraisal Header":
                begin
                    if HrAppraisal.Get(ApprovalEntry."Document No.") then begin
                        HrAppraisal.validate(status, HrAppraisal.status::Rejected);
                        HrAppraisal.Modify(true);
                    end;

                end;
            Database::"HR Company Activities":
                begin
                    RecRef.SetTable(HrcompanyActivity);
                    HrcompanyActivity.Validate(Status, HrcompanyActivity.Status::Rejected);
                    HrcompanyActivity.modify(true);

                end;
            Database::"Savings Account Application":
                begin
                    if SAccountAppl.Get(ApprovalEntry."Document No.") then begin
                        SAccountAppl.validate(status, SAccountAppl.status::Rejected);
                        SAccountAppl.Modify(true);
                    end;

                end;
            Database::"Securities Register":
                begin
                    RecRef.SetTable(SecuritiesReg);
                    SecuritiesReg.Validate(Status, SecuritiesReg.Status::Rejected);
                    SecuritiesReg.Modify(true);

                end;
            Database::"Savings Interest Header":
                begin
                    if AccInterest.Get(ApprovalEntry."Document No.") then begin
                        AccInterest.validate(status, AccInterest.status::Rejected);
                        AccInterest.Modify(true);
                    end;

                end;

            Database::"Fixed Deposit Contract":
                begin
                    if FDC.Get(ApprovalEntry."Document No.") then begin
                        FDC.validate(status, FDC.status::Rejected);
                        FDC.modify(true);
                    end;

                end;

            Database::"ATM Linking Applications":
                begin
                    if ATMLink.Get(ApprovalEntry."Document No.") then begin
                        ATMLink.validate(status, ATMLink.status::Rejected);
                        ATMLink.modify(true);
                    end;

                end;

            Database::"ATM Applications":
                begin
                    if ATMApp.Get(ApprovalEntry."Document No.") then begin
                        ATMApp.validate(status, ATMApp.status::Rejected);
                        ATMApp.modify(true);
                    end;

                end;

            Database::"RTGS Transfer Header":
                begin
                    if RTGS.Get(ApprovalEntry."Document No.") then begin
                        RTGS.validate(status, RTGS.status::Rejected);
                        RTGS.Modify(true);
                    end;
                end;
            Database::"Standing Order Header":
                begin
                    if STO.Get(ApprovalEntry."Document No.") then begin
                        STO.validate(status, STO.status::Rejected);
                        STO.modify(true);
                    end;

                end;
            Database::"Treasury Cashier Transactions":
                begin
                    if TrTrans.Get(ApprovalEntry."Document No.") then begin
                        TrTrans.validate(status, TrTrans.status::Rejected);
                        TrTrans.modify(true);
                    end;

                end;
            Database::"Bankers Cheque Application":
                begin
                    if BnkChq.Get(ApprovalEntry."Document No.") then begin
                        BnkChq.validate(status, BnkChq.status::Rejected);
                        BnkChq.modify(true);
                    end;

                end;
            Database::"Key Request Table":
                begin
                    RecRef.SetTable(KeyRequest);
                    KeyRequest.Validate(Status, KeyRequest.Status::Rejected);
                    KeyRequest.modify(true);

                end;
            Database::"Office Keys":
                begin
                    RecRef.SetTable(KeyCreation);
                    KeyCreation.Validate(Status, KeyCreation.Status::Rejected);
                    KeyCreation.modify(true);

                end;
            Database::"Appeals Table":
                begin
                    RecRef.SetTable(Appeals);
                    Appeals.Validate(Status, Appeals.Status::Rejected);
                    Appeals.modify(true);

                end;

            Database::"HR Fuel Management Header":
                begin
                    RecRef.SetTable(Fuel);
                    Fuel.Validate(Status, Accidents.Status::Rejected);
                    Fuel.modify(true);

                end;
            Database::"HR OSAccident":
                begin
                    RecRef.SetTable(Accidents);
                    Accidents.Validate(Status, Accidents.Status::Rejected);
                    Accidents.modify(true);
                end;
            database::Contracts:
                Begin
                    RecRef.SetTable(Contracts);
                    Contracts.Validate(Status, Contracts.Status::Rejected);
                    Contracts.modify(true);
                end;
            database::"SMS Alerts Header":
                begin
                    RecRef.SetTable(SMSAlerts);
                    SMSAlerts.Validate(Status, SMSAlerts.Status::Rejected);
                    SMSAlerts.modify(true);
                end;
            database::"Conference & Meeting Rooms-T":
                begin
                    RecRef.SetTable(ConferenceBooking);
                    ConferenceBooking.Validate(Status, ConferenceBooking.Status::Rejected);
                    ConferenceBooking.modify(true);
                end;
            database::"Conf & Meeting Rooms List":
                begin
                    RecRef.SetTable(ConferenceCreation);
                    ConferenceCreation.Validate(Status, ConferenceCreation.Status::Rejected);
                    ConferenceCreation.modify(true);
                end;
            database::"Parking List Table":
                begin
                    if ParkingCreation.Get(ApprovalEntry."Document No.") then begin
                        ParkingCreation.validate(status, ParkingCreation.Status::Rejected);
                        ParkingCreation.modify(true);
                    end;
                end;
            database::"Surety Management":
                begin
                    if Surety.Get(ApprovalEntry."Document No.") then begin
                        Surety.validate(status, Surety.Status::Rejected);
                        Surety.modify(true);
                    end;
                end;
            database::Lease:
                begin
                    if Lease.Get(ApprovalEntry."Document No.") then begin
                        Lease.validate(status, Lease.Status::Rejected);
                        Lease.modify(true);
                    end;
                end;
            database::"Property Details":
                begin
                    if ProprtyDetails.Get(ApprovalEntry."Document No.") then begin
                        ProprtyDetails.validate(status, ProprtyDetails.Status::Rejected);
                        ProprtyDetails.modify(true);
                    end
                end;
            database::"HR Drivers":
                begin
                    if HRDrivers.Get(ApprovalEntry."Document No.") then begin
                        HRDrivers.validate(status, HRDrivers.Status::Rejected);
                        HRDrivers.modify(true);
                    end
                end;
            database::Vendor:
                begin
                    if Vendor.Get(ApprovalEntry."Document No.") then begin
                        Vendor.validate(status, Vendor.Status::Rejected);
                        Vendor.modify(true);
                    end
                end;
            database::"Board members":
                begin
                    if BoardMemberPay.Get(ApprovalEntry."Document No.") then begin
                        BoardMemberPay.validate(status, BoardMemberPay.Status::Rejected);
                        BoardMemberPay.modify(true);
                    end
                end;
            database::"Delegates Payment":
                begin
                    if DelegatesPayment.Get(ApprovalEntry."Document No.") then begin
                        DelegatesPayment.validate(status, DelegatesPayment.Status::Rejected);
                        DelegatesPayment.modify(true);
                    end
                end;
            database::"Delegates Minutes Header":
                begin
                    if Minutes.Get(ApprovalEntry."Document No.") then begin
                        Minutes.validate(status, Minutes.Status::Rejected);
                        Minutes.modify(true);
                    end
                end;

            database::"Product Variations":
                begin
                    if VariationsRec.Get(ApprovalEntry."Document No.") then begin
                        VariationsRec.validate(status, VariationsRec.Status::Rejected);
                        VariationsRec.modify(true);
                    end
                end;
            database::"Security Discharge":
                begin
                    if SecurityDischarge.Get(ApprovalEntry."Document No.") then begin
                        SecurityDischarge.validate(status, SecurityDischarge.Status::Rejected);
                        SecurityDischarge.modify(true);
                    end
                end;
            //database::"Member withdrawal Notice":

            database::"Electoral Zones":
                begin
                    if ElectoralZones.Get(ApprovalEntry."Document No.") then begin
                        ElectoralZones.validate(status, ElectoralZones.Status::Rejected);
                        ElectoralZones.modify(true);
                    end
                end;
            database::"Member withdrawal Notice":

                begin
                    if MemberWithdrawalNotice.Get(ApprovalEntry."Document No.") then begin
                        MemberWithdrawalNotice.validate(status, MemberWithdrawalNotice.Status::Rejected);
                        MemberWithdrawalNotice.modify(true);
                    end
                end;
            database::"Investment Header":
                begin
                    if InvHeader.Get(ApprovalEntry."Document No.") then begin
                        InvHeader.validate(status, InvHeader.Status::Rejected);
                        InvHeader.modify(true);
                    end
                end;
            database::"Investment Interest Header":
                begin
                    if InvestInterestHeader.Get(ApprovalEntry."Document No.") then begin
                        InvestInterestHeader.validate(status, InvestInterestHeader.Status::Rejected);
                        InvestInterestHeader.modify(true);
                    end
                end;
            database::"Parking Space":
                begin
                    if ParkingSpace.Get(ApprovalEntry."Document No.") then begin
                        ParkingSpace.validate(status, ParkingSpace.Status::Rejected);
                        ParkingSpace.modify(true);
                    end
                end;
            database::"Fosa Payments Header":
                begin
                    if FOSAPV.Get(ApprovalEntry."Document No.") then begin
                        FOSAPV.validate(status, FOSAPV.Status::Cancelled);
                        FOSAPV.modify(true);
                    end
                end;
            database::"Security Perfection":
                begin
                    if SecurityPerfection.Get(ApprovalEntry."Document No.") then begin
                        SecurityPerfection.validate(status, SecurityPerfection.status::Rejected);
                        SecurityPerfection.modify(true);
                    end;
                end;
            database::Customer:
                begin
                    if Customer.Get(ApprovalEntry."Document No.") then begin
                        Customer.validate(status, Customer.status::Rejected);
                        Customer.modify(true);
                    end;
                end;
            database::"Overtime Claim Header":
                begin
                    if Overtime.Get(ApprovalEntry."Document No.") then begin
                        Overtime.validate(status, Overtime.status::Cancelled);
                        Overtime.modify(true);
                    end;
                end;
            database::"Interest Header":
                begin
                    if InterestHeader.Get(ApprovalEntry."Document No.") then begin
                        InterestHeader.validate(status, InterestHeader.status::Rejected);
                        InterestHeader.modify(true);
                    end;
                end;
            database::"Loan Recovery Header":
                begin
                    if LoanRecoveryHeader.Get(ApprovalEntry."Document No.") then begin
                        LoanRecoveryHeader.validate(status, LoanRecoveryHeader.status::Rejected);
                        LoanRecoveryHeader.modify(true);
                    end;
                end;
            database::"Loan Recovery Header II":
                begin
                    if LoanRecoveryHeaderII.Get(ApprovalEntry."Document No.") then begin
                        LoanRecoveryHeaderII.validate(status, LoanRecoveryHeaderII.status::Rejected);
                        LoanRecoveryHeaderII.modify(true);
                    end;
                end;
            database::Legal:
                begin
                    if Legal.Get(ApprovalEntry."Document No.") then begin
                        Legal.validate(status, Legal.status::Rejected);
                        Legal.modify(true);
                    end
                end;
            database::"HR Job Applications":
                begin
                    if Application.Get(ApprovalEntry."Document No.") then begin
                        Application.validate(status, Application.status::Unqualified);
                        Application.modify(true);
                    end
                end;
            database::"Dispatch ATM Header":
                begin
                    if DispatchATM.Get(ApprovalEntry."Document No.") then begin
                        DispatchATM.validate(status, DispatchATM.status::Rejected);
                        DispatchATM.modify(true);
                    end
                end;

            database::"Motor Vehicle Request":
                begin
                    if VehicleRequest.Get(ApprovalEntry."Document No.") then begin
                        VehicleRequest.validate(status, VehicleRequest.status::Rejected);
                        VehicleRequest.modify(true);
                    end
                end;

            database::"Vehicle Movement":
                begin
                    if VehicleMovement.Get(ApprovalEntry."Document No.") then begin
                        VehicleMovement.validate(status, VehicleMovement.status::Rejected);
                        VehicleMovement.modify(true);
                    end;
                end;
            // database::"Conference & Meeting Rooms-T":
            //     begin
            //         if ConferenceAndMeetingRooms.Get(ApprovalEntry."Document No.") then begin
            //             ConferenceAndMeetingRooms.Validate(status, ConferenceAndMeetingRooms.Status::Rejected);
            //             ConferenceAndMeetingRooms.Modify(true);
            //         end;
            //     end;

            database::"System Reversal":
                begin
                    if SystemReversal.Get(ApprovalEntry."Document No.") then begin
                        SystemReversal.validate(status, SystemReversal.status::Rejected);
                        SystemReversal.modify(true);
                    end;
                end;
            database::"Product Factory":
                begin
                    if ProductFactory.Get(ApprovalEntry."Document No.") then begin
                        ProductFactory.validate(status, ProductFactory.status::Rejected);
                        ProductFactory.modify(true);
                    end;
                end;
            database::"User Creation Requests":
                begin
                    if UserCreation.Get(ApprovalEntry."Document No.") then begin
                        UserCreation.validate(status, UserCreation.status::Rejected);
                        UserCreation.modify(true);
                    end;
                end;
            database::"User Termination":
                begin
                    if UserTermination.Get(ApprovalEntry."Document No.") then begin
                        UserTermination.validate(status, UserTermination.status::Rejected);
                        UserTermination.modify(true);
                    end;
                end;
            database::"SinkFund Report Information":
                begin
                    if sinkfund.Get(ApprovalEntry."Document No.") then begin
                        sinkfund.validate(status, sinkfund.status::Rejected);
                        sinkfund.modify(true);
                    end;
                end;
            database::"Company Vehicles":
                begin
                    if CompanyVehicles.Get(ApprovalEntry."Document No.") then begin
                        CompanyVehicles.validate(status, CompanyVehicles.status::Rejected);
                        CompanyVehicles.modify(true);
                    end;
                end;
            database::"Business Loan Clossure":
                begin
                    if BusinessLoanClossure.Get(ApprovalEntry."Document No.") then begin
                        BusinessLoanClossure.validate(status, BusinessLoanClossure.status::Rejected);
                        BusinessLoanClossure.modify(true);
                    end;
                end;
            database::"One Month Installment":
                begin
                    if OneMonthInstallments.Get(ApprovalEntry."Document No.") then begin
                        OneMonthInstallments.validate(status, OneMonthInstallments.status::Rejected);
                        OneMonthInstallments.modify(true);
                    end;
                end;
            database::"Dependancies Applications":
                begin
                    if DependancyApplications.Get(ApprovalEntry."Document No.") then begin
                        DependancyApplications.validate(status, DependancyApplications.status::Rejected);
                        DependancyApplications.modify(true);
                    end;
                end;
            database::"System Edits":
                begin
                    if SystemEdits.Get(ApprovalEntry."Document No.") then begin
                        SystemEdits.validate(status, SystemEdits.status::Rejected);
                        SystemEdits.modify(true);
                    end;
                end;
            database::"Payments Header":
                begin
                    if PettyCash.Get(ApprovalEntry."Document No.") then begin
                        PettyCash.validate(status, PettyCash.status::Cancelled);
                        PettyCash.modify(true);
                    end;
                end;
            database::"HR Employees":
                begin
                    if HREMP.Get(ApprovalEntry."Document No.") then begin
                        HREMP.validate(status, HREMP.status::InActive);
                        HREMP.modify(true);
                    end;
                end;
            database::"HR Jobs":
                begin
                    if HrJob.Get(ApprovalEntry."Document No.") then begin
                        HrJob.validate(status, HrJob.status::Rejected);
                        HrJob.modify(true);
                    end;
                end;
            Database::"Checkoff Header":
                begin
                    if LoanCheckoff.Get(ApprovalEntry."Document No.") then begin
                        LoanCheckoff.validate(status, LoanCheckoff.status::Rejected);
                        LoanCheckoff.modify(true);
                    end;
                end;
            database::"Account Transfer Header":
                begin
                    if ACTransfer.Get(ApprovalEntry."Document No.") then begin
                        ACTransfer.validate(status, ACTransfer.status::Rejected);
                        ACTransfer.modify(true);
                    end;
                end;
            Database::"Share Capital Transfer Buffer":
                begin
                    if Sharetransfer.Get(ApprovalEntry."Document No.") then begin
                        sharetransfer.Validate(Status, sharetransfer.Status::Rejected);
                        sharetransfer.Modify(true);
                    end;

                end;

            // Database::"Company Vehicles":
            //     begin
            //         if VehicleRequest.Get(ApprovalEntry."Document No.") then begin
            //             VehicleRequest.validate(status, VehicleRequest.status::Rejected);
            //             VehicleRequest.modify(true);
            //         end;
            //     end;

            database::"B/S Loan Account Application":
                begin
                    if BSLoansAccApp.Get(ApprovalEntry."Document No.") then begin
                        BSLoansAccApp.validate(status, BSLoansAccApp.status::Rejected);
                        BSLoansAccApp.modify(true);
                    end;
                end;
            database::"Refund,Account Transfer Header":
                begin
                    if RefundTransfer.Get(ApprovalEntry."Document No.") then begin
                        RefundTransfer.validate(status, RefundTransfer.status::Rejected);
                        RefundTransfer.modify(true);
                    end;
                end;
            database::"Member Application":
                begin
                    if MemberApp.Get(ApprovalEntry."Document No.") then begin
                        MemberApp.validate(status, MemberApp.status::rejected);
                        memberApp.modify(true);
                    end;
                end;
        end;
        case ApprovalEntry."Table ID" of
            database::"Moratorium Loan":
                begin
                    if MoratoriumLoan.Get(ApprovalEntry."Document No.") then begin
                        MoratoriumLoan.validate(status, MoratoriumLoan.status::rejected);
                        MoratoriumLoan.modify(true);
                    end;
                end;
        end;
        case ApprovalEntry."Table ID" of
            database::"Loan Rescheduling":
                begin
                    if LoanRescheduling.Get(ApprovalEntry."Document No.") then begin
                        LoanRescheduling.validate(status, LoanRescheduling.status::rejected);
                        LoanRescheduling."Rejected By" := UserId;
                        LoanRescheduling.modify(true);
                    end;
                end;
        end;

        case ApprovalEntry."Table ID" of
            database::Loans:
                begin
                    if LoanApp.Get(ApprovalEntry."Document No.") then begin
                        LoanApp.validate(status, LoanApp.status::Rejected);
                        LoanApp."Rejected By" := UserId;
                        LoanApp.modify(true);
                    end;

                end;
        end;
        case ApprovalEntry."Table ID" of
            database::"Membership closure":
                begin
                    if MClosure.Get(ApprovalEntry."Document No.") then begin
                        MClosure.validate(status, MClosure.status::rejected);

                        MClosure.modify(true);
                    end;

                end;
        end;
        case ApprovalEntry."Table ID" of
            database::"Banking Account Closure":
                begin
                    if BankAccClossure.Get(ApprovalEntry."Document No.") then begin
                        BankAccClossure.validate(status, BankAccClossure.status::rejected);
                        BankAccClossure.modify(true);
                    end;

                end;
        end;
        case ApprovalEntry."Table ID" of
            database::"Cashier Transactions":
                begin
                    if CashierTransactions.Get(ApprovalEntry."Document No.") then begin
                        CashierTransactions.validate(status, CashierTransactions.status::rejected);
                        CashierTransactions.modify(true);
                    end;

                end;
            database::"HR Employee Requisitions":
                begin
                    if EmpRequisitions.Get(ApprovalEntry."Document No.") then begin
                        EmpRequisitions.validate("Approval Status", EmpRequisitions."Approval Status"::rejected);
                        EmpRequisitions.modify(true);
                    end;

                end;
            database::"HR Leave Journal Line":
                begin
                    if HRLeaveJournalLine.Get(ApprovalEntry."Document No.") then begin
                        HRLeaveJournalLine.validate(Status, HRLeaveJournalLine.Status::rejected);
                        HRLeaveJournalLine.modify(true);
                    end;

                end;
            database::"Imprest Header":
                begin
                    if ImprestRequisition.Get(ApprovalEntry."Document No.") then begin
                        ImprestRequisition.validate(status, ImprestRequisition.status::Cancelled);
                        ImprestRequisition.modify(true);
                    end;

                end;
            database::"Imprest Surrender Header":
                begin
                    if ImprestSurrender.Get(ApprovalEntry."Document No.") then begin
                        ImprestSurrender.validate(Status, ImprestSurrender.Status::Cancelled);
                        ImprestSurrender.modify(true);
                    end;

                end;
            database::"Staff Claims Header":
                begin
                    if StaffClaim.Get(ApprovalEntry."Document No.") then begin
                        StaffClaim.validate(Status, StaffClaim.Status::Cancelled);
                        StaffClaim.modify(true);
                    end;

                end;
            database::"HR Disciplinary Cases NCA":
                begin
                    if Disciplinary.Get(ApprovalEntry."Document No.") then begin
                        Disciplinary.validate(Status, Disciplinary.Status::Rejected);
                        Disciplinary.modify(true);
                    end;

                end;
            database::"HRDisciplinary Case Withdrawal":
                begin
                    if disciplinarywithdrawal.Get(ApprovalEntry."Document No.") then begin
                        disciplinarywithdrawal.validate(Status, disciplinarywithdrawal.Status::Rejected);
                        disciplinarywithdrawal.modify(true);
                    end;

                end;
            database::"HRDisciplinary Appeal":
                begin
                    if DiscAppeal.Get(ApprovalEntry."Document No.") then begin
                        DiscAppeal.validate(Status, DiscAppeal.Status::Rejected);
                        DiscAppeal.modify(true);
                    end;

                end;
            database::"HR Training Feedback Form":
                begin
                    if feedback.Get(ApprovalEntry."Document No.") then begin
                        feedback.validate(Status, feedback.Status::"Rejected.");
                        feedback.modify(true);
                    end;

                end;
            database::"HR Training Needs":
                begin
                    if trainneeds.Get(ApprovalEntry."Document No.") then begin
                        trainneeds.validate(Status, trainneeds.Status::Rejected);
                        trainneeds.modify(true);
                    end;

                end;
            database::"HR Training App Header":
                begin
                    if TraiApp.Get(ApprovalEntry."Document No.") then begin
                        TraiApp.validate(Status, TraiApp.Status::Rejected);
                        TraiApp.modify(true);
                    end;

                end;
            database::"Salary Header":
                begin
                    if Salary.Get(ApprovalEntry."Document No.") then begin
                        Salary.validate(Status, Salary.Status::Rejected);
                        Salary.modify(true);
                    end;

                end;

            database::"Permission Requisition":
                begin
                    if PermissionReq.Get(ApprovalEntry."Document No.") then begin
                        PermissionReq.validate(Status, PermissionReq.Status::Rejected);
                        PermissionReq.modify(true);
                    end;

                end;


        end;
    end;
    //end approvals response


    procedure ReOpen(var Variant: Variant)
    var
        RecRef: RecordRef;
        SystemEdits: Record "System Edits";
        SecuritiesReg: Record "Securities Register";
        DependancyApplications: Record "Dependancies Applications";
        PaymentsHeader: Record 52185888;
        StaffClaimsHeader: Record 52185912;
        StaffAdvanceHeader: Record 52185914;
        StaffAdvanceSurrenderHeader: Record 52185916;
        ImprestHeader: Record 52185909;
        ImprestSurrenderHeader: Record 52185885;
        StoreRequistionHeader: Record 52185868;
        InterBankTransfers: Record 52185881;
        OvertimeClaimHeader: Record 52185936;
        Budget: Record "G/L Budget Name";
        Vote: Record 52185922;
        AssetTransfer: Record 52185892;
        Vendor: Record Vendor;
        ctrans: Record 52185776;
        Sal: Record 52185783;
        MemberAppl: Record 52185691;
        SAccountAppl: Record 52185704;
        RTGSAppl: Record 52185715;
        STOAppl: Record 52185717;
        StandingOrderControl: Record 52185722;
        Loans: Record 52185729;
        //ProductFactoryApplication: Record 52186117;
        BankersC: Record 52185793;
        BankC: Record 52185785;
        OD: Record 52185795;
        ACT: Record 52185797;
        TREAS: Record 52185778;
        INV: Record 52185807;
        CHQ: Record 52185787;
        LoanBatch: Record "Loan Disbursement Header";
        DividendsSimulationHeader: Record 52185710;
        InterestHeader: Record 52185860;
        SavingsInterestHeader: Record 52185845;
        EndYearTransferHeader: Record 52185847;
        ATMApplications: Record 52185850;
        ATMLinkingApplications: Record 52185842;
        Checkoff: Record 52185819;
        MembClosure: Record 52185824;
        LoanRescheduling: Record 52185823;
        MemberwithdrawalNotice: Record 52185826;
        GuarantorsSubstitution: Record 52185828;
        LoanRecoveryHeader: Record 52185829;
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        Bond: Record 52185835;
        BDEManagementHeader: Record 52186128;
        DelegateGroupsApplicationss: Record 52186064;
        DelegateGroupMemRetirements: Record 52186065;
        DelegatesPayment: Record 52186067;
        HRJobs: Record 52185508;
        Hrempreq: Record 52185519;
        Leave: Record 52185532;
        hrtraining: Record 52185580;
        hrtransport: Record 52185571;
        EmpTrans: Record 52185576;
        HRInternReq: Record 52185612;
        leavePlanner: Record 52185542;
        MsaccoPIN: Record 52185768;
        MsaccoApp: Record 52185757;
        StaffLoan: Record 52185674;
        TNeed: Record 52185581;
        SecuritiesCollectionRegister: Record 52185843;
        BBFRequisationHeader: Record 52186126;
        Disciplinary: Record 52186162;
        AppraisalAppeal: Record 52185596;
        DisciplinaryAppeal: Record 52185970;
        DiscWithdrawal: Record 52185971;
        LeaseDoc: Record 52186008;
        Sharetransfer: record "Share Capital Transfer Buffer";
        TFeed: Record 52186205;
        Intern: Record 52185611;
        PropertyDetails: Record 52186005;
        Cases1: Record 52185957;
        contrct: Record 52185942;
        SuretyMangt: Record 52185964;
        PaymentsHeaderBoard: Record 52185895;
        AgentApplications: Record 52186104;
        SinkFundReportInformation: Record 52185940;
        AGMDelegatesPayment: Record 52186209;
        BankingAccountClosure: Record 52186211;
        DelegateRegionChange: Record 52186074;
        DelegateAGMUpdateHeader: Record 52186077;
        MortDoc: Record 52186089;
        SalaryAgreement: Record 52186037;
        HREmployees: Record 52185650;
        SkyVirtualMember: Record 52185499;
        ElectoralZones: Record 52186239;
        DelegateOfficials: Record 52186240;
        HRLeaveJournalLine: Record 52185544;
        MoratoriumLoan: Record "Moratorium Loan";
        BSLoansAccApp: Record "B/S Loan Account Application";
        CompanyVehicles: Record "Company Vehicles";
        OneMonthInstallments: Record "One Month Installment";
        BusinessLoanClossure: Record "Business Loan Clossure";
        VehicleMovement: Record "Vehicle Movement";
        ConferenceAndMeetingRooms: Record "Conference & Meeting Rooms-T";
        SystemReversal: Record "System Reversal";
        UserCreation: Record "User Creation Requests";
        UserTermination: Record "User Termination";
        ProductFactory: Record "Product Factory";
        FixedDepositContract: Record "Fixed Deposit Contract";
        VehicleRequest: Record "Motor Vehicle Request";
        DMUCaseForwarding: Record "DMU Case Forwarding";
        DispatchATM: Record "Dispatch ATM Header";
        RefundTransfer: Record "Refund,Account Transfer Header";
        Legal: Record Legal;
        VariationsRec: Record "Product Variations";
        Customer: Record Customer;
        SecurityPerfection: Record "Security Perfection";
        Overtime: Record "Overtime Claim Header";
        ParkingSpace: Record "Parking Space";
        InvestInterestHeader: Record "Investment Interest Header";
        InvHeader: Record "Investment Header";
        //EmpRequisitions: record "HR Employee Requisitions";
        FOSAPV: Record "Fosa Payments Header";
        SecurityDischarge: Record "Security Discharge";
        Jobs: Record "HR Jobs";
        Minutes: Record "Delegates Minutes Header";
        //HRLeaveJournalLine: Record "HR Leave Journal Line";
        Application: Record "HR Job Applications";
        HRDrivers: Record "HR Drivers";
        Lease: Record Lease;
        Surety: Record "Surety Management";
        BoardMemberPay: Record "Board members";
        ParkingCreation: Record "Parking List Table";
        ConferenceCreation: Record "Conf & Meeting Rooms List";
        ConferenceBooking: Record "Conference & Meeting Rooms-T";
        SMSAlerts: Record "SMS Alerts Header";
        Contracts: Record Contracts;
        Accidents: Record "HR OSAccident";
        Fuel: Record "HR Fuel Management Header";
        Appeals: Record "Appeals Table";
        KeyCreation: Record "Office Keys List";
        KeyRequest: Record "Key Request Table";
        TrTrans: Record "Treasury Cashier Transactions";
        BnkChq: Record "Bankers Cheque Application";
        STO: Record "Standing Order Header";
        RTGS: Record "RTGS Transfer Header";
        ACTransfer: Record "Account Transfer Header";
        ATMLink: Record "ATM Linking Applications";
        AccInterest: Record "Savings Interest Header";
        EndYearTrans: Record "End Year Transfer Header";
        PermissionReq: Record "Permission Requisition";
        HrcompanyActivity: Record "HR Company Activities";
        HrAppraisal: Record "HR Appraisal Header";
        NomineeRequest: Record "Nominee Form Request";
        HrTPlanning: record "HR Training Planner";
        HrExitInterview: Record "HR Employee Exit Interviews";
        InterBankTr: Record "InterBank Transfers";
        StoreReq: Record "Store Requistion Header";
        DivProvision: Record "Dividends Provision Header";
        AccountAct: Record "Account Activation";
        ContractReq: Record "Contract Request";
        HrOverTime: Record "HR Overtime Header";
        TreasureyApp: record "Treasury Cheque Application";
        InsuaranceClaims: record "Insurance Claims";
        AssetInsuarance: Record Insurance;
        VehicleRepa: record "Maintain Machne/Vehicles";
        VehchileSer: Record "Vehicle Servicing Table";
        Stockkeeping: Record "Stock Keeping";
        WellfareAdvance: Record "Welfare Advance";
        StaffWellfare: Record "Staff Welfare";
        Clearanceform: Record "Clearance Form";
        BOSAAccActive: Record "BOSA Account Activation";
        Batchingprocess: Record "Batching Process Table";
        GeneralSMSHeader: Record "General SMS Header";
        MKey: Record "MKey Forwarding";
        RevenueCollection: Record "Revenue Collection";
        FAReclassificationJournal: Record "FA Reclass. Journal Line";
        BankDeposits: record "Bank Deposit Header";
        GroupUpdate: Record "Group Member Exit & Update";
    begin

        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Group Member Exit & Update":
                begin
                    GroupUpdate.Validate(Status, GroupUpdate.Status::Open);
                    GroupUpdate.Modify(True);
                    variant := GroupUpdate;
                end;
            Database::"Bank Deposit Header":
                begin
                    BankDeposits.validate(status, BankDeposits.Status::Open);
                    BankDeposits.modify(true);
                    Variant := BankDeposits;
                end;
            Database::"FA Reclass. Journal Line":
                begin
                    FAReclassificationJournal.validate(status, FAReclassificationJournal.Status::Open);
                    FAReclassificationJournal.modify(true);
                    Variant := FAReclassificationJournal;
                end;
            Database::"Revenue Collection":
                begin
                    RevenueCollection.validate(status, RevenueCollection.Status::Open);
                    RevenueCollection.modify(true);
                    Variant := RevenueCollection;
                end;
            Database::"MKey Forwarding":
                begin
                    MKey.validate(status, MKey.Status::Open);
                    MKey.modify(true);
                    Variant := MKey;
                end;
            Database::"General SMS Header":
                begin
                    GeneralSMSHeader.validate(status, GeneralSMSHeader.Status::Open);
                    GeneralSMSHeader.modify(true);
                    Variant := GeneralSMSHeader;
                end;
            Database::"Clearance Form":
                begin
                    Clearanceform.validate(status, Clearanceform.Status::Open);
                    Clearanceform.modify(true);
                    Variant := Clearanceform;
                end;
            Database::"Staff Welfare":
                begin
                    StaffWellfare.validate(status, StaffWellfare.Status::Open);
                    StaffWellfare.modify(true);
                    Variant := StaffWellfare;
                end;
            Database::"Welfare Advance":
                begin
                    WellfareAdvance.validate(status, WellfareAdvance.Status::Open);
                    WellfareAdvance.modify(true);
                    Variant := WellfareAdvance;
                end;
            Database::"Stock Keeping":
                begin
                    Stockkeeping.validate(status, Stockkeeping.Status::Open);
                    Stockkeeping.modify(true);
                    Variant := Stockkeeping;
                end;
            Database::"Vehicle Servicing Table":
                begin
                    VehchileSer.validate(status, VehchileSer.Status::Open);
                    VehchileSer.modify(true);
                    Variant := VehchileSer;
                end;

            Database::"Maintain Machne/Vehicles":
                begin
                    VehicleRepa.validate(status, VehicleRepa.Status::Open);
                    VehicleRepa.modify(true);
                    Variant := VehicleRepa;
                end;

            Database::Insurance:
                begin
                    AssetInsuarance.validate(status, AssetInsuarance.Status::Open);
                    AssetInsuarance.modify(true);
                    Variant := AssetInsuarance;
                end;
            Database::"Insurance Claims":
                begin
                    InsuaranceClaims.validate(status, InsuaranceClaims.Status::Open);
                    InsuaranceClaims.modify(true);
                    Variant := InsuaranceClaims;
                end;
            Database::"Treasury Cheque Application":
                begin
                    TreasureyApp.validate(status, TreasureyApp.Status::Open);
                    TreasureyApp.modify(true);
                    Variant := TreasureyApp;
                end;
            Database::"BOSA Account Activation":
                begin
                    BOSAAccActive.validate(status, BOSAAccActive.Status::Open);
                    BOSAAccActive.modify(true);
                    Variant := BOSAAccActive;
                end;
            Database::"HR Overtime Header":
                begin
                    HrOverTime.validate(status, HrOverTime.Status::New);
                    HrOverTime.modify(true);
                    Variant := HrOverTime;
                end;
            Database::"Contract Request":
                begin
                    ContractReq.validate(status, ContractReq.Status::Open);
                    ContractReq.modify(true);
                    Variant := ContractReq;
                end;
            Database::"account activation":
                begin
                    AccountAct.validate(status, AccountAct.Status::Open);
                    AccountAct.modify(true);
                    Variant := AccountAct;
                end;

            Database::"Key Request Table":
                begin
                    KeyRequest.validate(status, KeyRequest.Status::Open);
                    KeyRequest.modify(true);
                    Variant := KeyRequest;
                end;
            Database::"Dividends Provision Header":
                begin
                    DivProvision.validate(status, DivProvision.Status::Open);
                    DivProvision.modify(true);
                    Variant := DivProvision;
                end;
            Database::"HR Employee Exit Interviews":
                begin
                    HrExitInterview.validate(status, HrExitInterview.Status::Open);
                    HrExitInterview.modify(true);
                    Variant := HrExitInterview;
                end;
            Database::"HR Training Planner":
                begin
                    HrTPlanning.validate(status, HrTPlanning.Status::Open);
                    HrTPlanning.modify(true);
                    Variant := HrTPlanning;
                end;
            Database::"Nominee Form Request":
                begin
                    NomineeRequest.validate(status, NomineeRequest.Status::Open);
                    NomineeRequest.modify(true);
                    Variant := NomineeRequest;
                end;
            Database::"HR Appraisal Header":
                begin
                    HrAppraisal.validate(status, HrAppraisal.Status::Open);
                    HrAppraisal.modify(true);
                    Variant := HrAppraisal;
                end;
            Database::"HR Company Activities":
                begin
                    HrcompanyActivity.validate(status, HrcompanyActivity.Status::New);
                    HrcompanyActivity.modify(true);
                    Variant := HrcompanyActivity;
                end;
            Database::"Securities Register":
                begin
                    SecuritiesReg.validate(status, SecuritiesReg.Status::Open);
                    SecuritiesReg.modify(true);
                    Variant := SecuritiesReg;
                end;


            Database::"Office Keys List":
                begin
                    KeyCreation.validate(status, KeyCreation.Status::Open);
                    KeyCreation.modify(true);
                    Variant := KeyCreation;
                end;
            Database::"Appeals Table":
                begin
                    Appeals.validate(status, Appeals.Status::New);
                    Appeals.modify(true);
                    Variant := Appeals;
                end;
            Database::"HR Fuel Management Header":
                begin
                    Fuel.Validate(Status, Fuel.Status::Open);
                    Fuel.modify(true);
                    Variant := Fuel;
                end;
            database::"HR OSAccident":
                begin
                    Accidents.validate(status, Accidents.Status::Open);
                    Accidents.modify(true);
                    Variant := Accidents;
                end;
            database::Contracts:
                begin
                    Contracts.validate(status, Contracts.Status::New);
                    Contracts.modify(true);
                    Variant := Contracts;
                end;
            database::"SMS Alerts Header":
                begin
                    SMSAlerts.validate(status, SMSAlerts.Status::Open);
                    SMSAlerts.modify(true);
                    Variant := SMSAlerts;
                end;
            database::"Conference & Meeting Rooms-T":
                begin
                    ConferenceBooking.validate(status, ConferenceBooking.Status::Open);
                    ConferenceBooking.modify(true);
                    Variant := ConferenceBooking;
                end;
            database::"Conf & Meeting Rooms List":
                begin
                    ConferenceCreation.validate(status, ConferenceCreation.Status::Open);
                    ConferenceCreation.modify(true);
                    Variant := ConferenceCreation;
                end;
            database::"Parking List Table":
                begin
                    ParkingCreation.validate(status, ParkingCreation.Status::Open);
                    ParkingCreation.modify(true);
                    Variant := ParkingCreation;
                end;
            database::"Surety Management":
                begin
                    Surety.validate(status, Surety.Status::Open);
                    Surety.modify(true);
                    Variant := Surety;
                end;
            database::Lease:
                begin
                    Lease.validate(status, Lease.Status::Open);
                    Lease.modify(true);
                    Variant := Lease;
                end;
            database::"Property Details":
                begin
                    PropertyDetails.validate(status, PropertyDetails.Status::Open);
                    PropertyDetails.modify(true);
                    Variant := PropertyDetails;
                end;
            database::"HR Drivers":
                begin
                    HRDrivers.validate(status, HRDrivers.Status::Open);
                    HRDrivers.modify(true);
                    Variant := HRDrivers;
                end;
            database::"Company Vehicles":
                begin
                    CompanyVehicles.Validate(status, CompanyVehicles.Status);
                    CompanyVehicles.modify(true);
                    Variant := CompanyVehicles;
                end;
            database::Vendor:
                begin
                    Vendor.validate(status, Vendor.Status::New);
                    Vendor.modify(true);
                    Variant := Vendor;
                end;
            database::"Board members":
                begin
                    BoardMemberPay.validate(status, BoardMemberPay.Status::Open);
                    BoardMemberPay.modify(true);
                    Variant := BoardMemberPay;
                end;
            database::"Delegates Minutes Header":
                begin
                    Minutes.validate(status, Minutes.status::Open);
                    Minutes.modify(true);
                    Variant := Minutes;
                end;
            database::"Security Discharge":
                begin
                    SecurityDischarge.validate(status, SecurityDischarge.status::Open);
                    SecurityDischarge.modify(true);
                    Variant := SecurityDischarge;
                end;
            database::"Product Variations":
                begin
                    VariationsRec.validate(status, VariationsRec.status::Open);
                    VariationsRec.Modify(true);
                    Variant := VariationsRec;
                end;
            database::"Investment Interest Header":
                begin
                    InvestInterestHeader.validate(status, InvestInterestHeader.status::Open);
                    InvestInterestHeader.modify(true);
                    Variant := InvestInterestHeader;
                end;
            database::"Investment Header":
                begin
                    InvHeader.validate(status, InvHeader.status::Open);
                    InvHeader.modify(true);
                    Variant := InvHeader;
                end;
            database::"Parking Space":
                begin
                    ParkingSpace.validate(status, ParkingSpace.status::Open);
                    ParkingSpace.modify(true);
                    Variant := ParkingSpace;
                end;
            database::"Fosa Payments Header":
                begin
                    FOSAPV.validate(status, FOSAPV.status::Open);
                    FOSAPV.modify(true);
                    Variant := FOSAPV;
                end;
            database::"Security Perfection":
                begin
                    SecurityPerfection.validate(status, SecurityPerfection.Status::Open);
                    SecurityPerfection.modify(true);
                    Variant := SecurityPerfection;
                end;

            database::Customer:
                begin
                    RecRef.SetTable(Customer);
                    Customer.validate(status, Customer.Status::New);
                    Customer.modify(true);
                    Variant := Customer;
                end;
            database::"Overtime Claim Header":
                begin
                    RecRef.SetTable(Overtime);
                    Overtime.validate(status, Overtime.Status::Open);
                    Overtime.modify(true);
                    Variant := Overtime;
                end;
            database::"Interest Header":
                begin
                    RecRef.SetTable(InterestHeader);
                    InterestHeader.validate(status, InterestHeader.Status::Open);
                    InterestHeader.modify(true);
                    Variant := InterestHeader;
                end;
            database::Legal:
                begin
                    RecRef.SetTable(Legal);
                    Legal.validate(status, Legal.Status::Open);
                    Legal.modify(true);
                    Variant := Legal;
                end;
            Database::"Dispatch ATM Header":
                begin
                    RecRef.SetTable(DispatchATM);
                    DispatchATM.validate(status, DispatchATM.Status::Open);
                    DispatchATM.modify(true);
                    Variant := DispatchATM;
                end;
            Database::"Vehicle Movement":
                begin
                    RecRef.SetTable(VehicleMovement);
                    VehicleMovement.validate(status, VehicleMovement.Status::Open);
                    VehicleMovement.modify(true);
                    Variant := VehicleMovement;
                end;
            database::"Motor Vehicle Request":
                begin
                    RecRef.SetTable(VehicleRequest);
                    VehicleRequest.Validate(Status, VehicleRequest.Status::Open);
                    VehicleRequest.modify(true);
                    Variant := VehicleRequest;
                end;
            Database::"Refund,Account Transfer Header":
                begin
                    RecRef.SetTable(RefundTransfer);
                    RefundTransfer.Validate(Status, RefundTransfer.Status::Open);
                    RefundTransfer.modify(true);
                    Variant := RefundTransfer;
                end;

            // Database::"Conference & Meeting Rooms-T":
            //     begin
            //         RecRef.SetTable(ConferenceAndMeetingRooms);
            //         ConferenceAndMeetingRooms.Validate(Status, ConferenceAndMeetingRooms.Status::Open);
            //         ConferenceAndMeetingRooms.modify(true);
            //         Variant := ConferenceAndMeetingRooms;
            //     end;
            Database::"Fixed Deposit Contract":
                begin
                    RecRef.SetTable(FixedDepositContract);
                    FixedDepositContract.Validate(Status, FixedDepositContract.Status::Open);
                    FixedDepositContract.modify(true);
                    Variant := FixedDepositContract;
                end;
            Database::"System Reversal":
                begin
                    RecRef.SetTable(SystemReversal);
                    SystemReversal.Validate(Status, SystemReversal.Status::Open);
                    SystemReversal.modify(true);
                    Variant := SystemReversal;
                end;

            Database::"Product Factory":
                begin
                    ProductFactory.Validate(Status, ProductFactory.Status::Open);
                    ProductFactory.modify(true);
                    Variant := ProductFactory;
                end;

            Database::"User Creation Requests":
                begin
                    RecRef.SetTable(UserCreation);
                    UserCreation.Validate(Status, UserCreation.Status::Open);
                    UserCreation.modify(true);
                    Variant := UserCreation;
                end;
            Database::"User Termination":
                begin
                    RecRef.SetTable(UserTermination);
                    UserTermination.Validate(Status, UserTermination.Status::Open);
                    UserTermination.modify(true);
                    Variant := UserTermination;
                end;
            Database::"Business Loan Clossure":
                begin
                    BusinessLoanClossure.Validate(Status, BusinessLoanClossure.Status::Open);
                    BusinessLoanClossure.modify(true);
                    Variant := BusinessLoanClossure;
                end;
            database::"Vehicle Movement":
                begin
                    RecRef.SetTable(VehicleMovement);
                    VehicleMovement.Validate(Status, VehicleMovement.Status::Open);
                    VehicleMovement.modify(true);
                    Variant := VehicleMovement;
                end;
            Database::"One Month Installment":
                begin
                    RecRef.SetTable(OneMonthInstallments);
                    OneMonthInstallments.Validate(Status, OneMonthInstallments.Status::Open);
                    OneMonthInstallments.modify(true);
                    Variant := OneMonthInstallments;
                end;
            Database::"Dependancies Applications":
                begin
                    RecRef.SetTable(DependancyApplications);
                    DependancyApplications.Validate(Status, DependancyApplications.Status::Open);
                    DependancyApplications.Modify(true);
                    Variant := DependancyApplications;
                end;
            Database::"System Edits":
                begin
                    RecRef.SetTable(SystemEdits);
                    SystemEdits.Validate(Status, SystemEdits.Status::Open);
                    SystemEdits.Modify(true);
                    Variant := SystemEdits;
                end;
            Database::"B/S Loan Account Application":
                begin
                    RecRef.SetTable(BSLoansAccApp);
                    BSLoansAccApp.Validate(Status, BSLoansAccApp.Status::Open);
                    BSLoansAccApp.modify(true);
                    Variant := BSLoansAccApp;
                end;
            Database::"Electoral Zones":
                begin
                    RecRef.SetTable(ElectoralZones);
                    ElectoralZones.Validate(Status, DelegateAGMUpdateHeader.Status::Open);
                    ElectoralZones.modify(true);
                    Variant := ElectoralZones;
                end;
            Database::"Moratorium Loan":
                begin
                    RecRef.SetTable(MoratoriumLoan);
                    MoratoriumLoan.Validate(Status, MoratoriumLoan.Status::Open);
                    MoratoriumLoan.modify(true);
                    Variant := MoratoriumLoan;
                end;

            Database::"Share Capital Transfer Buffer":
                begin
                    RecRef.SetTable(Sharetransfer);
                    sharetransfer.Validate(Status, sharetransfer.Status::Open);
                    sharetransfer.Modify(true);
                    Variant := sharetransfer;
                end;
            Database::"HR Leave Journal Line":
                begin
                    RecRef.SetTable(HRLeaveJournalLine);
                    HRLeaveJournalLine.Validate(Status, HRLeaveJournalLine.Status::Open);
                    HRLeaveJournalLine.modify(true);
                    Variant := HRLeaveJournalLine;
                end;

            Database::"Delegate Officials":
                begin
                    RecRef.SetTable(DelegateOfficials);
                    DelegateOfficials.Validate(Status, DelegateOfficials.Status::Open);
                    DelegateOfficials.modify(true);
                    Variant := DelegateOfficials;
                end;

            //Sky Virtual Member
            Database::"Sky Virtual Member":
                begin
                    RecRef.SetTable(SkyVirtualMember);
                    SkyVirtualMember.Validate(Status, SkyVirtualMember.Status::Open);
                    SkyVirtualMember.modify(true);
                    Variant := SkyVirtualMember;
                end;
            //Sky Virtual Member

            Database::"SinkFund Report Information":
                begin
                    RecRef.SetTable(SinkFundReportInformation);
                    SinkFundReportInformation.Validate(Status, SinkFundReportInformation.Status::Open);
                    SinkFundReportInformation.Modify(true);
                    Variant := SinkFundReportInformation;
                end;

            Database::"Delegate Region Change":
                begin
                    RecRef.SetTable(DelegateRegionChange);
                    SinkFundReportInformation.Validate(Status, DelegateRegionChange.Status::Open);
                    DelegateRegionChange.modify(true);
                    Variant := DelegateRegionChange;
                end;



            Database::"Banking Account Closure":
                begin
                    RecRef.SetTable(BankingAccountClosure);
                    BankingAccountClosure.Validate(Status, BankingAccountClosure.Status::Open);
                    BankingAccountClosure.modify(true);
                    Variant := BankingAccountClosure;
                end;



            Database::"AGM Delegates Payment":
                begin
                    RecRef.SetTable(AGMDelegatesPayment);
                    AGMDelegatesPayment.Validate(Status, AGMDelegatesPayment.Status::Open);
                    AGMDelegatesPayment.modify(true);
                    Variant := AGMDelegatesPayment;
                end;




            Database::"Delegate AGM Update Header":
                begin
                    RecRef.SetTable(DelegateAGMUpdateHeader);
                    DelegateAGMUpdateHeader.Validate(Status, DelegateAGMUpdateHeader.Status::Open);
                    DelegateAGMUpdateHeader.modify(true);
                    Variant := DelegateAGMUpdateHeader;
                end;



            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Validate(Status, PaymentsHeader.Status::Pending);
                    PaymentsHeader.modify(true);
                    Variant := PaymentsHeader;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaimsHeader);
                    StaffClaimsHeader.Validate(Status, StaffClaimsHeader.Status::Pending);
                    StaffClaimsHeader.modify(true);
                    Variant := StaffClaimsHeader;
                end;
            Database::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvanceHeader);
                    StaffAdvanceHeader.Validate(Status, StaffAdvanceHeader.Status::Pending);
                    StaffAdvanceHeader.modify(true);
                    Variant := StaffAdvanceHeader;
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(StaffAdvanceSurrenderHeader);
                    StaffAdvanceSurrenderHeader.Validate(Status, StaffAdvanceSurrenderHeader.Status::Pending);
                    StaffAdvanceSurrenderHeader.modify(true);
                    Variant := StaffAdvanceSurrenderHeader;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::Pending);
                    ImprestHeader.modify(true);
                    Variant := ImprestHeader;
                end;
            //Property Lease
            Database::Lease:
                begin
                    RecRef.SetTable(LeaseDoc);
                    LeaseDoc.Validate(Status, LeaseDoc.Status::Open);
                    LeaseDoc.modify(true);
                    Variant := LeaseDoc;
                end;
            //end Property Lease
            //Property
            Database::"Property Details":
                begin
                    RecRef.SetTable(PropertyDetails);
                    PropertyDetails.Validate(Status, PropertyDetails.Status::Open);
                    PropertyDetails.modify(true);
                    Variant := PropertyDetails;
                end;
            //end Property

            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrenderHeader);
                    ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::Pending);
                    ImprestSurrenderHeader.modify(true);
                    Variant := ImprestSurrenderHeader;
                end;
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequistionHeader);
                    StoreRequistionHeader.Validate(Status, StoreRequistionHeader.Status::Open);
                    StoreRequistionHeader.modify(true);
                    Variant := StoreRequistionHeader;
                end;
            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTransfers);
                    InterBankTransfers.Validate(Status, InterBankTransfers.Status::Pending);
                    InterBankTransfers.modify(true);
                    Variant := InterBankTransfers;
                end;
            Database::"Overtime Claim Header":
                begin
                    RecRef.SetTable(OvertimeClaimHeader);
                    OvertimeClaimHeader.Validate(Status, OvertimeClaimHeader.Status::"Pending Approval");
                    OvertimeClaimHeader.modify(true);
                    Variant := OvertimeClaimHeader;
                end;
            Database::"G/L Budget Name":
                begin
                    RecRef.SetTable(Budget);
                    Budget.Validate(Status, Budget.Status::Open);
                    Budget.modify(true);
                    Variant := Budget;
                end;
           
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(Vote);
                    Vote.Validate(Status, Vote.Status::Open);
                    Vote.modify(true);
                    Variant := Vote;
                end;
            Database::"Asset Transfer":
                begin
                    RecRef.SetTable(AssetTransfer);
                    AssetTransfer.Validate(Status, AssetTransfer.Status::New);
                    AssetTransfer.modify(true);
                    Variant := AssetTransfer;
                end;
            Database::"Payments Header Board":
                begin
                    RecRef.SetTable(PaymentsHeaderBoard);
                    PaymentsHeaderBoard.Validate(Status, PaymentsHeaderBoard.Status::Pending);
                    PaymentsHeaderBoard.modify(true);
                    Variant := PaymentsHeaderBoard;
                end;
            
            Database::Vendor:
                begin
                    RecRef.SetTable(Vendor);
                    Vendor.Validate(Status, Vendor.Status::New);
                    Vendor.modify(true);
                    Variant := Vendor;
                end;
            //Cashier Transactions
            Database::"Cashier Transactions":
                begin
                    RecRef.SetTable(ctrans);
                    ctrans.Validate(Status, ctrans.Status::Open);
                    ctrans.modify(true);
                    Variant := ctrans;
                end;

            //Salary Transactions
            Database::"Salary Header":
                begin
                    RecRef.SetTable(Sal);
                    Sal.Validate(Status, Sal.Status::Open);
                    Sal.modify(true);
                    Variant := Sal;
                end;
            //Salary Transactions

            //Bankers Cheque
            Database::"Bankers Cheque Application":
                begin
                    RecRef.SetTable(BankersC);
                    BankersC.Validate(Status, BankersC.Status::Open);
                    BankersC.modify(true);
                    Variant := BankersC;
                end;
            //Bankers Cheque

            //Bank Cheque
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(BankC);
                    BankC.Validate(Status, BankC.Status::Open);
                    BankC.modify(true);
                    Variant := BankC;
                end;
            //Bank Cheque

            //Over Draft
            Database::"Over Draft Authorisation":
                begin
                    RecRef.SetTable(OD);
                    OD.Validate(Status, OD.Status::Open);
                    OD.modify(true);
                    Variant := OD;
                end;
            //Over Draft

            //Account Transfers
            Database::"Account Transfer Header":
                begin
                    RecRef.SetTable(ACT);
                    ACT.Validate(Status, ACT.Status::Open);
                    ACT.modify(true);
                    Variant := ACT;
                end;
            //Account Transfers

            //Inter Teller
            Database::"Treasury Cashier Transactions":
                begin
                    RecRef.SetTable(TREAS);
                    TREAS.Validate(Status, TREAS.Status::Open);
                    TREAS.modify(true);
                    Variant := TREAS;
                end;
            //Inter Teller

            //Investments
            Database::"Investment Header":
                begin
                    RecRef.SetTable(INV);
                    INV.Validate(Status, INV.Status::Open);
                    INV.modify(true);
                    Variant := INV;
                end;
            //Investments


            //Cheque receipts
            Database::"Cheque Receipts":
                begin
                    RecRef.SetTable(CHQ);
                    CHQ.Validate(Status, CHQ.Status::Open);
                    CHQ.modify(true);
                    Variant := CHQ;
                end;
            //Cheque Receipts

            //Member Application
            Database::"Member Application":
                begin
                    RecRef.SetTable(MemberAppl);
                    MemberAppl.Validate(Status, MemberAppl.Status::Open);
                    MemberAppl.modify(true);
                    Variant := MemberAppl;
                end;//

            //HR Employees
            Database::"HR Employees":
                begin
                    RecRef.SetTable(HREmployees);
                    HREmployees.Validate(Status, HREmployees.Status::New);
                    HREmployees.modify(true);
                    Variant := HREmployees;
                end;//

            //Salary Agreement
            Database::"Salary Agreement":
                begin
                    RecRef.SetTable(SalaryAgreement);
                    SalaryAgreement.Validate(Status, SalaryAgreement.Status::Open);
                    SalaryAgreement.modify(true);
                    Variant := SalaryAgreement;
                end;//

            //Account Application
            Database::"Savings Account Application":
                begin
                    RecRef.SetTable(SAccountAppl);
                    SAccountAppl.Validate(Status, SAccountAppl.Status::Open);
                    SAccountAppl.modify(true);
                    Variant := SAccountAppl;
                end;//
                    //Electronic Fund Transfer Application
            Database::"RTGS Transfer Header":
                begin
                    RecRef.SetTable(RTGSAppl);
                    RTGSAppl.Validate(Status, RTGSAppl.Status::Open);
                    RTGSAppl.modify(true);
                    Variant := RTGSAppl;
                end;//
                    //Standing Order Application
            Database::"Standing Order Header":
                begin
                    RecRef.SetTable(STOAppl);
                    STOAppl.Validate(Status, STOAppl.Status::Open);
                    STOAppl.modify(true);
                    Variant := STOAppl;
                end;//
                    //Standing Order Control Application
            Database::"Standing Order Control":
                begin
                    RecRef.SetTable(StandingOrderControl);
                    StandingOrderControl.Validate(Status, StandingOrderControl.Status::Open);
                    StandingOrderControl.modify(true);
                    Variant := StandingOrderControl;
                end;//
                    //Dividend Rate Application
            Database::"Dividend Simulation Header":
                begin
                    RecRef.SetTable(DividendsSimulationHeader);
                    DividendsSimulationHeader.Validate(Status, DividendsSimulationHeader.Status::Open);
                    DividendsSimulationHeader.modify(true);
                    Variant := DividendsSimulationHeader;
                end;//


            Database::Loans:
                begin
                    RecRef.SetTable(Loans);
                    Loans.Validate(Status, Loans.Status::Open);
                    Loans.modify(true);
                    Variant := Loans;
                end;
            //Collateral

            //Collateral return
            Database::"Securities Collection Register":
                begin
                    RecRef.SetTable(SecuritiesCollectionRegister);
                    SecuritiesCollectionRegister.Validate(Status, SecuritiesCollectionRegister.Status::Open);
                    SecuritiesCollectionRegister.modify(true);
                    Variant := SecuritiesCollectionRegister;
                end;
            //Loan batch
            Database::"Loan Disbursement Header":
                begin
                    RecRef.SetTable(LoanBatch);
                    LoanBatch.Validate(Status, LoanBatch.Status::Open);
                    LoanBatch.modify(true);
                    Variant := LoanBatch;
                end;
            //Interest Billing
            Database::"Interest Header":
                begin
                    RecRef.SetTable(InterestHeader);
                    InterestHeader.Validate(Status, InterestHeader.Status::Open);
                    InterestHeader.modify(true);
                    Variant := InterestHeader;
                end;//
                    //Savings Interest Header
            Database::"Savings Interest Header":
                begin
                    RecRef.SetTable(SavingsInterestHeader);
                    SavingsInterestHeader.Validate(Status, SavingsInterestHeader.Status::Open);
                    SavingsInterestHeader.modify(true);
                    Variant := SavingsInterestHeader;
                end;//
                    //End Year Transfer Header
            Database::"End Year Transfer Header":
                begin
                    RecRef.SetTable(EndYearTransferHeader);
                    EndYearTransferHeader.Validate(Status, EndYearTransferHeader.Status::Open);
                    EndYearTransferHeader.modify(true);
                    Variant := EndYearTransferHeader;
                end;//


            //ATM Applications
            Database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMApplications);
                    ATMApplications.Validate(Status, ATMApplications.Status::Open);
                    ATMApplications.modify(true);
                    Variant := ATMApplications;
                end;//
                    //ATM Linking Applications
            Database::"ATM Linking Applications":
                begin
                    RecRef.SetTable(ATMLinkingApplications);
                    ATMLinkingApplications.Validate(Status, ATMLinkingApplications.Status::Open);
                    ATMLinkingApplications.modify(true);
                    Variant := ATMLinkingApplications;
                end;//
                    //Checkoff
            Database::"Checkoff Header":
                begin
                    RecRef.SetTable(Checkoff);
                    Checkoff.Validate(Status, Checkoff.Status::Open);
                    Checkoff.modify(true);
                    Variant := Checkoff;
                end;
            //
            //Membership Closure
            Database::"Membership closure":
                begin
                    RecRef.SetTable(MembClosure);
                    MembClosure.Validate(Status, MembClosure.Status::Open);
                    MembClosure.modify(true);
                    Variant := MembClosure;
                end;
            //

            //Lona Resheduling
            Database::"Loan Rescheduling":
                begin
                    RecRef.SetTable(LoanRescheduling);
                    LoanRescheduling.Validate(Status, LoanRescheduling.Status::Open);
                    LoanRescheduling.modify(true);
                    Variant := LoanRescheduling;
                end;
            //
            //Legal
            Database::Contracts:
                begin
                    RecRef.SetTable(contrct);
                    contrct.Validate(Status, contrct.Status::New);
                    contrct.modify(true);
                    Variant := contrct;
                end;
            //

            //Member Withdrawal
            Database::"Member withdrawal Notice":
                begin
                    RecRef.SetTable(MemberwithdrawalNotice);
                    MemberwithdrawalNotice.Validate(Status, MemberwithdrawalNotice.Status::Open);
                    MemberwithdrawalNotice.modify(true);
                    Variant := MemberwithdrawalNotice;
                end;
            //

            //Gurantor Substitution
            Database::"Guarantors Substitution":
                begin
                    RecRef.SetTable(GuarantorsSubstitution);
                    GuarantorsSubstitution.Validate(Status, GuarantorsSubstitution.Status::Open);
                    GuarantorsSubstitution.modify(true);
                    Variant := GuarantorsSubstitution;
                end;
            //

            //Loan Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Validate(Status, LoanRecoveryHeader.Status::Open);
                    LoanRecoveryHeader.modify(true);
                    Variant := LoanRecoveryHeader;
                end;
            //Loan Recovery
            Database::"Loan Recovery Header II":
                begin
                    RecRef.SetTable(LoanRecoveryHeaderII);
                    LoanRecoveryHeaderII.Validate(Status, LoanRecoveryHeaderII.Status::Open);
                    LoanRecoveryHeaderII.modify(true);
                    Variant := LoanRecoveryHeaderII;
                end;
            //

            //Bond
            Database::Bond:
                begin
                    RecRef.SetTable(Bond);
                    Bond.Validate("Bond Status", Bond."bond status"::Open);
                    Bond.modify(true);
                    Variant := Bond;
                end;
            //

            //Sink Fund
            Database::"BBF Requisation Header":
                begin
                    RecRef.SetTable(BBFRequisationHeader);
                    BBFRequisationHeader.Validate(Status, BBFRequisationHeader.Status::Open);
                    BBFRequisationHeader.modify(true);
                    Variant := BBFRequisationHeader;
                end;
            //

            //BDE Management
            Database::"BDE Management Header":
                begin
                    RecRef.SetTable(BDEManagementHeader);
                    BDEManagementHeader.Validate(Status, BDEManagementHeader.Status::Open);
                    BDEManagementHeader.modify(true);
                    Variant := BDEManagementHeader;
                end;
            //
            //Delegate Groups Applicationss
            Database::"Delegate Region Applicationss":
                begin
                    RecRef.SetTable(DelegateGroupsApplicationss);
                    DelegateGroupsApplicationss.Validate(Status, DelegateGroupsApplicationss.Status::Open);
                    DelegateGroupsApplicationss.modify(true);
                    Variant := DelegateGroupsApplicationss;
                end;
            //Delegate Group Mem Retirements
            Database::"Delegate Region Mem Retirement":
                begin
                    RecRef.SetTable(DelegateGroupMemRetirements);
                    DelegateGroupMemRetirements.Validate(Status, DelegateGroupMemRetirements.Status::Open);
                    DelegateGroupMemRetirements.modify(true);
                    Variant := DelegateGroupMemRetirements;
                end;
            //Delegates Payment
            Database::"Delegates Payment":
                begin
                    RecRef.SetTable(DelegatesPayment);
                    DelegatesPayment.Validate(Status, DelegatesPayment.Status::Open);
                    DelegatesPayment.modify(true);
                    Variant := DelegatesPayment;
                end;


            //HR______________
            //HR
            //Jobs
            Database::"HR Jobs":
                begin
                    RecRef.SetTable(HRJobs);
                    HRJobs.Validate(Status, HRJobs.Status::Open);
                    HRJobs.modify(true);
                    Variant := HRJobs;
                end;
            //HR Jobs
            //HR leave Planner
            Database::"HR Leave Planner Header":
                begin
                    RecRef.SetTable(leavePlanner);
                    leavePlanner.Validate(Status, leavePlanner.Status::New);
                    leavePlanner.modify(true);
                    Variant := leavePlanner;
                end;
            //HR Intern Requisition
            Database::"HR Interns Requisition":
                begin
                    RecRef.SetTable(HRInternReq);
                    HRInternReq.Validate(Status, HRInternReq.Status::Open);
                    HRInternReq.modify(true);
                    Variant := HRInternReq;
                end;
            //HR Intern Requisition

            //Employee Requisition
            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(Hrempreq);
                    Hrempreq.Validate("Approval Status", Hrempreq."approval status"::Open);
                    Hrempreq.modify(true);
                    Variant := Hrempreq;
                end;


            //Leave
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::New);
                    Leave.modify(true);
                    Variant := Leave;
                end;


            //Training Feedback
            Database::"HR Training Feedback Form":
                begin
                    RecRef.SetTable(TFeed);
                    TFeed.Validate(Status, TFeed.Status::New);
                    TFeed.modify(true);
                    Variant := TFeed;
                end;


            //Interns
            Database::"HR Interns":
                begin
                    RecRef.SetTable(Intern);
                    Intern.Validate("Posting Status", Intern."posting status"::Open);
                    Intern.modify(true);
                    Variant := Intern;
                end;

            //Appraisal Appeal
            Database::"HR Appraissal Appeal":
                begin
                    RecRef.SetTable(AppraisalAppeal);
                    AppraisalAppeal.Validate(Status, AppraisalAppeal.Status::New);
                    AppraisalAppeal.modify(true);
                    Variant := AppraisalAppeal;
                end;

            //Disciplinary Appeal
            Database::"HRDisciplinary Appeal":
                begin
                    RecRef.SetTable(DisciplinaryAppeal);
                    DisciplinaryAppeal.Validate(Status, DisciplinaryAppeal.Status::New);
                    DisciplinaryAppeal.modify(true);
                    Variant := DisciplinaryAppeal;
                end;

            //Disciplinary Withdrwal
            Database::"HRDisciplinary Case Withdrawal":
                begin
                    RecRef.SetTable(DiscWithdrawal);
                    DiscWithdrawal.Validate(Status, DiscWithdrawal.Status::New);
                    DiscWithdrawal.modify(true);
                    Variant := DiscWithdrawal;
                end;


            //Disciplinary
            Database::"HR Disciplinary Cases NCA":
                begin
                    RecRef.SetTable(Disciplinary);
                    Disciplinary.Validate(Status, Disciplinary.Status::New);
                    Disciplinary.modify(true);
                    Variant := Disciplinary;
                end;

            //Staff Loan
            Database::"prSalary Advance":
                begin
                    RecRef.SetTable(StaffLoan);
                    StaffLoan.Validate(Status, StaffLoan.Status::New);
                    StaffLoan.modify(true);
                    Variant := StaffLoan;
                end;

            //Training Need
            Database::"HR Training Needs":
                begin
                    RecRef.SetTable(TNeed);
                    TNeed.Validate(Status, TNeed.Status::New);
                    TNeed.modify(true);
                    Variant := TNeed;
                end;
            //Training
            Database::"HR Training App Header":
                begin
                    RecRef.SetTable(hrtraining);
                    hrtraining.Validate(Status, hrtraining.Status::New);
                    hrtraining.modify(true);
                    Variant := hrtraining;
                end;

            //Permission Requistion
            Database::"Permission Requisition":
                begin
                    RecRef.SetTable(PermissionReq);
                    PermissionReq.Validate(Status, PermissionReq.Status::Open);
                    PermissionReq.modify(true);
                    Variant := PermissionReq;
                end;
            //Hr Transport hrtransport
            Database::"HR Transport Requisition Head":
                begin
                    RecRef.SetTable(hrtransport);
                    hrtransport.Validate(Status, hrtransport.Status::New);
                    hrtransport.modify(true);
                    Variant := hrtransport;
                end;

            //Hr Emplpoyee Transfer EmpTrans
            Database::"HR Employee Transfer Header":
                begin
                    RecRef.SetTable(EmpTrans);
                    EmpTrans.Validate(Status, EmpTrans.Status::New);
                    EmpTrans.modify(true);
                    Variant := EmpTrans;
                end;
            //end HR

            // M-SACCO PIN No Change MSACCOPIN
            Database::"M-SACCO Change PIN No":
                begin
                    RecRef.SetTable(MsaccoPIN);
                    MsaccoPIN.Validate(Status, MsaccoPIN.Status::Open);
                    MsaccoPIN.modify(true);
                    Variant := MsaccoPIN;
                end;


            //legal
            Database::Legal:
                begin
                    RecRef.SetTable(Cases1);
                    Cases1.Validate(Status, Cases1.Status::Open);
                    Cases1.modify(true);
                    Variant := Cases1;
                end;
            //SuretyMangt
            Database::"Surety Management":
                begin
                    RecRef.SetTable(SuretyMangt);
                    SuretyMangt.Validate(Status, SuretyMangt.Status::Open);
                    SuretyMangt.modify(true);
                    Variant := SuretyMangt;
                end;



            /* // M-SACCO Applications
              DATABASE::"M-SACCO Applications":
              BEGIN
                 RecRef.SETTABLE(MsaccoApp);
                 MsaccoApp.VALIDATE(Status,MsaccoApp.Status::Open);
                 MsaccoApp.modify(true);
                 Variant := MsaccoApp;
                END;*/


            // M-SACCO Applications
            Database::"M-SACCO Applications":
                begin
                    RecRef.SetTable(MsaccoApp);
                    MsaccoApp.Validate(Status, MsaccoApp.Status::Open);
                    MsaccoApp.modify(true);
                    Variant := MsaccoApp;
                end;

            //Agent Applications
            Database::"Agent Applications":
                begin
                    RecRef.SetTable(AgentApplications);
                    AgentApplications.Validate("Approval Status", AgentApplications."approval status"::Open);
                    AgentApplications.modify(true);
                    Variant := AgentApplications;
                end;


            // Mortgage Release Doc
            Database::"Mortgage Loans Doc Release":
                begin
                    RecRef.SetTable(MortDoc);
                    MortDoc.Validate(Status, MortDoc.Status::Open);
                    MortDoc.modify(true);
                    Variant := MortDoc;
                end;


            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end

    end;

    procedure SetStatusToPending(var Variant: Variant)
    var
        RecRef: RecordRef;
        SystemEdits: Record "System Edits";
        SecuritiesReg: Record "Securities Register";
        DependancyApplications: Record "Dependancies Applications";
        PaymentsHeader: Record 52185888;
        StaffClaimsHeader: Record 52185912;
        StaffAdvanceHeader: Record 52185914;
        StaffAdvanceSurrenderHeader: Record 52185916;
        ImprestHeader: Record 52185909;
        ImprestSurrenderHeader: Record 52185885;
        StoreRequistionHeader: Record 52185868;
        InterBankTransfers: Record 52185881;
        OvertimeClaimHeader: Record 52185936;
        Budget: Record "G/L Budget Name";
        Vote: Record "Vote Transfer";
        AssetTransfer: Record 52185892;
        PaymentsHeaderBoard: Record 52185895;
        Vendor: Record Vendor;
        ctrans: Record 52185776;
        Sal: Record 52185783;
        MemberAppl: Record 52185691;
        SAccountAppl: Record 52185704;
        RTGSAppl: Record 52185715;
        STOAppl: Record 52185717;
        StandingOrderControl: Record 52185722;
        DeactivateReactivateHeader: Record 52185753;
        Loans: Record 52185729;
        ProductFactoryApplication: Record 52186117;
        BankersC: Record 52185793;
        BankC: Record 52185785;
        OD: Record 52185795;
        ACT: Record 52185797;
        TREAS: Record 52185778;
        INV: Record 52185807;
        CHQ: Record 52185787;
        LoanBatch: Record 52185736;
        DividendsSimulationHeader: Record 52185710;
        InterestHeader: Record 52185860;
        SavingsInterestHeader: Record 52185845;
        EndYearTransferHeader: Record 52185847;
        ATMApplications: Record 52185850;
        ATMLinkingApplications: Record 52185842;
        Checkoff: Record 52185819;
        MembClosure: Record 52185824;
        LoanRescheduling: Record 52185823;
        MemberwithdrawalNotice: Record 52185826;
        GuarantorsSubstitution: Record 52185828;
        LoanRecoveryHeader: Record 52185829;
        LoanRecoveryHeaderII: Record "Loan Recovery Header II";
        Bond: Record 52185835;
        BDEManagementHeader: Record 52186128;
        DelegateGroupsApplicationss: Record 52186064;
        DelegateGroupMemRetirements: Record 52186065;
        DelegatesPayment: Record 52186067;
        HRJobs: Record 52185508;
        Hrempreq: Record 52185519;
        Leave: Record 52185532;
        hrtraining: Record 52185580;
        hrtransport: Record 52185571;
        EmpTrans: Record 52185576;
        HRInternReq: Record 52185612;
        leavePlanner: Record 52185542;
        MsaccoPIN: Record 52185768;
        MsaccoApp: Record 52185757;
        StaffLoan: Record 52185674;
        TNeed: Record 52185581;
        SecuritiesCollectionRegister: Record 52185843;
        BBFRequisationHeader: Record 52186126;
        Disciplinary: Record 52186162;
        AppraisalAppeal: Record 52185596;
        DisciplinaryAppeal: Record 52185970;
        DiscWithdrawal: Record 52185971;
        LeaseDoc: Record 52186008;
        TFeed: Record 52186205;
        Intern: Record 52185611;
        PropertyDetails: Record 52186005;
        Cases1: Record 52185957;
        contrct: Record 52185942;
        SuretyMangt: Record 52185964;
        AgentApplications: Record 52186104;
        SinkFundReportInformation: Record 52185940;
        AGMDelegatesPayment: Record 52186209;
        BankingAccountClosure: Record 52186211;
        DelegateRegionChange: Record 52186074;
        DelegateAGMUpdateHeader: Record 52186077;
        MortDoc: Record 52186089;
        SalaryAgreement: Record 52186037;
        HREmployees: Record 52185650;
        //PermissionRequisition: Record 52186039;
        SkyVirtualMember: Record 52185499;
        ElectoralZones: Record 52186239;
        DelegateOfficials: Record 52186240;
        Hrleave: Record 52185544;
        Sharetransfer: Record "Share Capital Transfer Buffer";
        MoratoriumLoan: Record "Moratorium Loan";
        BSLoansAccApp: Record "B/S Loan Account Application";
        OneMonthInstallments: Record "One Month Installment";
        BusinessLoanClossure: Record "Business Loan Clossure";
        SystemReversal: Record "System Reversal";
        FixedDepositContract: Record "Fixed Deposit Contract";
        VehicleRequest: Record "Motor Vehicle Request";
        CompanyVehicles: Record "Company Vehicles";
        VehicleMovement: Record "Vehicle Movement";
        //ConferenceAndMeetingRooms: Record "Conference & Meeting Rooms-T";
        DMUCaseForwarding: Record "DMU Case Forwarding";
        UserCreation: Record "User Creation Requests";
        UserTermination: Record "User Termination";
        ProductFactory: Record "Product Factory";
        DispatchATM: Record "Dispatch ATM Header";
        RefundTransfer: Record "Refund,Account Transfer Header";
        Legal: Record "Legal";
        VariationsRec: Record "Product Variations";
        Customer: Record Customer;
        InvHeader: Record "Investment Header";
        Jobs: record "HR Jobs";
        SecurityPerfection: Record "Security Perfection";
        InvestInterestHeader: Record "Investment Interest Header";
        FOSAPV: Record "Fosa Payments Header";
        SecurityDischarge: Record "Security Discharge";
        Minutes: Record "Delegates Minutes Header";
        BoardMemberPay: Record "Board members";
        HRLeaveJournalLine: Record "HR Leave Journal Line";
        //Leave : Record "HR Leave Application";
        HRDrivers: Record "HR Drivers";
        Lease: Record Lease;
        Surety: Record "Surety Management";
        ConferenceCreation: Record "Conf & Meeting Rooms List";
        ConferenceBooking: Record "Conference & Meeting Rooms-T";
        SMSAlerts: Record "SMS Alerts Header";
        Contracts: Record Contracts;
        Accidents: Record "HR OSAccident";
        Fuel: Record "HR Fuel Management Header";
        Appeals: Record "Appeals Table";
        KeyCreation: Record "Office Keys List";
        KeyRequest: Record "Key Request Table";
        BnkChq: Record "Bankers Cheque Application";
        TrTrans: Record "Treasury Cashier Transactions";
        Salary: Record "Salary Header";
        STO: Record "Standing Order Header";
        RTGS: Record "RTGS Transfer Header";
        ACTransfer: Record "Account Transfer Header";
        PermissionReq: Record "Permission Requisition";
        HrcompanyActivity: Record "HR Company Activities";
        HrAppraisal: Record "HR Appraisal Header";
        NomineeRequest: Record "Nominee Form Request";
        HrTPlanning: record "HR Training Planner";
        HrExitInterview: Record "HR Employee Exit Interviews";
        DivProvision: record "Dividends Provision Header";
        AccountAcv: record "account activation";
        ContractReq: Record "Contract Request";
        HrOverTime: record "HR Overtime Header";
        TreasureyApp: Record "Treasury Cheque Application";
        InsuaranceClaims: record "Insurance Claims";
        AssetInsuarance: Record Insurance;
        VehicleRepair: Record "Maintain Machne/Vehicles";
        VehicleServ: record "Vehicle Servicing Table";
        StockKeeping: Record "Stock Keeping";
        WellfareAdvance: Record "Welfare Advance";
        StaffWellafare: Record "Staff Welfare";
        ClearanceForm: Record "Clearance Form";
        BOSAAccActive: Record "BOSA Account Activation";
        Batchingprocess: Record "Batching Process Table";
        GeneralSMSHeader: Record "General SMS Header";
        Mkey: Record "MKey Forwarding";
        RevenueCollection: Record "Revenue Collection";
        FAReclassificationJournal: Record "FA Reclass. Journal Line";
        BankDeposit: Record "Bank Deposit Header";
        GroupUpdate: Record "Group Member Exit & Update";
    begin

        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Group Member Exit & Update":
                begin
                    RecRef.SetTable(GroupUpdate);
                    GroupUpdate.Validate(Status, GroupUpdate.Status::Open);
                    GroupUpdate.Modify(True);
                    Variant := GroupUpdate;
                end;
            Database::"Bank Deposit Header":
                begin
                    RecRef.SetTable(BankDeposit);
                    BankDeposit.Validate(Status, BankDeposit.Status::Open);
                    BankDeposit.modify(true);
                    Variant := BankDeposit;
                end;
            Database::"FA Reclass. Journal Line":
                begin
                    RecRef.SetTable(FAReclassificationJournal);
                    FAReclassificationJournal.Validate(Status, FAReclassificationJournal.Status::Open);
                    FAReclassificationJournal.modify(true);
                    Variant := FAReclassificationJournal;
                end;
            Database::"Revenue Collection":
                begin
                    RecRef.SetTable(RevenueCollection);
                    RevenueCollection.Validate(Status, RevenueCollection.Status::Pending);
                    RevenueCollection.modify(true);
                    Variant := RevenueCollection;
                end;
            Database::"MKey Forwarding":
                begin
                    RecRef.SetTable(Mkey);
                    Mkey.Validate(Status, Mkey.Status::Pending);
                    Mkey.modify(true);
                    Variant := Mkey;
                end;
            Database::"General SMS Header":
                begin
                    RecRef.SetTable(GeneralSMSHeader);
                    GeneralSMSHeader.Validate(Status, GeneralSMSHeader.Status::Pending);
                    GeneralSMSHeader.modify(true);
                    Variant := GeneralSMSHeader;
                end;
            Database::"Clearance Form":
                begin
                    RecRef.SetTable(ClearanceForm);
                    ClearanceForm.Validate(Status, ClearanceForm.Status::Pending);
                    ClearanceForm.modify(true);
                    Variant := ClearanceForm;
                end;
            Database::"Staff Welfare":
                begin
                    RecRef.SetTable(StaffWellafare);
                    StaffWellafare.Validate(Status, StaffWellafare.Status::"Pending Approval");
                    StaffWellafare.modify(true);
                    Variant := StaffWellafare;
                end;
            Database::"Welfare Advance":
                begin
                    RecRef.SetTable(WellfareAdvance);
                    WellfareAdvance.Validate(Status, WellfareAdvance.Status::Pending);
                    WellfareAdvance.modify(true);
                    Variant := WellfareAdvance;
                end;
            Database::"Stock Keeping":
                begin
                    RecRef.SetTable(StockKeeping);
                    StockKeeping.Validate(Status, StockKeeping.Status::Pending);
                    StockKeeping.modify(true);
                    Variant := StockKeeping;
                end;
            Database::"Vehicle Servicing Table":
                begin
                    RecRef.SetTable(VehicleServ);
                    VehicleServ.Validate(Status, VehicleServ.Status::Pending);
                    VehicleServ.modify(true);
                    Variant := VehicleServ;
                end;
            Database::"Maintain Machne/Vehicles":
                begin
                    RecRef.SetTable(VehicleRepair);
                    VehicleRepair.Validate(Status, VehicleRepair.Status::Pending);
                    VehicleRepair.modify(true);
                    Variant := VehicleRepair;
                end;
            Database::Insurance:
                begin
                    RecRef.SetTable(AssetInsuarance);
                    AssetInsuarance.Validate(Status, AssetInsuarance.Status::Pending);
                    AssetInsuarance.modify(true);
                    Variant := AssetInsuarance;
                end;
            Database::"Insurance Claims":
                begin
                    RecRef.SetTable(InsuaranceClaims);
                    InsuaranceClaims.Validate(Status, InsuaranceClaims.Status::Pending);
                    InsuaranceClaims.modify(true);
                    Variant := InsuaranceClaims;
                end;
            Database::"Treasury Cheque Application":
                begin
                    RecRef.SetTable(TreasureyApp);
                    TreasureyApp.Validate(Status, TreasureyApp.Status::"Pending Approval");
                    TreasureyApp.modify(true);
                    Variant := TreasureyApp;
                end;
            Database::"BOSA Account Activation":
                begin
                    RecRef.SetTable(BOSAAccActive);
                    BOSAAccActive.Validate(Status, BOSAAccActive.Status::Pending);
                    BOSAAccActive.modify(true);
                    Variant := BOSAAccActive;
                end;
            Database::"HR Overtime Header":
                begin
                    RecRef.SetTable(HrOverTime);
                    HrOverTime.Validate(Status, HrOverTime.Status::"Pending Approval");
                    HrOverTime.modify(true);
                    Variant := HrOverTime;
                end;
            Database::"Contract Request":
                begin
                    RecRef.SetTable(ContractReq);
                    ContractReq.Validate(Status, ContractReq.Status::pending);
                    ContractReq.modify(true);
                    Variant := ContractReq;
                end;
            Database::"account activation":
                begin
                    RecRef.SetTable(AccountAcv);
                    AccountAcv.Validate(Status, AccountAcv.Status::pending);
                    AccountAcv.modify(true);
                    Variant := AccountAcv;
                end;
            Database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMApplications);
                    ATMApplications.Validate(Status, ATMApplications.Status::"Pending Approval");
                    ATMApplications.modify(true);
                    Variant := ATMApplications;
                end;
            Database::"Dividends Provision Header":
                begin
                    RecRef.SetTable(DivProvision);
                    DivProvision.Validate(Status, DivProvision.Status::"Pending Approval");
                    DivProvision.modify(true);
                    Variant := DivProvision;
                end;
            Database::"HR Employee Exit Interviews":
                begin
                    RecRef.SetTable(HrExitInterview);
                    HrExitInterview.Validate(Status, HrExitInterview.Status::"Pending Approval");
                    HrExitInterview.modify(true);
                    Variant := HrExitInterview;
                end;
            Database::"HR Training Planner":
                begin
                    RecRef.SetTable(HrTPlanning);
                    HrTPlanning.Validate(Status, HrTPlanning.Status::"Pending Approval");
                    HrTPlanning.modify(true);
                    Variant := HrTPlanning;
                end;
            Database::"Nominee Form Request":
                begin
                    RecRef.SetTable(NomineeRequest);
                    NomineeRequest.Validate(Status, NomineeRequest.Status::Pending);
                    NomineeRequest.modify(true);
                    Variant := NomineeRequest;
                end;
            Database::"HR Appraisal Header":
                begin
                    RecRef.SetTable(HrAppraisal);
                    HrAppraisal.Validate(Status, HrAppraisal.Status::"Pending Approval");
                    HrAppraisal.modify(true);
                    Variant := HrAppraisal;
                end;
            Database::"HR Company Activities":
                begin
                    RecRef.SetTable(HrcompanyActivity);
                    HrcompanyActivity.Validate(Status, HrcompanyActivity.Status::"Pending Approval");
                    HrcompanyActivity.modify(true);
                    Variant := HrcompanyActivity;
                end;
            Database::"Securities Register":
                begin
                    RecRef.SetTable(SecuritiesReg);
                    SecuritiesReg.Validate(Status, SecuritiesReg.Status::Pending);
                    SecuritiesReg.modify(true);
                    Variant := SecuritiesReg;
                end;
            Database::"RTGS Transfer Header":
                begin
                    RecRef.SetTable(RTGS);
                    RTGS.Validate(Status, RTGS.Status::Pending);
                    RTGS.modify(true);
                    Variant := RTGS;
                end;
            Database::"Standing Order Header":
                begin
                    RecRef.SetTable(STO);
                    STO.Validate(Status, STO.Status::Pending);
                    STO.modify(true);
                    Variant := STO;
                end;
            Database::"Salary Header":
                begin
                    RecRef.SetTable(Salary);
                    Salary.Validate(Status, Salary.Status::Pending);
                    Salary.modify(true);
                    Variant := Salary;
                end;
            Database::"Treasury Cashier Transactions":
                begin
                    RecRef.SetTable(TrTrans);
                    TrTrans.Validate(Status, TrTrans.Status::Pending);
                    TrTrans.modify(true);
                    Variant := TrTrans;
                end;
            Database::"Key Request Table":
                begin
                    RecRef.SetTable(KeyRequest);
                    KeyRequest.Validate(Status, KeyRequest.Status::Pending);
                    KeyRequest.modify(true);
                    Variant := KeyRequest;
                end;
            Database::"Bankers Cheque Application":
                begin
                    RecRef.SetTable(BnkChq);
                    BnkChq.Validate(Status, BnkChq.Status::"Pending Approval");
                    BnkChq.modify(true);
                    Variant := BnkChq;
                end;
            Database::"Office Keys List":
                begin
                    RecRef.SetTable(KeyCreation);
                    KeyCreation.Validate(Status, KeyCreation.Status::Pending);
                    KeyCreation.modify(true);
                    Variant := KeyCreation;
                end;
            Database::"Appeals Table":
                begin
                    RecRef.SetTable(Appeals);
                    Appeals.Validate(Status, Appeals.Status::"Pending Approval");
                    Appeals.modify(true);
                    Variant := Appeals;
                end;

            Database::"HR Fuel Management Header":

                begin
                    RecRef.SetTable(Fuel);
                    Fuel.Validate(Status, Fuel.Status::Pending);
                    Fuel.modify(true);
                    Variant := Fuel;
                end;
            Database::"HR OSAccident":
                begin
                    RecRef.SetTable(Accidents);
                    Accidents.Validate(Status, Accidents.Status::Pending);
                    Accidents.modify(true);
                    Variant := Accidents;
                end;
            database::Contracts:
                begin
                    RecRef.SetTable(Contracts);
                    Contracts.Validate(Status, Contracts.Status::New);
                    Contracts.modify(true);
                    Variant := Contracts;
                end;
            database::"SMS Alerts Header":
                begin
                    RecRef.SetTable(SMSAlerts);
                    SMSAlerts.Validate(Status, SMSAlerts.Status::Open);
                    SMSAlerts.modify(true);
                    Variant := SMSAlerts;
                end;
            database::"Conference & Meeting Rooms-T":
                begin
                    RecRef.SetTable(ConferenceBooking);
                    ConferenceBooking.Validate(Status, ConferenceBooking.Status::Pending);
                    ConferenceBooking.modify(true);
                    Variant := ConferenceBooking;
                end;
            database::"Conf & Meeting Rooms List":
                begin
                    RecRef.SetTable(ConferenceCreation);
                    ConferenceCreation.Validate(Status, ConferenceCreation.Status::Open);
                    ConferenceCreation.modify(true);
                    Variant := ConferenceCreation;
                end;
            database::"Surety Management":
                begin
                    RecRef.SetTable(Surety);
                    Surety.Validate(Status, Surety.Status::Pending);
                    Surety.modify(true);
                    Variant := Surety;
                end;
            database::Lease:
                begin
                    RecRef.SetTable(Lease);
                    Lease.Validate(Status, Lease.Status::Pending);
                    Lease.modify(true);
                    Variant := Lease;
                end;
            database::Customer:
                begin
                    RecRef.SetTable(Customer);
                    Customer.Validate(Status, Customer.Status::New);
                    Customer.modify(true);
                    Variant := Customer;
                end;
            database::"Property Details":
                begin
                    RecRef.SetTable(PropertyDetails);
                    PropertyDetails.Validate(Status, PropertyDetails.Status::Open);
                    PropertyDetails.modify(true);
                    Variant := PropertyDetails;
                end;
            database::"HR Drivers":
                begin
                    RecRef.SetTable(HRDrivers);
                    HRDrivers.Validate(Status, HRDrivers.Status::Open);
                    HRDrivers.modify(true);
                    Variant := HRDrivers;
                end;
            database::"Company Vehicles":
                begin
                    recref.SetTable(CompanyVehicles);
                    CompanyVehicles.Validate(status, CompanyVehicles.Status::"Pending Approval");
                    CompanyVehicles.modify(true);
                    Variant := CompanyVehicles;

                end;
            database::Vendor:
                begin
                    recref.SetTable(Vendor);
                    Vendor.Validate(Status, Vendor.Status::"Pending Approval");

                end;
            database::"Board members":
                begin
                    recref.SetTable(BoardMemberPay);
                    BoardMemberPay.Validate(Status, BoardMemberPay.Status::pending);

                end;
            database::"Delegates Minutes Header":
                begin
                    recref.SetTable(Minutes);
                    Minutes.Validate(Status, Minutes.Status::Pending);
                    Minutes.Validate(Status, Minutes.Status::Pending);
                    Minutes.modify(true);
                    Variant := Minutes;

                end;
            database::"Security Discharge":
                begin
                    recref.SetTable(SecurityDischarge);
                    SecurityDischarge.Validate(Status, SecurityDischarge.Status::Pending);
                    SecurityDischarge.modify(true);
                    Variant := SecurityDischarge;

                end;
            database::"Delegate Officials":
                begin
                    recref.SetTable(DelegateOfficials);
                    DelegateOfficials.Validate(Status, DelegateOfficials.Status::Pending);
                    DelegateOfficials.modify(true);
                    Variant := DelegateOfficials;

                end;
            database::"Product Variations":
                begin
                    recref.SetTable(VariationsRec);
                    VariationsRec.Validate(Status, VariationsRec.Status::"Pending");
                    VariationsRec.modify(true);
                    Variant := VariationsRec;

                end;
            Database::"Investment Interest Header":
                begin
                    RecRef.SetTable(InvestInterestHeader);
                    InvestInterestHeader.Validate(Status, InvestInterestHeader.Status::"Pending Approval");
                    InvestInterestHeader.modify(true);
                    Variant := InvestInterestHeader;
                end;
            Database::"Investment Header":
                begin
                    RecRef.SetTable(InvHeader);
                    InvHeader.Validate(Status, InvHeader.Status::"Pending Approval");
                    InvHeader.modify(true);
                    Variant := InvHeader;
                end;
            database::"Security Perfection":
                begin
                    RecRef.SetTable(SecurityPerfection);
                    SecurityPerfection.Validate(Status, SecurityPerfection.Status::"Pending");
                    SecurityPerfection.modify(true);
                    Variant := SecurityPerfection;
                end;

            database::"Interest Header":
                begin
                    RecRef.SetTable(InterestHeader);
                    InterestHeader.Validate(Status, InterestHeader.Status::"Pending Approval");
                    InterestHeader.modify(true);
                    Variant := InterestHeader;
                end;
            database::"Fosa Payments Header":
                begin
                    RecRef.SetTable(FOSAPV);
                    FOSAPV.Validate(Status, FOSAPV.Status::Pending);
                    FOSAPV.modify(true);
                    Variant := FOSAPV;
                end;
            database::Legal:
                begin
                    RecRef.SetTable(Legal);
                    Legal.Validate(Status, Legal.Status::Pending);
                    Legal.modify(true);
                    Variant := Legal;
                end;
            Database::"Dispatch ATM Header":
                begin
                    RecRef.SetTable(DispatchATM);
                    DispatchATM.Validate(Status, DispatchATM.Status::Pending);
                    DispatchATM.modify(true);
                    Variant := DispatchATM;
                end;
            Database::"System Reversal":
                begin
                    RecRef.SetTable(SystemReversal);
                    SystemReversal.Validate(Status, SystemReversal.Status::Pending);
                    SystemReversal.modify(true);
                    Variant := SystemReversal;
                end;
            Database::"Refund,Account Transfer Header":
                begin
                    RecRef.SetTable(RefundTransfer);
                    RefundTransfer.Validate(Status, RefundTransfer.Status::Pending);
                    RefundTransfer.modify(true);
                    Variant := RefundTransfer;
                end;
            Database::"Product Factory":
                begin
                    RecRef.SetTable(ProductFactory);
                    ProductFactory.Validate(Status, ProductFactory.Status::Pending);
                    ProductFactory.modify(true);
                    Variant := ProductFactory;
                end;
            Database::"User Creation Requests":
                begin
                    RecRef.SetTable(UserCreation);
                    UserCreation.Validate(Status, UserCreation.Status::Pending);
                    UserCreation.modify(true);
                    Variant := UserCreation;
                end;
            Database::"User Termination":
                begin
                    RecRef.SetTable(UserTermination);
                    UserTermination.Validate(Status, UserTermination.Status::Pending);
                    UserTermination.modify(true);
                    Variant := UserTermination;
                end;
        end;


        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Motor Vehicle Request":
                begin
                    RecRef.SetTable(VehicleRequest);
                    VehicleRequest.Validate(Status, VehicleRequest.Status::Pending);
                    VehicleRequest.modify(true);
                    Variant := VehicleRequest;
                end;
            // Database::"Conference & Meeting Rooms-T":
            //     begin
            //         RecRef.SetTable(ConferenceAndMeetingRooms);
            //         ConferenceAndMeetingRooms.Validate(Status, ConferenceAndMeetingRooms.Status::Pending);
            //         ConferenceAndMeetingRooms.modify(true);
            //         Variant := ConferenceAndMeetingRooms;
            //     end;
            Database::"Vehicle Movement":
                begin
                    RecRef.SetTable(VehicleMovement);
                    VehicleMovement.Validate(Status, VehicleMovement.Status::Pending);
                    VehicleMovement.modify(true);
                    Variant := VehicleMovement;
                end;
            // database::"Conference & Meeting Rooms-T":
            //     begin
            //         RecRef.SetTable(ConferenceAndMeetingRooms);
            //         ConferenceAndMeetingRooms.Validate(Status, ConferenceAndMeetingRooms.Status::Pending);
            //         ConferenceAndMeetingRooms.modify(true);
            //         Variant := ConferenceAndMeetingRooms;
            //     end;

            Database::"Fixed Deposit Contract":
                begin
                    RecRef.SetTable(FixedDepositContract);
                    FixedDepositContract.Validate(Status, FixedDepositContract.Status::Pending);
                    FixedDepositContract.modify(true);
                    Variant := FixedDepositContract;
                end;

            Database::"System Reversal":
                begin
                    RecRef.SetTable(SystemReversal);
                    SystemReversal.Validate(Status, SystemReversal.Status::Pending);
                    SystemReversal.modify(true);
                    Variant := SystemReversal;
                end;
            Database::"Business Loan Clossure":
                begin
                    RecRef.SetTable(BusinessLoanClossure);
                    BusinessLoanClossure.Validate(Status, BusinessLoanClossure.Status::Pending);
                    BusinessLoanClossure.modify(true);
                    Variant := BusinessLoanClossure;
                end;
            Database::"One Month Installment":
                begin
                    RecRef.SetTable(OneMonthInstallments);
                    OneMonthInstallments.Validate(Status, OneMonthInstallments.Status::Pending);
                    OneMonthInstallments.modify(true);
                    Variant := OneMonthInstallments;
                end;
            Database::"Dependancies Applications":
                begin
                    RecRef.SetTable(DependancyApplications);
                    DependancyApplications.Validate(Status, DependancyApplications.Status::Pending);
                    DependancyApplications.Modify(true);
                    Variant := DependancyApplications;
                end;
            Database::"System Edits":
                begin
                    RecRef.SetTable(SystemEdits);
                    SystemEdits.Validate(Status, SystemEdits.Status::Pending);
                    SystemEdits.Modify(true);
                    Variant := SystemEdits;
                end;
            Database::"B/S Loan Account Application":
                begin
                    RecRef.SetTable(BSLoansAccApp);
                    BSLoansAccApp.Validate(Status, BSLoansAccApp.Status::Pending);
                    BSLoansAccApp.modify(true);
                    Variant := BSLoansAccApp;
                end;
            Database::"Electoral Zones":
                begin
                    RecRef.SetTable(ElectoralZones);
                    ElectoralZones.Validate(Status, ElectoralZones.Status::Pending);
                    ElectoralZones.modify(true);
                    Variant := ElectoralZones;
                end;
            Database::"Moratorium Loan":
                begin
                    RecRef.SetTable(MoratoriumLoan);
                    MoratoriumLoan.Validate(Status, MoratoriumLoan.Status::Pending);
                    MoratoriumLoan.modify(true);
                    Variant := MoratoriumLoan;
                end;
            Database::"Share Capital Transfer Buffer":
                begin
                    RecRef.SetTable(Sharetransfer);
                    sharetransfer.Validate(Status, sharetransfer.Status::Pending);
                    sharetransfer.Modify(true);
                    Variant := sharetransfer;
                end;
            //hr leave
            Database::"HR Leave Journal Line":
                begin
                    RecRef.SetTable(HRLeaveJournalLine);
                    HRLeaveJournalLine.Validate(Status, HRLeaveJournalLine.Status::"Pending Approval");
                    HRLeaveJournalLine.modify(true);
                    Variant := HRLeaveJournalLine;
                end;


            //Sky Virtual Member
            Database::"Sky Virtual Member":
                begin
                    RecRef.SetTable(SkyVirtualMember);
                    SkyVirtualMember.Validate(Status, SkyVirtualMember.Status::Pending);
                    SkyVirtualMember.modify(true);
                    Variant := SkyVirtualMember;
                end;
            //Sky Virtual Member

            Database::"SinkFund Report Information":
                begin
                    RecRef.SetTable(SinkFundReportInformation);
                    SinkFundReportInformation.Validate(Status, SinkFundReportInformation.Status::Pending);
                    SinkFundReportInformation.Modify(true);
                    Variant := SinkFundReportInformation;
                end;

            Database::"Delegate Region Change":
                begin
                    RecRef.SetTable(DelegateRegionChange);
                    DelegateRegionChange.Validate(Status, DelegateRegionChange.Status::Pending);
                    DelegateRegionChange.modify(true);
                    Variant := DelegateRegionChange;
                end;



            Database::"Delegate AGM Update Header":
                begin
                    RecRef.SetTable(DelegateAGMUpdateHeader);
                    DelegateAGMUpdateHeader.Validate(Status, DelegateAGMUpdateHeader.Status::Pending);
                    DelegateAGMUpdateHeader.modify(true);
                    Variant := DelegateAGMUpdateHeader;
                end;




            Database::"Banking Account Closure":
                begin
                    RecRef.SetTable(BankingAccountClosure);
                    BankingAccountClosure.Validate(Status, BankingAccountClosure.Status::Pending);
                    BankingAccountClosure.modify(true);
                    Variant := BankingAccountClosure;
                end;


            Database::"AGM Delegates Payment":
                begin
                    RecRef.SetTable(AGMDelegatesPayment);
                    AGMDelegatesPayment.Validate(Status, AGMDelegatesPayment.Status::Pending);
                    AGMDelegatesPayment.modify(true);
                    Variant := AGMDelegatesPayment;
                end;



            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentsHeader);
                    PaymentsHeader.Validate(Status, PaymentsHeader.Status::"Pending Approval");
                    PaymentsHeader.modify(true);
                    Variant := PaymentsHeader;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaimsHeader);
                    StaffClaimsHeader.Validate(Status, StaffClaimsHeader.Status::"Pending Approval");
                    StaffClaimsHeader.modify(true);
                    Variant := StaffClaimsHeader;
                end;
            Database::"Staff Advance Header":
                begin
                    RecRef.SetTable(StaffAdvanceHeader);
                    StaffAdvanceHeader.Validate(Status, StaffAdvanceHeader.Status::"Pending Approval");
                    StaffAdvanceHeader.modify(true);
                    Variant := StaffAdvanceHeader;
                end;
            Database::"Staff Advance Surrender Header":
                begin
                    RecRef.SetTable(StaffAdvanceSurrenderHeader);
                    StaffAdvanceSurrenderHeader.Validate(Status, StaffAdvanceSurrenderHeader.Status::"Pending Approval");
                    StaffAdvanceSurrenderHeader.modify(true);
                    Variant := StaffAdvanceSurrenderHeader;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestHeader);
                    ImprestHeader.Validate(Status, ImprestHeader.Status::"Pending Approval");
                    ImprestHeader.modify(true);
                    Variant := ImprestHeader;
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrenderHeader);
                    ImprestSurrenderHeader.Validate(Status, ImprestSurrenderHeader.Status::"Pending Approval");
                    ImprestSurrenderHeader.modify(true);
                    Variant := ImprestSurrenderHeader;
                end;
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(StoreRequistionHeader);
                    StoreRequistionHeader.Validate(Status, StoreRequistionHeader.Status::"Pending Approval");
                    StoreRequistionHeader.modify(true);
                    Variant := StoreRequistionHeader;
                end;
            Database::"InterBank Transfers":
                begin
                    RecRef.SetTable(InterBankTransfers);
                    InterBankTransfers.Validate(Status, InterBankTransfers.Status::"Pending Approval");
                    InterBankTransfers.modify(true);
                    Variant := InterBankTransfers;
                end;
            Database::"Overtime Claim Header":
                begin
                    RecRef.SetTable(OvertimeClaimHeader);
                    OvertimeClaimHeader.Validate(Status, OvertimeClaimHeader.Status::"Pending Approval");
                    OvertimeClaimHeader.modify(true);
                    Variant := OvertimeClaimHeader;
                end;
            Database::"G/L Budget Name":
                begin
                    RecRef.SetTable(Budget);
                    Budget.Validate(Status, Budget.Status::"Pending Approval");
                    Budget.modify(true);
                    Variant := Budget;
                end;
            Database::"Vote Transfer":
                begin
                    RecRef.SetTable(Vote);
                    Vote.Validate(Status, Vote.Status::"Pending Approval");
                    Vote.modify(true);
                    Variant := Vote;
                end;
            Database::"Asset Transfer":
                begin
                    RecRef.SetTable(AssetTransfer);
                    AssetTransfer.Validate(Status, AssetTransfer.Status::"Pending Approval");
                    AssetTransfer.modify(true);
                    Variant := AssetTransfer;
                end;
            Database::"Payments Header Board":
                begin
                    RecRef.SetTable(PaymentsHeaderBoard);
                    PaymentsHeaderBoard.Validate(Status, PaymentsHeaderBoard.Status::"Pending Approval");
                    PaymentsHeaderBoard.modify(true);
                    Variant := PaymentsHeaderBoard;
                end;

            Database::Vendor:
                begin
                    RecRef.SetTable(Vendor);
                    Vendor.Validate(Status, Vendor.Status::"Pending Approval");
                    Vendor.modify(true);
                    Variant := Vendor;
                end;

            //Cashier Transactions
            Database::"Cashier Transactions":
                begin
                    RecRef.SetTable(ctrans);
                    ctrans.Validate(Status, ctrans.Status::"Pending Approval");
                    ctrans.modify(true);
                    Variant := ctrans;
                end;
            //Cashier Transactions
            //Property Lease
            Database::Lease:
                begin
                    RecRef.SetTable(LeaseDoc);
                    LeaseDoc.Validate(Status, LeaseDoc.Status::"Pending");
                    LeaseDoc.modify(true);
                    Variant := LeaseDoc;
                end;
            //Property Lease

            //Property
            Database::"Property Details":
                begin
                    RecRef.SetTable(PropertyDetails);
                    PropertyDetails.Validate(Status, PropertyDetails.Status::"Pending Approval");
                    PropertyDetails.modify(true);
                    Variant := PropertyDetails;
                end;
            //Property

            //Salary Transactions
            Database::"Salary Header":
                begin
                    RecRef.SetTable(Sal);
                    Sal.Validate(Status, Sal.Status::Pending);
                    Sal.modify(true);
                    Variant := Sal;
                end;
            //Salary Transactions

            //Bankers Cheque
            Database::"Bankers Cheque Application":
                begin
                    RecRef.SetTable(BankersC);
                    BankersC.Validate(Status, BankersC.Status::"Pending Approval");
                    BankersC.modify(true);
                    Variant := BankersC;
                end;
            //Bankers Cheque

            //Bank Cheque
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(BankC);
                    BankC.Validate(Status, BankC.Status::"Pending Approval");
                    BankC.modify(true);
                    Variant := BankC;
                end;
            //Bank Cheque

            //Over Draft
            Database::"Over Draft Authorisation":
                begin
                    RecRef.SetTable(OD);
                    OD.Validate(Status, OD.Status::Pending);
                    OD.modify(true);
                    Variant := OD;
                end;
            //Over Draft

            //Account Transfers
            Database::"Account Transfer Header":
                begin
                    RecRef.SetTable(ACT);
                    ACT.Validate(Status, ACT.Status::"Pending Approval");
                    ACT.modify(true);
                    Variant := ACT;
                end;
            //Account Trasnfers

            //Inter Teller
            Database::"Treasury Cashier Transactions":
                begin
                    RecRef.SetTable(TREAS);
                    TREAS.Validate(Status, TREAS.Status::Pending);
                    TREAS.modify(true);
                    Variant := TREAS;
                end;
            //Inter teller

            //Investment
            Database::"Investment Header":
                begin
                    RecRef.SetTable(INV);
                    INV.Validate(Status, INV.Status::"Pending Approval");
                    INV.modify(true);
                    Variant := INV;
                end;
            //Investment


            //Cheque Receipts
            Database::"Cheque Receipts":
                begin
                    RecRef.SetTable(CHQ);
                    CHQ.Validate(Status, INV.Status::"Pending Approval");
                    CHQ.modify(true);
                    Variant := CHQ;
                end;
            //Cheque Receipts

            //Permission Requistion
            Database::"Permission Requisition":
                begin
                    RecRef.SetTable(PermissionReq);
                    PermissionReq.Validate(Status, PermissionReq.Status::"Pending Approval");
                    PermissionReq.modify(true);
                    Variant := PermissionReq;
                end;

            //Member Application
            Database::"Member Application":
                begin
                    RecRef.SetTable(MemberAppl);
                    MemberAppl.Validate(Status, MemberAppl.Status::Pending);
                    MemberAppl."Created By" := UserId;
                    MemberAppl."Application Date" := Today;
                    MemberAppl.modify(true);
                    Variant := MemberAppl;
                end;//
                    //Salary Agreement
            Database::"Salary Agreement":
                begin
                    RecRef.SetTable(SalaryAgreement);
                    SalaryAgreement.Validate(Status, SalaryAgreement.Status::"Pending Approval");
                    SalaryAgreement.modify(true);
                    Variant := SalaryAgreement;
                end;//
                    //Account Application
            Database::"Savings Account Application":
                begin
                    RecRef.SetTable(SAccountAppl);
                    SAccountAppl.Validate(Status, SAccountAppl.Status::Pending);
                    SAccountAppl.modify(true);
                    Variant := SAccountAppl;
                end;//
                    //Electronic Fund Transfer Application
            Database::"RTGS Transfer Header":
                begin
                    RecRef.SetTable(RTGSAppl);
                    RTGSAppl.Validate(Status, RTGSAppl.Status::Pending);
                    RTGSAppl.modify(true);
                    Variant := RTGSAppl;
                end;//
                    //Standing Order Application
            Database::"Standing Order Header":
                begin
                    RecRef.SetTable(STOAppl);
                    STOAppl.Validate(Status, STOAppl.Status::Pending);
                    STOAppl.modify(true);
                    Variant := STOAppl;
                end;//
                    //Standing Order Control Application
            Database::"Standing Order Control":
                begin
                    RecRef.SetTable(StandingOrderControl);
                    StandingOrderControl.Validate(Status, StandingOrderControl.Status::Pending);
                    StandingOrderControl.modify(true);
                    Variant := StandingOrderControl;
                end;//
                    //Dividend Rate Application
            Database::"Dividend Simulation Header":
                begin
                    RecRef.SetTable(DividendsSimulationHeader);
                    DividendsSimulationHeader.Validate(Status, DividendsSimulationHeader.Status::Pending);
                    DividendsSimulationHeader.modify(true);
                    Variant := DividendsSimulationHeader;
                end;//
                    //Account/Member deactivation or reactivation

            //Loans
            Database::Loans:
                begin
                    RecRef.SetTable(Loans);
                    if Loans."Override Loan Qualification" = true then begin
                        if not confirm('This is an exceptional Loan, do you wish to approve? More information on the comment section.') then
                            exit;
                    end;
                    Loans.Validate(Status, Loans.Status::Pending);
                    Loans."Loan Appraised By" := UserId;
                    Loans.modify(true);
                    Variant := Loans;
                end;

            //Collateral Register



            //Collateral return
            Database::"Securities Collection Register":
                begin
                    RecRef.SetTable(SecuritiesCollectionRegister);
                    SecuritiesCollectionRegister.Validate(Status, SecuritiesCollectionRegister.Status::Pending);
                    SecuritiesCollectionRegister.modify(true);
                    Variant := SecuritiesCollectionRegister;
                end;//
            Database::"Loan Disbursement Header":
                begin
                    RecRef.SetTable(LoanBatch);
                    LoanBatch.Validate(Status, LoanBatch.Status::Pending);
                    LoanBatch.modify(true);
                    Variant := LoanBatch;
                end;
            //Interest Billing
            Database::"Interest Header":
                begin
                    RecRef.SetTable(InterestHeader);
                    InterestHeader.Validate(Status, InterestHeader.Status::"Pending Approval");
                    InterestHeader.modify(true);
                    Variant := InterestHeader;
                end;//
                    //SavingsInterestHeader
            Database::"Savings Interest Header":
                begin
                    RecRef.SetTable(SavingsInterestHeader);
                    SavingsInterestHeader.Validate(Status, SavingsInterestHeader.Status::"Pending Approval");
                    SavingsInterestHeader.modify(true);
                    Variant := SavingsInterestHeader;
                end;//
                    //End Year Transfer Header
            Database::"End Year Transfer Header":
                begin
                    RecRef.SetTable(EndYearTransferHeader);
                    EndYearTransferHeader.Validate(Status, EndYearTransferHeader.Status::"Pending Approval");
                    EndYearTransferHeader.modify(true);
                    Variant := EndYearTransferHeader;
                end;//
            //ATM Applications
            Database::"ATM Applications":
                begin
                    RecRef.SetTable(ATMApplications);
                    ATMApplications.Validate(Status, ATMApplications.Status::"Pending Approval");
                    ATMApplications.modify(true);
                    Variant := ATMApplications;
                end;//
                    ////ATM Linking Applications
            Database::"ATM Linking Applications":
                begin
                    RecRef.SetTable(ATMLinkingApplications);
                    ATMLinkingApplications.Validate(Status, ATMLinkingApplications.Status::"Pending Approval");
                    ATMLinkingApplications.modify(true);
                    Variant := ATMLinkingApplications;
                end;//
                    //Checkoff
            Database::"Checkoff Header":
                begin
                    RecRef.SetTable(Checkoff);
                    Checkoff.Validate(Status, Checkoff.Status::Pending);
                    Checkoff.modify(true);
                    Variant := Checkoff;
                end;

            //Membership Closure
            Database::"Membership closure":
                begin
                    RecRef.SetTable(MembClosure);
                    MembClosure.Validate(Status, MembClosure.Status::Pending);
                    MembClosure.modify(true);
                    Variant := MembClosure;
                end;

            //Loan Rescheduling
            Database::"Loan Rescheduling":
                begin
                    RecRef.SetTable(LoanRescheduling);
                    LoanRescheduling.Validate(Status, LoanRescheduling.Status::Pending);
                    LoanRescheduling.modify(true);
                    Variant := LoanRescheduling;
                end;//

            //HR Employees
            Database::"HR Employees":
                begin
                    RecRef.SetTable(HREmployees);
                    HREmployees.Validate(Status, HREmployees.Status::"Pending Approval");
                    HREmployees.modify(true);
                    Variant := HREmployees;
                end;//

            //Member Withdrawal
            Database::"Member withdrawal Notice":
                begin
                    RecRef.SetTable(MemberwithdrawalNotice);
                    MemberwithdrawalNotice.Validate(Status, MemberwithdrawalNotice.Status::Pending);
                    MemberwithdrawalNotice.modify(true);
                    Variant := MemberwithdrawalNotice;
                end;
            //

            //Gurantor Substitution
            Database::"Guarantors Substitution":
                begin
                    RecRef.SetTable(GuarantorsSubstitution);
                    GuarantorsSubstitution.Validate(Status, GuarantorsSubstitution.Status::Pending);
                    GuarantorsSubstitution.modify(true);
                    Variant := GuarantorsSubstitution;
                end;
            //

            //Loan Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Validate(Status, LoanRecoveryHeader.Status::Pending);
                    LoanRecoveryHeader.modify(true);
                    Variant := LoanRecoveryHeader;
                end;

            //Loan Recovery
            Database::"Loan Recovery Header II":
                begin
                    RecRef.SetTable(LoanRecoveryHeaderII);
                    LoanRecoveryHeaderII.Validate(Status, LoanRecoveryHeaderII.Status::Pending);
                    LoanRecoveryHeaderII.modify(true);
                    Variant := LoanRecoveryHeaderII;
                end;
            //

            //Bond
            Database::Bond:
                begin
                    RecRef.SetTable(Bond);
                    Bond.Validate("Bond Status", Bond."bond status"::"Pending Approval");
                    Bond.modify(true);
                    Variant := Bond;
                end;
            //

            //DelegateGroupsApplicationss
            Database::"Delegate Region Applicationss":
                begin
                    RecRef.SetTable(DelegateGroupsApplicationss);
                    DelegateGroupsApplicationss.Validate(Status, DelegateGroupsApplicationss.Status::Pending);
                    DelegateGroupsApplicationss.modify(true);
                    Variant := DelegateGroupsApplicationss;
                end;
            //Sink Fund
            Database::"BBF Requisation Header":
                begin
                    RecRef.SetTable(BBFRequisationHeader);
                    BBFRequisationHeader.Validate(Status, BBFRequisationHeader.Status::Pending);
                    BBFRequisationHeader.modify(true);
                    Variant := BBFRequisationHeader;
                end;

            //BDE Management
            Database::"BDE Management Header":
                begin
                    RecRef.SetTable(BDEManagementHeader);
                    BDEManagementHeader.Validate(Status, BDEManagementHeader.Status::Pending);
                    BDEManagementHeader.modify(true);
                    Variant := BDEManagementHeader;
                end;
            //

            //Delegate Group Mem Retirements
            Database::"Delegate Region Mem Retirement":
                begin
                    RecRef.SetTable(DelegateGroupMemRetirements);
                    DelegateGroupMemRetirements.Validate(Status, DelegateGroupMemRetirements.Status::Pending);
                    DelegateGroupMemRetirements.modify(true);
                    Variant := DelegateGroupMemRetirements;
                end;
            //Delegates Payment
            Database::"Delegates Payment":
                begin
                    RecRef.SetTable(DelegatesPayment);
                    DelegatesPayment.Validate(Status, DelegatesPayment.Status::Pending);
                    DelegatesPayment.modify(true);
                    Variant := DelegatesPayment;
                end;

            //HR____________
            //hr
            //Jobs
            Database::"HR Jobs":
                begin
                    RecRef.SetTable(HRJobs);
                    HRJobs.Validate(Status, HRJobs.Status::"Pending Approval");
                    HRJobs.modify(true);
                    Variant := HRJobs;
                end;
            //HR Jobs
            //HR leave Planner
            Database::"HR Leave Planner Header":
                begin
                    RecRef.SetTable(leavePlanner);
                    leavePlanner.Validate(Status, leavePlanner.Status::"Pending Approval");
                    leavePlanner.modify(true);
                    Variant := leavePlanner;
                end;
            //HR Intern Requisition
            Database::"HR Interns Requisition":
                begin
                    RecRef.SetTable(HRInternReq);
                    HRInternReq.Validate(Status, HRInternReq.Status::"Pending Approval");
                    HRInternReq.modify(true);
                    Variant := HRInternReq;
                end;
            //HR Intern Requisition

            //Employee Requisition
            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(Hrempreq);
                    Hrempreq.Validate("Approval Status", Hrempreq."approval status"::"Pending Approval");
                    Hrempreq.modify(true);
                    Variant := Hrempreq;
                end;
            //Leave
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::"Pending Approval");
                    Leave.modify(true);
                    Variant := Leave;
                end;


            //HR Training Feedback
            Database::"HR Training Feedback Form":
                begin
                    RecRef.SetTable(TFeed);
                    TFeed.Validate(Status, TFeed.Status::"Pending Approval");
                    TFeed.modify(true);
                    Variant := TFeed;
                end;


            //Interns
            Database::"HR Interns":
                begin
                    RecRef.SetTable(Intern);
                    Intern.Validate("Posting Status", Intern."posting status"::"Pending Approval");
                    Intern.modify(true);
                    Variant := Intern;
                end;


            //Appraisal Appeal
            Database::"HR Appraissal Appeal":
                begin
                    RecRef.SetTable(AppraisalAppeal);
                    AppraisalAppeal.Validate(Status, AppraisalAppeal.Status::"Pending Approval");
                    AppraisalAppeal.modify(true);
                    Variant := AppraisalAppeal;
                end;

            //Disciplinary Appeal
            Database::"HRDisciplinary Appeal":
                begin
                    RecRef.SetTable(DisciplinaryAppeal);
                    DisciplinaryAppeal.Validate(Status, DisciplinaryAppeal.Status::"Pending Approval");
                    DisciplinaryAppeal.modify(true);
                    Variant := DisciplinaryAppeal;
                end;

            //Disciplinary Withdrawal
            Database::"HRDisciplinary Case Withdrawal":
                begin
                    RecRef.SetTable(DiscWithdrawal);
                    DiscWithdrawal.Validate(Status, DiscWithdrawal.Status::"Pending Approval");
                    DiscWithdrawal.modify(true);
                    Variant := DiscWithdrawal;
                end;


            //Disciplinary
            Database::"HR Disciplinary Cases NCA":
                begin
                    RecRef.SetTable(Disciplinary);
                    Disciplinary.Validate(Status, Disciplinary.Status::"Pending Approval");
                    Disciplinary.modify(true);
                    Variant := Disciplinary;
                end;

            //StaffLoan
            Database::"prSalary Advance":
                begin
                    RecRef.SetTable(StaffLoan);
                    StaffLoan.Validate(Status, StaffLoan.Status::"Pending Approval");
                    StaffLoan.modify(true);
                    Variant := StaffLoan;
                end;

            //Training Need
            Database::"HR Training Needs":
                begin
                    RecRef.SetTable(TNeed);
                    TNeed.Validate(Status, TNeed.Status::"Pending Approval");
                    TNeed.modify(true);
                    Variant := TNeed;
                end;
            //Training
            Database::"HR Training App Header":
                begin
                    RecRef.SetTable(hrtraining);
                    hrtraining.Validate(Status, hrtraining.Status::"Pending Approval");
                    hrtraining.modify(true);
                    Variant := hrtraining;
                end;
            //Hr Transport hrtransport
            Database::"HR Transport Requisition Head":
                begin
                    RecRef.SetTable(hrtransport);
                    hrtransport.Validate(Status, hrtransport.Status::"Pending Approval");
                    hrtransport.modify(true);
                    Variant := hrtransport;
                end;

            //Hr Emplpoyee Transfer EmpTrans
            Database::"HR Employee Transfer Header":
                begin
                    RecRef.SetTable(EmpTrans);
                    EmpTrans.Validate(Status, EmpTrans.Status::"Pending Approval");
                    EmpTrans.modify(true);
                    Variant := EmpTrans;
                end;
            //end HR

            // MSACCO

            //M-SACCO PIN
            Database::"M-SACCO Change PIN No":
                begin
                    RecRef.SetTable(MsaccoPIN);
                    MsaccoPIN.Validate(Status, MsaccoPIN.Status::Pending);
                    MsaccoPIN.modify(true);
                    Variant := MsaccoPIN;
                end;

            //M-SACCO APPLICATIONS
            Database::"M-SACCO Applications":
                begin
                    RecRef.SetTable(MsaccoApp);
                    MsaccoApp.Validate(Status, MsaccoApp.Status::Pending);
                    MsaccoApp.modify(true);
                    Variant := MsaccoApp;
                end;

            //Agent applications
            Database::"Agent Applications":
                begin
                    RecRef.SetTable(AgentApplications);
                    AgentApplications.Validate("Approval Status", AgentApplications."approval status"::Pending);
                    AgentApplications.modify(true);
                    Variant := AgentApplications;
                end;

            //Contract
            Database::Contracts:
                begin
                    RecRef.SetTable(contrct);
                    contrct.Validate(Status, contrct.Status::"Pending Approval");
                    contrct.modify(true);
                    Variant := contrct;
                end;

            //SuretyMangt
            Database::"Surety Management":
                begin
                    RecRef.SetTable(SuretyMangt);
                    SuretyMangt.Validate(Status, SuretyMangt.Status::Pending);
                    SuretyMangt.modify(true);
                    Variant := SuretyMangt;
                end;

            //LEGAL
            Database::Legal:
                begin
                    RecRef.SetTable(Cases1);
                    Cases1.Validate(Status, Cases1.Status::Pending);
                    Cases1.modify(true);
                    Variant := Cases1;
                end;

            //Mortgage Release Doc
            Database::"Mortgage Loans Doc Release":
                begin
                    RecRef.SetTable(MortDoc);
                    MortDoc.Validate(Status, MortDoc.Status::Pending);
                    MortDoc.modify(true);
                    Variant := MortDoc;
                end;

            else
                Error(UnsupportedRecordTypeErr, RecRef.Caption);
        end
    end;
}
