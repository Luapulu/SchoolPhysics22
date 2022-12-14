### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ 26c3d3fe-af66-4d79-8aaa-5f5b0784bab0
using CairoMakie

# ╔═╡ 0bee0d4b-272d-406f-b9fd-b947b901278b
using StatsBase

# ╔═╡ 9b0a5eee-a0d0-4b5e-83cf-7badb1753688
using PlutoUI: Slider

# ╔═╡ 30c0a8df-2340-4f66-a415-9375d0a6c893
using Distributions

# ╔═╡ c708e88a-4771-4144-8765-a78aa730e7f9
using LinearAlgebra

# ╔═╡ 6259db20-c705-4e7c-ba8f-18cc8b733f8b
using Random: AbstractRNG, Xoshiro, default_rng, randexp

# ╔═╡ aa7a9420-f7e1-4a44-9375-882c79f97e1a
using LsqFit

# ╔═╡ 7c145e9e-5d12-11ed-3c4b-796dde8540c7
md"""
# Random Variables

Useful links for this section:
- [Random docs](https://docs.julialang.org/en/v1/stdlib/Random/#Random-Numbers)
- [Mathematical operations docs](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Mathematical-Operations-and-Elementary-Functions)
- [Histogram docs](https://juliastats.org/StatsBase.jl/stable/empirical/#Empirical-Estimation-1)
- [Plotting docs](https://docs.makie.org/stable/)
- [Plotting example gallery](https://beautiful.makie.org/dev/)

In Julia, the [rand](https://docs.julialang.org/en/v1/stdlib/Random/#Base.rand) function samples a number in [0,1). press SHIFT + RETURN with the cursor in the cell below to sample a new number.
"""

# ╔═╡ 9128a75c-bcc4-4131-bdd0-73a6a8490165
rand()

# ╔═╡ f89e1123-2dd8-4c40-b501-909829e8c714
md"## Exercise 1: Bernoulli Trial
Below is a function definition and evaluation. Right now the function only returns *true* no matter what random number rand spits out."

# ╔═╡ 985916d7-8105-48d7-a3c9-9447afa50416
bernoulli(ω, p) = true

# ╔═╡ f3e091d6-5359-40b2-817e-db2848d70f90
bernoulli(rand(), 0.5)

# ╔═╡ f1ff8af1-6954-4771-9981-db2e295360a3
# this counts how often bernoulli(rand(), 0.7) returns true out of 1_000 evaluations
# If you've implemented the function correctly this should return 0.7
count([bernoulli(rand(), 0.7) for _ in 1:1_000]) / 1_000

# ╔═╡ 6382e7e4-2508-4bf6-9b09-41692268089b
md"Here are some examples of how to define functions in Julia."

# ╔═╡ bed0c3f8-0017-4fdd-b520-e4a265677140
# This is a one line function definition
# f adds the inputs x, y and z and subtracts 5
f(x, y, z) = x + y + z - 5 

# ╔═╡ 0642ade6-1869-4848-bc85-f60a85ec15ff
f(0.6, 0.1, 10)

# ╔═╡ 154cd13b-391d-46c2-83d6-241ca23a154e
# Functions often do more complicated things and may require multiple lines
# I show the return staement here, but you can delete return and just keep
# max(a,b) at the end. The last line of a function is automatically returned.
function g(x, y)
	a = 2x
	b = 5y + x
	return max(a, b)  # returns the larger of a and b
end

# ╔═╡ 08548873-ffd7-4f0c-83cd-8ba4c8d536c6
g(5, 7)

# ╔═╡ bbfdd8d8-f27f-4830-b468-df189c778de8
md"To return something else, try changing the bernoulli function above to return *false* instead. To do the first exercise, you may find the less than or equals (<=) comparison operator useful.

To be able to use greek letters and other symbols, type \\omega and press TAB. You can get all kinds of greek letters and mathematical symbols this way."

# ╔═╡ a666d797-ecf3-441f-9406-f616305f2d31
rand() <= 0.9

# ╔═╡ a736afcc-b477-45f9-ae5b-0fdd31b4f4f7
md"One major use of the *true* and *false* values is to conditionally execute code. For example,"

# ╔═╡ ca39bb7a-39e6-4756-810b-20813aede18f
if bernoulli(rand(), 0.8)
	println("80% of the time I'm happy! :)")
else
	println("But 20% of the time I'm sad :(")
end

# ╔═╡ 57ea1a43-33ec-46d9-a26c-9a52d5fb52f1
md"## Exercise 2: Uniform Distribution"

# ╔═╡ e09214e7-82b3-4119-8b97-ff92da6c9f3f
uniform(ω, a, b) = ω

# ╔═╡ e12a61f0-b0bc-4fad-8712-64668dad552b
# Not quite right yet
5 <= uniform(rand(), 5, 9) <= 9

# ╔═╡ f35904f0-a884-4979-a464-2ac04fcd5cf7
md"To generate a uniformly distributed variable, you may find the basic mathematical operations useful. Below are some examples. For more details, click on the docs link at the beginning of this section."

# ╔═╡ 4cf08f8c-b7ee-4700-b556-b61abe166b15
# This is a variable representing the number 2.3
foo = 2.3

# ╔═╡ 04a883ff-f076-47a3-9c7a-b645abb6e2c3
# It can be multiplied
foo * 3

# ╔═╡ b45f6141-c1ee-4ec0-949f-b4fbc7b512e3
# Or divided. Get π by typing \pi and then TAB
foo / π

# ╔═╡ 7d0b767d-61c4-4041-909e-1fb2a177ccf9
# Or added and subtracted
foo + 3 - 20 <= 0

# ╔═╡ 41d77d2a-b38b-46a7-97a1-a3e530df33fb
# and much more...
sqrt(sin(log(foo^3)))

# ╔═╡ 9e61d9c4-1308-46d5-b32d-7e8419a48f67
md"## Making a Histogram
Let's test whether your random variable is doing the right thing by sampling many times and plotting the distribution of the samples we get.

To make a list or vector of samples, you can use a list comprehension as below. I also provide some further examples so you can see how list comprehensions and Vectors work."

# ╔═╡ 08cb36a2-4b14-4003-b2f1-131f87e82db2
[i for i in 1:5]

# ╔═╡ 8d59dc93-cc98-4e58-aaf0-3112758c7cb5
# Note that these a:b objects are not Vectors, they are called ranges.
# However, they behave like a Vector and they can be converted to one with collect
# In fact, anything you can iterate over can be turned into a Vector with collect
5:8, collect(5:8)

# ╔═╡ bca187e3-04c6-4a30-81ba-c639f288db3e
1:10 isa Vector

# ╔═╡ ce084ee6-1b2f-40da-8a70-1005dd861f05
# we don't need the variable, so we use underscore _ to signal this fact
[2 for _ in 1:5]

# ╔═╡ fca887ee-28d2-4c21-9938-b892d87380eb
# cube each number from 0 to 0.5, going in steps of size 0.1
[x^3 for x in 0.0:0.1:0.5]

# ╔═╡ dca96c3e-e674-4124-a794-ad1ea5daecb8
md"vectors can be iterated over and indexed into as follows."

# ╔═╡ 9dd88140-fc85-4896-bd3a-90a79d4c86b3
squares = [n^2 for n in 1:10]

# ╔═╡ 0cc8e35a-412f-4675-b9db-1c79ed305821
for x in squares
	if isodd(x)
		println("forward")
	else
		println("backward")
	end
end

# ╔═╡ 5f8ce592-ab59-49f1-babb-ae7d759bebbf
# get the first entry
squares[1]

# ╔═╡ edb3721e-8fc2-4cf4-b925-bc2c729fc401
# get the last entry
squares[end]

# ╔═╡ db53f578-7050-4831-8c98-8e5e243eb606
# get the third to fifth entry
squares[3:5]

# ╔═╡ 681ddd77-9da9-4777-b0f5-64169fc47e3c
# set the 9th entry
squares[9] = -1

# ╔═╡ f4631d98-dad4-41c9-ac78-af0aee40a119
# and the 2nd to 3rd entries
squares[2:3] = [-2, -3]

# ╔═╡ 81fe6e9a-2af8-40b2-a364-a9512537aeeb
squares

# ╔═╡ 7d29e024-975f-4d61-8c5a-d3c9a6dfb0e2
md"Back to our samples... Let's make a histogram and plot it."

# ╔═╡ 93e93bcb-29cd-4b26-9047-0d7ff9c0ebb1
md"## Exercise 6: Exponential Distribution"

# ╔═╡ fd3754b0-f8cd-428d-9c97-f5d2583eb82f
# not quite right jet. This should be sampled exponentially
myrandexp(ω) = sqrt(ω)

# ╔═╡ b545f815-545e-44bf-be76-25ee69881bf8
samples = [myrandexp(rand()) for _ in 1:100_000]

# ╔═╡ c994b386-e183-471c-b161-5a4b5a3374ff
samples isa Vector

# ╔═╡ 3af8c14b-fa91-457a-87e3-d29866cc3e49
# Make a histogram
hist = fit(Histogram, samples)

# ╔═╡ 53073c14-bf67-4f84-9a56-7d179dc77301
plot(hist)

# ╔═╡ d216cf65-2de7-46c7-8b0c-f1e3a355ab5f
# compare to the built in randexp()
randexp()

# ╔═╡ 9ec38300-de96-4860-9893-1a8a00166004
md"## Exercise 9: Semicircle"

# ╔═╡ 831a9d8f-3eeb-4f1c-8c50-fb09413ee689
function semicircle(rng::AbstractRNG)
	x = rand(rng)
	y = rand(rng)
	# accept some, reject others

	return x
end

# ╔═╡ 4912e73b-d15c-4024-9bb2-e355d0de663d
let fig = Figure(), n = 500
	ax = Axis(fig[1, 1]; aspect=DataAspect(), xlabel="x", ylabel="y")

	pdf(x) = sqrt(1 - x^2)
	
	rxs = 2 .* rand(n) .- 1
	rys = rand(n)
	idx = rys .^2 .+ rxs .^2 .< 1
	notidx = map(!identity, idx)
	scatter!(ax, rxs[idx], rys[idx], color=:red, label="accepted")
	scatter!(ax, rxs[notidx], rys[notidx], color=:black, label="rejected")

	xs = -1:0.01:1
	ys = pdf.(xs)
	lines!(ax, xs, ys; label="pdf")

	axislegend(ax)
	
	fig
end

# ╔═╡ 0391e8fe-0a18-4782-a797-157d253417af
let n = 100_000  # estimating π
	p = 4 * count(_ -> rand()^2 + rand()^2 <= 1, 1:n) / n
	(π = p, error = abs(π - p) / π)
end

# ╔═╡ 01004f3b-fb1e-4da0-801e-786eb12a1e76
md"# Monte Carlo"

# ╔═╡ 4e88f8a9-fe2d-40b8-829d-b5d636127e83
function walk(
	jump,
	rng::AbstractRNG,
	x0s::AbstractVector{T},
	nt::Integer,
	p
) where T
	# initialise memory for trajectories
	xs = map(_ -> Vector{T}(undef, nt), x0s)

	for i in 1:length(x0s)  # for each trajectory
		x = x0s[i]  # init position
		xs[i][1] = x  # # save initial position
		
		for j in 2:nt  # for each time step: jump and save
			x = jump(rng, x, p)
			xs[i][j] = x
		end
	end

	return xs
end

# ╔═╡ f8acef37-ce4a-49f7-81df-745ba26b50a8
function walk(jump, x0s::AbstractVector{T}, nt::Integer, p) where T
	walk(jump, default_rng(), x0s, nt, p)
end

# ╔═╡ c75338b4-6bf0-4ef3-a07f-4736e3bcd4dd
opendiffuse(rng::AbstractRNG, x, p) = x + p.σ * randn(rng)

# ╔═╡ f0a0c065-600a-44e7-afec-9a43c1c02698
discrete(rng::AbstractRNG, x, p) = rand(rng, Bool) ? x + p.σ : x - p.σ

# ╔═╡ 9086bcd0-3fc4-4ba9-8f30-2f78b5ead628
function boxdiffuse(rng::AbstractRNG, x, p)
	y = x + p.σ * randn(rng)
	y = y < 0.0 ? -y : y
	while y > p.L
		y = p.L - (y - p.L)
		y = y < 0.0 ? -y : y
	end
	return y
end

# ╔═╡ 7b2c2c89-ff31-4f15-99b9-3a46eee4d19e
ohrnstein_uhlenbeck(rng, x, p) = x - p.a * x + p.σ * randn(rng)

# ╔═╡ 9286d291-cc9b-450a-aae5-7bf8fa32f185
periodic(rng, x, p) = x - p.a * sin(x) + p.σ * randn(rng)

# ╔═╡ a1a66164-d290-40f9-8f76-0fe3aef90564
pareto(rng, x, p) = x + p.σ * (rand(rng, Pareto(p.α)) - 1) * rand(rng, (-1, 1))

# ╔═╡ d7d7a506-993a-48a7-8215-d0c1a192dcf7
kelly(rng, x, p) = rand(rng) <= p.p ? x * (1.0 + p.f * p.b) : x * (1.0 - p.f)

# ╔═╡ a3bc1aa1-0795-4e7e-a55a-9e76366ce0f2
rw = walk(opendiffuse, 0.1 * randn(100), 100, (σ = 0.1,))

# ╔═╡ f1b1ecb1-4147-48c6-a9bc-b4949372094c
let fig = Figure()
	# add the following after fig[1, 1] to plot with y axis using log scale
	# ; yscale=log10
	ax = Axis(fig[1, 1])

	for i in 1:length(rw)
		lines!(ax, rw[i], color=(:black, 0.2))
	end

	fig
end

# ╔═╡ fa122c23-f3c8-4bdb-a6ed-585bb694da6f
let fig = Figure()
	ax = Axis(fig[1, 1])

	N = length(rw[1])
	μs = [mean([xs[i] for xs in rw]) for i in 1:N]

	lines!(ax, μs)

	fig
end

# ╔═╡ 6ee96f9d-4e8a-4c9a-aa44-c30f14496b97
getvars(rw) = [var([xs[i] for xs in rw]) for i in 1:length(rw[1])]

# ╔═╡ e20309dd-03d0-4003-b383-581fadaf74d0
let fig = Figure()
	ax = Axis(fig[1, 1])

	lines!(ax, getvars(rw))

	fig
end

# ╔═╡ 98179e10-52fa-44b7-9155-7300c27cd5a7
linmodel(x, p) = x .* p[1] .+ p[2]

# ╔═╡ 05873c45-3276-4df6-8cf0-3c97b55aa48d
function getslope(vars)
	fit = curve_fit(linmodel, 1:length(vars), vars, [1.0, 0.0])
	fit.param[1]
end

# ╔═╡ 6fe7dcc5-805a-4d09-8baa-949952762d4c
let fig = Figure()
	ax = Axis(fig[1, 1])

	σs = 0.1:0.1:1.0
	slopes = [getslope(getvars(
		walk(opendiffuse, 0.1 * randn(1_000), 10, (σ = σ,))
	)) for σ in σs]
	
	scatter!(ax, σs .^ 2, slopes)

	fig
end

# ╔═╡ f2f81a76-a2c8-40e8-8282-be7bf869370c
md"# Markov Chains"

# ╔═╡ b62f7c11-07b8-4dd9-b6c7-bc8a13ea7faf
T = [0.2 0.2; 0.8 0.8]

# ╔═╡ 8f001bf1-b456-4fbd-b025-8faee9754768
p0 = [0.5, 0.5]

# ╔═╡ 3e9244ab-1160-4381-820f-4ae01df68383
p = T^1000 * p0

# ╔═╡ 099de66c-9163-4fdc-9f94-52d83ce345cf
sum(p)

# ╔═╡ 854bdeba-0c10-4631-995e-81ca747d8c4f
E = eigen(T)

# ╔═╡ 557f84d7-7526-4978-942c-c2d0fe328dc8
pstat = E.vectors[:, 2]

# ╔═╡ 6ac10e92-8687-4a99-b64c-4979f96826aa
T * pstat ≈ pstat

# ╔═╡ 9ebe8846-ee64-44be-8726-fafcee2488b2
let fig = Figure(), p0 = [1, 0], T = T, nsteps = 10
	ax = Axis(fig[1, 1]; xlabel = "t", ylabel = "p")
	heat = zeros(nsteps, length(p0))
	heat[1, :] .= p0
	for i in 2:nsteps
		mul!(view(heat, i, :), T, view(heat, i-1, :))
	end

	xs = 1:nsteps
	ys = 1:length(p0)
	hmap = heatmap!(ax, xs, ys, heat)
	Colorbar(fig[1, 2], hmap; width = 15, ticksize = 15)

	fig
end

# ╔═╡ ca0fb426-6214-4818-9db7-d7a57b2f9b7e
md"# Poker"

# ╔═╡ f0e60438-584c-476f-a832-3e59bc42010e
struct Game
	die::Int
	b1::Float64
	b2::Float64
end

# ╔═╡ 5983efa0-5cf3-4fb5-abcd-5390a578e95d
game = Game(6, 2.5, 5.0)

# ╔═╡ 87d0ddbb-07d5-4f60-938a-0930478800e7
game.die

# ╔═╡ aa3a4673-f16e-4efc-910a-c94fa7e2939a
game.b1

# ╔═╡ 46d31d61-eb5a-47e5-8bb7-6c06bb31091a


# ╔═╡ 46d9aac7-18d2-4a04-8c15-dc83aa23b86f
function winner(dA, dB, df)

end

# ╔═╡ 49980be2-be66-49c9-a131-21d580dd2813
function play(
	rng::AbstractRNG,
	(; die, b1, b2)::Game,
	pr1::Vector{Float64},
	pc1::Vector{Float64},
	pr2::Vector{Float64},
	pc2::Vector{Float64},
	nrounds::Int
)
	if !(die == length(pr1) == length(pc1) == length(pr2) == length(pc2))
		throw(ArgumentError("die and probability lengths must match"))
	end

	if !all(p -> 0 <= p <= 1, pr1) || !all(p -> 0 <= p <= 1, pc1) ||
		!all(p -> 0 <= p <= 1, pr2) || !all(p -> 0 <= p <= 1, pc2)
		throw(ArgumentError("Probabilities must take values between 0 and 1"))
	end

	# player A's profit == - player B's profit
	pft = 0.0
	
	for _ in 1:nrounds
		dA = rand(rng, 1:die)
		if rand(rng) <= pr1[dA]  # A raises b1
			dB = rand(rng, 1:die)
			if rand(rng) <= pc1[dB]  # B calls b1
				if rand(rng) <= pr2[dB]  # B raises b2
					if rand(rng) <= pc2[dA]  # A calls b2
						pay = sign(dA - dB) * (b1 + b2 + 1.0)
					else  # A folds to b2 raise
						pay = -(1.0 + b1)
					end
				else  # B checks
					pay = sign(dA - dB) * (b1 + 1.0)
				end
			else  # B folds to b1 raise
				pay = 1.0
			end
		else # A folds initially
			pay = -0.5
		end

		pft += pay
	end

	return pft
end

# ╔═╡ d3378855-4ca5-4e82-9785-57ab9747ef8e
function eprofit((; die, b1, b2)::Game, pr1, pc1, pr2, pc2)
	if !(die == length(pr1) == length(pc1) == length(pr2) == length(pc2))
		throw(ArgumentError("die and probability lengths must match"))
	end

	pft = 0.0
	for dA in 1:die
		for dB in 1:die
			s = sign(dA - dB)  # =1 if A wins, -1 if B wins and 0 if tie
			pft -= 0.5 * (1-pr1[dA])  # A folds initially
			pft += 1.0 * pr1[dA] * (1-pc1[dB])  # B folds to b1 raise

			# probability of getting to second betting round
			ps2 = pr1[dA] * pc1[dB]

			# B checks
			pft += s * (b1 + 1.0) * ps2 * (1-pr2[dB])
			# A folds to b2 raise
			pft -= (1.0 + b1) * ps2 * pr2[dB] * (1-pc2[dA])
			# A calls b2 raise
			pft += s * (b1 + b2 + 1.0) * ps2 * pr2[dB] * pc2[dA]
		end
	end

	return pft / die^2
end

# ╔═╡ c4bbf394-0811-4966-8488-7d3864d266f8
# grad points in direction of improving prfoit for A and B respectively,
# so both players want to change their strategies in the direction of grad
function gradprofit!(
	∇pr1, ∇pc1, ∇pr2, ∇pc2,
	(; die, b1, b2)::Game,
	pr1, pc1, pr2, pc2
)
	if !(die == length(pr1) == length(pc1) == length(pr2) == length(pc2)) ||
		!(die == length(∇pr1) == length(∇pc1) == length(∇pr2) == length(∇pc2))
		throw(ArgumentError("die, grad and probability lengths must match"))
	end

	fill!(∇pr1, 0.0)
	fill!(∇pc1, 0.0)
	fill!(∇pr2, 0.0)
	fill!(∇pc2, 0.0)

	for dA in 1:die
		for dB in 1:die
			s = sign(dA - dB)  # =1 if A wins, -1 if B wins and 0 if tie

			# pft -= 0.5 * (1-pr1[dA])  # A folds initially
			∇pr1[dA] += 0.5
			
			# pft += 1.0 * pr1[dA] * (1-pc1[dB])  # B folds to b1 raise
			∇pr1[dA] += 1.0 * (1-pc1[dB])
			∇pc1[dB] += 1.0 * pr1[dA]

			# B checks
			# pft += s * (b1 + 1.0) * pr1[dA] * pc1[dB] * (1-pr2[dB])
			∇pr1[dA] += s * (b1 + 1.0) * pc1[dB] * (1-pr2[dB])
			∇pc1[dB] -= s * (b1 + 1.0) * pr1[dA] * (1-pr2[dB])
			∇pr2[dB] += s * (b1 + 1.0) * pr1[dA] * pc1[dB]
			
			# A folds to b2 raise
			# pft -= (1.0 + b1) * pr1[dA] * pc1[dB] * pr2[dB] * (1-pc2[dA])
			∇pr1[dA] -= (1.0 + b1) * pc1[dB] * pr2[dB] * (1-pc2[dA])
			∇pc1[dB] += (1.0 + b1) * pr1[dA] * pr2[dB] * (1-pc2[dA])
			∇pr2[dB] += (1.0 + b1) * pr1[dA] * pc1[dB] * (1-pc2[dA])
			∇pc2[dA] += (1.0 + b1) * pr1[dA] * pc1[dB] * pr2[dB]
			
			# A calls b2 raise
			# pft += s * (b1 + b2 + 1.0) * pr1[dA] * pc1[dB] * pr2[dB] * pc2[dA]
			∇pr1[dA] += s * (b1 + b2 + 1.0) * pc1[dB] * pr2[dB] * pc2[dA]
			∇pc1[dB] -= s * (b1 + b2 + 1.0) * pr1[dA] * pr2[dB] * pc2[dA]
			∇pr2[dB] -= s * (b1 + b2 + 1.0) * pr1[dA] * pc1[dB] * pc2[dA]
			∇pc2[dA] += s * (b1 + b2 + 1.0) * pr1[dA] * pc1[dB] * pr2[dB]
		end
	end

	return inv(die^2) .* (∇pr1, ∇pc1, ∇pr2, ∇pc2)
end

# ╔═╡ 565575d7-4bf7-41a4-89d4-5d9a9e331f06
function gradprofit(game::Game, pr1, pc1, pr2, pc2)
	∇pr1 = Vector{Float64}(undef, game.die)
	∇pc1 = Vector{Float64}(undef, game.die)
	∇pr2 = Vector{Float64}(undef, game.die)
	∇pc2 = Vector{Float64}(undef, game.die)
	gradprofit!(∇pr1, ∇pc1, ∇pr2, ∇pc2, game, pr1, pc1, pr2, pc2)
end

# ╔═╡ 47f410d9-9fac-437c-a273-72c52ca36236
function gradascent!(praise, pcall, N, bet, niter, rate)
	rgrad = Vector{Float64}(undef, N)
	cgrad = Vector{Float64}(undef, N)
	for _ in niter
		rgrad, ∇cgrad = gradprofit!(rgrad, cgrad, N, bet, praise, pcall)
		praise .= clamp.(praise .+ rate .* rgrad, 0.0, 1.0)
		pcall .= clamp.(pcall .+ rate .* cgrad, 0.0, 1.0)
	end
	praise, pcall
end

# ╔═╡ c5258501-01e5-4f7f-a408-ed54c7d4ce6a
begin
	mypr1 = [0.0, 0.0, 0.0, 0.5, 1.0, 1.0]
	mypc1 = [0.0, 0.0, 0.0, 0.0, 1.0, 1.0]
	mypr2 = [0.0, 0.0, 0.0, 1.0, 0.0, 1.0]
	mypc2 = [0.0, 0.0, 0.0, 0.0, 1.0, 1.0]
end

# ╔═╡ ddedae38-867a-4771-96c6-4d6953805955
let nrounds = 10_000_000
	play(default_rng(), game, mypr1, mypc1, mypr2, mypc2, nrounds) / nrounds
end

# ╔═╡ f1330b02-b271-43fe-8c66-01773c3d4818
@profview play(default_rng(), game, mypr1, mypc1, mypr2, mypc2, 10_000_000)

# ╔═╡ f296db36-7ae6-4f70-a8de-c959daf32254
eprofit(game, mypr1, mypc1, mypr2, mypc2)

# ╔═╡ 315a94c7-2ba5-4ccd-bd24-bab1cfd12bc8
gradprofit(game, mypr1, mypc1, mypr2, mypc2)

# ╔═╡ ec17738d-2f28-42a1-b3f9-b231edb394c4
function optimise!(praise, pcall, N, bet, niter)
	rgrad = Vector{Float64}(undef, N)
	cgrad = Vector{Float64}(undef, N)
	for _ in niter
		∇rpft, ∇cpft = gradprofit(N, bet, praise, pcall)
		for i in 1:N
			∂pr = ∇rpft[i]
			if ∂pr > 0.0
				praise[i] = 1.0
			elseif ∂pr < 0.0
				praise[i] = 0.0
			else
				praise[i] = rand()
			end
			∂pc = ∇cpft[i]
			if ∂pc > 0.0
				pcall[i] = 1.0
			elseif ∂pc < 0.0
				pcall[i] = 0.0
			else
				# since grad is zero, any probability is equally good
				pcall[i] = rand()
			end
		end
	end
	praise, pcall
end

# ╔═╡ 4fe533dc-3ccc-4a0c-b868-ac1b2bb014f9
optimise!(rand(2), rand(2), 2, 2.0, 20)

# ╔═╡ ce97e2ed-3d99-424b-92bd-99224bec7a5b
clamp(-2.0, 0.0, 1.5)

# ╔═╡ 824836d2-9d47-4ce4-ae96-8d3933381bce
gradascent!(rand(2), rand(2), 2, 2.0, 100_000, 10.0)

# ╔═╡ c4d79a40-7173-4fc7-8ea7-d1b95f88bbfd
fuzz(ps::Vector, fz) = ps .* (1 .- fz) .+ (1 .- ps) .* fz

# ╔═╡ bfcb7dd2-3d08-4eac-bd3c-40b4fbd71b82
fuzz(fill(0.4, 10), 0.2)

# ╔═╡ 83862c32-40e1-4bd3-89d6-8882d7b7ea1a
let N = 10, bet = 10.0, nrounds = 1_000_000
	g = Game(N, bet)
	pro, pco = optimise!(rand(N), rand(N), N, bet, 100)
	prg, pcg = gradascent!(rand(N), rand(N), N, bet, 10_000, 100.0)
	∇rpft, ∇cpft = gradprofit(N, bet, prg, pcg)
	praise = prg
	pcall = pco
	gpft = play(g, praise, pcall, nrounds) ./ nrounds
	epft = eprofit(N, bet, praise, pcall)
	(
		(praise, pcall),
		(pro, pco),
		(prg, pcg),
		(∇rpft, ∇cpft),
		gpft, epft 
	)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CairoMakie = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
LsqFit = "2fda8390-95c7-5789-9bda-21331edee243"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
CairoMakie = "~0.9.2"
Distributions = "~0.25.76"
LsqFit = "~0.13.0"
PlutoUI = "~0.7.48"
StatsBase = "~0.33.21"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "9edc8ebdaf323159a2dd679a78c4ed43778fb7d5"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "69f7020bd72f069c219b5e8c236c1fa90d2cb409"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.2.1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.Animations]]
deps = ["Colors"]
git-tree-sha1 = "e81c509d2c8e49592413bfb0bb3b08150056c79d"
uuid = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
version = "0.4.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArrayInterfaceCore]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "c46fb7dd1d8ca1d213ba25848a5ec4e47a1a1b08"
uuid = "30b0a656-2188-435a-8636-2ec0e6a096e2"
version = "0.1.26"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Automa]]
deps = ["Printf", "ScanByte", "TranscodingStreams"]
git-tree-sha1 = "d50976f217489ce799e366d9561d56a98a30d7fe"
uuid = "67c07d97-cdcb-5c2c-af73-a7f9c32a568b"
version = "0.8.2"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "d0b3f8b4ad16cb0a2988c6788646a5e6a17b6b1b"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.0.5"

[[deps.CairoMakie]]
deps = ["Base64", "Cairo", "Colors", "FFTW", "FileIO", "FreeType", "GeometryBasics", "LinearAlgebra", "Makie", "SHA", "SnoopPrecompile"]
git-tree-sha1 = "d5fcc28d94729c8828c7651e81d6b119fe9e87f5"
uuid = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
version = "0.9.2"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e7ff6cadf743c098e08fca25c91103ee4303c9bb"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.6"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.ColorBrewer]]
deps = ["Colors", "JSON", "Test"]
git-tree-sha1 = "61c5334f33d91e570e1d0c3eb5465835242582c4"
uuid = "a2cac450-b92f-5266-8821-25eda20663c8"
version = "0.4.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "1fd869cc3875b57347f7027521f561cf46d1fcd8"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.19.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "d08c20eef1f2cbc6e60fd3612ac4340b89fea322"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.9"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "3ca828fe1b75fa84b021a7860bd039eaea84d2f2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.3.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "fb21ddd70a051d882a1686a5a550990bbe371a95"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.4.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "46d2680e618f8abd007bce0c3026cb0c4a8f2032"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.12.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "8b7a4d23e22f5d44883671da70865ca98f2ebf9d"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.12.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "04db820ebcfc1e053bd8cbb8d8bccf0ff3ead3f7"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.76"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "c36550cb29cbe373e95b3f40486b9a4148f89ffd"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.2"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.Extents]]
git-tree-sha1 = "5e1e4c53fa39afe63a7d356e30452249365fba99"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "90630efff0894f8142308e334473eba54c433549"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.5.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "7be5f99f7d15578798f338f5433b6c432ea8037b"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "802bfc139833d2ba893dd9e62ba1767c88d708ae"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.5"

[[deps.FiniteDiff]]
deps = ["ArrayInterfaceCore", "LinearAlgebra", "Requires", "Setfield", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "bb61d9e5085784fe453f70c97b23964c5bf36942"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.16.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "187198a4ed8ccd7b5d99c41b69c679269ea2b2d4"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.32"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "cabd77ab6a6fdff49bfd24af2ebe76e6e018a2b4"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.0.0"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "38a92e40157100e796690421e34a11c107205c86"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.10.0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "fb28b5dc239d0174d7297310ef7b84a11804dfab"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.0.1"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "12a584db96f1d460421d5fb8860822971cdb8455"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.4"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "fb83fbe02fe57f2c068013aa94bcdf6760d3a7a7"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+1"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.GridLayoutBase]]
deps = ["GeometryBasics", "InteractiveUtils", "Observables"]
git-tree-sha1 = "678d136003ed5bceaab05cf64519e3f956ffa4ba"
uuid = "3955a311-db13-416c-9275-1d80ed98e5e9"
version = "0.9.1"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "342f789fd041a55166764c351da1710db97ce0e0"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.6"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "87f7662e03a649cffa2e05bf19c303e168732d3e"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "842dd89a6cb75e02e85fdd75c760cdc43f5d6863"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.6"

[[deps.IntervalSets]]
deps = ["Dates", "Random", "Statistics"]
git-tree-sha1 = "3f91cd3f56ea48d4d2a75c2a65455c5fc74fa347"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.3"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.Isoband]]
deps = ["isoband_jll"]
git-tree-sha1 = "f9b6d97355599074dc867318950adaa6f9946137"
uuid = "f1662d9f-8043-43de-a69a-05efc1cc6ff4"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "a77b273f1ddec645d1b7c4fd5fb98c8f90ad10a5"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "9816b296736292a80b9a3200eb7fbb57aaa3917a"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.5"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "94d9c52ca447e23eac0c0f074effbcd38830deb5"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.18"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LsqFit]]
deps = ["Distributions", "ForwardDiff", "LinearAlgebra", "NLSolversBase", "OptimBase", "Random", "StatsBase"]
git-tree-sha1 = "00f475f85c50584b12268675072663dfed5594b2"
uuid = "2fda8390-95c7-5789-9bda-21331edee243"
version = "0.13.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "2ce8695e1e699b68702c03402672a69f54b8aca9"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Makie]]
deps = ["Animations", "Base64", "ColorBrewer", "ColorSchemes", "ColorTypes", "Colors", "Contour", "Distributions", "DocStringExtensions", "FFMPEG", "FileIO", "FixedPointNumbers", "Formatting", "FreeType", "FreeTypeAbstraction", "GeometryBasics", "GridLayoutBase", "ImageIO", "InteractiveUtils", "IntervalSets", "Isoband", "KernelDensity", "LaTeXStrings", "LinearAlgebra", "MakieCore", "Markdown", "Match", "MathTeXEngine", "MiniQhull", "Observables", "OffsetArrays", "Packing", "PlotUtils", "PolygonOps", "Printf", "Random", "RelocatableFolders", "Serialization", "Showoff", "SignedDistanceFields", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "StatsFuns", "StructArrays", "TriplotBase", "UnicodeFun"]
git-tree-sha1 = "0462fdf13cfad9fa6f23a2fb41da38e7a2aa4908"
uuid = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
version = "0.18.2"

[[deps.MakieCore]]
deps = ["Observables"]
git-tree-sha1 = "c1885d865632e7f37e5a1489a164f44c54fb80c9"
uuid = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
version = "0.5.2"

[[deps.MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Match]]
git-tree-sha1 = "1d9bc5c1a6e7ee24effb93f175c9342f9154d97f"
uuid = "7eb4fadd-790c-5f42-8a69-bfa0b872bfbf"
version = "1.2.0"

[[deps.MathTeXEngine]]
deps = ["AbstractTrees", "Automa", "DataStructures", "FreeTypeAbstraction", "GeometryBasics", "LaTeXStrings", "REPL", "RelocatableFolders", "Test", "UnicodeFun"]
git-tree-sha1 = "7f837e1884f1ef84984c919fc7a00638cff1e6d1"
uuid = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
version = "0.5.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.MiniQhull]]
deps = ["QhullMiniWrapper_jll"]
git-tree-sha1 = "9dc837d180ee49eeb7c8b77bb1c860452634b0d1"
uuid = "978d7f02-9e05-4691-894f-ae31a51d76ca"
version = "0.4.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "b34e3bc3ca7c94914418637cb10cc4d1d80d877d"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.3"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "50310f934e55e5ca3912fb941dec199b49ca9b68"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.2"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore"]
git-tree-sha1 = "18efc06f6ec36a8b801b23f076e3c6ac7c3bf153"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Observables]]
git-tree-sha1 = "c2dffec4623a66b9c850e67026839137a5f63a3d"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.3"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "f71d8950b724e9ff6110fc948dff5a329f901d64"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.8"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "923319661e9a22712f24596ce81c54fc0366f304"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.1+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6e9dba33f9f2c44e08a020b0caf6903be540004"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.19+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OptimBase]]
deps = ["NLSolversBase", "Printf", "Reexport"]
git-tree-sha1 = "9cb1fee807b599b5f803809e85c81b582d2009d6"
uuid = "87e2bd06-a317-5318-96d9-3ecbac512eee"
version = "2.0.2"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "cf494dca75a69712a72b80bc48f59dcf3dea63ec"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.16"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "f809158b27eba0c18c269cf2a2be6ed751d3e81d"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.17"

[[deps.Packing]]
deps = ["GeometryBasics"]
git-tree-sha1 = "1155f6f937fa2b94104162f01fa400e192e4272f"
uuid = "19eb6ba3-879d-56ad-ad62-d5c202156566"
version = "0.4.2"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "03a7a85b76381a3d04c7a1656039197e70eda03d"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.11"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "84a314e3926ba9ec66ac097e3635e270986b0f10"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.50.9+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "cceb0257b662528ecdf0b4b4302eb00e767b38e7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "21303256d239f6b484977314674aef4bb1fe4420"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "efc140104e6d0ae3e7e30d56c98c4a927154d684"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.48"

[[deps.PolygonOps]]
git-tree-sha1 = "77b3d3605fc1cd0b42d95eba87dfcd2bf67d5ff6"
uuid = "647866c9-e3ac-4575-94e7-e3d426903924"
version = "0.1.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.QhullMiniWrapper_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Qhull_jll"]
git-tree-sha1 = "607cf73c03f8a9f83b36db0b86a3a9c14179621f"
uuid = "460c41e3-6112-5d7f-b78c-b6823adb3f2d"
version = "1.0.0+1"

[[deps.Qhull_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "695c3049ad94fa38b7f1e8243cdcee27ecad0867"
uuid = "784f63db-0788-585a-bace-daefebcd302b"
version = "8.0.1000+0"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "97aa253e65b784fd13e83774cadc95b38011d734"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.6.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
git-tree-sha1 = "7dbc15af7ed5f751a82bf3ed37757adf76c32402"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.4.1"

[[deps.ScanByte]]
deps = ["Libdl", "SIMD"]
git-tree-sha1 = "2436b15f376005e8790e318329560dcc67188e84"
uuid = "7b38b023-a4d7-4c5e-8d43-3f3097f304eb"
version = "0.3.3"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SignedDistanceFields]]
deps = ["Random", "Statistics", "Test"]
git-tree-sha1 = "d263a08ec505853a5ff1c1ebde2070419e3f28e9"
uuid = "73760f76-fbc4-59ce-8f25-708e95d2df96"
version = "0.4.0"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "f86b3a049e5d05227b10e15dbb315c5b90f14988"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.9"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "5783b877201a82fc0014cbf381e7e6eb130473a4"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.0.1"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArraysCore", "Tables"]
git-tree-sha1 = "13237798b407150a6d2e2bce5d793d7d9576e99e"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.13"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "c79322d36826aa2f4fd8ecfa96ddb47b174ac78d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "70e6d2da9210371c927176cb7a56d41ef1260db7"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.1"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "8a75929dcd3c38611db2f8d08546decb514fcadf"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.9"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.TriplotBase]]
git-tree-sha1 = "4d4ed7f294cda19382ff7de4c137d24d16adc89b"
uuid = "981d1d27-644d-49a2-9326-4793e63143c3"
version = "0.1.0"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "58443b63fb7e465a8a7210828c91c08b92132dff"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.14+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.isoband_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51b5eeb3f98367157a7a12a1fb0aa5328946c03c"
uuid = "9a68df92-36a6-505f-a73e-abb412b6bfb4"
version = "0.2.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"
"""

# ╔═╡ Cell order:
# ╠═26c3d3fe-af66-4d79-8aaa-5f5b0784bab0
# ╠═0bee0d4b-272d-406f-b9fd-b947b901278b
# ╠═9b0a5eee-a0d0-4b5e-83cf-7badb1753688
# ╠═30c0a8df-2340-4f66-a415-9375d0a6c893
# ╠═c708e88a-4771-4144-8765-a78aa730e7f9
# ╠═6259db20-c705-4e7c-ba8f-18cc8b733f8b
# ╠═aa7a9420-f7e1-4a44-9375-882c79f97e1a
# ╟─7c145e9e-5d12-11ed-3c4b-796dde8540c7
# ╠═9128a75c-bcc4-4131-bdd0-73a6a8490165
# ╟─f89e1123-2dd8-4c40-b501-909829e8c714
# ╠═985916d7-8105-48d7-a3c9-9447afa50416
# ╠═f3e091d6-5359-40b2-817e-db2848d70f90
# ╠═f1ff8af1-6954-4771-9981-db2e295360a3
# ╟─6382e7e4-2508-4bf6-9b09-41692268089b
# ╠═bed0c3f8-0017-4fdd-b520-e4a265677140
# ╠═0642ade6-1869-4848-bc85-f60a85ec15ff
# ╠═154cd13b-391d-46c2-83d6-241ca23a154e
# ╠═08548873-ffd7-4f0c-83cd-8ba4c8d536c6
# ╟─bbfdd8d8-f27f-4830-b468-df189c778de8
# ╠═a666d797-ecf3-441f-9406-f616305f2d31
# ╟─a736afcc-b477-45f9-ae5b-0fdd31b4f4f7
# ╠═ca39bb7a-39e6-4756-810b-20813aede18f
# ╟─57ea1a43-33ec-46d9-a26c-9a52d5fb52f1
# ╠═e09214e7-82b3-4119-8b97-ff92da6c9f3f
# ╠═e12a61f0-b0bc-4fad-8712-64668dad552b
# ╟─f35904f0-a884-4979-a464-2ac04fcd5cf7
# ╠═4cf08f8c-b7ee-4700-b556-b61abe166b15
# ╠═04a883ff-f076-47a3-9c7a-b645abb6e2c3
# ╠═b45f6141-c1ee-4ec0-949f-b4fbc7b512e3
# ╠═7d0b767d-61c4-4041-909e-1fb2a177ccf9
# ╠═41d77d2a-b38b-46a7-97a1-a3e530df33fb
# ╟─9e61d9c4-1308-46d5-b32d-7e8419a48f67
# ╠═b545f815-545e-44bf-be76-25ee69881bf8
# ╠═c994b386-e183-471c-b161-5a4b5a3374ff
# ╠═08cb36a2-4b14-4003-b2f1-131f87e82db2
# ╠═8d59dc93-cc98-4e58-aaf0-3112758c7cb5
# ╠═bca187e3-04c6-4a30-81ba-c639f288db3e
# ╠═ce084ee6-1b2f-40da-8a70-1005dd861f05
# ╠═fca887ee-28d2-4c21-9938-b892d87380eb
# ╟─dca96c3e-e674-4124-a794-ad1ea5daecb8
# ╠═9dd88140-fc85-4896-bd3a-90a79d4c86b3
# ╠═0cc8e35a-412f-4675-b9db-1c79ed305821
# ╠═5f8ce592-ab59-49f1-babb-ae7d759bebbf
# ╠═edb3721e-8fc2-4cf4-b925-bc2c729fc401
# ╠═db53f578-7050-4831-8c98-8e5e243eb606
# ╠═681ddd77-9da9-4777-b0f5-64169fc47e3c
# ╠═f4631d98-dad4-41c9-ac78-af0aee40a119
# ╠═81fe6e9a-2af8-40b2-a364-a9512537aeeb
# ╟─7d29e024-975f-4d61-8c5a-d3c9a6dfb0e2
# ╠═3af8c14b-fa91-457a-87e3-d29866cc3e49
# ╠═53073c14-bf67-4f84-9a56-7d179dc77301
# ╟─93e93bcb-29cd-4b26-9047-0d7ff9c0ebb1
# ╠═fd3754b0-f8cd-428d-9c97-f5d2583eb82f
# ╠═d216cf65-2de7-46c7-8b0c-f1e3a355ab5f
# ╟─9ec38300-de96-4860-9893-1a8a00166004
# ╠═831a9d8f-3eeb-4f1c-8c50-fb09413ee689
# ╠═4912e73b-d15c-4024-9bb2-e355d0de663d
# ╠═0391e8fe-0a18-4782-a797-157d253417af
# ╟─01004f3b-fb1e-4da0-801e-786eb12a1e76
# ╠═4e88f8a9-fe2d-40b8-829d-b5d636127e83
# ╠═f8acef37-ce4a-49f7-81df-745ba26b50a8
# ╠═c75338b4-6bf0-4ef3-a07f-4736e3bcd4dd
# ╠═f0a0c065-600a-44e7-afec-9a43c1c02698
# ╠═9086bcd0-3fc4-4ba9-8f30-2f78b5ead628
# ╠═7b2c2c89-ff31-4f15-99b9-3a46eee4d19e
# ╠═9286d291-cc9b-450a-aae5-7bf8fa32f185
# ╠═a1a66164-d290-40f9-8f76-0fe3aef90564
# ╠═d7d7a506-993a-48a7-8215-d0c1a192dcf7
# ╠═a3bc1aa1-0795-4e7e-a55a-9e76366ce0f2
# ╠═f1b1ecb1-4147-48c6-a9bc-b4949372094c
# ╠═fa122c23-f3c8-4bdb-a6ed-585bb694da6f
# ╠═6ee96f9d-4e8a-4c9a-aa44-c30f14496b97
# ╠═e20309dd-03d0-4003-b383-581fadaf74d0
# ╠═98179e10-52fa-44b7-9155-7300c27cd5a7
# ╠═05873c45-3276-4df6-8cf0-3c97b55aa48d
# ╠═6fe7dcc5-805a-4d09-8baa-949952762d4c
# ╠═f2f81a76-a2c8-40e8-8282-be7bf869370c
# ╠═b62f7c11-07b8-4dd9-b6c7-bc8a13ea7faf
# ╠═8f001bf1-b456-4fbd-b025-8faee9754768
# ╠═3e9244ab-1160-4381-820f-4ae01df68383
# ╠═099de66c-9163-4fdc-9f94-52d83ce345cf
# ╠═854bdeba-0c10-4631-995e-81ca747d8c4f
# ╠═557f84d7-7526-4978-942c-c2d0fe328dc8
# ╠═6ac10e92-8687-4a99-b64c-4979f96826aa
# ╠═9ebe8846-ee64-44be-8726-fafcee2488b2
# ╠═ca0fb426-6214-4818-9db7-d7a57b2f9b7e
# ╠═f0e60438-584c-476f-a832-3e59bc42010e
# ╠═5983efa0-5cf3-4fb5-abcd-5390a578e95d
# ╠═87d0ddbb-07d5-4f60-938a-0930478800e7
# ╠═aa3a4673-f16e-4efc-910a-c94fa7e2939a
# ╠═46d31d61-eb5a-47e5-8bb7-6c06bb31091a
# ╠═46d9aac7-18d2-4a04-8c15-dc83aa23b86f
# ╠═49980be2-be66-49c9-a131-21d580dd2813
# ╠═d3378855-4ca5-4e82-9785-57ab9747ef8e
# ╠═c4bbf394-0811-4966-8488-7d3864d266f8
# ╠═565575d7-4bf7-41a4-89d4-5d9a9e331f06
# ╠═47f410d9-9fac-437c-a273-72c52ca36236
# ╠═c5258501-01e5-4f7f-a408-ed54c7d4ce6a
# ╠═ddedae38-867a-4771-96c6-4d6953805955
# ╠═f1330b02-b271-43fe-8c66-01773c3d4818
# ╠═f296db36-7ae6-4f70-a8de-c959daf32254
# ╠═315a94c7-2ba5-4ccd-bd24-bab1cfd12bc8
# ╠═ec17738d-2f28-42a1-b3f9-b231edb394c4
# ╠═4fe533dc-3ccc-4a0c-b868-ac1b2bb014f9
# ╠═ce97e2ed-3d99-424b-92bd-99224bec7a5b
# ╠═824836d2-9d47-4ce4-ae96-8d3933381bce
# ╠═c4d79a40-7173-4fc7-8ea7-d1b95f88bbfd
# ╠═bfcb7dd2-3d08-4eac-bd3c-40b4fbd71b82
# ╠═83862c32-40e1-4bd3-89d6-8882d7b7ea1a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
