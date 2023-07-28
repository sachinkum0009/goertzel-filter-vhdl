GHDL=ghdl
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) read_signal.vhd goertzel_filter.vhd
	@$(GHDL) -e $(FLAGS) read_signal
	@$(GHDL) -r $(FLAGS) read_signal --wave=wave_file_reader3.ghw --stop-time=10000ms

