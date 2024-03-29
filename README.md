# PlutoUIExtra.jl

> Input and output widgets for `Pluto`, those that didn't get into `PlutoUI.jl`: too narrow of a usecase, implementation not general enough, etc. \
Following [Fons's advice](https://github.com/JuliaPluto/PlutoUI.jl/pull/257#issuecomment-1577995821), these widgets are put into a separated package, `PlutoUIExtra`.

`PlutoUIExtra` reexport everything from `PlutoUI` (and adds extra). There's no need to manually import both in your code.

For now, contains the following widgets:
- `Sidebar`: [usage & implementation](https://aplavin.github.io/PlutoUIExtra.jl/src/sidebar.html), [PlutoUI PR](https://github.com/JuliaPluto/PlutoUI.jl/pull/257)
- `Slider`: [usage & implementation](https://aplavin.github.io/PlutoUIExtra.jl/src/slider.html)
  - CSS styling: [PlutoUI PR](https://github.com/JuliaPluto/PlutoUI.jl/pull/258)
  - trigger on mouse release: [PlutoUI PR](https://github.com/JuliaPluto/PlutoUI.jl/pull/268)
- `Select` with specified `size` (height): [usage & implementation](https://aplavin.github.io/PlutoUIExtra.jl/src/select.html)
- `Radio` with specified `orientation`: [usage & implementation](https://aplavin.github.io/PlutoUIExtra.jl/src/radio.html)
- `TextField` with an autocomplete list (`options`): [usage & implementation](https://aplavin.github.io/PlutoUIExtra.jl/src/textfield.html)

Feel free to suggest more!
