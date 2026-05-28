codeunit 52185438 "sky Chart Colors"
{
    procedure GetColor(Color: Enum "sky Chart Color"): Text
    begin
        case Color of
            Color::Blue:
                exit('rgba(54,162,235,0.8)');
            Color::Red:
                exit('rgba(255,99,132,0.8)');
            Color::Green:
                exit('rgba(75,192,192,0.8)');
            Color::Orange:
                exit('rgba(255,159,64,0.8)');
            Color::Purple:
                exit('rgba(153,102,255,0.8)');
            Color::Yellow:
                exit('rgba(255,205,86,0.8)');
            Color::Teal:
                exit('rgba(0,188,212,0.8)');
            Color::Pink:
                exit('rgba(233,30,99,0.8)');
        end;
    end;

    procedure GetSolidColor(Color: Enum "sky Chart Color"): Text
    begin
        case Color of
            Color::Blue:
                exit('rgba(54,162,235,1.0)');
            Color::Red:
                exit('rgba(255,99,132,1.0)');
            Color::Green:
                exit('rgba(75,192,192,1.0)');
            Color::Orange:
                exit('rgba(255,159,64,1.0)');
            Color::Purple:
                exit('rgba(153,102,255,1.0)');
            Color::Yellow:
                exit('rgba(255,205,86,1.0)');
            Color::Teal:
                exit('rgba(0,188,212,1.0)');
            Color::Pink:
                exit('rgba(233,30,99,1.0)');
        end;
    end;
}
