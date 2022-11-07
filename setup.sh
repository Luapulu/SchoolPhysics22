#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install julia git
git clone https://github.com/Luapulu/SchoolPhysics22.git
cd SchoolPhysics22
julia -e 'using Pkg; Pkg.add("Pluto"); using Pluto; Pluto.run(notebook="stochastic.jl")'
