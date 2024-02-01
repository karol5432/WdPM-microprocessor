rm -f tb_processor
rm -f tb_processor.vcd

iverilog -Wall -o tb_processor tb_processor.v

if [ $? -ne 0 ]; then
    echo Error: iverilog
    exit 1
fi

vvp tb_processor

if [ $? -ne 0 ]; then
    echo Error: VVP
    exit 1
fi

gtkwave tb_processor.vcd tb_processor.gtkw

if [ $? -ne 0 ]; then
    echo Error: GTKWave
    exit 1
fi