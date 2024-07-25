classdef results_obj
    %% How to use
    % This file is updated with the relevent data from a simulation setup,
    % then the needed statistics update automatically for retreival. Save
    % this updated object to be pulled from later, in order to render
    % figures whenever.
    %
    % 7/25/2024, JRW

    %% Properties ---------------------------------------------------------
    properties
        M_ary;
        syms_per_frame;
        frames;
        bit_errors;
        sym_errors
        frame_errors;
    end

    properties (Dependent)
        BER;
        SER;
        FER;
        Thr;
    end

    methods
        %% DEPENDENT VARIABLES --------------------------------------------

        function result = get.BER(obj)
            result = obj.bit_errors / (obj.syms_per_frame * obj.frames * log2(obj.M_ary));
        end

        function result = get.SER(obj)
            result = obj.sym_errors / (obj.syms_per_frame * obj.frames);
        end

        function result = get.FER(obj)
            result = obj.frame_errors / obj.frames;
        end

        function result = get.Thr(obj)
            result = log2(obj.M_ary) * (1-obj.FER);
        end

        %% INTERNAL FUNCTIONS ---------------------------------------------

        
    end
end