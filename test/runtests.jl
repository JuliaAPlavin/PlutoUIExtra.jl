using TestItems
using TestItemRunner
@run_package_tests


@testitem "Sidebar" begin
    map(Iterators.product(["upper", "center", "lower"], ["left", "center", "right"])) do (v, h)
        Sidebar(((;v, h)), location="$v $h")
    end |> vec
end

@testitem "Slider" begin
    using PlutoUIExtra.PlutoUI.BuiltinsNotebook.AbstractPlutoDingetjes
    default(x) = Base.get(x)
    transform(el, x) = AbstractPlutoDingetjes.Bonds.transform_value(el, x)

    el = Slider(0.0:π:20)
    @test default(el) == 0
    el = Slider(0.0:π:20; show_value = true, style=(width="100%",))
    el = Slider(0.0:π:20; default = π)
    @test default(el) == Float64(π) # should have been converted to Float64 because our range has been
    el = Slider(1:1//3:20; default = 7 // 3)
    @test default(el) === 7 // 3
    el = Slider(1:1//3:20)
    @test default(el) === 1 // 1
    el = Slider([sin, cos, tan])
    @test default(el) == sin
    el = Slider([sin, cos, tan]; default = tan)
    @test default(el) == tan

    # Downsampling Slider ranges
    x1 = [1,2,3]
    x2 = rand(500)

    x4 = 1:9802439083
    el = Slider(x4; default=2, show_value=true)
    @test length(el.values) <= 1000
    @test default(el) == 1
end


@testitem "_" begin
    import Aqua
    Aqua.test_all(PlutoUIExtra; ambiguities=false, undefined_exports=false)
    Aqua.test_ambiguities(PlutoUIExtra)

    import CompatHelperLocal as CHL
    CHL.@check()
end