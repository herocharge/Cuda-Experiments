#!/bin/python3
import os

def list_cpp_files(directory):
    cpp_files = [file for file in os.listdir(directory) if file.endswith(".cpp")]
    return cpp_files

if __name__ == "__main__":
    # Change this to the directory you want to search for .cpp files
    target_directory = "./benchmarks/"

    cpp_files = list_cpp_files(target_directory)

    if cpp_files:
        print("[info] Start")
        for i, cpp_file in enumerate(cpp_files):
            print(f"[{i+1}/{len(cpp_files)}] Making Benchmark: {cpp_file}")
            os.system("make bench BENCH_NAME=" + cpp_file)
            print()
            print()
            print(f"[{i+1}/{len(cpp_files)}] Running Benchmark: {cpp_file}")
            os.system("./bench")
            print()
            print()

            # print(cpp_file)
        print("[info] End")
        
    else:
        print("No benchmark files found in the directory.")
