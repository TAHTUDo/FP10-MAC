# On Windows: Check weather the environment variable for ghdl is set properly.
# Imports the os-module which allows the execution of shell commands.
import os
# Imports the time-module which allows the thread to sleep.
import time

# File names of all vhdl files.
vhdl_files = [
    "and2.vhdl",
    "brent_kung_adder8.vhdl",
    "brent_kung_adder16.vhdl",
    "brent_kung_processor.vhdl",
    "complementer8.vhdl",
    "d_ff.vhdl",
    "dadda_reducer.vhdl",
    "fa.vhdl",
    "ha.vhdl",
    "mac.vhdl",
    "mux2_1.vhdl",
    "not1.vhdl",
    "or2.vhdl",
    "pipo8.vhdl",
    "pipo16.vhdl",
    "xor2.vhdl",
    "xor3.vhdl",
    "and2_tb.vhdl",
    "brent_kung_adder8_tb.vhdl",
    "brent_kung_adder16_tb.vhdl",
    "brent_kung_processor_tb.vhdl",
    "complementer8_tb.vhdl",
    "d_ff_tb.vhdl",
    "dadda_reducer_tb.vhdl",
    "fa_tb.vhdl",
    "ha_tb.vhdl",
    "mac_tb.vhdl",
    "mux2_1_tb.vhdl",
    "not1_tb.vhdl",
    "or2_tb.vhdl",
    "pipo8_tb.vhdl",
    "pipo16_tb.vhdl",
    "xor2_tb.vhdl",
    "xor3_tb.vhdl"
]

# Syntax-Check
# List of all files failing the syntax check.
files_failed_syntax_check = []
# Conducts the syntax check for each given file.
# If a file fails the syntax check it is added to the corresponding list.
for vhdl_file in vhdl_files:
    # Successful execution is indicated by a completion code of 0.
    syntax_check_completion_code = os.system(f'cmd /c "ghdl -s {vhdl_file}"')
    if syntax_check_completion_code != 0:
        files_failed_syntax_check.append(vhdl_file)
# If all syntax checks were successful, a success message is printed.
# Otherwise an error message containing all file names of files that failed their syntax check is printed. After that
# this program gets terminated.
if len(files_failed_syntax_check) == 0:
    print("Syntax-check: OK")
else:
    print("Syntax-check: Failed")
    print("for")
    for file in files_failed_syntax_check:
        print(f'    {file}')
    exit(-1)

# Analysis
# List of all files failing the analysis.
files_failed_analysis = []
# Conducts the analysis for each given file.
# If a file fails the analysis it is added to the corresponding list.
for vhdl_file in vhdl_files:
    # Successful execution is indicated by a completion code of 0.
    analysis_completion_code = os.system(f'cmd /c "ghdl -a {vhdl_file}"')
    if analysis_completion_code != 0:
        files_failed_analysis.append(vhdl_file)
# If all analyses were successful, a success message is printed.
# Otherwise an error message containing all file names of files that failed their analysis is printed. After that
# this program gets terminated.
if len(files_failed_analysis) == 0:
    print("Analysis: OK")
else:
    print("Analysis: Failed")
    print("for")
    for file in files_failed_analysis:
        print(f'    {file}')
    exit(-1)

# Build
# List of all files failing the build.
files_failed_build = []
# Conducts the build for each given file.
# If a file fails the build it is added to the corresponding list.
for vhdl_file in vhdl_files:
    # Cuts off the vhdl file extension.
    file = vhdl_file.replace(".vhdl", "")
    # Successful execution is indicated by a completion code of 0.
    build_completion_code = os.system(f'cmd /c "ghdl -e {file}"')
    if build_completion_code != 0:
        files_failed_build.append(file)
# If all builds were successful, a success message is printed.
# Otherwise an error message containing all file names of files that failed their build is printed. After that
# this program gets terminated.
if len(files_failed_build) == 0:
    print("Build: OK")
else:
    print("Build: Failed")
    print("for")
    for file in files_failed_build:
        print(f'    {file}')
    exit(-1)

# VCD-Dump
# Creates a new folder for the vcd-files.
if not os.path.exists("VCD"):
  os.mkdir("VCD")
# List of all files failing the execution.
files_failed_exec = []
# Conducts the execution for each given file.
# If a file fails the execution it is added to the corresponding list.
for vhdl_file in vhdl_files:
    if vhdl_file.endswith("_tb.vhdl"):
        # Cuts off the vhdl file extension.
        file = vhdl_file.replace(".vhdl", "")
        # Successful execution is indicated by a completion code of 0.
        vcd_dump_completion_code = os.system(f'cmd /c "ghdl -r {file} --vcd=VCD\{file}.vcd --ieee-asserts=disable"')
        if vcd_dump_completion_code != 0:
            files_failed_exec.append(file)
time.sleep(1)
# If all executions were successful, a success message is printed.
# Otherwise an error message containing all file names of files that failed their execution is printed. After that
# this program gets terminated.
if len(files_failed_exec) == 0:
    print("Execution: OK")
else:
    print("Execution: Failed")
    print("for")
    for file in files_failed_exec:
        print(f'    {file}')
    exit(-1)
