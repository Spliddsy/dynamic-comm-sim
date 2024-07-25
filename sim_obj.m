classdef sim_obj
    %% SIM_OBJ
    %% How to use
    % This object stores the simulation information outside the simulated
    % systems data, so it can update needed parameters like needed runtime
    % and simulation display information.
    %
    % Written by JRW, 6/21/2024

    %% Properties ---------------------------------------------------------
    properties
        % Display parameters
        freq_display;

        % Simulation limits for each system
        max_frames = 1250;
        max_errors = Inf;
        var_tol = 0;
        saved_results_length = 1;
        frames_so_far = 0;
        max_time;

        % Simulation data
        var_list;
        var1 = "N_tsyms";
        var2 = "NA";
        x_var = "EbN0_db";
        x_range = 3:3:18;
        var1_range = [16,64];
        var2_range = ["rect","sinc","rrc"];
        var_defaults = {18,4,"MPSK",15e3,4e9,500,16,64,8,"rect",1};
        rrc_vals = 1;
        num_systems = 1;
        current_system = 0;
        sims_completed = 0;
        init_time
        final_time

        % Reload setting
        reload = true;
    end

    properties (Dependent)
        total_sims
    end

    methods
        %% DEPENDENT VARIABLES --------------------------------------------

        function result = get.total_sims(obj)
            result = length(obj.x_range) * obj.num_systems;
        end

        function obj = sim_obj()
            obj.init_time = datetime('now');
        end

        %% INTERNAL FUNCTIONS ---------------------------------------------

        
    end
end