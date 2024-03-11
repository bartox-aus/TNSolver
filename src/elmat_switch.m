function [lhs, rhs] = elmat_switch(el, Tel, rhs)
%
% Created by ACB on 3/3/2024
%

% determine Gswitch, the conductance (kL/A) of the switch based on the temperature of node 1
if Tel(1) > el.Tswitch + el.Tramp/2
 Gswitch=el.Uon;
elseif Tel(1) < el.Tswitch - el.Tramp/2
 Gswitch=el.Uoff;
else
 slope=(el.Uon-el.Uoff)/el.Tramp;
 offset=Tel(1)-el.Tswitch;
 Gav=(el.Uon-el.Uoff)/2;
 Gswitch=Gav + offset * slope;
end

 lhs = Gswitch*[  1.0, -1.0 ;   ...
                    -1.0,  1.0 ];

 rhs = rhs - lhs*Tel;  %  Element residual
