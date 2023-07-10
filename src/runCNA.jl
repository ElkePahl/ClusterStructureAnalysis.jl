# Author: AJ Tyler
# Date: 24/01/22

# This script calls the compare and classify function from the main module.

include("/home/tyu044/Downloads/CNA/CNA/main.jl")
using .main
compare("/home/tyu044/Downloads/CNA/CNA/DianaConfigs")
classify("/home/tyu044/Downloads/CNA/CNA/CNA/DianaConfigs")
