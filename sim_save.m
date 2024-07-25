function sim_data = sim_save(systems,sim_data)
% This function takes a collection of systems and a SNR range, simulating
% the BER, SER, FER and Throughput of all the systems. The results are
% saved externally to a local folder titled "Saved Data". This
% externally saved data can later be rendered in a figure using the
% render_figure function.
% NOTE: Custom object comms_obj_OTFS is needed for this function to run properly
%
% Coded by Jeremiah Rhys Wimer, 3/24/2024

% Import data from sim_data_obj
num_systems = sim_data.num_systems;
x_var = sim_data.x_var;
x_range = sim_data.x_range;
max_frames = sim_data.max_frames;
var_list = sim_data.var_list;
reload = sim_data.reload;

% Prepare to save data
if ~exist("Saved Data", 'dir')
    mkdir("Saved Data")
end

% Print message
fprintf("Checking saved simulation data...\n")

% Sim loop
for i = 1:num_systems
    % Select current system
    sys = systems(i);

    for j = 1:length(x_range)
        % Set current system number
        sim_data.current_system = (i-1)*length(x_range) + j;

        % Select current x-val to modify system
        x_val = x_range(j);
        eval("sys." + x_var + " = " + x_val + ";");

        % Generate name of data to try to load
        for k = 1:length(var_list)
            if k > 1
                save_name = eval(sprintf("save_name + ""_"" + sys.%s",var_list(k)));
            else
                save_name = eval(sprintf("sys.%s;",var_list(k)));
            end
        end
        save_loc = "Saved Data\\" + save_name + "_sim.mat";

        % Normalize number of frames
        sim_data.max_frames = max_frames * (64/sys.N_tsyms);

        if reload
            try
                % Try to load if data exists
                load_test = load(save_loc);
                results_loaded = load_test.results_data;
                if results_loaded.frames < sim_data.max_frames
                    % Record current frames
                    sim_data.frames_so_far = results_loaded.frames;
                    
                    % Add more frames
                    sim_data.max_frames = sim_data.max_frames - results_loaded.frames;
                    [sim_data,results_data] = OTFS_pulse_sim(sys,sim_data);

                    % Combine results
                    results_data.frames = results_data.frames + results_loaded.frames;
                    results_data.bit_errors = results_data.bit_errors + results_loaded.bit_errors;
                    results_data.sym_errors = results_data.sym_errors + results_loaded.sym_errors;
                    results_data.frame_errors = results_data.frame_errors + results_loaded.frame_errors;

                    % Save 
                    save(save_loc,"results_data");
                    sim_data.max_frames = max_frames;
                end
            catch
                % Run simulation for current system and SNR
                [sim_data,results_data] = OTFS_pulse_sim(sys,sim_data);
                save(save_loc,"results_data");
            end
        else
            % Run simulation for current system and SNR
            [sim_data,results_data] = OTFS_pulse_sim(sys,sim_data);
            save(save_loc,"results_data");
        end
        % Print message
        clc;
        fprintf("Checking saved simulation data...\n")
    end
end

% Announce completion time
sim_data.final_time = datetime('now');