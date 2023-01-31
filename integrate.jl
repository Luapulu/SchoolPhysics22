### A Pluto.jl notebook ###
# v0.19.17

using Markdown
using InteractiveUtils

# ╔═╡ 2122ef12-9bd5-11ed-2b8c-a7183eb8a049
using PlutoTest

# ╔═╡ 0b37ca4d-7a38-4cbb-b9c5-50b97e28293b
using Random: default_rng

# ╔═╡ bec77c74-e404-4e3d-b33d-68d8f03c1e8b
begin
	struct MonteCarlo{RNG}
		rng::RNG
	end

	MonteCarlo(rng::RNG) where RNG = MonteCarlo{RNG}(rng)

	MonteCarlo() = MonteCarlo(default_rng())
end

# ╔═╡ 76adf4fc-f882-4d4d-8f4c-9daf11cc1740
function integrate(f, (a, b)::Tuple{T, T}, N::Integer, method::MonteCarlo) where T
	s = zero(T)
	L = b - a
	for _ in 1:N
		s += f(a + L * rand(method.rng, T))
	end
	return L * s / N
end

# ╔═╡ 28c1bfef-1833-42ac-a340-d8cb7f65ac73
test_method = MonteCarlo()

# ╔═╡ 55d57916-2da8-4ce3-8004-12f80b7fe929
testN = 10_000

# ╔═╡ e41bcfcd-6c0c-487c-bdcc-c11377b0821d
integrate(x -> x^2, (-5.0, 5.0), testN, test_method)

# ╔═╡ 6dda8d6d-d5aa-43e8-8a42-3ef026b2dc48
@test integrate(x -> sinpi(x)^2, (-1.0, 1.0), testN, test_method) ≈ 1.0

# ╔═╡ 457f749e-1c44-4b9c-ab93-3de38fccbb91
let coeffs = (1.5, 5.0, 2.0, 9.0), int_coeffs = (0.0, 1.5, 5.0 / 2, 2.0 / 3, 9.0 / 4)
	a, b = (-1.0, 3.0)
	I = evalpoly(b, int_coeffs) - evalpoly(a, int_coeffs)
	@test integrate(x -> evalpoly(x, coeffs), (a, b), testN, test_method) ≈ I
end

# ╔═╡ 8d6e2795-3dee-4b14-96f1-733f59cada66
@test integrate(x -> exp(-x^2), (-100.0, 100.0), testN, test_method) ≈ sqrt(π)

# ╔═╡ 3306d319-736c-4c43-a235-0f124ed324fb
@test integrate(exp, (-5.0, 10.0), testN, test_method) ≈ exp(10.0) - exp(-5.0)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoTest = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
PlutoTest = "~0.2.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "474a1f3cfb0a80401d39c59c744d0a768f0c524a"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.PlutoTest]]
deps = ["HypertextLiteral", "InteractiveUtils", "Markdown", "Test"]
git-tree-sha1 = "17aa9b81106e661cffa1c4c36c17ee1c50a86eda"
uuid = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
version = "0.2.2"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"
"""

# ╔═╡ Cell order:
# ╠═2122ef12-9bd5-11ed-2b8c-a7183eb8a049
# ╠═0b37ca4d-7a38-4cbb-b9c5-50b97e28293b
# ╠═bec77c74-e404-4e3d-b33d-68d8f03c1e8b
# ╠═76adf4fc-f882-4d4d-8f4c-9daf11cc1740
# ╠═28c1bfef-1833-42ac-a340-d8cb7f65ac73
# ╠═55d57916-2da8-4ce3-8004-12f80b7fe929
# ╠═e41bcfcd-6c0c-487c-bdcc-c11377b0821d
# ╠═6dda8d6d-d5aa-43e8-8a42-3ef026b2dc48
# ╠═457f749e-1c44-4b9c-ab93-3de38fccbb91
# ╠═8d6e2795-3dee-4b14-96f1-733f59cada66
# ╠═3306d319-736c-4c43-a235-0f124ed324fb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
