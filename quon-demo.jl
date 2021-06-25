### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 3eb73336-4709-4b90-bdbc-02d6322caccf
begin
	using Pkg
	Pkg.activate(".")
	Pkg.instantiate()
	using PlutoUI
end

# ╔═╡ d66a5d34-d344-11eb-3ad4-ab924315b21b
using Quon

# ╔═╡ 276d023e-251e-4fff-b74d-fc05c16d11a5
html"<button onclick='present()'>present</button>"

# ╔═╡ a1be015a-0943-420f-95af-c4ce55b96818
md"""
# Quon.jl: A Julia implementation of the Quon language

#### Chen Zhao

University of Chinese Academy of Sciences

"""

# ╔═╡ 4823bf81-5fc9-43cd-a2a4-2cd52a085dfd
md"""
# Table of contents
- Demonstration with Quon.jl
- Purpose of Quon.jl
"""

# ╔═╡ ed8a3f64-5b88-4405-bb2a-709f85e5d041
md"""
# Demonstration with Quon.jl
"""

# ╔═╡ 4e4edb18-9806-47fe-a574-7a3a9235b00f
md"""
# Building blocks in Quon.jl
"""

# ╔═╡ bff74664-9355-4810-868c-25c93bede4a8
md"""
## Rotation-Z
"""

# ╔═╡ bd5475a5-d994-4855-a235-b44ca9d07877
PlutoUI.LocalResource("images/rz.png")

# ╔═╡ 2e8c2413-0575-48c1-9b22-e6c6bf22ef05
Rz = tait_rz(π/4*im)

# ╔═╡ 907004f5-1b07-4fe2-acda-955121e27960
st_rz = Dict(
    1 => (3, -π/2),
    2 => (7, 0.0),
    3 => (8, π),
    4 => (6, π/2),
    5 => (12, π/2),
);

# ╔═╡ bc8db274-25fa-421e-91db-385ee17c2cda
plot(Rz; 
	show_tait = false, start_hes = st_rz)

# ╔═╡ 71cdeb02-36ca-4346-b508-1753f16d96f2
md"""
## Rotation-X
"""

# ╔═╡ 1bb632bb-b66e-40a6-8ebc-4547518a3ee3
PlutoUI.LocalResource("images/rx.png")

# ╔═╡ 591fdbb4-1f30-4c70-8dd8-d7c978052cbc
Rx = tait_rx(π/4*im)

# ╔═╡ a824c5cd-6834-4f35-a919-50cc5f4566ed
st_rx = Dict(
    1 => (3, -π/2),
    2 => (2, π/2),
    3 => (7, -π/2),
    4 => (11, -π/2),
    5 => (13, -π/2),
    6 => (12, π/2),
);

# ╔═╡ 325c07a9-8f82-48ea-a89b-2be7af5da0f3
plot(Rx; 
	show_tait = false, start_hes = st_rx) 

# ╔═╡ 23a2d772-4c24-4168-8e9c-c4720663b39c
md"""
## Copy tensor
"""

# ╔═╡ 380b7346-944d-4279-bf92-781d65704df0
PlutoUI.LocalResource("images/copy-tensor.png")

# ╔═╡ da2df527-f0e7-4d54-b1f9-488ad817b1de
copy_tensor = tait_copy()

# ╔═╡ 7c980d7e-f18d-41fd-821b-644dfbe08d83
st_copy = Dict(
    1 => (3, -π/2),
    2 => (11, π),
    5 => (6, π/2),
    6 => (2, π/2),
    7 => (4, π/2),
    4 => (18, 0.0),
    3 => (13, 0.0)
);

# ╔═╡ d6a9599c-c7ce-4efc-aacd-35c09c114287
plot(copy_tensor; 
	show_tait = false, start_hes = st_copy, radius = 0.6)

# ╔═╡ bac8f237-e9a1-4c57-a6ee-165d78bb6e60
md"""
# Constructing gates with these building blocks
"""

# ╔═╡ f9dc36c6-5cf5-4fe7-8711-aff382338d3c
md"""
## Pauli X
"""

# ╔═╡ ae32d3a9-bf29-40f5-b699-496cdfe7d722
begin
	XGate = tait_rx(π*im)
	plot(XGate; 
		show_tait = false, start_hes = st_rx)
end

# ╔═╡ 4496833a-628e-45cd-a172-e466ce2f6438
md"""
## S gate
"""

# ╔═╡ 20beb763-afdc-497f-a5f7-09178cc2fcdd
begin
	SGate = tait_rz(π/2*im)
	plot(SGate; 
		show_tait = false, start_hes = st_rz)
end

# ╔═╡ c21fd958-d188-464c-a5f2-eda2bffc781f
md"""
## Hadamard gate (by contraction)
"""

# ╔═╡ 8ec4b145-43d8-43e2-a60a-62b5a5e90458
HGate1 = 
	contract!(
		contract!(tait_rz(π/2*im), tait_rx(π/2*im)), 
		tait_rz(π/2*im)
	)

# ╔═╡ 09941218-735b-4a1b-9e65-325c35800656
md"""
## Hadamard gate (predefined)
"""

# ╔═╡ dd0d3197-0692-4007-afd1-a44dfd7a0043
HGate2 = tait_hadamard()

# ╔═╡ 3e18bdfd-1ba3-4490-93dd-c6a4b953b979
st_h = Dict(
	1 => (3, -π/2),
	2 => (7, π/4),
	3 => (4, π/2),
	4 => (6, π/2),
	16 => (40, π/2)
);

# ╔═╡ f805ccf9-a36e-4263-9a7c-f3624759ab6c
plot(HGate1; 
	show_tait = false, start_hes = st_h)

# ╔═╡ 24027f3a-d30e-497c-a619-cdb3c4f4d86a
plot(HGate2; 
	show_tait = false, start_hes = st_h)

# ╔═╡ 60c2960c-fb15-445b-806b-20c2b28941b4
md"""
## CZ gate
"""

# ╔═╡ 5fcb4ed0-bf61-4a12-8533-c5622b722236
CZGate = tait_cz()

# ╔═╡ 587248d5-3b39-4c38-8bf4-45b0b3f26af9
st_cz = Dict(
    1 => (3, -π/2),
    5 => (6, π),
    24 => (63, -π/2),
    6 => (2, π/2),
    7 => (39, π/4),
    16 => (40, 3π/4),
    28 => (66, π/2),
    4 => (53, π/4),
    2 => (9, π/2),
    26 => (75, π/2),
);

# ╔═╡ 87786d00-409f-45c5-8fad-190d3f87fd19
plot(CZGate; 
    show_tait = false, radius = 0.6, start_hes = st_cz)

# ╔═╡ 70b0a895-b180-40f5-9440-3731c7032b16
md"""
# Rules in Quon.jl
"""

# ╔═╡ feabe1c6-20ae-4b2e-ab5a-8a782b8f4571
PlutoUI.LocalResource("images/quon-cheat-sheet.png")

# ╔═╡ c03d63f9-a748-4293-b794-e9e89953fd26
md"""
## APIs for rewriting

### Matching
	matches = match(rule, quon)

### Rewriting
	rewrite!(quon, m)
"""

# ╔═╡ 827cf4fe-198e-4b18-a48a-fdc4acc6bc56
md"""
# A simple example: $$CZ^2 = I$$
"""

# ╔═╡ 7b0f433d-2099-4982-a158-ba2bf8e990b9
md"""
## 
"""

# ╔═╡ f9cdac71-d07d-4f88-8ced-04f86c013b16
CZ = tait_cz()

# ╔═╡ ace7b973-8f21-49d5-a969-ac1861305e47
plot(tait_cz(); 
	show_tait = false, radius = 0.6, start_hes = st_cz)

# ╔═╡ 6ddbcd88-7488-47d4-8e2c-c54bc4894fd0
md"""
## Constructing $$CZ^2$$ by contraction
"""

# ╔═╡ 28368032-1ca8-4650-85e2-d9b2a7f106f8
CZ2 = contract!(CZ, tait_cz())

# ╔═╡ 25a93476-d08f-4746-be79-4ef2e286e469
begin
	CZ.locations[4] = (2.0, 1.0)
	start_hes = Dict(
	    1 => (3, -π/2),
	    5 => (6, π),
	    24 => (63, -π/2),
	    7 => (26, 0),
	    4 => (53, 0),
	    16 => (54, π),
	    34 => (131, π/4),
	    32 => (87, π/2),
	    56 => (153, π/2)
	)
end;

# ╔═╡ b5582d50-5da7-4ac8-a346-13867fb6a6cc
plot(CZ2; show_tait = false, 
	start_hes = start_hes, radius = 0.6)

# ╔═╡ dc40186f-e0b2-489c-a52b-a21ad9b415f7
md"""
## Applying Rz rule
"""

# ╔═╡ af2ef819-ac70-4cbd-85b4-e34863bbae0a
begin
	m = match(Rule(:perm_rz), CZ2)
	rewrite!(CZ2, m[3])
	rewrite!(CZ2, m[9])
end

# ╔═╡ ff0eb1c1-325b-485d-affc-10191d0a2dfc
begin
	st = copy(start_hes)
	st[7] = (4, π/2)
	st[16] = (64, π/2)
	st[34] = (103, π)
	delete!(st, 4)
end;

# ╔═╡ cc21e16a-1d85-4d2b-8358-73977f0e778e
plot(CZ2; show_tait = false, 
	start_hes = st)

# ╔═╡ 83918272-e858-4eec-8b6f-46c0dbf1cb93
md"""
## Applying string-genus relation
"""

# ╔═╡ e3b422d6-369a-4086-9e72-50588d28c975
begin
	m_string_genus = match(Rule(:string_genus), CZ2)
	rewrite!(CZ2, m_string_genus[1])
end

# ╔═╡ 092cb87d-a328-4a4d-8ece-c16a4850383b
plot(CZ2; show_tait = false, 
	start_hes = st)

# ╔═╡ 453e6c69-1120-46f7-bd79-6f6ebd723f11
md"""
## Applying fusion rule
"""

# ╔═╡ 4b991a3d-91b0-48ae-9b8b-87e9d0cdeb98
begin
	m_fusion = match(Rule(:z_fusion), CZ2)
	rewrite!(CZ2, m_fusion[1])
	rewrite!(CZ2, m_fusion[2])
	rewrite!(CZ2, m_fusion[3])
end

# ╔═╡ 91513749-1927-4ae5-b056-ee8745d15c56
begin
	st2 = copy(st)
	st2[34] = (158, π/4)
end;

# ╔═╡ 3aa3a1d6-12ee-44c2-9f48-ac271cb80e92
plot(CZ2; show_tait = false,
	start_hes = st2)

# ╔═╡ a26f363c-1e3d-4504-a143-bd44641746d7
md"""
## Applying charge-reducing rule
"""

# ╔═╡ 178e2332-e51f-4103-9f6f-805e03cd7c4f
begin
	m_charge = match(Rule(:charge_rm_f), CZ2)
	rewrite!(CZ2, m_charge[1])
end

# ╔═╡ 3d85d190-78f9-4ce7-86c9-8cef2e020574
plot(CZ2; show_tait = false,
	start_hes = st2)

# ╔═╡ 30a2960a-95be-4a8c-a867-5858c2eb7d4c
md"""
## Applying identity rule
"""

# ╔═╡ 5eadba74-f6ab-426b-ac36-2cb7acf5245b
begin
	m_id = match(Quon.Rule(:identity), CZ2)
	rewrite!(CZ2, m_id[1])
	rewrite!(CZ2, m_id[3])
	rewrite!(CZ2, m_id[5])
end

# ╔═╡ ca005a24-cb8d-4a22-bca0-1b66171e423d
begin
	st3 = copy(st2)
	st3[34] = (86, π)
	CZ2.locations[32] = (1.0, 3.0)
	CZ2.locations[56] = (3.0, 3.0)
end;

# ╔═╡ f254b23e-7148-4d19-9307-06b4708492bf
plot(CZ2; 
	show_tait = false, start_hes = st3, radius = 0.6)

# ╔═╡ a2b26d83-9b04-4476-a653-289d4555d7b1
md"""
## Applying genus-fusion rule
"""

# ╔═╡ 374875ac-56c9-45cc-9d31-0d0c7a342114
begin
	m_gf = match(Rule(:genus_fusion), CZ2)
	rewrite!(CZ2, m_gf[2])
end 

# ╔═╡ baeb0c85-4ece-4b87-96de-e64513489815
begin
	st4 = copy(st3)
	st4[34] = (86, -3π/4)
	CZ2.locations[34] = (2.0, 1.0)
end;

# ╔═╡ 1a6f1268-a221-4e3e-9e24-869f28c78f13
plot(CZ2; show_tait = false,
	start_hes = st4)

# ╔═╡ df428f43-166d-4934-a9e7-f0f6bdd12540
md"""
# Purpose of Quon.jl
"""

# ╔═╡ c309495b-e449-4e18-a50c-04b1fe2899d8
md"""
## Representing Quon diagrams

### Tait graphs

"""

# ╔═╡ 53e2ce16-34a8-4240-bb74-c6714f346e89
PlutoUI.LocalResource("images/tait-graph.png")

# ╔═╡ c830f768-d18c-43eb-a054-c38485449e32
plot(tait_hadamard();
	show_string = false,
	show_tait = true,
	start_hes = st_h)

# ╔═╡ 09d1407d-47ff-47a5-8bc6-2bbd4191e523
md"""
## Quon rules on Tait graphs
"""

# ╔═╡ 003db1c9-5711-46a7-bbb4-01aee4f981d9
PlutoUI.LocalResource("images/tait-rule.png")

# ╔═╡ 7ed7a9bb-7646-4c7d-8020-f731655bb83a
begin
	m_yb = match(Rule(:yang_baxter_triangle), HGate2)
	rewrite!(HGate2, m_yb[1])
end

# ╔═╡ 1ec0573c-727d-4d85-9883-48d693c81535
begin
	HGate2.locations[17] = (0.8, 2.0)
	HGate2.locations[2] = (0.0, 2.0)
	HGate2.locations[4] = (2.0, 2.0)
	HGate2.locations[9] = (1.0, 3.0)
	HGate2.locations[16] = (1.0, 4.0)
	st_h_alt = Dict(
		1 => (3, -π/2),
		2 => (45, 0),
		3 => (4, π/2),
		17 => (46, π),
		9 => (39, -π/2),
		16 => (40, π/2)
	)
end;

# ╔═╡ 474261be-7cff-4e65-86c0-f49d5d041467
plot(HGate2,
	show_string = false,
	start_hes = st_h_alt,
	radius = 0.6
)

# ╔═╡ 7a2e804f-216e-4c3d-8a12-f48ff9f56fab
md"""
# Purpose of Quon.jl

- Provide a library for representing, manipulating, and visualizing Quon graphs

"""

# ╔═╡ 68221de0-6821-49f5-9ebf-bf87a95873c4
md"""
## Quon.jl in the ecosystem of Yao.jl
"""

# ╔═╡ c28f5d66-639d-40a1-a0bd-48f8c462f568
PlutoUI.LocalResource("images/yao-01.png")

# ╔═╡ 20a2a2d3-4055-4305-a00f-0698afbcf7c5
md"""
## 
"""

# ╔═╡ 558a708b-ffa2-4a41-9fb7-f74205f2acc7
PlutoUI.LocalResource("images/yao-02.png")

# ╔═╡ ad028833-3165-474c-98b6-11d78b271016
md"""
## 
"""

# ╔═╡ 4719dd10-2c6b-4300-8202-ae09e9dc75a7
PlutoUI.LocalResource("images/yao-03.png")

# ╔═╡ 90d73abf-db6e-49e0-8c77-76b9c9b7c1eb
md"""
## 
"""

# ╔═╡ b38d7077-0db0-4356-b9e8-f1ab8deca4cb
PlutoUI.LocalResource("images/yao-04.png")

# ╔═╡ cb3870c6-5182-43f2-80d0-2d09baef8aa8
md"""
# YaoCompiler.jl

#### A domain specific language (DSL) for hybrid quantum-classical programs

"""

# ╔═╡ b9c2fc02-8778-46a0-9f9f-5cdba18099f8
md"""
## 
"""

# ╔═╡ 7a80372f-9be8-4b42-a1b4-cd488cef3daf
PlutoUI.LocalResource("images/demo.gif")

# ╔═╡ 1ff03293-5039-404d-82f6-dc08217740a1
md"""
## 
"""

# ╔═╡ 37bca038-3440-4026-9bce-b790c60b0bdf
PlutoUI.LocalResource("images/yao-05.png")

# ╔═╡ c0a24afd-334f-4ebc-bb4f-722bd9e7cd42
md"""
# Purpose of Quon.jl

- provide a library for representing, manipulating, and visualizing Quon graphs
- provide a circuit optimization backend for YaoCompiler.jl

"""

# ╔═╡ 292ab26b-6df1-424c-bd35-a0c16a840ab0
md"""
# Thank you!
"""

# ╔═╡ Cell order:
# ╟─3eb73336-4709-4b90-bdbc-02d6322caccf
# ╟─276d023e-251e-4fff-b74d-fc05c16d11a5
# ╟─a1be015a-0943-420f-95af-c4ce55b96818
# ╟─4823bf81-5fc9-43cd-a2a4-2cd52a085dfd
# ╟─ed8a3f64-5b88-4405-bb2a-709f85e5d041
# ╠═d66a5d34-d344-11eb-3ad4-ab924315b21b
# ╟─4e4edb18-9806-47fe-a574-7a3a9235b00f
# ╟─bff74664-9355-4810-868c-25c93bede4a8
# ╟─bd5475a5-d994-4855-a235-b44ca9d07877
# ╠═2e8c2413-0575-48c1-9b22-e6c6bf22ef05
# ╟─907004f5-1b07-4fe2-acda-955121e27960
# ╠═bc8db274-25fa-421e-91db-385ee17c2cda
# ╟─71cdeb02-36ca-4346-b508-1753f16d96f2
# ╟─1bb632bb-b66e-40a6-8ebc-4547518a3ee3
# ╠═591fdbb4-1f30-4c70-8dd8-d7c978052cbc
# ╟─a824c5cd-6834-4f35-a919-50cc5f4566ed
# ╠═325c07a9-8f82-48ea-a89b-2be7af5da0f3
# ╟─23a2d772-4c24-4168-8e9c-c4720663b39c
# ╟─380b7346-944d-4279-bf92-781d65704df0
# ╠═da2df527-f0e7-4d54-b1f9-488ad817b1de
# ╟─7c980d7e-f18d-41fd-821b-644dfbe08d83
# ╠═d6a9599c-c7ce-4efc-aacd-35c09c114287
# ╟─bac8f237-e9a1-4c57-a6ee-165d78bb6e60
# ╟─f9dc36c6-5cf5-4fe7-8711-aff382338d3c
# ╠═ae32d3a9-bf29-40f5-b699-496cdfe7d722
# ╟─4496833a-628e-45cd-a172-e466ce2f6438
# ╠═20beb763-afdc-497f-a5f7-09178cc2fcdd
# ╟─c21fd958-d188-464c-a5f2-eda2bffc781f
# ╠═8ec4b145-43d8-43e2-a60a-62b5a5e90458
# ╠═f805ccf9-a36e-4263-9a7c-f3624759ab6c
# ╟─09941218-735b-4a1b-9e65-325c35800656
# ╠═dd0d3197-0692-4007-afd1-a44dfd7a0043
# ╟─3e18bdfd-1ba3-4490-93dd-c6a4b953b979
# ╠═24027f3a-d30e-497c-a619-cdb3c4f4d86a
# ╟─60c2960c-fb15-445b-806b-20c2b28941b4
# ╠═5fcb4ed0-bf61-4a12-8533-c5622b722236
# ╟─587248d5-3b39-4c38-8bf4-45b0b3f26af9
# ╠═87786d00-409f-45c5-8fad-190d3f87fd19
# ╟─70b0a895-b180-40f5-9440-3731c7032b16
# ╟─feabe1c6-20ae-4b2e-ab5a-8a782b8f4571
# ╟─c03d63f9-a748-4293-b794-e9e89953fd26
# ╟─827cf4fe-198e-4b18-a48a-fdc4acc6bc56
# ╟─7b0f433d-2099-4982-a158-ba2bf8e990b9
# ╠═f9cdac71-d07d-4f88-8ced-04f86c013b16
# ╠═ace7b973-8f21-49d5-a969-ac1861305e47
# ╟─6ddbcd88-7488-47d4-8e2c-c54bc4894fd0
# ╠═28368032-1ca8-4650-85e2-d9b2a7f106f8
# ╟─25a93476-d08f-4746-be79-4ef2e286e469
# ╠═b5582d50-5da7-4ac8-a346-13867fb6a6cc
# ╟─dc40186f-e0b2-489c-a52b-a21ad9b415f7
# ╠═af2ef819-ac70-4cbd-85b4-e34863bbae0a
# ╟─ff0eb1c1-325b-485d-affc-10191d0a2dfc
# ╠═cc21e16a-1d85-4d2b-8358-73977f0e778e
# ╟─83918272-e858-4eec-8b6f-46c0dbf1cb93
# ╠═e3b422d6-369a-4086-9e72-50588d28c975
# ╠═092cb87d-a328-4a4d-8ece-c16a4850383b
# ╟─453e6c69-1120-46f7-bd79-6f6ebd723f11
# ╠═4b991a3d-91b0-48ae-9b8b-87e9d0cdeb98
# ╟─91513749-1927-4ae5-b056-ee8745d15c56
# ╠═3aa3a1d6-12ee-44c2-9f48-ac271cb80e92
# ╟─a26f363c-1e3d-4504-a143-bd44641746d7
# ╠═178e2332-e51f-4103-9f6f-805e03cd7c4f
# ╠═3d85d190-78f9-4ce7-86c9-8cef2e020574
# ╟─30a2960a-95be-4a8c-a867-5858c2eb7d4c
# ╠═5eadba74-f6ab-426b-ac36-2cb7acf5245b
# ╟─ca005a24-cb8d-4a22-bca0-1b66171e423d
# ╠═f254b23e-7148-4d19-9307-06b4708492bf
# ╟─a2b26d83-9b04-4476-a653-289d4555d7b1
# ╠═374875ac-56c9-45cc-9d31-0d0c7a342114
# ╟─baeb0c85-4ece-4b87-96de-e64513489815
# ╠═1a6f1268-a221-4e3e-9e24-869f28c78f13
# ╟─df428f43-166d-4934-a9e7-f0f6bdd12540
# ╟─c309495b-e449-4e18-a50c-04b1fe2899d8
# ╟─53e2ce16-34a8-4240-bb74-c6714f346e89
# ╠═c830f768-d18c-43eb-a054-c38485449e32
# ╟─09d1407d-47ff-47a5-8bc6-2bbd4191e523
# ╟─003db1c9-5711-46a7-bbb4-01aee4f981d9
# ╠═7ed7a9bb-7646-4c7d-8020-f731655bb83a
# ╟─1ec0573c-727d-4d85-9883-48d693c81535
# ╠═474261be-7cff-4e65-86c0-f49d5d041467
# ╟─7a2e804f-216e-4c3d-8a12-f48ff9f56fab
# ╟─68221de0-6821-49f5-9ebf-bf87a95873c4
# ╟─c28f5d66-639d-40a1-a0bd-48f8c462f568
# ╟─20a2a2d3-4055-4305-a00f-0698afbcf7c5
# ╟─558a708b-ffa2-4a41-9fb7-f74205f2acc7
# ╟─ad028833-3165-474c-98b6-11d78b271016
# ╟─4719dd10-2c6b-4300-8202-ae09e9dc75a7
# ╟─90d73abf-db6e-49e0-8c77-76b9c9b7c1eb
# ╟─b38d7077-0db0-4356-b9e8-f1ab8deca4cb
# ╟─cb3870c6-5182-43f2-80d0-2d09baef8aa8
# ╟─b9c2fc02-8778-46a0-9f9f-5cdba18099f8
# ╟─7a80372f-9be8-4b42-a1b4-cd488cef3daf
# ╟─1ff03293-5039-404d-82f6-dc08217740a1
# ╟─37bca038-3440-4026-9bce-b790c60b0bdf
# ╟─c0a24afd-334f-4ebc-bb4f-722bd9e7cd42
# ╟─292ab26b-6df1-424c-bd35-a0c16a840ab0
