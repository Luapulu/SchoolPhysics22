### A Pluto.jl notebook ###
# v0.19.17

using Markdown
using InteractiveUtils

# ╔═╡ f4620c0b-92bc-4087-9a0e-df8f11879b95
using Random: AbstractRNG, shuffle!

# ╔═╡ 8271c26e-8f1f-43b1-b002-62eaaef423a9
using PlutoTest

# ╔═╡ fd20a949-7e32-4fce-a470-2f73f676ead5
using BenchmarkTools

# ╔═╡ 6e225a89-d38a-4c8c-8131-c3adde989b28
md"# Intro to Structs and Methods"

# ╔═╡ 2a54a219-97de-4bf2-aab1-6de54558e3ee
md"Below is a `struct`. Structs are containers for data. In this case, we define a `Human` struct which contains the human's name."

# ╔═╡ 7c42dd5a-0e50-4d73-9489-d8b9f1c5a09e
struct Human
	name::String
end

# ╔═╡ 98edd11d-fd57-4079-8882-a3ff3842339c
md"To make a human we have to actually give it a name. Let's make ourselves a Bob."

# ╔═╡ ad151310-9fb0-4fb1-8e18-5c321e63465b
bob = Human("Bob")

# ╔═╡ 88620f32-4473-4dab-8a62-6881c922bc3f
md"We can retrieve Bob's name as shown below. In general, the data in a struct can be accessed by `instance_of_struct.property_name`"

# ╔═╡ a186f59d-ebfb-44f7-930a-e1015404a9ad
bob.name

# ╔═╡ b9034f7d-3390-4b9d-8370-fa2783e890e6
md"Given a struct we can figure out what kind of struct it is as follows. Try this with other objects you know like numbers or true/false values, etc."

# ╔═╡ a8c544c9-1992-4c64-8765-bfbd77b83c0e
typeof(bob)

# ╔═╡ 5bb63cbd-7645-4aad-8f35-e959dc08503d
md"So far we're just using structs to store data. Let's do something with the data. Let's define a greeting for each animal."

# ╔═╡ ba9a63db-570c-4938-8b99-591c88ee8036
greeting(human::Human) = "Hi, my name is $(human.name)."

# ╔═╡ 87299824-56b7-48fc-b9f7-440eec253a01
md"A world without cats is a sad world, so let's create cats, too."

# ╔═╡ a621ff26-7c24-4c4e-b910-efb52f66d820
struct Cat
	islarge::Bool  # lion or house cat?
	lifenum::Int  # how many lives has this cat experienced?
end

# ╔═╡ 36398dcb-433f-46db-928e-d365be20454e
oscar = Cat(false, 3)

# ╔═╡ ea207303-60ed-40e8-86f0-fe0b1f9afffb
oscar.lifenum

# ╔═╡ ed712b3a-2358-4b3b-b4b4-d4da1cf9f6c8
oscar.islarge

# ╔═╡ bfa53a70-6063-4806-9d33-87d1071884f4
md"We've already defined a greeting for humans. Cats are different though. We can define different behaviour for functions based on the type of their inputs. Each such version of a function is called a method. Below, we define a method which defines greetings for cats. Above, we defined a method which defines greetings for humans."

# ╔═╡ 5524881f-9a22-4f80-98f9-97d2022a9400
function greeting(cat::Cat)
	if cat.lifenum > 4  # experienced cats have no need for greetings
		return ""
	elseif cat.islarge  # big cats roar
		return "ROAR!"
	else  # small cats meow
		return "meow"
	end
end

# ╔═╡ bb7feb5a-3bb7-472e-bbb8-d894ff16bb71
greeting(bob)

# ╔═╡ 6380d654-7644-4fa7-9086-fc94873facfd
greeting(Human("John"))

# ╔═╡ 178e87b1-9864-4f10-accd-e9187e13aaa3
greeting(oscar)

# ╔═╡ 97c78fec-a7c8-466a-a5f4-ef6397f960da
md"# Root Finding"

# ╔═╡ f3e5a7b0-b6ab-4f44-8b61-99c15d6cbec0
struct Brute end

# ╔═╡ c0773a01-91d1-4720-80fc-39d9f79e86b2
function findroot(f, (lb, ub)::Tuple{T, T}, xtol::T, method::Brute) where T <: Real
	bx, bf = lb, Inf  # init best so far input and function value
	for x in range(lb, ub; step=xtol)  # search interval in steps of xtol
		fx = f(x)  # evaluate function at candidate position
		if abs(fx) < abs(bf) # if candiate closer to zero
			bx, bf = x, fx  # update best so far
		end
	end
	bx  # return best so far
end

# ╔═╡ f11de00e-b2d9-42c7-9263-448e123a8cec
md"Add your own methods below :)"

# ╔═╡ c349311e-778a-4b41-8a28-a03d94fc59e5
# add your own method struct
struct MyMethod
	pos::Float64
	mid::Bool
end

# ╔═╡ 290e7ca1-804a-4564-bad7-4c2fdac175e5
# define how root finding should work for your method
function findroot(f, (lb, ub)::Tuple{T, T}, xtol::T, method::MyMethod) where T <: Real
	# This is dummy code, feel free to replace
	if method.mid
		return (lb + ub) / 2
	else
		return lb + method.pos * (ub - lb)
	end
end

# ╔═╡ 5adad1e8-4c1a-4e48-883e-7198a0dcd49a
md"# Tests
See if your method works.
A good root finding method should be able to handle a tolerance of `1e-15`.
Don't use Brute with that tolerance though --- it will never finish.
"

# ╔═╡ a1f6cf26-9ae1-4b30-811b-f39e9a705067
testmethod = Brute()

# ╔═╡ 1f3db068-872b-45c8-8e62-d3e1e13b55cd
test_tol = 1e-3

# ╔═╡ 7e6cc62d-778a-49a8-98e9-f970a584359f
findroot(x -> (x - 4) * (x - 1), (-2.0, 3.0), test_tol, testmethod)

# ╔═╡ 952cf622-14ed-48f8-b72a-b07e0db09289
let f(x) = x, r = 0.0, I=(-1.0, 3.0)
	@test abs(findroot(f, I, test_tol, testmethod) - r) < test_tol
end

# ╔═╡ dec53edb-f7b0-405d-bd88-1b4d53825581
let f(x) = (exp(x)-1) / (exp(x)+1), x0 = 0.0, I=(-50.0, 10.0)
	@test abs(findroot(f, I, test_tol, testmethod) - x0) < test_tol
end

# ╔═╡ 61506dd8-f7ba-45ab-b0a1-a41b9e6a33c8
let f(x) = sinpi(x), x0 = 0.0, I=(-0.25, 0.3)
	r = findroot(f, I, test_tol, testmethod)
	@test abs(r - x0) < test_tol
end

# ╔═╡ 1fe7e6ca-9c0a-42a5-94e9-5e82520eb8ca
md"# Benchmarking
See how fast your method is.
Once you have a method that can calculate roots accurately (not Brute!), set the tolerance to `1e-15` in the benchmark."

# ╔═╡ 6b09b7c5-b210-48f6-914e-a5484a5116fb
md"Below is the code to define the benchmark functions."

# ╔═╡ 3781cf2a-087d-4558-8b22-11d6e9f5245e
# maximum deviation from true root
# over iterable of functions `bfs` for `method`, given tolerance `tol`
benchmark(method::M, bfs, tol) where M = maximum(bfs) do bf
	abs(findroot(x -> bf(x), (-1.0, 1.0), tol, method) - bf.r)
end

# ╔═╡ 2f5dba56-08bb-4e94-a89a-d85e8baf4dcd
begin
	struct BenchFunction{T<:Real}
		a::T
		r::T
		f::T
		p::T
	end

	function ((; a, r, f, p)::BenchFunction)(x::T) where T<:Real
		y1 = a * (x - r)
		y2 = one(T)+T(2//3)*sinpi(f*(x+p))
		return y1 * y2
	end
end

# ╔═╡ aadd6284-7d3f-4701-94ce-9355aaf90475
begin
	import Random: rand
	using Random: SamplerType

	function rand(rng::AbstractRNG, ::SamplerType{BenchFunction{T}}) where T<:Real
		r = 2*rand(rng, T)-1
		f = T(1//3) + rand(rng, T)
		p = 2*rand(rng, T)-1
		a = randn(rng, T)
		while a == zero(T)
			a = randn(rng, T)
		end
		BenchFunction{T}(a, r, f, p)
	end
end

# ╔═╡ e8bd48d0-9f59-4277-94ee-8433c02173b4
testbf = rand(BenchFunction{Float64})

# ╔═╡ 4dbf84b1-f751-445b-9606-a20f5495e743
testr = findroot(testbf, (-1.0, 1.0), test_tol, testmethod)

# ╔═╡ f989e563-dde5-4c0e-9a57-bcdce9a99235
testbf(testr)

# ╔═╡ 62172ddb-6a37-42d1-96ab-b30483fabb3c
@test abs(testr - testbf.r) < test_tol

# ╔═╡ ac28a6f4-bb90-4ec7-a683-9cdf12d6c991
testbfs = rand(BenchFunction{Float64}, 10_000)  # 10_000 test functions

# ╔═╡ 79271e78-1076-4872-8d96-7fd928963e9a
benchmark(testmethod, testbfs, test_tol) # maximum error for testbfs

# ╔═╡ b9b29f42-4bdf-4f9a-9bfb-ec3125e29336
benchbfs = rand(BenchFunction{Float64}, 1_000)

# ╔═╡ 2b1f8bb6-8216-4ff5-8d84-e2cc0733810b
b = @benchmark benchmark(Brute(), $benchbfs, 1e-2) setup=(shuffle!(benchbfs))

# ╔═╡ dd6d39ed-05a3-42fe-a1af-4aad4d8499d6
minimum(b)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
PlutoTest = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
BenchmarkTools = "~1.3.2"
PlutoTest = "~0.2.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "3b60ace1561a96ad20e42eb8bec73e11c82fa009"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "d9a9701b899b30332bbcb3e1679c41cce81fb0e8"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.2"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "6466e524967496866901a78fca3f2e9ea445a559"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.2"

[[deps.PlutoTest]]
deps = ["HypertextLiteral", "InteractiveUtils", "Markdown", "Test"]
git-tree-sha1 = "17aa9b81106e661cffa1c4c36c17ee1c50a86eda"
uuid = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
version = "0.2.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"
"""

# ╔═╡ Cell order:
# ╠═f4620c0b-92bc-4087-9a0e-df8f11879b95
# ╠═8271c26e-8f1f-43b1-b002-62eaaef423a9
# ╠═fd20a949-7e32-4fce-a470-2f73f676ead5
# ╟─6e225a89-d38a-4c8c-8131-c3adde989b28
# ╟─2a54a219-97de-4bf2-aab1-6de54558e3ee
# ╠═7c42dd5a-0e50-4d73-9489-d8b9f1c5a09e
# ╟─98edd11d-fd57-4079-8882-a3ff3842339c
# ╠═ad151310-9fb0-4fb1-8e18-5c321e63465b
# ╟─88620f32-4473-4dab-8a62-6881c922bc3f
# ╠═a186f59d-ebfb-44f7-930a-e1015404a9ad
# ╟─b9034f7d-3390-4b9d-8370-fa2783e890e6
# ╠═a8c544c9-1992-4c64-8765-bfbd77b83c0e
# ╟─5bb63cbd-7645-4aad-8f35-e959dc08503d
# ╠═ba9a63db-570c-4938-8b99-591c88ee8036
# ╠═bb7feb5a-3bb7-472e-bbb8-d894ff16bb71
# ╠═6380d654-7644-4fa7-9086-fc94873facfd
# ╟─87299824-56b7-48fc-b9f7-440eec253a01
# ╠═a621ff26-7c24-4c4e-b910-efb52f66d820
# ╠═36398dcb-433f-46db-928e-d365be20454e
# ╠═ea207303-60ed-40e8-86f0-fe0b1f9afffb
# ╠═ed712b3a-2358-4b3b-b4b4-d4da1cf9f6c8
# ╟─bfa53a70-6063-4806-9d33-87d1071884f4
# ╠═5524881f-9a22-4f80-98f9-97d2022a9400
# ╠═178e87b1-9864-4f10-accd-e9187e13aaa3
# ╟─97c78fec-a7c8-466a-a5f4-ef6397f960da
# ╠═f3e5a7b0-b6ab-4f44-8b61-99c15d6cbec0
# ╠═c0773a01-91d1-4720-80fc-39d9f79e86b2
# ╟─f11de00e-b2d9-42c7-9263-448e123a8cec
# ╠═c349311e-778a-4b41-8a28-a03d94fc59e5
# ╠═290e7ca1-804a-4564-bad7-4c2fdac175e5
# ╟─5adad1e8-4c1a-4e48-883e-7198a0dcd49a
# ╠═a1f6cf26-9ae1-4b30-811b-f39e9a705067
# ╠═1f3db068-872b-45c8-8e62-d3e1e13b55cd
# ╠═7e6cc62d-778a-49a8-98e9-f970a584359f
# ╠═952cf622-14ed-48f8-b72a-b07e0db09289
# ╠═dec53edb-f7b0-405d-bd88-1b4d53825581
# ╠═61506dd8-f7ba-45ab-b0a1-a41b9e6a33c8
# ╠═e8bd48d0-9f59-4277-94ee-8433c02173b4
# ╠═4dbf84b1-f751-445b-9606-a20f5495e743
# ╠═f989e563-dde5-4c0e-9a57-bcdce9a99235
# ╠═62172ddb-6a37-42d1-96ab-b30483fabb3c
# ╠═ac28a6f4-bb90-4ec7-a683-9cdf12d6c991
# ╠═79271e78-1076-4872-8d96-7fd928963e9a
# ╟─1fe7e6ca-9c0a-42a5-94e9-5e82520eb8ca
# ╠═b9b29f42-4bdf-4f9a-9bfb-ec3125e29336
# ╠═2b1f8bb6-8216-4ff5-8d84-e2cc0733810b
# ╠═dd6d39ed-05a3-42fe-a1af-4aad4d8499d6
# ╟─6b09b7c5-b210-48f6-914e-a5484a5116fb
# ╠═3781cf2a-087d-4558-8b22-11d6e9f5245e
# ╠═2f5dba56-08bb-4e94-a89a-d85e8baf4dcd
# ╠═aadd6284-7d3f-4701-94ce-9355aaf90475
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
