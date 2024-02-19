classdef sources
    %all properties of system
    %   being computed here ...
    
    properties
        l
        %
        alpha
        d
        r
        D
        R
        T
        eps
        %
        m
        k
        g
        %
        x
        y
        u0
        v0
        V
        gamma
        
        l_Bez
        T_Bez
        F_Bez
        
    end
    
    methods
        function obj = sources(data)
            %initialize
            %   class
            SIunits = containers.Map;
            SIunits('m')     = 1;
            SIunits('s')     = 1;
            SIunits('kg')    = 1;
            SIunits('cm')    = 1E-2;
            SIunits('mm')    = 1E-3;
            SIunits('N/m')   = 1;
            SIunits('N/m^2') = 1;
            SIunits('m/s')   = 1;
            SIunits('°')     = pi/180;
            
            obj.l(1) = data({'l[1]'},:).number*SIunits(data({'l[1]'},:).unit{1});
            obj.l(2) = data({'l[2]'},:).number*SIunits(data({'l[2]'},:).unit{1});
            obj.alpha= data({'α'   },:).number*SIunits(data({'α'   },:).unit{1});
            obj.d    = data({'d'   },:).number*SIunits(data({'d'   },:).unit{1});
            obj.m    = data({'m'   },:).number*SIunits(data({'m'   },:).unit{1});
            obj.D    = data({'D'   },:).number*SIunits(data({'D'   },:).unit{1});
            obj.k    = data({'k'   },:).number*SIunits(data({'k'   },:).unit{1});
            obj.T    = data({'T'   },:).number*SIunits(data({'T'   },:).unit{1});
            obj.eps  = data({'ε'   },:).number*SIunits(data({'ε'   },:).unit{1});
            obj.g    = 9.81;

            
            obj.x(1) = data({'x[1]'},:).number*SIunits(data({'x[1]'},:).unit{1});
            obj.y(1) = data({'y[1]'},:).number*SIunits(data({'y[1]'},:).unit{1});
            obj.x(2) = data({'x[2]'},:).number*SIunits(data({'x[2]'},:).unit{1});
            obj.y(2) = data({'y[2]'},:).number*SIunits(data({'y[2]'},:).unit{1});
            obj.x(3) = data({'x[3]'},:).number*SIunits(data({'x[3]'},:).unit{1});
            obj.y(3) = data({'y[3]'},:).number*SIunits(data({'y[3]'},:).unit{1});
            obj.x(4) = data({'x[4]'},:).number*SIunits(data({'x[4]'},:).unit{1});
            obj.y(4) = data({'y[4]'},:).number*SIunits(data({'y[4]'},:).unit{1});
            obj.x(5) = data({'x[5]'},:).number*SIunits(data({'x[5]'},:).unit{1});
            obj.y(5) = data({'y[5]'},:).number*SIunits(data({'y[5]'},:).unit{1});    
            
            % initial values 
            obj.u0   = data({'u(0)'},:).number*SIunits(data({'u(0)'},:).unit{1});
            obj.v0   = data({'v(0)'},:).number*SIunits(data({'v(0)'},:).unit{1});
            obj.V    = data({'V'   },:).number*SIunits(data({'V'   },:).unit{1});
            obj.gamma= data({'γ'   },:).number*SIunits(data({'γ'   },:).unit{1});
               
            % derived properties
            obj.r    = obj.d/2;
            obj.R    = obj.D/2;
            
        end
        
        function dydt = odeRhs(obj,t,y)
            %METHOD dydt delivers rhs of eom
            
            % coordinates
            r = y(1:2,1);
            % velocoties
            rp= y(3:4,1);

            % rhs for u, v
            dydt(1:2,1) =  rp;
            % rhs for u, v           
            dydt(3:4,1) = [0;-obj.g] + obj.border(r) + obj.obstacle(r);
        end
        
        function [value, isterminal, direction] = myEvent(obj, t, y)
            value      = (y(2) <= 0);
            isterminal = 1;   % Stop the integration
            direction  = 0;
        end
        
        
        function F = contact(obj,p)
            % computes contact force from intrusion            
            if p < -obj.eps
                F=0;
            elseif p < obj.eps
                F = p^2/(4*obj.eps)+p/2+obj.eps/4;
            else
                F = p;
             end
             F = F*obj.k;
        end
        
        function f = border(obj,r)
            % compute restoring forces from borders
           
            f = [0;0];
            % p ... penetration
            % top
            p = (r(2)+obj.r) - obj.l(2);
            if p > -obj.eps
                f = f-[0;contact(obj,p)];
            end
            
            % left
            p = -(r(1)-obj.r);
            if p > -obj.eps
                f = f+[contact(obj,p);0];
            end
            
            % right
            p = (r(1)+obj.r) - obj.l(1);
            if p > -obj.eps
                f = f-[contact(obj,p);0];
            end
            
        end
        
        
        function f = obstacle(obj,r)
            % compute restoring forces from borders
           
            f = [0;0];
            
            % for all obstacles
            for o = 1:length(obj.x)
                e = r-[obj.x(o);obj.y(o)];
                % length
                l = sqrt(dot(e,e));
                % p ... penetration
                p = obj.r+obj.R - l;
                if p > -obj.eps
                    % unit vector
                    e = e/l;
                    f = f + obj.contact(p)*e;
                end
            end            
        end       
        
    end
end

