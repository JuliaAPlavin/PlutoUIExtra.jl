### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ a683c9b4-4285-49b5-bcc9-7fc572f03e91
using HypertextLiteral

# ╔═╡ ecb07281-3405-4fbd-8ace-bb53785490e6
import AbstractPlutoDingetjes.Bonds

# ╔═╡ 55fa7b18-54ad-4910-ac5f-4e91a264333f
import PlutoUI

# ╔═╡ 5400e620-0479-11ee-3e40-e986b7b30ab0
begin
	struct Slider{T <: Any}
		values::AbstractVector{T}
		default::T
		show_value::Bool
		on_release::Bool
		style
	end
	
	function Slider(values::AbstractVector{T}; default=missing, show_value=false, on_release=false, max_steps=1_000, style=(;)) where T
		new_values = PlutoUI.BuiltinsNotebook.downsample(values, max_steps)
		Slider(new_values, (default === missing) ? first(new_values) : let
			d = default
			d ∈ new_values ? convert(T, d) : PlutoUI.BuiltinsNotebook.closest(new_values, d)
		end, show_value, on_release, style)
	end
end

# ╔═╡ 47a3798b-2dc3-4cbc-8c34-3a5cc2cf4d50
Slider(30:.5:40; style=(var"-webkit-appearance"="slider-vertical", width="1em"), show_value=true)

# ╔═╡ 599e7851-21db-4430-b9ae-d3b3f06ccdff
function Base.show(io::IO, m::MIME"text/html", slider::Slider)
	start_index = findfirst(isequal(slider.default), slider.values)
	
	# comment from @fonsp:
	# It looks like this could be implemented in a slightly more robust way by listening to the "change" event instead of "input" on the <input type=range> element. That means that you don't need the mouseup handlers, but you still need a wrapper element, custom value property etc.
	show(io, m, @htl(
		"""
		$(
				slider.on_release ? @htl(
				"""<span></span>
				<script>
				const input_el = currentScript.nextElementSibling;
				const event_el = currentScript.previousElementSibling;

				const propagateevt = () => {
					const new_value = input_el.valueAsNumber;
					if (new_value == event_el.value) {
						return;
					}
					event_el.value = new_value;
					event_el.dispatchEvent(new CustomEvent("input"));
				}
				input_el.addEventListener("mouseup", propagateevt);
				input_el.addEventListener("touchend", propagateevt);
				input_el.addEventListener("input", e => e.stopPropagation());
				event_el.value = $start_index;
				</script>
				"""
			) : nothing
		)
		<input $((
			type="range",
			min=1,
			max=length(slider.values),
			value=start_index,
			style=slider.style,
		))>
		$(
				slider.show_value ? @htl(
				"""<script>
				const input_el = currentScript.previousElementSibling
				const output_el = currentScript.nextElementSibling
				const displays = $(string.(slider.values))
				
				input_el.addEventListener("input", () => {
					output_el.value = displays[input_el.valueAsNumber - 1]
				})
				</script><output style='
					font-family: system-ui;
					font-size: 15px;
					margin-left: 3px;
					transform: translateY(-4px);
					display: inline-block;'>$(string(slider.default))</output>"""
			) : nothing
		)"""
	))
end

# ╔═╡ 5679f79d-10ae-4ab2-9470-f15db2636712
Base.get(slider::Slider) = slider.default

# ╔═╡ bd9b0a51-1d25-4f53-bd87-a2fc998704b7
# ╠═╡ skip_as_script = true
#=╠═╡
@bind y Slider(30:.5:40; show_value=true, on_release=true)
  ╠═╡ =#

# ╔═╡ 1854fc42-e10a-4c1b-97db-cbb4e68695a2
# ╠═╡ skip_as_script = true
#=╠═╡
@bind x Slider(30:.5:40; style=(width="70%",), show_value=true)
  ╠═╡ =#

# ╔═╡ a2f83ae0-7679-4fe0-8377-c623989eef8f
# ╠═╡ skip_as_script = true
#=╠═╡
(sleep(0.5); (y, x))
  ╠═╡ =#

# ╔═╡ d4dd14aa-6531-4b5d-a0e3-bf03d0b32eec
@bind c PlutoUI.combine() do C
	C(Slider(1:10; on_release=true))
end

# ╔═╡ 7afcb5e7-05a2-4737-aa8b-9768bcea6067
(sleep(0.5); c)

# ╔═╡ 77791e63-c04d-4d7e-accc-c997c994e468
Bonds.initial_value(slider::Slider) = slider.default

# ╔═╡ d0ff290d-2318-4114-b92e-da9dc2dc9afa
Bonds.possible_values(slider::Slider) = 1:length(slider.values)

# ╔═╡ 72b1b62e-0f4d-4e93-ae89-dd03fafc6c9e
Bonds.transform_value(slider::Slider, val_from_js) = slider.values[val_from_js]

# ╔═╡ aaa8d6eb-6718-4157-bb34-93c92282580d
Bonds.validate_value(slider::Slider, val) = val isa Integer && 1 <= val <= length(slider.values)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractPlutoDingetjes = "6e696c72-6542-2067-7265-42206c756150"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
AbstractPlutoDingetjes = "~1.1.4"
HypertextLiteral = "~0.9.4"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "27a0b4ad1a5546b6faff1357f16dc1216a00b6db"

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

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "9673d39decc5feece56ef3940e5dafba15ba0f81"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

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
# ╠═ecb07281-3405-4fbd-8ace-bb53785490e6
# ╠═bd9b0a51-1d25-4f53-bd87-a2fc998704b7
# ╠═1854fc42-e10a-4c1b-97db-cbb4e68695a2
# ╠═47a3798b-2dc3-4cbc-8c34-3a5cc2cf4d50
# ╠═a2f83ae0-7679-4fe0-8377-c623989eef8f
# ╠═d4dd14aa-6531-4b5d-a0e3-bf03d0b32eec
# ╠═7afcb5e7-05a2-4737-aa8b-9768bcea6067
# ╠═55fa7b18-54ad-4910-ac5f-4e91a264333f
# ╠═a683c9b4-4285-49b5-bcc9-7fc572f03e91
# ╠═5400e620-0479-11ee-3e40-e986b7b30ab0
# ╠═599e7851-21db-4430-b9ae-d3b3f06ccdff
# ╠═5679f79d-10ae-4ab2-9470-f15db2636712
# ╠═77791e63-c04d-4d7e-accc-c997c994e468
# ╠═d0ff290d-2318-4114-b92e-da9dc2dc9afa
# ╠═72b1b62e-0f4d-4e93-ae89-dd03fafc6c9e
# ╠═aaa8d6eb-6718-4157-bb34-93c92282580d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
