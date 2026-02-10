#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186450 pageextension52186450 extends "Main Asset Statistics" 
{
    layout
    {
        modify(NoOfComponents)
        {
            ApplicationArea = Basic;
        }
        modify(NoOfSoldComponents)
        {
            ApplicationArea = Basic;
        }
        modify("NoOfComponents + NoOfSoldComponents")
        {
            ApplicationArea = Basic;
        }
        modify(FAAcqDate)
        {
            ApplicationArea = Basic;
        }
        modify(GLAcqDate)
        {
            ApplicationArea = Basic;
        }
        modify(DispDate)
        {
            ApplicationArea = Basic;
        }
        modify(DispPrice)
        {
            ApplicationArea = Basic;
        }
        modify(GLPrice)
        {
            ApplicationArea = Basic;
        }
        modify(LastAcqCost)
        {
            ApplicationArea = Basic;
        }
        modify(LastDepreciation)
        {
            ApplicationArea = Basic;
        }
        modify(LastWriteDown)
        {
            ApplicationArea = Basic;
        }
        modify(LastAppreciation)
        {
            ApplicationArea = Basic;
        }
        modify(LastCustom1)
        {
            ApplicationArea = Basic;
        }
        modify(LastSalvageValue)
        {
            ApplicationArea = Basic;
        }
        modify(LastCustom2)
        {
            ApplicationArea = Basic;
        }
        modify(AcquisitionCost)
        {
            ApplicationArea = Basic;
        }
        modify(Depreciation2)
        {
            ApplicationArea = Basic;
        }
        modify(WriteDown)
        {
            ApplicationArea = Basic;
        }
        modify(Appreciation2)
        {
            ApplicationArea = Basic;
        }
        modify(Custom1)
        {
            ApplicationArea = Basic;
        }
        modify(SalvageValue)
        {
            ApplicationArea = Basic;
        }
        modify(Custom2)
        {
            ApplicationArea = Basic;
        }
        modify(BookValue)
        {
            ApplicationArea = Basic;
        }
        modify(DeprBasis)
        {
            ApplicationArea = Basic;
        }
        modify(Maintenance2)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfComponents(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfSoldComponents(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""NoOfComponents + NoOfSoldComponents"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FAAcqDate(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GLAcqDate(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DispDate(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DispPrice(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GLPrice(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastAcqCost(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastDepreciation(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastWriteDown(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastAppreciation(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastCustom1(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastSalvageValue(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LastCustom2(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AcquisitionCost(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Depreciation2(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WriteDown(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Appreciation2(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Custom1(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalvageValue(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Custom2(Control 4)".

        modify(Control3)
        {
            Visible = false;
        }
        modify(Control5)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "BookValue(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DeprBasis(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Maintenance2(Control 2)".

        addafter(NoOfComponents)
        {
            field(Text000;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(NoOfSoldComponents)
        {
            field(Control40;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter("NoOfComponents + NoOfSoldComponents")
        {
            field(Control41;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(FAAcqDate)
        {
            field(Control43;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(GLAcqDate)
        {
            field(Control48;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(DispDate)
        {
            field(Control49;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(DispPrice)
        {
            field(Control46;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(GLPrice)
        {
            field(Control47;Text000)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
        addafter(LastCustom1)
        {
            field("Book Value";Text000)
            {
                ApplicationArea = Basic;
                Caption = 'Book Value';
                Visible = false;
            }
        }
        addafter(LastSalvageValue)
        {
            field("Depreciation Basis";Text000)
            {
                ApplicationArea = Basic;
                Caption = 'Depreciation Basis';
                Visible = false;
            }
        }
        addafter(LastCustom2)
        {
            field(Maintenance;Text000)
            {
                ApplicationArea = Basic;
                Caption = 'Maintenance';
                Visible = false;
            }
        }
        moveafter(Custom1;BookValue)
        moveafter(SalvageValue;DeprBasis)
    }

    var
        Text000: label 'Placeholder';
}
