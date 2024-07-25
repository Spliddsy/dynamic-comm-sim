%% Initialization
clear; clc; close all;
% Initialization
sim_data = sim_obj;
fig_data = fig_obj;
profile_num = 0;
all_profiles = [];

% System setting defaults - list all possible variables
var_list = ["EbN0_db","M_ary","select_mod","sbcar_spacing","Fc","v_vel","N_tsyms","M_sbcars","q","filter","rolloff"];
fig_data.var_list = var_list;

%% Simulation and figure settings
% Simulation settings
max_errors = Inf;
max_frames = 1250;
increment_frames = 1250;
norm_var_tol = 0;
saved_results_length = 1;
freq_of_display = 1; % In seconds
max_mins_per_sim = 10;
iteratively_improve = false;

% Figure settings
show_figure = false;
save_figure = false;
render_for_paper = true;
fig_num = 3;
make_all_figs = false;
reload = true;

% Figure 1 - BER vs all filters, Q=8
profile_num = profile_num + 1;
new_profile = profile_obj;
sub_sim_data = sim_data;
sub_fig_data = fig_data;
sub_sim_data.var1 = "N_tsyms";
sub_sim_data.var2 = "filter";
sub_sim_data.x_var = "EbN0_db";
sub_sim_data.x_range = 3:3:18;
sub_sim_data.var1_range = [16,64];
sub_sim_data.var2_range = ["rect","sinc","rrc","rrc"];
sub_sim_data.var_defaults = {18,4,"MPSK",15e3,4e9,500,16,64,8,"rect",1};
sub_sim_data.rrc_vals = [1,0.2];
sub_fig_data.fig_num = profile_num;
sub_fig_data.fig_data_type = "BER";
sub_fig_data.xlabel_vec = "E_b/N_0 (dB)";
sub_fig_data.ylim_vec = [1e-7 2e-1];
sub_fig_data.fig_title = "Performance of typical pulses under Q=8";
sub_fig_data.var1_spec = ["ro","b*"];
sub_fig_data.var2_spec = ["-","--","-.",":"];
sub_fig_data.gen_spec = "";
new_profile.sub_sim_data = sub_sim_data;
new_profile.sub_fig_data = sub_fig_data;
eval("profile_"+profile_num+" = new_profile;");
eval("all_profiles = [all_profiles profile_"+profile_num+"];");

% Figure 2 - BER vs Q, sinc and RRC
profile_num = profile_num + 1;
new_profile = profile_obj;
sub_sim_data = sim_data;
sub_fig_data = fig_data;
sub_sim_data.var1 = "EbN0_db";
sub_sim_data.var2 = "rolloff";
sub_sim_data.x_var = "q";
sub_sim_data.x_range = 2:2:14;
sub_sim_data.var1_range = [12,18];
sub_sim_data.var2_range = [0,0.2,1];
sub_sim_data.var_defaults = {18,4,"MPSK",15e3,4e9,500,16,64,8,"rrc",1};
sub_sim_data.rrc_vals = [0.2,1];
sub_fig_data.fig_num = profile_num;
sub_fig_data.fig_data_type = "BER";
sub_fig_data.xlabel_vec = "Q";
sub_fig_data.ylim_vec = [1e-5 2e-1];
sub_fig_data.fig_title = "Improvements with RRC pulses as Q increases";
sub_fig_data.var1_spec = ["-","--"];
sub_fig_data.var2_spec = ["ro","bv","ksquare"];
sub_fig_data.gen_spec = "";
sub_fig_data.legend_loc = "northeast";
new_profile.sub_sim_data = sub_sim_data;
new_profile.sub_fig_data = sub_fig_data;
eval("profile_"+profile_num+" = new_profile;");
eval("all_profiles = [all_profiles profile_"+profile_num+"];");

% Figure 3 - BER vs rolloff, RRC
profile_num = profile_num + 1;
new_profile = profile_obj;
sub_sim_data = sim_data;
sub_fig_data = fig_data;
sub_sim_data.var1 = "q";
sub_sim_data.var2 = "NA";
sub_sim_data.x_var = "rolloff";
sub_sim_data.x_range = 0:.1:1;
sub_sim_data.var1_range = 4:2:10;
sub_sim_data.var2_range = [];
sub_sim_data.var_defaults = {12,4,"MPSK",15e3,4e9,500,64,64,8,"rrc",1};
sub_fig_data.fig_num = profile_num;
sub_fig_data.fig_data_type = "BER";
sub_fig_data.xlabel_vec = "rolloff factor \alpha";
sub_fig_data.ylim_vec = [1e-3 1e-2];
sub_fig_data.fig_title = "Performance of RRC under various \alpha values";
sub_fig_data.var1_spec = ["-","--"];
sub_fig_data.var2_spec = ["gv","ro","b*","ksquare"];
sub_fig_data.gen_spec = "";
sub_fig_data.legend_loc = "northeast";
new_profile.sub_sim_data = sub_sim_data;
new_profile.sub_fig_data = sub_fig_data;
eval("profile_"+profile_num+" = new_profile;");
eval("all_profiles = [all_profiles profile_"+profile_num+"];");

% % Figure 2
% profile_num = profile_num + 1;
% new_profile = profile_obj;
% sub_sim_data = sim_data;
% sub_fig_data = fig_data;
% sub_sim_data.var1 = "N_tsyms";
% sub_sim_data.var2 = "q";
% sub_sim_data.x_var = "EbN0_db";
% sub_sim_data.x_range = 3:3:18;
% sub_sim_data.var1_range = [16,64];
% sub_sim_data.var2_range = 2:2:8;
% sub_sim_data.var_defaults = {18,4,"MPSK",15e3,4e9,500,16,64,8,"sinc",1};
% sub_fig_data.fig_num = profile_num;
% sub_fig_data.fig_data_type = "BER";
% sub_fig_data.xlabel_vec = "E_b/N_0 (dB)";
% sub_fig_data.ylim_vec = [1e-6 2e-1];
% sub_fig_data.fig_title = "Performance of truncated sinc pulses";
% sub_fig_data.var1_spec = ["ro","b*"];
% sub_fig_data.var2_spec = ["-","--","-.",":"];
% sub_fig_data.gen_spec = "";
% new_profile.sub_sim_data = sub_sim_data;
% new_profile.sub_fig_data = sub_fig_data;
% eval("profile_"+profile_num+" = new_profile;");
% eval("all_profiles = [all_profiles profile_"+profile_num+"];");
%
% % Figure 3
% profile_num = profile_num + 1;
% new_profile = profile_obj;
% sub_sim_data = sim_data;
% sub_fig_data = fig_data;
% sub_sim_data.var1 = "N_tsyms";
% sub_sim_data.var2 = "q";
% sub_sim_data.x_var = "EbN0_db";
% sub_sim_data.x_range = 3:3:18;
% sub_sim_data.var1_range = [16,64];
% sub_sim_data.var2_range = 2:2:8;
% sub_sim_data.var_defaults = {18,4,"MPSK",15e3,4e9,500,16,64,8,"rrc",1};
% sub_fig_data.fig_num = profile_num;
% sub_fig_data.fig_data_type = "BER";
% sub_fig_data.xlabel_vec = "E_b/N_0 (dB)";
% sub_fig_data.ylim_vec = [1e-6 2e-1];
% sub_fig_data.fig_title = sprintf("Performance of truncated RRC pulses (\\alpha=%d)",sub_sim_data.var_defaults{length(var_list)});
% sub_fig_data.var1_spec = ["ro","b*"];
% sub_fig_data.var2_spec = ["-","--","-.",":"];
% sub_fig_data.gen_spec = "";
% new_profile.sub_sim_data = sub_sim_data;
% new_profile.sub_fig_data = sub_fig_data;
% eval("profile_"+profile_num+" = new_profile;");
% eval("all_profiles = [all_profiles profile_"+profile_num+"];");

% Figure 4 - Resiliency to velocity
profile_num = profile_num + 1;
new_profile = profile_obj;
sub_sim_data = sim_data;
sub_fig_data = fig_data;
sub_sim_data.var1 = "filter";
sub_sim_data.var2 = "NA";
sub_sim_data.x_var = "v_vel";
sub_sim_data.x_range = 50:150:800;
sub_sim_data.var1_range = ["rect","sinc","rrc"];
sub_sim_data.var2_range = "";
sub_sim_data.var_defaults = {12,4,"MPSK",15e3,4e9,500,16,64,8,"rect",0.3};
sub_sim_data.rrc_vals = 1;
sub_fig_data.fig_num = profile_num;
sub_fig_data.fig_data_type = "BER";
sub_fig_data.xlabel_vec = "vehicle speed (km/hr)";
sub_fig_data.ylim_vec = [1e-3 2e-2];
sub_fig_data.fig_title = "Performance under various vehicle speeds";
sub_fig_data.var1_spec = ["ro","b*","ksquare"];
sub_fig_data.var2_spec = "";
sub_fig_data.gen_spec = "-";
new_profile.sub_sim_data = sub_sim_data;
new_profile.sub_fig_data = sub_fig_data;
eval("profile_"+profile_num+" = new_profile;");
eval("all_profiles = [all_profiles profile_"+profile_num+"];");

% % Figure 5
% profile_num = profile_num + 1;
% new_profile = profile_obj;
% sub_sim_data = sim_data;
% sub_fig_data = fig_data;
% sub_sim_data.var1 = "filter";
% sub_sim_data.var2 = "NA";
% sub_sim_data.x_var = "sbcar_spacing";
% sub_sim_data.x_range = 10e3:1e3:20e3;
% sub_sim_data.var1_range = ["rect","sinc","rrc"];
% sub_sim_data.var2_range = [];
% sub_sim_data.var_defaults = {12,4,"MPSK",15e3,4e9,500,16,64,8,"rect",0.3};
% sub_fig_data.fig_num = profile_num;
% sub_fig_data.fig_data_type = "BER";
% sub_fig_data.xlabel_vec = "subcarrier spacing (Hz)";
% sub_fig_data.ylim_vec = [1e-7 2e-1];
% sub_fig_data.fig_title = "Performance under various subcarrier spacings";
% sub_fig_data.var1_spec = [];
% sub_fig_data.var2_spec = ["ro","b*","ksquare"];
% sub_fig_data.gen_spec = "-";
% new_profile.sub_sim_data = sub_sim_data;
% new_profile.sub_fig_data = sub_fig_data;
% eval("profile_"+profile_num+" = new_profile;");
% eval("all_profiles = [all_profiles profile_"+profile_num+"];");



%% Backend

% Set figures that are simulated and rendered
if not(make_all_figs)
    sweep_range = fig_num;
else
    sweep_range = 1:profile_num;
end

% Set flag for continuing to improve
improve_flag = true;
if iteratively_improve
    max_frames = Inf;
end

% Sweep through all systems
iterations = 0;
while improve_flag
    iterations = iterations + 1;
    frame_goal = iterations * increment_frames;
    if frame_goal > max_frames
        frame_goal = max_frames;
    end
    for p = sweep_range
        % Set current profile
        profile_sel = all_profiles(p);
        fig_data = profile_sel.sub_fig_data;
        fig_data.render_for_paper = render_for_paper;
        fig_data.save_figure = save_figure;
        sim_data = profile_sel.sub_sim_data;
        sim_data.max_errors = max_errors;
        sim_data.max_frames = frame_goal;
        sim_data.var_tol = norm_var_tol;
        sim_data.saved_results_length = saved_results_length;
        sim_data.freq_display = freq_of_display;
        sim_data.max_time = 60 * max_mins_per_sim;
        sim_data.var_list = var_list;
        sim_data.reload = reload;

        % Extract sim data to make systems
        var1 = sim_data.var1;
        var2 = sim_data.var2;
        x_var = sim_data.x_var;
        x_range = sim_data.x_range;
        var1_range = sim_data.var1_range;
        var2_range = sim_data.var2_range;
        var_defaults = sim_data.var_defaults;

        % Make needed variables
        if var2 == "NA"
            num_vars = 1;
            var_names = var1;
            variants = table2cell(combinations(var1_range));
        else
            num_vars = 2;
            var_names = [var1,var2];
            variants = table2cell(combinations(var1_range,var2_range));
        end

        % Add a detail about selected alpha for RRC pulses
        rrc_count = 0;
        for k = 1:2
            try
                vars_temp = [variants{:,k}];
                if ismember("rrc",vars_temp)
                    for i = 1:length(vars_temp)
                        if vars_temp(i) == "rrc"
                            rrc_index = mod(rrc_count,length(sim_data.rrc_vals)) + 1;
                            vars_temp(i) = vars_temp(i) + ",\alpha=" + sim_data.rrc_vals(rrc_index);
                            rrc_count = rrc_count + 1;
                        end
                    end
                end

                if k == 1
                    variants_legend = table2cell(combinations(vars_temp(1:(length(vars_temp)/length(var2_range))),var2_range));
                else
                    variants_legend = table2cell(combinations(var1_range,vars_temp(1:(length(vars_temp)/length(var1_range)))));
                end

                break;
            catch
                variants_legend = variants;
            end
        end

        % Make legend vector
        legend_vec_name = repmat("",1,size(variants_legend,1));
        legend_mat = cell(size(variants_legend,1),num_vars);
        for j = 1:num_vars
            var_sel = eval("var" + j);
            switch var_sel
                case "EbN0_db"
                    prefix = "";
                    suffix = "dB";
                case "M_ary"
                    prefix = "";
                    suffix = "-ary";
                case "select_mod"
                    prefix = "";
                    suffix = "";
                case "sbcar_spacing"
                    prefix = "df=";
                    suffix = "Hz";
                case "Fc"
                    prefix = "f_c=";
                    suffix = "Hz";
                case "v_vel"
                    prefix = "";
                    suffix = "km/hr";
                case "N_tsyms"
                    prefix = "N=";
                    suffix = "";
                case "M_sbcars"
                    prefix = "M=";
                    suffix = "";
                case "q"
                    prefix = "Q=";
                    suffix = "";
                case "filter"
                    prefix = "";
                    suffix = "";
                case "rolloff"
                    prefix = "\alpha=";
                    suffix = "";
            end
            for i = 1:size(variants_legend,1)
                legend_mat{i,j} = prefix + variants_legend{i,j} + suffix;
            end
        end
        for i = 1:size(variants_legend,1)
            for j = 1:num_vars
                if j > 1
                    legend_vec_name(i) = legend_vec_name(i) + ",";
                end
                legend_vec_name(i) = legend_vec_name(i) + legend_mat{i,j};
            end
        end
        fig_data.legend_name_vec = legend_vec_name;

        % Define all systems
        num_systems = size(variants,1);
        sim_data.num_systems = num_systems;
        systems = repmat(comms_obj_OTFS,1,num_systems);
        for i = 1:length(systems)
            for k = 1:length(var_list)
                if ismember(var_list(k),var_names)
                    variant_index = find(strcmp(var_list(k),var_names));
                    variant_val = variants(i,variant_index);
                    eval("systems(i)." + var_list(k) + " = variant_val{1};");
                else
                    % variant_val = var_defaults{k};
                    eval("systems(i)." + var_list(k) + " = var_defaults{k};");
                end
            end
        end

        % Add redundancies
        rrc_count = 0;
        for i = 1:length(systems)
            if systems(i).filter == "rect"
                systems(i).q = 1;
                systems(i).rolloff = 1;
            end
            if systems(i).filter == "sinc"
                systems(i).rolloff = 1;
            end
            if systems(i).filter == "rrc"
                if systems(i).rolloff == 0
                    systems(i).filter = "sinc";
                    systems(i).rolloff = 1;
                else
                    rrc_index = mod(rrc_count,length(sim_data.rrc_vals)) + 1;
                    systems(i).rolloff = sim_data.rrc_vals(rrc_index);
                    rrc_count = rrc_count + 1;
                end
            end
        end

        % Run aimulations as needed
        sim_data = sim_save(systems,sim_data);

        if show_figure
            % Plot data
            render_figure(systems,sim_data,fig_data);
        end
    end

    % Break if goal is met
    if frame_goal > max_frames
        improve_flag = false;
    end
end
