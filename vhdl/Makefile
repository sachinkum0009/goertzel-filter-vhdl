ENTITY=goertzel_filter
GHDL=ghdl
FLAGS="--std=08"

wave:
	@$(GHDL) -a $(FLAGS) read_signal.vhd $(ENTITY).vhd
	@$(GHDL) -e $(FLAGS) read_signal
	@$(GHDL) -r $(FLAGS) read_signal --wave=$(ENTITY).ghw --stop-time=10000ms

simulate:
	ghdl -a $(ENTITY).vhd

svg:
	@$(MAKE) simulate
	for en in $(ENTITY); do \
		yosys -m $(GHDL) -p "ghdl $$en; prep -top $$en; write_json -compat-int svg.json"; \
		netlistsvg svg.json -o netlist.svg; \
		svgexport netlist.svg netlist.jpg; \
	done