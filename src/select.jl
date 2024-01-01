### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ ea558abf-ed50-41fa-a707-eff760eb1403
using HypertextLiteral

# ╔═╡ 6da60798-5a36-47b0-a65b-326ecfa602e6
import AbstractPlutoDingetjes.Bonds

# ╔═╡ a38118b1-b32c-4b41-a4f5-d34bdc7171fd
begin
	struct Select
		options::AbstractVector{Pair}
		default::Union{Missing, Any}
		size::Union{Nothing, Int}
	end
	
	Select(options::AbstractVector; default=missing, size=nothing) = Select([o => o for o in options], default, size)
	
	Select(options::AbstractVector{<:Pair}; default=missing, size=nothing) = Select(options, default, size)
end

# ╔═╡ 5415b0df-3dbb-4286-ab23-27f996fb73f4
Base.show(io::IO, m::MIME"text/html", select::Select) =
	show(io, m, @htl(
		"""<select size=$(select.size)>$(
	map(enumerate(select.options)) do (i,o)
			@htl(
			"<option value=$(i) selected=$(!ismissing(select.default) && o.first == select.default)>$(
			string(o.second)
			)</option>")
		end
	)</select>"""))

# ╔═╡ 3e4377f7-5dbd-4414-8b1a-2c942c75a513
Base.get(select::Select) = ismissing(select.default) ? first(select.options).first : select.default

# ╔═╡ 1e559b6e-676c-4651-bd55-c9b6373d70aa
Bonds.initial_value(select::Select) = ismissing(select.default) ? first(select.options).first : select.default

# ╔═╡ 0892cbf3-0c9b-46c5-8fd5-ae688aeec052
Bonds.possible_values(select::Select) = (string(i) for i in 1:length(select.options))

# ╔═╡ c2fc65aa-65c1-4eef-b1ae-08df3fd2dddd
function Bonds.transform_value(select::Select, val_from_js)
	# val_from_js will be a String, but let's allow Integers as well, there's no harm in that
	val_num = val_from_js isa Integer ? val_from_js : tryparse(Int64, val_from_js)
	select.options[val_num].first
end

# ╔═╡ b13937e9-0aa8-4ac9-abf4-bfabb8f4113f
function Bonds.validate_value(select::Select, val_from_js)
	# val_from_js will be a String, but let's allow Integers as well, there's no harm in that
	val_num = val_from_js isa Integer ? val_from_js : tryparse(Int64, val_from_js)
	val_num isa Integer && 1 <= val_num <= length(select.options)
end

# ╔═╡ 7d44d23f-3b20-4b1e-911d-224087737231
# ╠═╡ skip_as_script = true
#=╠═╡
Select(1:10)
  ╠═╡ =#

# ╔═╡ 03ab8fc8-4523-4579-ab9b-a9bd2835dac2
# ╠═╡ skip_as_script = true
#=╠═╡
Select(1:10, size=1)
  ╠═╡ =#

# ╔═╡ ac3eec10-95fa-40e7-8f1e-bfeb0fba41b2
# ╠═╡ skip_as_script = true
#=╠═╡
Select(1:10, size=4)
  ╠═╡ =#

# ╔═╡ 23f18ff7-35d9-4d1d-a90f-08680167118b
# ╠═╡ skip_as_script = true
#=╠═╡
Select(1:10, size=10)
  ╠═╡ =#

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractPlutoDingetjes = "6e696c72-6542-2067-7265-42206c756150"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"

[compat]
AbstractPlutoDingetjes = "~1.1.4"
HypertextLiteral = "~0.9.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.1"
manifest_format = "2.0"
project_hash = "36e47fc97174e73ec9de2276756d96eadb78d814"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═6da60798-5a36-47b0-a65b-326ecfa602e6
# ╠═ea558abf-ed50-41fa-a707-eff760eb1403
# ╠═a38118b1-b32c-4b41-a4f5-d34bdc7171fd
# ╠═5415b0df-3dbb-4286-ab23-27f996fb73f4
# ╠═3e4377f7-5dbd-4414-8b1a-2c942c75a513
# ╠═1e559b6e-676c-4651-bd55-c9b6373d70aa
# ╠═0892cbf3-0c9b-46c5-8fd5-ae688aeec052
# ╠═c2fc65aa-65c1-4eef-b1ae-08df3fd2dddd
# ╠═b13937e9-0aa8-4ac9-abf4-bfabb8f4113f
# ╠═7d44d23f-3b20-4b1e-911d-224087737231
# ╠═03ab8fc8-4523-4579-ab9b-a9bd2835dac2
# ╠═ac3eec10-95fa-40e7-8f1e-bfeb0fba41b2
# ╠═23f18ff7-35d9-4d1d-a90f-08680167118b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
