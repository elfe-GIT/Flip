classdef EBB
    %all properties of system
    %   being computed here ...
    
    properties
        l
        %
        E
        b
        h
        q
        %
        I
        EI
        %
        x
    end
    
    methods
        function obj = EBB(data)
            %initialize
            %   class
            SIunits = containers.Map;
            SIunits('m')     =1;
            SIunits('cm')    =1E-2;
            SIunits('mm')    =1E-3;
            SIunits('N/m')   =1;
            SIunits('N/m^2') =1;
            
            obj.l(1) = data({'l[1]'},:).number*SIunits(data({'l[1]'},:).unit{1});
            obj.l(2) = data({'l[2]'},:).number*SIunits(data({'l[2]'},:).unit{1});
            obj.E    = data({'E'   },:).number*SIunits(data({'E'   },:).unit{1});
            obj.b    = data({'b'   },:).number*SIunits(data({'b'   },:).unit{1});
            obj.h    = data({'h'   },:).number*SIunits(data({'h'   },:).unit{1});
            obj.q    = data({'q[0]'},:).number*SIunits(data({'q[0]'},:).unit{1});
            
            % derived properties
            obj.I    = obj.b*obj.h^3/12;
            obj.EI   = obj.E*obj.I;
            
        end
        
        function A = sysmat(obj)
            %populate
            %   system matrix A

            % create matrix
            A   = zeros(8,8);
            % populate matrix (only non-zero elements)
            A( 1 , 1 ) =  8 ;
            A( 2 , 2 ) =  6 ;
            A( 3 , 1 ) =  8 ;
            A( 3 , 2 ) =  16 ;
            A( 3 , 3 ) =  16 ;
            A( 3 , 4 ) =  32/3;
            A( 4 , 2 ) =  6 ;
            A( 4 , 3 ) =  12 ;
            A( 4 , 4 ) =  12 ;
            A( 4 , 6 ) =  -6 ;
            A( 5 , 3 ) =  -2 ;
            A( 5 , 4 ) =  -4 ;
            A( 5 , 7 ) =  2 ;
            A( 6 , 5 ) =  8 ;
            A( 7 , 7 ) =  -2 ;
            A( 7 , 8 ) =  -2 ;
            A( 8 , 8 ) =  -1;
        end
                
        function b = rhs(obj)
            %populate
            %   right-hand side

            % cretae matrix
            b   = zeros(8,1);
            % populate matrix
            b(7,1) = 1;
            b(8,1) = 1;
        end
                
    end
end

