# dynamic-comm-sim
This collection of functions act as a blueprint for simulating complex wireless communication systems while minimizing headache. The basic process is this:
Front-end:
- Change settings that apply to every experiment you want to conduct, including maximum number of tested frames, number of frames to be tested at a time, whether to improve endlessly, and so on.
- Set which experiment you want to focus on, whether you want it to render the figure or just simulate, and whether you want it to reload or not.
- Create the experiment setups you want to test (including different variables you want tested, x-range variable and values, system defaults, etc.).
 
Back-end:
1. All needed system configurations are made automatically from the experimental setups given.
2. Each system simulates for however long it's allowed, depending on the front-end settings.
3. Bit, symbol and frame errors are externally saved, as well as number of frames, symbols per frame and modulation order.
4. Once all simulation files have at least the needed number of frames, figures are rendered according to settings

Each simulation file is saved separately for each parameter setup. The simulator automatically reads already-saved data and improves upon it if more frames are needed.
This system allows for easier testing of systems that require significant amounts of time to simulate. For instance, setting the number of "increment frames" makes it
so only that amount of frames are processed at once, leading to a system where it iteratively improves until the amount of data is satisfactory, rather than trying to
complete it all at once. Additionally, once all data is saved, figures can be rendered instead of relying on using saved image files. As of now, you can limit how long
each simulation runs for by setting the number of increment frames or maximum time per simulation.

The actual file that simulates these systems is not included yet. I'm working on making a simpler group of files to more easily convey this simulation method, but my 
work may be the work of the university at the moment.
