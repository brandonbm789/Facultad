#!/bin/bash

CONTAINER_NAME="adc2024_gem5"
IMAGE_NAME="gvodanovic/adc_gem5:latest"
RESULT_PATH="./se_results/"


# Definir el benchmark a correr, opciones: ej_daxpy, ej_branchPred
# BENCHMARK="ej_daxpy"
BENCHMARK="ej_branchPred"

# Definir el procesador a utilizar,
# opciones: in_order, out_of_order, direct_map_8kb, direct_map_16kb, direct_map_32kb, way_2_32kb, way_4_32kb, way_8_32kb, y sus variaciones.
# PROCESSOR="in_order"
# PROCESSOR="out_of_order"
PROCESSOR="out_of_order_direct_map_8kb"
# PROCESSOR="out_of_order_tournament_way_2_8kb"

# PROCESSOR="tournament_direct_map_8kb"
# PROCESSOR="direct_map_8kb"
# PROCESSOR="direct_map_16kb"
# PROCESSOR="direct_map_32kb"

# PROCESSOR="way_2_32kb"
# PROCESSOR="way_2_16kb"
# PROCESSOR="way_2_8kb"
# PROCESSOR="tournament_way_2_8kb"

# PROCESSOR="way_4_32kb"
# PROCESSOR="way_4_16kb"
# PROCESSOR="way_4_8kb"
# PROCESSOR="tournament_way_4_8kb"

# PROCESSOR="way_8_32kb"
# PROCESSOR="way_8_16kb"
# PROCESSOR="way_8_8kb"
# PROCESSOR="tournament_way_8_8kb"

# docker build --platform linux/amd64 -t $IMAGE_NAME .

docker run -it --rm -v "$(pwd)":/local --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v "$HOME/.Xauthority:/root/.Xauthority:rw" --name $CONTAINER_NAME $IMAGE_NAME /bin/bash -c "aarch64-linux-gnu-gcc --static /local/benchmarks/$BENCHMARK.s -o /local/benchmarks/$BENCHMARK.img -I /opt/gem5/include -L /opt/gem5/util/m5/build/arm64/out/ -lm5 /opt/gem5/util/m5/build/arm64/out/libm5.a"

docker run -it --rm -v "$(pwd)":/local --privileged -v /tmp/.X11-unix:/tmp/.X11-unix -v "$HOME/.Xauthority:/root/.Xauthority:rw" --name $CONTAINER_NAME $IMAGE_NAME /bin/bash -c "/opt/gem5/build/ARM/gem5.opt -d $RESULT_PATH /local/scripts/se.py /local/scripts/cpu_config.toml $PROCESSOR /local/benchmarks/$BENCHMARK.img" > sim.log

python3 scripts/stat-collect.py se_results/stats.txt
