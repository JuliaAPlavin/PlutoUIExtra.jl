module PlutoUIExtra

using Reexport
@reexport using PlutoUI
export Sidebar

include("sidebar.jl")
include("slider.jl")

end
