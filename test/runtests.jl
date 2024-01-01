using TestItems
using TestItemRunner
@run_package_tests


@testitem "_" begin
    import Aqua
    Aqua.test_all(PlutoUIExtra; ambiguities=false)
    Aqua.test_ambiguities(PlutoUIExtra)

    import CompatHelperLocal as CHL
    CHL.@check()
end
